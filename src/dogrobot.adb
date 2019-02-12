with COMM;
with COMM.SOCKETS;
with CORE.BUFFER;

-- =============================================================================
-- Implements the DogRobot main application in Raspberry Pi and Windows.
-- =============================================================================
procedure DOGROBOT is
begin

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

end DOGROBOT;
