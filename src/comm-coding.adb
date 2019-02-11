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

end COMM.CODING;
