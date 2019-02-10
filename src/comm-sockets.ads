with GNAT.Sockets;

-- =============================================================================
-- Implements the sockets layers for the client/server application
-- =============================================================================
package COMM.SOCKETS is

   package SOCKETS renames GNAT.Sockets;

   -- Configuration Addresses
   HOST_ADDRESS  : constant SOCKETS.Inet_Addr_Type := SOCKETS.Any_Inet_Addr;
   HOST_PORT     : constant SOCKETS.Port_Type := 55505;
   OTHER_ADDRESS : constant SOCKETS.Inet_Addr_Type := SOCKETS.Inet_Addr ("192.168.0.116");
   OTHER_PORT    : constant SOCKETS.Port_Type := 55506;

   -- Multicast group: administratively scoped IP address
   Group : constant String := "239.255.128.128";

   task Socket_Manager is
      entry Start;
      --        entry Stop;
   end Socket_Manager;

end COMM.SOCKETS;
