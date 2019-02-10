with GNAT.Sockets;

-- =============================================================================
-- Implements the sockets layers for the client/server application
-- =============================================================================
package COMM.SOCKETS is

   package SOCKETS renames GNAT.Sockets;

   --  Multicast group: administratively scoped IP address
   Group : constant String := "239.255.128.128";

   task Socket_Manager is
      entry Start;
      entry Stop;
   end Socket_Manager;

end COMM.SOCKETS;
