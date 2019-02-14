-- =============================================================================
-- Database of static objects for DEVS.SYSFS
-- =============================================================================
package DEVS.SYSFS.STATIC is

   -- ==========================================================================
   -- Devices in use
   -- ==========================================================================

   Dev_Lamp0      : access Device_Type := Construct (Pin => PIN_03, Class => DIGITAL_OUT);
   Dev_Lamp1      : access Device_Type := Construct (Pin => PIN_05, Class => DIGITAL_OUT);
   Dev_Lamp2      : access Device_Type := Construct (Pin => PIN_07, Class => DIGITAL_OUT);
   Dev_Motor0     : access Device_Type := Construct (Pin => PIN_12, Class => PWM);
   Dev_CheckFlag0 : access Device_Type := Construct (Pin => PIN_13, Class => DIGITAL_IN);
   Dev_CheckFlag1 : access Device_Type := Construct (Pin => PIN_15, Class => DIGITAL_IN);
   Dev_Analog0    : access Device_Type := Construct (Pin => PIN_16, Class => ANALOG_IN);
   Dev_Analog1    : access Device_Type := Construct (Pin => PIN_18, Class => ANALOG_IN);

   PIN_TO_COMMAND : constant array (Pin_Type) of COMM.Id_Type :=
     (PIN_03 => COMM.DEVICE_OUT_LAMP0,
      PIN_05 => COMM.DEVICE_OUT_LAMP1,
      PIN_07 => COMM.DEVICE_OUT_LAMP2,
      PIN_12 => COMM.DEVICE_OUT_MOTOR0,
      PIN_13 => COMM.DEVICE_IN_CHECKFLAG0,
      PIN_15 => COMM.DEVICE_IN_CHECKFLAG1,
      PIN_16 => COMM.DEVICE_IN_ANALOG0,
      PIN_18 => COMM.DEVICE_IN_ANALOG1,
      others => COMM.SYSTEM_RPI
     );

   -- ==========================================================================
   -- Public Services
   -- ==========================================================================

   procedure Init_Devices (Forced : Boolean := False);
   procedure DeInit_Devices;

end DEVS.SYSFS.STATIC;
