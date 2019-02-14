with Text_IO;

package body DEVS.SYSFS.STATIC is

   procedure Init_Devices
     (Forced : Boolean := False) is
   begin

      if not Dev_Lamp0.Init (True) or
        not Dev_Lamp1.Init (True) or
        not Dev_Lamp2.Init (True) or
        --          not Dev_Motor0.Init (True) or
        --          not Dev_Analog0.Init (True) or
        --          not Dev_Analog1.Init (True)
        not Dev_CheckFlag0.Init (True)or
        not Dev_CheckFlag1.Init (True)
      then
         Text_IO.Put_Line
           ("There was an error while initializing the devices.");
      else
         Text_IO.Put_Line ("#devs# Devices initialized successfully.");
      end if;

   end Init_Devices;

   procedure DeInit_Devices is
   begin
      if Dev_Lamp0.DeInit and
        Dev_Lamp1.DeInit and
        Dev_Lamp2.DeInit and
        Dev_Motor0.DeInit and
        Dev_CheckFlag0.DeInit and
        Dev_CheckFlag1.DeInit and
        Dev_Analog0.DeInit and
        Dev_Analog1.DeInit and
        Dev_Lamp0.DeInit
      then
         Text_IO.Put_Line ("#devs# All devices uninitialized successfully.");
      end if;
   end DeInit_Devices;


end DEVS.SYSFS.STATIC;
