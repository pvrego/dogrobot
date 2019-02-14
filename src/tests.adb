with Text_IO;
with DEVS.SYSFS; use DEVS.SYSFS;
with DEVS.SYSFS.STATIC;

package body TESTS is

   package SYSFS renames DEVS.SYSFS.STATIC;
   ------------------------
   -- Test_File_Handling --
   ------------------------

   procedure Test_File_Handling is
      File_In : Text_IO.File_Type;
      File_Path : String := "/home/pi/test_file";
   begin
      Text_IO.Put_Line ("File will open.");
      Text_IO.Open (File => File_In,
                    Mode => Text_IO.Out_File,
                    Name => File_Path);
      Text_IO.Put_Line ("File will be written.");
      Text_IO.Put (File_In, "5");
      Text_IO.Put_Line (File_Path & "is written.");
      Text_IO.Close (File_In);
      Text_IO.Put_Line (File_Path & "is closed.");
   end Test_File_Handling;


   procedure Test_Lamps_012 is
      Delay_Time : constant Duration := 0.01;
   begin
      --        for Index in Integer range 1 .. 20
      loop
         if (SYSFS.Dev_Lamp0.Set_State (ON)) then Text_IO.Put ("^"); end if;
         delay Delay_Time;
         if (SYSFS.Dev_Lamp0.Set_State (OFF)) then Text_IO.Put ("~"); end if;
         delay Delay_Time;
      end loop;
   end Test_Lamps_012;

end TESTS;
