with COMM.CODING;
with CORE;
with Text_IO;

package body COMM.PROCESS is

   function Process_Request_Message
     (Message  : String;
      Response : out Command_Type)
      return Boolean
   is
      Command : COMM.Command_Type;
   begin

      if (Message'Size = COMM.COMMAND_DATA_SIZE) then
         Command := COMM.CODING.To_Command (COMM.Command_String_Type (Message));

         if COMM.CODING.Is_Valid (Command) and then
           Command.Category = REQUEST
         then
            Response := CORE.Handle_Request (Command);
            return True;
         else
            return False;
         end if;
      end if;

      -- =======================================================================
      -- Process like a common text string.
      -- =======================================================================
      Text_IO.Put_Line ("=== General string message of size"
                        & Integer'Image (Message'Size));
      return False;

   end Process_Request_Message;

   function Process_Response_Message
     (Message : String)
      return Boolean
   is
      Command : COMM.Command_Type;
   begin
      if (Message'Size = COMM.COMMAND_DATA_SIZE) then
         Command := COMM.CODING.To_Command (COMM.Command_String_Type (Message));

         if COMM.CODING.Is_Valid (Command) and then
           Command.Category = RESPONSE
         then
            CORE.Handle_Response (Command);
            return True;
         else
            return False;
         end if;
      end if;

      -- =======================================================================
      -- Process like a common text string.
      -- =======================================================================
      Text_IO.Put_Line ("=== General string message of size"
                        & Integer'Image (Message'Size));
      return False;

      end Process_Response_Message;

end COMM.PROCESS;
