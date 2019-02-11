with GNAT.Sockets;
with Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with GNAT.Traceback.Symbolic;
with COMM.CODING;

package body COMM.SOCKETS is

   task body Socket_Manager is

      Socket  : SOCKETS.Socket_Type;
      Address : SOCKETS.Sock_Addr_Type;
      Channel : SOCKETS.Stream_Access;

   begin

      accept Start;

      SOCKETS.Initialize;
      Text_IO.Put_Line ("## Server initialized.");

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
      Address.Addr := HOST_ADDRESS;
      Address.Port := HOST_PORT;

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
         (SOCKETS.Add_Membership, SOCKETS.Inet_Addr (GROUP_ADRRESS), SOCKETS.Any_Inet_Addr));

      --  If this socket is intended to send messages, provide the
      --  receiver socket address.
      --        Address.Addr := SOCKETS.Inet_Addr (Group);
      Address.Addr := OTHER_ADDRESS;
      Address.Port := OTHER_PORT;

      --     accept Start;
#if Module = "MOD_RPI" or Module = "MOD_ALL" then
      -- accept Start;
      loop
         --  Receive and print message from client Ping
         Channel := SOCKETS.Stream (Socket, Address);
         declare
            Message  : String := String'Input (Channel);
            Relevant : Boolean;
            Response : String := COMM.CODING.Process_Message (Message, Relevant);
         begin

            --  Get the address of the sender
            Address := SOCKETS.Get_Address (Channel);
            Text_IO.Put_Line ("[Received from " & SOCKETS.Image (Address)&"] "&Message);

            --  Send response back if it is relevant
            if Relevant then
               String'Output (Channel, "[RESPONSE] " & Response);
            end if;

         end;

      end loop;
      -- accept Stop;
      -- SOCKETS.Close_Socket (Socket);
      -- SOCKETS.Finalize;

#else -- Module = "MOD_WIN"
      --  Return a stream associated to the connected socket
      Channel := SOCKETS.Stream (Socket, Address);

      -- =======================================================================
      -- Send message to server
      -- =======================================================================
      String'Output (Channel, "Hello world single phrase.");

      declare
         Command : constant Command_Single_Type :=
           (Header       => '#',
            Id           => SYSTEM_WIN,
            Category     => RESPONSE,
            Container    => False,
            Footer_Slash => '/',
            Footer_Term  => '#');
      begin
         String'Output (Channel, String (COMM.CODING.To_String_Single (Command)));
      end;

      -- =======================================================================
      -- Receive and print message from server Pong
      -- =======================================================================
      declare
         Message : String := String'Input (Channel);
      begin
         Address := SOCKETS.Get_Address (Channel);
         Text_IO.Put_Line ("[From "&SOCKETS.Image (Address)&"]"&Message);
      end;
      -- accept Stop;
      SOCKETS.Close_Socket (Socket);
      SOCKETS.Finalize;
#end if;


   exception
      when The_Error : others =>
         Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
         Text_Io.Put_Line ("Traceback => " & GNAT.Traceback.Symbolic.Symbolic_Traceback(The_Error));

   end Socket_Manager;

end COMM.SOCKETS;
