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
   for Command_Single_Type'Size use
     3 * Character'Size + Id_Type'Size + Category_Type'Size + Boolean'Size;

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
   for Command_Value_Type'Size use
     3 * Character'Size + Id_Type'Size + Category_Type'Size + Float'Size;

   type Container_Complex_Type is
      record
         Status : Boolean;
         Value  : Float;
      end record;
   for Container_Complex_Type'Size use Boolean'Size + Float'Size;
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
   for Command_Complex_Type'Size use
     3 * Character'Size + Id_Type'Size + Category_Type'Size +
       Boolean'Size + Float'Size;
   pragma Pack (Command_Complex_Type);

end COMM;
