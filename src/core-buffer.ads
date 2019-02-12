with COMM;

-- =============================================================================
-- Responsible for buffering of commands to be executable.
-- =============================================================================
package CORE.BUFFER is

   -- Retrieve the current queue command
   function Get
     (Command : out COMM.Command_Type)
      return Boolean;

   -- Put a command in the queue
   function Put
     (Command : COMM.Command_Type)
      return Boolean;

private

   Command_Buffer : COMM.Command_Type := COMM.COMMAND_DEFAULT;
   Command_Buffer_Is_Full : Boolean := False;

end CORE.BUFFER;
