with Text_IO;
with Ada.Characters.Handling;
with DEVS.SYSFS;
with DEVS.SYSFS.STATIC;

package body CORE.UI is

   ------------------------
   -- Basic_UI_Task_Type --
   ------------------------

   task body Basic_UI_Task_Type is
      Curr_Char : Character;
      use Ada.Characters.Handling;
      Curr_Dev_Number : Integer;
      Curr_Dev : access DEVS.SYSFS.Device_Type;

   begin
      Text_IO.Put_Line ("#ui# Starting Basic User Interface...");
      accept Start;

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
      Text_IO.Put ("#ui# Choose [1-9] >> ");
      loop
         Text_IO.Get (Curr_Char);
         if Is_Decimal_Digit (Curr_Char) and then
           Integer'Value (Character'Image (Curr_Char)) > 0
         then
            exit;
         end if;
      end loop;
      case Curr_Dev_Number is
         when 1 => null; -- Curr_Dev := DEVS.SYSFS.STATIC.Dev_Lamp0;
         when others => null;
      end case;

   end Basic_UI_Task_Type;

end CORE.UI;
