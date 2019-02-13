with COMM;
with COMM.SOCKETS;
with CORE.BUFFER;
with DEVS.SYSFS;

-- =============================================================================
-- Implements the DogRobot main application in Raspberry Pi and Windows.
-- =============================================================================
procedure DOGROBOT is
begin

--   COMM.SOCKETS.Socket_Manager.Init;

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
   DEVS.SYSFS.Init_Devices;
   DEVS.SYSFS.Test_File_Handling;
#end if;

   -- At this point this will be deactivated.
   -- COMM.SOCKETS.Socket_Manager.Start;

end DOGROBOT;
