with Unchecked_Conversion;

-- =============================================================================
-- Responsible for encoding and decoding features of the communication protocol,
-- as string from/to command types.
-- =============================================================================
package COMM.CODING is

   function To_Command_Single is new Unchecked_Conversion
     (Source => String_Single_Type,
      Target => Command_Single_Type);

   function To_Command_Value is new Unchecked_Conversion
     (Source => String_Value_Type,
      Target => Command_Value_Type);

   function To_Command_Complex is new Unchecked_Conversion
     (Source => String_Complex_Type,
      Target => Command_Complex_Type);

   function To_String_Single is new Unchecked_Conversion
     (Source => Command_Single_Type,
      Target => String_Single_Type);

   function To_String_Value is new Unchecked_Conversion
     (Source => Command_Value_Type,
      Target => String_Value_Type);

   function To_String_Complex is new Unchecked_Conversion
     (Source => Command_Complex_Type,
      Target => String_Complex_Type);

   -- Check header and footer for a command protocol.
   function Is_Valid (Command : Command_Single_Type) return Boolean;

   -- Check header and footer for a command protocol.
   function Is_Valid (Command : Command_Value_Type) return Boolean;

   -- Check header and footer for a command protocol.
   function Is_Valid (Command : Command_Complex_Type) return Boolean;

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
   function Process_Message
     (Message  : String;
      Relevant : out Boolean)
      return String;

end COMM.CODING;
