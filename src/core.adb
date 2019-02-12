with Text_IO;

package body CORE is

   --------------------
   -- Handle_Request --
   --------------------

   function Handle_Request
     (Command : COMM.Command_Type)
      return COMM.Command_Type
   is
      Response : COMM.Command_Type := Command;
   begin
#if Private_Warnings = "TRUE" then
      pragma Compile_Time_Warning (True, "Implement this service.");
#end if;
      Text_IO.Put_Line
        ("Id["&COMM.Id_Type'Image (Command.Id)&"] "&
           "Category["&COMM.Category_Type'Image (Command.Category)&"] "&
           "Data["&
           Boolean'Image (Command.Data.Status)&","&
           Float'Image (Command.Data.Value)&"]"
        );

      -- Return response
      Response.Category := COMM.RESPONSE;
      return Response;
   end Handle_Request;

   ---------------------
   -- Handle_Response --
   ---------------------

   procedure Handle_Response
     (Command : COMM.Command_Type)
   is
   begin
#if Private_Warnings = "TRUE" then
      pragma Compile_Time_Warning (True, "Implement this service.");
#end if;
      Text_IO.Put_Line
        ("Id["&COMM.Id_Type'Image (Command.Id)&"] "&
           "Category["&COMM.Category_Type'Image (Command.Category)&"] "&
           "Data["&
           Boolean'Image (Command.Data.Status)&","&
           Float'Image (Command.Data.Value)&"]"
        );
   end Handle_Response;

end CORE;
