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
      GPIO0_I2C0_SDA,
      GPIO1_I2C0_SCL,
      GPIO4_GP_CLK0,
      GPIO14_UART0_TX,
      GPIO15_UART0_RX,
      GPI17,
      GPI18_PWM0,
      GPIO21,
      GPIO22,
      GPIO23,
      GPIO24,
      GPIO25,
      GPIO10_SPI_MOSI,
      GPIO9_SPI_MISO,
      GPI25,
      GPIO11_SPI_SCLK,
      GPIO8_SPI_CS0,
      GPIO7_SPI_SC1);

   type Pin_Type is new Integer range 1 .. 26;

   -- https://raspberry-projects.com/pi/pi-hardware/raspberry-pi-model-b/model-b-io-pins
   PIN_DESCRIPTOR : constant array (Pin_Type) of Descriptor_Type :=
     (-- P1 Header
     03      => GPIO0_I2C0_SDA,
      05     => GPIO1_I2C0_SCL,
      07     => GPIO4_GP_CLK0,
      08     => GPIO14_UART0_TX,
      10     => GPIO15_UART0_RX,
      11     => GPI17,
      12     => GPI18_PWM0,
      13     => GPIO21,
      15     => GPIO22,
      16     => GPIO23,
      18     => GPIO24,
      19     => GPIO10_SPI_MOSI,
      21     => GPIO9_SPI_MISO,
      22     => GPIO25,
      23     => GPIO11_SPI_SCLK,
      24     => GPIO8_SPI_CS0,
      26     => GPIO7_SPI_SC1,
      others => NONE);

   DESCRIPTOR_PIN : constant array (Descriptor_Type) of Pin_Type :=
     (GPIO0_I2C0_SDA  => 03,
      GPIO1_I2C0_SCL  => 05,
      GPIO4_GP_CLK0   => 07,
      GPIO14_UART0_TX => 08,
      GPIO15_UART0_RX => 10,
      GPI17           => 11,
      GPI18_PWM0      => 12,
      GPIO21          => 13,
      GPIO22          => 15,
      GPIO23          => 16,
      GPIO24          => 18,
      GPIO10_SPI_MOSI => 19,
      GPIO9_SPI_MISO  => 21,
      GPIO25          => 22,
      GPIO11_SPI_SCLK => 23,
      GPIO8_SPI_CS0   => 24,
      GPIO7_SPI_SC1   => 26,
      others          => 1);

   type GPIO_Type is tagged record
      Pin   : Pin_Type;
      Class : Class_Type;
   end record;

   function Init (This : GPIO_Type) return Boolean;

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

   Dev_Lamp0      : GPIO_Type := (Pin => 3, Class => DIGITAL_OUT);
   Dev_Lamp1      : GPIO_Type := (Pin => 5, Class => DIGITAL_OUT);
   Dev_Lamp2      : GPIO_Type := (Pin => 7, Class => DIGITAL_OUT);
   Dev_Motor0     : GPIO_Type := (Pin => 12, Class => PWM);
   Dev_CheckFlag0 : GPIO_Type := (Pin => 13, Class => DIGITAL_IN);
   Dev_CheckFlag1 : GPIO_Type := (Pin => 15, Class => DIGITAL_IN);
   Dev_Analog0    : GPIO_Type := (Pin => 16, Class => ANALOG_IN);
   Dev_Analog1    : GPIO_Type := (Pin => 18, Class => ANALOG_IN);

end DEVS.SYSFS;
