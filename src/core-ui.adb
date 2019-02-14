with Text_IO;
with Ada.Characters.Handling;
with DEVS.SYSFS;
with DEVS.SYSFS.STATIC;
with Ada.Exceptions;
with GNAT.Traceback.Symbolic;
with UTILS;
with CORE.BUFFER;

package body CORE.UI is

   ------------------------
   -- Basic_UI_Task_Type --
   ------------------------

   task body Basic_UI_Task_Type is
      Curr_Char : Character;
      use Ada.Characters.Handling;
      Curr_Dev_Number : Integer := 0;
      Curr_Dev : access DEVS.SYSFS.Device_Type;
      Curr_Action : Integer := 0;
      Success : Boolean := False;

   begin
      Text_IO.Put_Line ("#ui# Starting Basic User Interface...");
      accept Start;

      loop
         -- ====================================================================
         -- Get Device
         -- ====================================================================

         Text_IO.Put_Line ("#ui# ==========================================");
         Text_IO.Put_Line ("#ui# ==== List of Devices ====");
         Text_IO.Put_Line ("#ui# [1] Dev_Lamp0");
         Text_IO.Put_Line ("#ui# [2] Dev_Lamp1");
         Text_IO.Put_Line ("#ui# [3] Dev_Lamp2");
         Text_IO.Put_Line ("#ui# [4] Dev_Motor0");
         Text_IO.Put_Line ("#ui# [5] Dev_CheckFlag0");
         Text_IO.Put_Line ("#ui# [6] Dev_CheckFlag1");
         Text_IO.Put_Line ("#ui# [7] Dev_Analog0");
         Text_IO.Put_Line ("#ui# [8] Dev_Analog1");
         Text_IO.Put_Line ("#ui# [9] ---> Exit");
         Text_IO.Put ("#ui# Choose [1-9] >> ");
         loop
            Text_IO.Get (Curr_Char);
            if Curr_Char in '1' .. '9' then
               Curr_Dev_Number := Integer'Value ((1 => Curr_Char));
               exit;
            end if;
         end loop;

         case Curr_Dev_Number is
         when 1 => Curr_Dev := DEVS.SYSFS.STATIC.Dev_Lamp0;
         when 2 => Curr_Dev := DEVS.SYSFS.STATIC.Dev_Lamp1;
         when 3 => Curr_Dev := DEVS.SYSFS.STATIC.Dev_Lamp2;
         when 4 => Curr_Dev := DEVS.SYSFS.STATIC.Dev_Motor0;
         when 5 => Curr_Dev := DEVS.SYSFS.STATIC.Dev_CheckFlag0;
         when 6 => Curr_Dev := DEVS.SYSFS.STATIC.Dev_CheckFlag1;
         when 7 => Curr_Dev := DEVS.SYSFS.STATIC.Dev_Analog0;
         when 8 => Curr_Dev := DEVS.SYSFS.STATIC.Dev_Analog1;
         when 9 => exit;
         when others => null;
         end case;

         -- ====================================================================
         -- Direct actions from devices
         -- ====================================================================
         Curr_Char := ' ';
         Text_IO.Put_Line ("#ui# ==== Actions for "& DEVS.SYSFS.Class_Type'Image (Curr_Dev.Class)&" ====");
         case Curr_Dev.Class is
         when DEVS.SYSFS.DIGITAL_OUT =>
            Text_IO.Put_Line ("#ui# [1] Read State");
            Text_IO.Put_Line ("#ui# [2] Turn On");
            Text_IO.Put_Line ("#ui# [3] Turn Off");
            loop
               Text_IO.Get (Curr_Char);
               if Curr_Char in '1' .. '3' then
                  Curr_Action := Integer'Value ((1 => Curr_Char));
                  exit;
               end if;
            end loop;
            case Curr_Action is
               when 1 => Text_IO.Put_Line ("Action for DIGITAL_OUT"); -- Read state action
               when 2 => Text_IO.Put_Line ("Action for DIGITAL_OUT"); -- Turn on
                  if CORE.BUFFER.Put
                    (('#', DEVS.SYSFS.STATIC.PIN_TO_COMMAND (Curr_Dev.Pin),
                     COMM.REQUEST, (True, 0.0), '/', '#')) then
                     Text_IO.Put_Line ("Action for DIGITAL_OUT sent successfully.");
                  end if;

               when 3 => Text_IO.Put_Line ("Action for DIGITAL_OUT"); -- Turn off
                  if CORE.BUFFER.Put
                    (('#', DEVS.SYSFS.STATIC.PIN_TO_COMMAND (Curr_Dev.Pin),
                     COMM.REQUEST, (True, 0.0), '/', '#')) then
                     Text_IO.Put_Line ("Action for DIGITAL_OUT sent successfully.");
                  end if;
               when others => null;
            end case;

         when DEVS.SYSFS.DIGITAL_IN =>
            Text_IO.Put_Line ("#ui# [1] Read State");
            loop
               Text_IO.Get (Curr_Char);
               if Curr_Char = '1' then exit; end if;
            end loop;
            Text_IO.Put_Line ("Action for DIGITAL_IN");

         when DEVS.SYSFS.ANALOG_IN =>
            Text_IO.Put_Line ("#ui# [1] Read Value");
            loop
               Text_IO.Get (Curr_Char);
               if Curr_Char = '1' then exit; end if;
            end loop;
            Text_IO.Put_Line ("Action for ANALOG_IN");

         when DEVS.SYSFS.PWM =>
            Text_IO.Put_Line ("#ui# [1] Set Period > ");
            Text_IO.Put_Line ("#ui# [2] Set Duty Cycle > ");
            Text_IO.Put_Line ("Action for PWM");
         end case;
      end loop;

   exception
      when The_Error : others =>
         Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
         Text_Io.Put_Line ("Traceback => " & GNAT.Traceback.Symbolic.Symbolic_Traceback(The_Error));

   end Basic_UI_Task_Type;

end CORE.UI;
