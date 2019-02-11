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
   COMMAND_SINGLE_SIZE  : constant := 4 * Character'Size;
   COMMAND_VALUE_SIZE   : constant := 8 * Character'Size;
   COMMAND_COMPLEX_SIZE : constant := 13 * Character'Size;

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
   -- Command_Single_Type :
   -- Container    : Bit/Boolean responses as acknowledgement, led state or
   --                status.
   --
   -- * Any message different from this standard shall be considered as a simple
   --   string and will not be forwarded for command procedures.
   -- ==========================================================================
   type Command_Single_Type is
      record
         Header       : Character;
         Id           : Id_Type;
         Category     : Category_Type;
         Container    : Boolean;
         Footer_Slash : Character;
         Footer_Term  : Character;
      end record;
   pragma Pack (Command_Single_Type);
   for Command_Single_Type'Size use 4 * Character'Size;

   -- Type used for converting the sockets channel stream into command type.
   type String_Single_Type is new String (1 .. 4);
   for String_Single_Type'Size use 4 * Character'Size;

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
   -- Container    : Double. Float responses as analog measurements.
   --
   -- * Any message different from this standard shall be considered as a simple
   --   string and will not be forwarded for command procedures.
   -- ==========================================================================
   type Command_Value_Type is
      record
         Header       : Character;
         Id           : Id_Type;
         Category     : Category_Type;
         Container    : Float;
         Footer_Slash : Character;
         Footer_Term  : Character;
      end record;
   pragma Pack (Command_Value_Type);
   for Command_Value_Type'Size use 8 * Character'Size;

   -- Type used for converting the sockets channel stream into command type.
   type String_Value_Type is new String (1 .. 8);
   for String_Value_Type'Size use 8 * Character'Size;

   -- Container field type for delimitation of Command_Complex_Type.
   type Container_Complex_Type is
      record
         Status : Boolean;
         Order  : Integer;
         Value  : Float;
      end record;
   for Container_Complex_Type'Size use Boolean'Size + Integer'Size + Float'Size;
   pragma Pack (Container_Complex_Type);

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
   -- * If a more complex data type is required for Container_Complex_Type, the
   --   total size shall be a multiple of character size. The exceeding bits
   --   shall be filled with a spare type.
   --
   -- * Any message different from this standard shall be considered as a simple
   --   string and will not be forwarded for command procedures.
   -- ==========================================================================
   type Command_Complex_Type is
      record
         Header       : Character;
         Id           : Id_Type;
         Category     : Category_Type;
         Container    : Container_Complex_Type;
         Footer_Slash : Character;
         Footer_Term  : Character;
      end record;
   for Command_Complex_Type'Size use 13 * Character'Size;
   pragma Pack (Command_Complex_Type);

   -- Type used for converting the sockets channel stream into command type.
   type String_Complex_Type is new String (1 .. 13);
   for String_Complex_Type'Size use 13 * Character'Size;
end COMM;
