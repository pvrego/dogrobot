with COMM.SOCKETS;

-- =============================================================================
-- Implements the DogRobot client main application in Windows
-- =============================================================================
procedure CLIENT_WIN is
begin

   COMM.SOCKETS.Socket_Manager.Start;

end CLIENT_WIN;
