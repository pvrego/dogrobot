with COMM.CODING;
with CORE;
with Text_IO;

package body COMM.PROCESS is

   function Process_Input_Message
     (Message  : String;
      Relevant : out Boolean)
      return String
   is
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
            Response : COMM.Command_Single_Type;
         begin
            if Command.Category = REQUEST then
               Response := CORE.Handle_Request (Command);
               Response.Category := COMM.RESPONSE; -- Force this
               Relevant := True;
            else
               CORE.Handle_Response (Command); -- WRONG == server only processes requests
            end if;
            return String (COMM.CODING.To_String_Single (Response));
         end;
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
            Response : COMM.Command_Value_Type;
         begin
            if Command.Category = REQUEST then
               Response := CORE.Handle_Request (Command);
               Response.Category := COMM.RESPONSE; -- Force this
               Relevant := True;
            else
               CORE.Handle_Response (Command);
            end if;
            return String (COMM.CODING.To_String_Value (Response));
         end;
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
            Response : COMM.Command_Complex_Type;
         begin
            if Command.Category = REQUEST then
               Response := CORE.Handle_Request (Command);
               Response.Category := COMM.RESPONSE; -- Force this
               Relevant := True;
            else
               CORE.Handle_Response (Command);
            end if;
            return String (COMM.CODING.To_String_Complex (Response));
         end;
      end if;

      -- =======================================================================
      -- Process like a common text string.
      -- =======================================================================
      Text_IO.Put_Line ("=== General string message of size" & Integer'Image (Message'Size));
      Relevant := True;
      return Message;

   end Process_Input_Message;

end COMM.PROCESS;
