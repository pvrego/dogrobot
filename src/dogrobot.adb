with COMM;
with COMM.SOCKETS;
with CORE.BUFFER;
with DEVS.SYSFS;
with Text_IO;
with Ada.Exceptions;
with GNAT.Traceback.Symbolic;

-- =============================================================================
-- Implements the DogRobot main application in Raspberry Pi and Windows.
-- =============================================================================
procedure DOGROBOT is
begin

   Text_IO.Put_Line ("============ DogRobot ============");

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

#elsif Module = "MOD_RPI" then
   --     DEVS.SYSFS.Init_Devices;
   DEVS.SYSFS.DeInit_Devices;

#end if;

   COMM.SOCKETS.Socket_Manager.Start;

exception
   when The_Error : others =>
      Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
      Text_Io.Put_Line ("Traceback => " & GNAT.Traceback.Symbolic.Symbolic_Traceback(The_Error));

end DOGROBOT;
