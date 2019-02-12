-- =============================================================================
-- Responsible for the communication modules.
-- =============================================================================
package COMM is

   type Id_Type is
     (-- System Devices, reserved for ping, status and acknoledgement
      SYSTEM_RPI,
      SYSTEM_WIN,

      -- Output Device drivers
      DEVICE_OUT_LAMP0,
      DEVICE_OUT_LAMP1,
      DEVICE_OUT_LAMP2,
      DEVICE_OUT_MOTOR0,

      -- Input Device Drivers
      DEVICE_IN_CHECKFLAG0, -- Boolean controller (alarm)
      DEVICE_IN_CHECKFLAG1,
      DEVICE_IN_ANALOG0,
      DEVICE_IN_ANALOG1
     );
   for Id_Type'Size use 4;

   type Category_Type is
     (REQUEST,
      RESPONSE
     );
   for Category_Type'Size use 1;

   -- Command Protocol Sizes Definitions
   COMMAND_LENGTH    : constant := 8;
   COMMAND_DATA_SIZE : constant := COMMAND_LENGTH * Character'Size;

   -- Type used for converting the sockets channel stream into command type.
   type String_Value_Type is new String (1 .. COMMAND_LENGTH);
   for String_Value_Type'Size use COMMAND_DATA_SIZE;

   -- Container field type for delimitation of Command_Complex_Type.
   type Container_Data_Type is
      record
         Status : Boolean;
         Value  : Float;
      end record;
   for Container_Data_Type'Size use Boolean'Size + Float'Size;
   pragma Pack (Container_Data_Type);

   -- ==========================================================================
   -- == DogRobot Command Protocol description ==
   --
   -- Header       : '#'
   -- Id           : System identificator
   -- Category     : Message category (request or response)
   -- Container    : <depends on the protocol type>
   -- Footer_Slash : '/'
   -- Footer_End   : '#'
   --
   -- Command_Value_Type :
   -- Container    : Record. Complex data is needed to be sent at the same time.
   --
   -- * If a more complex data type is required for Container_Data_Type, the
   --   total size shall be a multiple of character size. The exceeding bits
   --   shall be filled with a spare type.
   --
   -- * Any message different from this standard shall be considered as a simple
   --   string and will not be forwarded for command procedures.
   -- ==========================================================================
   type Command_Type is
      record
         Header       : Character;
         Id           : Id_Type;
         Category     : Category_Type;
         Data         : Container_Data_Type;
         Footer_Slash : Character;
         Footer_Term  : Character;
      end record;
   for Command_Type'Size use COMMAND_DATA_SIZE;
   pragma Pack (Command_Type);

   -- Type used for converting the sockets channel stream into command type.
   type Command_String_Type is new String (1 .. COMMAND_LENGTH);
   for Command_String_Type'Size use COMMAND_DATA_SIZE;

   COMMAND_DEFAULT : constant Command_Type :=
     (Header          => ' ',
      Id              => SYSTEM_RPI,
      Category        => REQUEST,
      Data => (Status => False,
               Value  => 0.0),
      Footer_Slash    => ' ',
      Footer_Term     => ' ');

end COMM;
