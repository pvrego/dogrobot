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
