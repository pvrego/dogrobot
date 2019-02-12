package body CORE.BUFFER is

   ------------------------------
   -- Retrieve_Current_Command --
   ------------------------------

   function Get
     (Command : out COMM.Command_Type)
      return Boolean
   is
   begin
--        Command :=
--          (Header          => '#',
--           Id              => COMM.SYSTEM_WIN,
--           Category        => COMM.REQUEST,
--           Data => (Status => True,
--                    Value  => 0.0),
--           Footer_Slash    => '/',
--           Footer_Term     => '#');
--
--        return True;

      if (Command_Buffer_Is_Full) then
         Command := Command_Buffer;
         Command_Buffer_Is_Full := False;
         return True;
      else
         return False;
      end if;
   end Get;

   function Put
     (Command : COMM.Command_Type)
      return Boolean
   is
   begin
      if (not Command_Buffer_Is_Full) then
         Command_Buffer := Command;
         Command_Buffer_Is_Full := True;
         return True;
      else
         return False;
      end if;
   end Put;

end CORE.BUFFER;
