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

   type GPIO_Descriptor_Type is
     (GPIO_00_I2C0_SDA,
      GPIO_01_I2C0_SCL,
      GPIO_04_GP_CLK0,
      GPIO_14_UART0_TX,
      GPIO_15_UART0_RX,
      GPIO_17,
      GPIO_18_PWM0,
      GPIO_21,
      GPIO_22,
      GPIO_23,
      GPIO_24,
      GPIO_10_SPI_MOSI,
      GPIO_09_SPI_MISO,
      GPIO_25,
      GPIO_11_SPI_SCLK,
      GPIO_08_SPI_CS0,
      GPIO_07_SPI_SC1);

   type GPIO_Number_Type is new Integer range 0 .. 26;

   GPIO_DESCRIPTOR_NUMBER : constant
     array (GPIO_Descriptor_Type) of GPIO_Number_Type :=
     (GPIO_00_I2C0_SDA  => 0,
      GPIO_01_I2C0_SCL  => 1,
      GPIO_04_GP_CLK0   => 4,
      GPIO_07_SPI_SC1   => 7,
      GPIO_08_SPI_CS0   => 8,
      GPIO_09_SPI_MISO  => 9,
      GPIO_10_SPI_MOSI => 10,
      GPIO_11_SPI_SCLK => 11,
      GPIO_14_UART0_TX => 14,
      GPIO_15_UART0_RX => 15,
      GPIO_17           => 17,
      GPIO_18_PWM0      => 18,
      GPIO_21          => 21,
      GPIO_22          => 22,
      GPIO_23          => 23,
      GPIO_24          => 24,
      GPIO_25          => 25
     );

   type Pin_Type is
     (PIN_03,
      PIN_05,
      PIN_07,
      PIN_08,
      PIN_10,
      PIN_11,
      PIN_12,
      PIN_13,
      PIN_15,
      PIN_16,
      PIN_18,
      PIN_19,
      PIN_21,
      PIN_22,
      PIN_23,
      PIN_24,
      PIN_26
     );

   -- https://raspberry-projects.com/pi/pi-hardware/raspberry-pi-model-b/model-b-io-pins
   PIN_DESCRIPTOR : constant array (Pin_Type) of GPIO_Descriptor_Type :=
     (-- P1 Header
      PIN_03 => GPIO_00_I2C0_SDA,
      PIN_05 => GPIO_01_I2C0_SCL,
      PIN_07 => GPIO_04_GP_CLK0,
      PIN_08 => GPIO_14_UART0_TX,
      PIN_10 => GPIO_15_UART0_RX,
      PIN_11 => GPIO_17,
      PIN_12 => GPIO_18_PWM0,
      PIN_13 => GPIO_21,
      PIN_15 => GPIO_22,
      PIN_16 => GPIO_23,
      PIN_18 => GPIO_24,
      PIN_19 => GPIO_10_SPI_MOSI,
      PIN_21 => GPIO_09_SPI_MISO,
      PIN_22 => GPIO_25,
      PIN_23 => GPIO_11_SPI_SCLK,
      PIN_24 => GPIO_08_SPI_CS0,
      PIN_26 => GPIO_07_SPI_SC1);

   DESCRIPTOR_PIN : constant array (GPIO_Descriptor_Type) of Pin_Type :=
     (GPIO_00_I2C0_SDA  => PIN_03,
      GPIO_01_I2C0_SCL  => PIN_05,
      GPIO_04_GP_CLK0   => PIN_07,
      GPIO_14_UART0_TX => PIN_08,
      GPIO_15_UART0_RX => PIN_10,
      GPIO_17           => PIN_11,
      GPIO_18_PWM0      => PIN_12,
      GPIO_21          => PIN_13,
      GPIO_22          => PIN_15,
      GPIO_23          => PIN_16,
      GPIO_24          => PIN_18,
      GPIO_10_SPI_MOSI => PIN_19,
      GPIO_09_SPI_MISO  => PIN_21,
      GPIO_25          => PIN_22,
      GPIO_11_SPI_SCLK => PIN_23,
      GPIO_08_SPI_CS0   => PIN_24,
      GPIO_07_SPI_SC1   => PIN_26);

   type GPIO_Type is tagged record
      Pin   : Pin_Type;
      Class : Class_Type;
   end record;

   function Init
     (This : GPIO_Type;
      Forced : Boolean := False)
      return Boolean;

   procedure Export (This : GPIO_Type);
   procedure Unexport (This : GPIO_Type);

   procedure Init_Devices (Forced : Boolean := False);
   procedure DeInit_Devices;

   procedure Test_File_Handling;

private

   -- ==========================================================================
   -- Devices in use
   -- ==========================================================================

   Assigned_Descriptor : array (GPIO_Descriptor_Type) of Boolean :=
     (others => False);

   Dev_Lamp0      : GPIO_Type := (Pin => PIN_03, Class => DIGITAL_OUT);
   Dev_Lamp1      : GPIO_Type := (Pin => PIN_05, Class => DIGITAL_OUT);
   Dev_Lamp2      : GPIO_Type := (Pin => PIN_07, Class => DIGITAL_OUT);
   Dev_Motor0     : GPIO_Type := (Pin => PIN_12, Class => PWM);
   Dev_CheckFlag0 : GPIO_Type := (Pin => PIN_13, Class => DIGITAL_IN);
   Dev_CheckFlag1 : GPIO_Type := (Pin => PIN_15, Class => DIGITAL_IN);
   Dev_Analog0    : GPIO_Type := (Pin => PIN_16, Class => ANALOG_IN);
   Dev_Analog1    : GPIO_Type := (Pin => PIN_18, Class => ANALOG_IN);

end DEVS.SYSFS;
