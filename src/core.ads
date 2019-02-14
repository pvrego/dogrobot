with COMM;
with DEVS.SYSFS;

-- =============================================================================
-- Responsible for the high-level functions
-- =============================================================================
package CORE is

   package SYSFS renames DEVS.SYSFS;

   function Handle_Request
     (Command : COMM.Command_Type)
      return COMM.Command_Type; -- returns a response

   procedure Handle_Response
     (Command : COMM.Command_Type);

--     procedure Digital_Out_TurnOn
--       (Dev : SYSFS.Device_Type
end CORE;
