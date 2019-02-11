with COMM;

-- =============================================================================
-- Responsible for the high-level functions
-- =============================================================================
package CORE is

   function Handle_Request
     (Command : COMM.Command_Type)
      return COMM.Command_Type; -- returns a response

   procedure Handle_Response
     (Command : COMM.Command_Type);

end CORE;
