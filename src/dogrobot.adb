with COMM;
with COMM.SOCKETS;
with CORE.BUFFER;
with DEVS.SYSFS.STATIC;
with Text_IO;
with Ada.Exceptions;
with GNAT.Traceback.Symbolic;
with TESTS;
with CORE.UI;

-- =============================================================================
-- Implements the DogRobot main application in Raspberry Pi and Windows.
-- =============================================================================
procedure DOGROBOT is
   package SYSFS renames DEVS.SYSFS.STATIC;

begin

   Text_IO.Put_Line ("============ DogRobot ============");

   -- ==========================================================================
   -- Sockets management
   -- ==========================================================================

   COMM.SOCKETS.Socket_Manager.Init;

#if Module = "MOD_WIN" then
   declare
      Command : COMM.Command_Type :=
        (Header          => '#',
         Id              => COMM.SYSTEM_WIN,
         Category        => COMM.REQUEST,
         Data => (Status => True,
                  Value  => 0.0),
         Footer_Slash    => '/',
         Footer_Term     => '#');
      Success : Boolean;
   begin
      Success := CORE.BUFFER.Put (Command);
   end;
#end if;

   COMM.SOCKETS.Socket_Manager.Start;

   -- ==========================================================================
   -- Devices management
   -- ==========================================================================

#if Module = "MOD_RPI" then
   SYSFS.Init_Devices;
   --     DEVS.SYSFS.DeInit_Devices;
#end if;

   -- ==========================================================================
   -- User Interface
   -- ==========================================================================

#if Module = "MOD_WIN" then
   declare
      Basic_UI : CORE.UI.Basic_UI_Task_Type;
   begin
      Basic_UI.Start;
   end;
#end if;

exception
   when The_Error : others =>
      Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
      Text_Io.Put_Line ("Traceback => " & GNAT.Traceback.Symbolic.Symbolic_Traceback(The_Error));

end DOGROBOT;
