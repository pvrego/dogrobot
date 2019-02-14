-- =============================================================================
-- Database of static objects for DEVS.SYSFS
-- =============================================================================
package DEVS.SYSFS.STATIC is

   -- ==========================================================================
   -- Devices in use
   -- ==========================================================================

   Assigned_GPIO : array (GPIO_Descriptor_Type) of Boolean :=
     (others => False);

   Dev_Lamp0      : access Device_Type := Construct (Pin => PIN_03, Class => DIGITAL_OUT);
   Dev_Lamp1      : access Device_Type := Construct (Pin => PIN_05, Class => DIGITAL_OUT);
   Dev_Lamp2      : access Device_Type := Construct (Pin => PIN_07, Class => DIGITAL_OUT);
   Dev_Motor0     : access Device_Type := Construct (Pin => PIN_12, Class => PWM);
   Dev_CheckFlag0 : access Device_Type := Construct (Pin => PIN_13, Class => DIGITAL_IN);
   Dev_CheckFlag1 : access Device_Type := Construct (Pin => PIN_15, Class => DIGITAL_IN);
   Dev_Analog0    : access Device_Type := Construct (Pin => PIN_16, Class => ANALOG_IN);
   Dev_Analog1    : access Device_Type := Construct (Pin => PIN_18, Class => ANALOG_IN);

   -- ==========================================================================
   -- Public Services
   -- ==========================================================================

   procedure Init_Devices (Forced : Boolean := False);
   procedure DeInit_Devices;

end DEVS.SYSFS.STATIC;
