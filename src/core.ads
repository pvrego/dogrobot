with GNAT.Sockets;

-- =============================================================================
-- Responsible for the high-level functions
-- =============================================================================
package CORE is
   package SOCKETS renames GNAT.Sockets;

   procedure Process_Message (Message : String);

end CORE;
