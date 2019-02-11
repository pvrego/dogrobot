-- =============================================================================
-- Responsible for the management of input messages decodification, and the
-- output buffering commands.
-- =============================================================================
package COMM.PROCESS is

   -- ==========================================================================
   -- To decode a string message into a command message.
   -- A. If the message is identified as a command:
   --   A1. The required actions will be directed to CORE.
   --   A2. A RESPONSE will be returned as output, and the Relevant flag is set
   --       to True only if it is a REQUEST.
   --   A3. If the message is not a REQUEST, the Relevant flag is set to False.
   --
   -- B. If the message is not a command, the return is the original message,
   --    and the Relevant flag is always set to True.
   -- ==========================================================================
   function Process_Input_Message
     (Message  : String;
      Relevant : out Boolean)
      return String;

end COMM.PROCESS;
