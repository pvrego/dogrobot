with Text_IO;
with DEVS.SYSFS;
with DEVS.SYSFS.STATIC;

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
      Text_IO.Put_Line
        ("Id["&COMM.Id_Type'Image (Command.Id)&"] "&
           "Category["&COMM.Category_Type'Image (Command.Category)&"] "&
           "Data["&
           Boolean'Image (Command.Data.Status)&","&
           Float'Image (Command.Data.Value)&"]"
        );

      case Command.Id is
         when COMM.DEVICE_OUT_LAMP0 =>
            if (DigitalOut_Put_State
                (DEVS.SYSFS.STATIC.Dev_Lamp0,
                 DEVS.SYSFS.State_Type'Val (Boolean'Pos (Command.Data.Status))))
            then
               Text_IO.Put_Line ("State put with success");
            end if;

         when COMM.DEVICE_OUT_LAMP1 =>
            if (DigitalOut_Put_State
                (DEVS.SYSFS.STATIC.Dev_Lamp1,
                 DEVS.SYSFS.State_Type'Val (Boolean'Pos (Command.Data.Status))))
            then
               Text_IO.Put_Line ("State put with success");
            end if;

         when COMM.DEVICE_OUT_LAMP2 =>
            if (DigitalOut_Put_State
                (DEVS.SYSFS.STATIC.Dev_Lamp2,
                 DEVS.SYSFS.State_Type'Val (Boolean'Pos (Command.Data.Status))))
            then
               Text_IO.Put_Line ("State put with success");
            end if;

         when COMM.SYSTEM_RPI           =>
            Text_IO.Put_Line ("Implement XXXX requests.");
         when COMM.SYSTEM_WIN           =>
            Text_IO.Put_Line ("Implement XXXX requests.");
         when COMM.DEVICE_OUT_MOTOR0    =>
            Text_IO.Put_Line ("Implement XXXX requests.");
         when COMM.DEVICE_IN_CHECKFLAG0 .. COMM.DEVICE_IN_CHECKFLAG1 =>
            Text_IO.Put_Line ("Implement XXXX requests.");
         when COMM.DEVICE_IN_ANALOG0    .. COMM.DEVICE_IN_ANALOG1    =>
            Text_IO.Put_Line ("Implement XXXX requests.");
      end case;

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

   function DigitalOut_Put_State
     (Dev : access SYSFS.Device_Type; State : SYSFS.State_Type)
      return Boolean
   is
      use type SYSFS.Class_Type;
   begin
      return Dev.Class = SYSFS.DIGITAL_OUT and then
        Dev.Set_State (State);
   end DigitalOut_Put_State;

end CORE;
