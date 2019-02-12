with COMM;

-- =============================================================================
-- Responsible for buffering of commands to be executable.
-- =============================================================================
package CORE.BUFFER is

   function Retrieve_Current_Command
     (Command : out COMM.Command_Type)
      return Boolean;

private

   Current_Command : COMM.Command_Type := COMM.COMMAND_DEFAULT;
   Command_Buffer_Is_Full : Boolean := False;

end CORE.BUFFER;
