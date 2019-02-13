with Text_IO;

package body DEVS.SYSFS is

   ----------
   -- Init --
   ----------

   function Init (This : GPIO_Type) return Boolean is
   begin
      -- Check if the pin is already assigned to another GPIO device to avoid
      -- function conflicts.
      if not Assigned_Descriptor (PIN_DESCRIPTOR (This.Pin)) then

         case This.Class is
            when DIGITAL_OUT =>
               -- Handle device initialization
               null;

            when DIGITAL_IN =>
               -- Handle device initialization
               null;

            when ANALOG_IN =>
               -- Handle device initialization
               null;

            when PWM =>
               -- Handle device initialization
               null;

         end case;

         Assigned_Descriptor (PIN_DESCRIPTOR (This.Pin)) := True;

         return True;
      else
         return False;
      end if;
   end Init;

   ------------
   -- Export --
   ------------

   procedure Export (This : GPIO_Type) is
   begin
      null;
   end Export;

   --------------
   -- Unexport --
   --------------

   procedure Unexport (This : GPIO_Type) is
   begin
      null;
   end Unexport;

   procedure Init_Devices is
   begin

      if not Dev_Lamp0.Init or
        not Dev_Lamp1.Init or
        not Dev_Lamp2.Init or
        not Dev_Motor0.Init or
        not Dev_CheckFlag0.Init or
        not Dev_CheckFlag1.Init or
        not Dev_Analog0.Init or
        not Dev_Analog1.Init or
        not Dev_Lamp0.Init
      then
         Text_IO.Put_Line
           ("There was an error while initializing the devices.");
      end if;

   end Init_Devices;

   procedure DeInit_Devices is
   begin
      null;
   end DeInit_Devices;

   procedure Test_File_Handling is
      File_In : Text_IO.File_Type;
      File_Path : String := "./home/pi/test_file";
   begin
      Text_IO.Open (File => File_In,
                    Mode => Text_IO.In_File,
                    Name => File_Path);
      Text_IO.Put (File_In, "5");
   end Test_File_Handling;
end DEVS.SYSFS;
