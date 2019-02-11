with COMM;

-- =============================================================================
-- Responsible for the high-level functions
-- =============================================================================
package CORE is

   function Handle_Request
     (Command : COMM.Command_Single_Type)
      return COMM.Command_Single_Type; -- returns a response

   function Handle_Request
     (Command : COMM.Command_Value_Type)
      return COMM.Command_Value_Type;  -- returns a response

   function Handle_Request
     (Command : COMM.Command_Complex_Type)
      return COMM.Command_Complex_Type;  -- returns a response

   procedure Handle_Response
     (Command : COMM.Command_Single_Type);

   procedure Handle_Response
     (Command : COMM.Command_Value_Type);

   procedure Handle_Response
     (Command : COMM.Command_Complex_Type);

end CORE;
