with COMM.SOCKETS;

-- =============================================================================
-- Implements the DogRobot server main application in Raspberry Pi
-- =============================================================================
procedure SERVER_RPI is
begin

   COMM.SOCKETS.Socket_Manager.Start;

end SERVER_RPI;
