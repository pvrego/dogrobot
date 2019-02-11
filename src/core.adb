with Text_IO;

package body CORE is

   --------------------
   -- Handle_Request --
   --------------------

   function Handle_Request
     (Command : COMM.Command_Single_Type)
      return COMM.Command_Single_Type
   is
      Response : COMM.Command_Single_Type;
   begin
#if Private_Warnings = "TRUE" then
      pragma Compile_Time_Warning (True, "Implement this service.");
#end if;
      Text_IO.Put_Line
        ("Id<"&COMM.Id_Type'Image (Command.Id)&">"&
           "-Cat<"&COMM.Category_Type'Image (Command.Category)&">"&
           "-Cont<"&Boolean'Image (Command.Container)&">");

      -- Return response
      Response.Category := COMM.RESPONSE;
      return Response;
   end Handle_Request;

   --------------------
   -- Handle_Request --
   --------------------

   function Handle_Request
     (Command : COMM.Command_Value_Type)
      return COMM.Command_Value_Type
   is
      Response : COMM.Command_Value_Type;
   begin
#if Private_Warnings = "TRUE" then
      pragma Compile_Time_Warning (True, "Implement this service.");
#end if;
      Text_IO.Put_Line
        ("Id<"&COMM.Id_Type'Image (Command.Id)&">"&
           "-Cat<"&COMM.Category_Type'Image (Command.Category)&">"&
           "-Cont<"&Float'Image (Command.Container)&">");

      -- Return response
      Response.Category := COMM.RESPONSE;
      return Response;
   end Handle_Request;

   --------------------
   -- Handle_Request --
   --------------------

   function Handle_Request
     (Command : COMM.Command_Complex_Type)
      return COMM.Command_Complex_Type
   is
      Response : COMM.Command_Complex_Type;
   begin
#if Private_Warnings = "TRUE" then
      pragma Compile_Time_Warning (True, "Implement this service.");
#end if;
      Text_IO.Put_Line
        ("Id<"&COMM.Id_Type'Image (Command.Id)&">"&
           "-Cat<"&COMM.Category_Type'Image (Command.Category)&">"&
           "-Cont<"&
           Boolean'Image (Command.Container.Status)&","&
           Integer'Image (Command.Container.Order)&","&
           Float'Image (Command.Container.Value)&">"
        );

      -- Return response
      Response.Category := COMM.RESPONSE;
      return Response;
   end Handle_Request;

   ---------------------
   -- Handle_Response --
   ---------------------

   procedure Handle_Response
     (Command : COMM.Command_Single_Type)
   is
   begin
#if Private_Warnings = "TRUE" then
      pragma Compile_Time_Warning (True, "Implement this service.");
#end if;
      null;
   end Handle_Response;

   ---------------------
   -- Handle_Response --
   ---------------------

   procedure Handle_Response
     (Command : COMM.Command_Value_Type)
   is
   begin
#if Private_Warnings = "TRUE" then
      pragma Compile_Time_Warning (True, "Implement this service.");
#end if;
      null;
   end Handle_Response;

   ---------------------
   -- Handle_Response --
   ---------------------

   procedure Handle_Response
     (Command : COMM.Command_Complex_Type)
   is
   begin
#if Private_Warnings = "TRUE" then
      pragma Compile_Time_Warning (True, "Implement this service.");
#end if;
      null;
   end Handle_Response;

end CORE;
