package body CORE.BUFFER is

   ------------------------------
   -- Retrieve_Current_Command --
   ------------------------------

   function Retrieve_Current_Command
     (Command : out COMM.Command_Type)
      return Boolean
   is
   begin
      Command :=
        (Header          => '#',
         Id              => COMM.SYSTEM_WIN,
         Category        => COMM.REQUEST,
         Data => (Status => True,
                  Value  => 0.0),
         Footer_Slash    => '/',
         Footer_Term     => '#');

      return True;

   end Retrieve_Current_Command;

end CORE.BUFFER;
