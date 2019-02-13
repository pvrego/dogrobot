-- =============================================================================
-- Responsible for SYSFS setups and management.
-- =============================================================================
package DEVS.SYSFS is

   --  ===================
   --  GPIO functions list
   --  ===================
   --  PWM (pulse-width modulation)
   --    Software PWM available on all pins
   --    Hardware PWM available on GPIO12, GPIO13, GPIO18, GPIO19
   --  SPI
   --    SPI0: MOSI (GPIO10); MISO (GPIO9); SCLK (GPIO11); CE0 (GPIO8), CE1 (GPIO7)
   --    SPI1: MOSI (GPIO20); MISO (GPIO19); SCLK (GPIO21); CE0 (GPIO18); CE1 (GPIO17); CE2 (GPIO16)
   --  I2C
   --    Data: (GPIO2); Clock (GPIO3)
   --    EEPROM Data: (GPIO0); EEPROM Clock (GPIO1)
   --  Serial
   --    TX (GPIO14); RX (GPIO15)

-- Para usar o wiringpi (e portanto o command-line gpio), instalar via apt-get
   --   sudo apt-get install wiringpi

   type Class_Type is (DIGITAL_OUT, DIGITAL_IN, ANALOG_IN, PWM);

   type Descriptor_Type is
     (NONE,
      GPIO2,
      GPIO3,
      GPIO4,
      GPIO5,
      GPIO6,
      GPIO7,
      GPIO8,
      GPIO9,
      GPIO10,
      GPIO11,
      GPIO12_PWM,
      GPIO13_PWM,
      GPIO14,
      GPIO15,
      GPIO16,
      GPIO17,
      GPIO18_PWM,
      GPIO19,
      GPIO20,
      GPIO21,
      GPIO22,
      GPIO23,
      GPIO24,
      GPIO25,
      GPIO26,
      GPIO27_PWM,
      ID_SD,
      ID_SC);

   type Pin_Type is new Integer range 1 .. 40;

   PIN_DESCRIPTOR : constant array (Pin_Type) of Descriptor_Type :=
     (03     => GPIO2,
      05     => GPIO3,
      07     => GPIO4,
      08     => GPIO14,
      10     => GPIO15,
      11     => GPIO17,
      12     => GPIO18_PWM,
      13     => GPIO27_PWM,
      15     => GPIO22,
      16     => GPIO23,
      18     => GPIO24,
      19     => GPIO10,
      21     => GPIO9,
      22     => GPIO25,
      23     => GPIO11,
      24     => GPIO8,
      26     => GPIO7,
      27     => ID_SD,
      28     => ID_SC,
      29     => GPIO5,
      31     => GPIO6,
      32     => GPIO12_PWM,
      33     => GPIO13_PWM,
      35     => GPIO19,
      36     => GPIO16,
      37     => GPIO26,
      38     => GPIO20,
      40     => GPIO21,
      others => NONE);

   DESCRIPTOR_PIN : constant array (Descriptor_Type) of Pin_Type :=
     (GPIO10     => 19,
      GPIO11     => 23,
      GPIO12_PWM => 32,
      GPIO13_PWM => 33,
      GPIO14     => 08,
      GPIO15     => 10,
      GPIO16     => 36,
      GPIO17     => 11,
      GPIO18_PWM => 12,
      GPIO19     => 35,
      GPIO2      => 03,
      GPIO20     => 38,
      GPIO21     => 40,
      GPIO22     => 15,
      GPIO23     => 16,
      GPIO24     => 18,
      GPIO25     => 22,
      GPIO26     => 37,
      GPIO27_PWM => 13,
      GPIO3      => 05,
      GPIO4      => 07,
      GPIO5      => 29,
      GPIO6      => 31,
      GPIO7      => 26,
      GPIO8      => 24,
      GPIO9      => 21,
      ID_SC      => 28,
      ID_SD      => 27,
      NONE       => 1);

   type GPIO_Type is tagged record
      Pin   : Pin_Type;
      Class : Class_Type;
   end record;

   function Init
     (This  : GPIO_Type)
      return Boolean;

   procedure Export (This : GPIO_Type);
   procedure Unexport (This : GPIO_Type);

   procedure Init_Devices;
   procedure DeInit_Devices;

private

-- ==========================================================================
-- Devices in use
-- ==========================================================================

   Assigned_Descriptor : array (Descriptor_Type) of Boolean :=
     (others => False);

   -- Digital output
   Dev_Lamp0 : GPIO_Type := (Pin => 11, Class => DIGITAL_OUT);
   Dev_Lamp1 : GPIO_Type := (Pin => 13, Class => DIGITAL_OUT);
   Dev_Lamp2 : GPIO_Type := (Pin => 15, Class => DIGITAL_OUT);

   -- PWM
   Dev_Motor0 : GPIO_Type := (Pin => 32, Class => PWM);

   -- Digital input
   Dev_CheckFlag0 : GPIO_Type := (Pin => 16, Class => DIGITAL_IN);
   Dev_CheckFlag1 : GPIO_Type := (Pin => 18, Class => DIGITAL_IN);

   -- Analog input
   Dev_Analog0 : GPIO_Type := (Pin => 36, Class => ANALOG_IN);
   Dev_Analog1 : GPIO_Type := (Pin => 38, Class => ANALOG_IN);

end DEVS.SYSFS;
