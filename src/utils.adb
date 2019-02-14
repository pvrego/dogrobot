with Text_IO;

package body UTILS is

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

end UTILS;
