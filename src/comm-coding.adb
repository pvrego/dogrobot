with Text_IO;

package body COMM.CODING is

   function Is_Valid (Command : Command_Single_Type) return Boolean is
   begin
      return
        Command.Header = '#' and then
        Command.Footer_Slash = '/' and then
        Command.Footer_Term = '#';
   end Is_Valid;

   function Is_Valid (Command : Command_Value_Type) return Boolean is
   begin
      return
        Command.Header = '#' and then
        Command.Footer_Slash = '/' and then
        Command.Footer_Term = '#';
   end Is_Valid;

   function Is_Valid (Command : Command_Complex_Type) return Boolean is
   begin
      return
        Command.Header = '#' and then
        Command.Footer_Slash = '/' and then
        Command.Footer_Term = '#';
   end Is_Valid;

   procedure Process_Message (Message : String) is
   begin

      -- =======================================================================
      -- Command Single Type process
      -- =======================================================================
      if (Message'Size = COMM.COMMAND_SINGLE_SIZE) and then COMM.CODING.Is_Valid
        (COMM.CODING.To_Command_Single (COMM.String_Single_Type (Message)))
      then
         declare
            Command : constant COMM.Command_Single_Type :=
              COMM.CODING.To_Command_Single (COMM.String_Single_Type (Message));
         begin
            pragma Compile_Time_Warning (TRUE, "Command Single Type process");
            Text_IO.Put_Line ("Command Single Type : Map to CORE");
         end;
         return;
      end if;

      -- =======================================================================
      -- Command Value Type process
      -- =======================================================================
      if (Message'Size = COMM.COMMAND_VALUE_SIZE) and then COMM.CODING.Is_Valid
        (COMM.CODING.To_Command_Value (COMM.String_Value_Type (Message)))
      then
         declare
            Command : constant COMM.Command_Value_Type :=
              COMM.CODING.To_Command_Value (COMM.String_Value_Type (Message));
         begin
            pragma Compile_Time_Warning (TRUE, "Command Value Type process");
            Text_IO.Put_Line ("Command Value Type : Map to CORE");
         end;
         return;
      end if;

      -- =======================================================================
      -- Command Complex Type process
      -- =======================================================================
      if (Message'Size = COMM.COMMAND_COMPLEX_SIZE) and then COMM.CODING.Is_Valid
        (COMM.CODING.To_Command_Complex (COMM.String_Complex_Type (Message)))
      then
         declare
            Command : constant COMM.Command_Complex_Type :=
              COMM.CODING.To_Command_Complex (COMM.String_Complex_Type (Message));
         begin
            pragma Compile_Time_Warning (TRUE, "Command Complex Type process");
            Text_IO.Put_Line ("Command Complex Type : Map to CORE");
         end;
         return;
      end if;

      -- =======================================================================
      -- Process like a common text string.
      -- =======================================================================
      Text_IO.Put_Line ("General string message of size" & Integer'Image (Message'Size));

   end Process_Message;

end COMM.CODING;
