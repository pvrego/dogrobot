with COMM.SOCKETS;

-- =============================================================================
-- Implements the DogRobot main application in Raspberry Pi and Windows.
-- =============================================================================
procedure DOGROBOT is
begin

   COMM.SOCKETS.Socket_Manager.Start;

end DOGROBOT;
