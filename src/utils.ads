with Ada.Strings.Fixed;

package UTILS is



   function Format
     (Number_Text : String) return String is
     (Ada.Strings.Fixed.Trim (Number_Text, Ada.Strings.Left));

end UTILS;
