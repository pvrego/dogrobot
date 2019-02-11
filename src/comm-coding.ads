with Unchecked_Conversion;

-- =============================================================================
-- Responsible for encoding and decoding features of the communication protocol,
-- as string from/to command types.
-- =============================================================================
package COMM.CODING is

   function To_Command is new Unchecked_Conversion
     (Source => Command_String_Type,
      Target => Command_Type);

   function To_String is new Unchecked_Conversion
     (Source => Command_Type,
      Target => Command_String_Type);

   -- Check header and footer for a command protocol.
   function Is_Valid (Command : Command_Type) return Boolean;

end COMM.CODING;
