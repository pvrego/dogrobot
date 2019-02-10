with GNAT.Sockets;
with Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with GNAT.Traceback.Symbolic;

-- =============================================================================
-- Implements the DogRobot client main application in Windows
-- =============================================================================
procedure CLIENT_WIN is
   package SOCKETS renames GNAT.Sockets;

   Socket  : SOCKETS.Socket_Type;
   Address : SOCKETS.Sock_Addr_Type;
   Channel : SOCKETS.Stream_Access;

   --  Multicast group: administratively scoped IP address
   Group : constant String := "239.255.128.128";

begin

   SOCKETS.Initialize;
   Text_IO.Put_Line ("## Client initialized.");

   --  Create a datagram socket to send connectionless, unreliable
   --  messages of a fixed maximum length.
   SOCKETS.Create_Socket (Socket, SOCKETS.Family_Inet, SOCKETS.Socket_Datagram);
   Text_IO.Put_Line ("## Socket created.");

   --  Allow reuse of local addresses
   SOCKETS.Set_Socket_Option
     (Socket,
      SOCKETS.Socket_Level,
      (SOCKETS.Reuse_Address, True));

   --  Controls the live time of the datagram to avoid it being
   --  looped forever due to routing errors. Routers decrement
   --  the TTL of every datagram as it traverses from one network
   --  to another and when its value reaches 0 the packet is
   --  dropped. Default is 1.

   SOCKETS.Set_Socket_Option
     (Socket,
      SOCKETS.IP_Protocol_For_IP_Level,
      (SOCKETS.Multicast_TTL, 1));

   --  Want the data you send to be looped back to your host

   SOCKETS.Set_Socket_Option
     (Socket,
      SOCKETS.IP_Protocol_For_IP_Level,
      (SOCKETS.Multicast_Loop, True));

   Text_IO.Put_Line ("## Socket options configured");
   -- ==========================================================================
   -- Address configuration
   -- ==========================================================================

   --  If this socket is intended to receive messages, bind it
   --  to a given socket address.
   Address.Addr := SOCKETS.Any_Inet_Addr;
   Address.Port := 55506;

   --  A server marks a socket as willing to receive connect events
   SOCKETS.Bind_Socket (Socket, Address);
   Text_IO.Put_Line ("## Address bound.");
   Text_IO.Put_Line ("## Now will listen to connections ... ");

   --  Join a multicast group
   --  Portability note: On Windows, this option may be set only
   --  on a bound socket.
   SOCKETS.Set_Socket_Option
     (Socket,
      SOCKETS.IP_Protocol_For_IP_Level,
      (SOCKETS.Add_Membership, SOCKETS.Inet_Addr (Group), SOCKETS.Any_Inet_Addr));

   --  If this socket is intended to send messages, provide the
   --  receiver socket address.
   Address.Addr := SOCKETS.Inet_Addr (Group);
   --  If this client is from windows, set this address of the Raspberry Pi,
   --  instead of Group.
   -- Address.Addr := SOCKETS.Inet_Addr ("192.168.0.105");

   Address.Port := 55505;

   --     accept Start;
   --     loop
   --  Return a stream associated to the connected socket
   Channel := SOCKETS.Stream (Socket, Address);

   --  Send message to server Pong

   String'Output (Channel, "Hello world");

   --  Receive and print message from server Pong

   declare
      Message : String := String'Input (Channel);

   begin
      Address := SOCKETS.Get_Address (Channel);
      Text_IO.Put_Line (Message & " from " & SOCKETS.Image (Address));
   end;

   -- accept Stop;
   SOCKETS.Close_Socket (Socket);
   SOCKETS.Finalize;

exception
   when The_Error : others =>
      Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
      --Text_Io.Put_Line ("Traceback => " & GNAT.Traceback.Symbolic.Symbolic_Traceback(The_Error));


end CLIENT_WIN;
