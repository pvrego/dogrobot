-- =============================================================================
-- Responsible for the management of input messages decodification, and the
-- output buffering commands.
-- =============================================================================
package COMM.PROCESS is

   -- ==========================================================================
   -- To decode a string message into a command message.
   -- A. If the message is identified as a command:
   --   A1. The required actions will be directed to CORE.
   --   A2. If the command is a REQUEST, a RESPONSE will output, and return True.
   --   A3. If the message is not a REQUEST, the return is False.
   --
   -- B. If the message is not a command, the return is False.
   -- ==========================================================================
   function Process_Request_Message
     (Message  : String;
      Response : out Command_Type)
      return Boolean;

   function Process_Response_Message
     (Message : String)
     return Boolean;

end COMM.PROCESS;
