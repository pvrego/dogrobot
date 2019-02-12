with GNAT.Sockets;

-- =============================================================================
-- Implements the sockets layers for the client/server application
-- =============================================================================
package COMM.SOCKETS is

   package SOCKETS renames GNAT.Sockets;

   -- Configuration Addresses
   HOST_ADDRESS  : constant SOCKETS.Inet_Addr_Type := SOCKETS.Any_Inet_Addr;

#if Module = "MOD_ALL" or Module = "MOD_RPI" then
   OTHER_ADDRESS : constant SOCKETS.Inet_Addr_Type := SOCKETS.Inet_Addr ("192.168.0.116");
   HOST_PORT     : constant SOCKETS.Port_Type := 55505;
   OTHER_PORT    : constant SOCKETS.Port_Type := 55506;
#else -- MOD_WIN
   OTHER_ADDRESS : constant SOCKETS.Inet_Addr_Type := SOCKETS.Inet_Addr ("192.168.0.105");
   HOST_PORT     : constant SOCKETS.Port_Type := 55506;
   OTHER_PORT    : constant SOCKETS.Port_Type := 55505;
#end if;

   -- Multicast group: administratively scoped IP address
   GROUP_ADRRESS : constant String := "239.255.128.128";

   task Socket_Manager is
      entry Init;
      entry Start;
      --        entry Stop;
   end Socket_Manager;

end COMM.SOCKETS;
