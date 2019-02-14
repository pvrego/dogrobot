with Text_IO;
with Ada.Exceptions;
with UTILS; use UTILS;

package body DEVS.SYSFS is

   function Construct (Pin : Pin_Type; Class : Class_Type)
     return access Device_Type
   is
      To_Return : access Device_Type := new Device_Type;
   begin
      To_Return.Pin := Pin;
      To_Return.Class := Class;
      To_Return.Assigned := False;
      return To_Return;
   end Construct;

   ----------
   -- Init --
   ----------

   function Init
     (This : in out Device_Type;
      Forced : Boolean)
      return Boolean
   is
      Success : Boolean := False;
      Gpio_Str : constant String :=
        GPIO_Descriptor_Type'Image (TO_GPIO (This.Pin));
   begin
#if Private_Warnings then
      pragma Compile_Time_Warning (TRUE, "Implement devices initialization.");
#end if;
      -- Check if the pin is already assigned to another GPIO device to avoid
      -- function conflicts.
      if not This.Assigned then

         case This.Class is
            when DIGITAL_OUT =>
               -- Handle device initialization
               if This.Export (Forced) and then This.Set_Direction (GPIO_OUT) then
                  Text_IO.Put_Line
                    ("#devs# "&Gpio_Str&" exported as "
                     &Class_Type'Image (This.Class)&" successfully.");
               end if;
            when DIGITAL_IN =>
               -- Handle device initialization
               if This.Export (Forced) and then This.Set_Direction (GPIO_IN) then
                  Text_IO.Put_Line
                    ("#devs# "&Gpio_Str&" exported as "
                     &Class_Type'Image (This.Class)&" successfully.");
               end if;

            when ANALOG_IN =>
               -- Handle device initialization
               null;

            when PWM =>
               -- Handle device initialization
               null;

         end case;

         This.Assigned := True;

         return True;
      else
         return False;
      end if;

   exception
      when The_Error : others =>
         Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
         return False;
   end Init;

   function DeInit
     (This : in out Device_Type)
      return Boolean
   is
   begin
      if This.Assigned and This.Unexport then
         This.Assigned := False;
         return True;
      end if;
      return False;

   exception
      when The_Error : others =>
         Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
         return False;
   end DeInit;

   ------------
   -- Export --
   ------------

   function Export (This : Device_Type; Forced : Boolean) return Boolean is
      Full_Name : constant String := GPIO_BASE_PATH & "/export";
      Curr_File : Text_IO.File_Type;
      Cmd : constant String :=
        Format (GPIO_Number_Type'Image (TO_GPIO_NUMBER (TO_GPIO (This.Pin))));

   begin

      if Forced and then This.Unexport then null; end if;

      Text_IO.Open (Curr_File, Text_IO.Out_File, Full_Name);
      Text_IO.Put_Line (Curr_File, Cmd);
      Text_IO.Close (Curr_File);
      return True;

   exception
      when The_Error : others =>
         Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
         return False;
   end Export;

   --------------
   -- Unexport --
   --------------

   function Unexport (This : Device_Type) return Boolean is
      Full_Name : constant String := GPIO_BASE_PATH & "/unexport";
      Curr_File : Text_IO.File_Type;
      Cmd : constant String :=
        Format (GPIO_Number_Type'Image (TO_GPIO_NUMBER (TO_GPIO (This.Pin))));
   begin
      Text_IO.Open (Curr_File, Text_IO.Out_File, Full_Name);
      Text_IO.Put_Line (Curr_File, Cmd);
      Text_IO.Close (Curr_File);
      return True;
   exception
      when The_Error : others =>
         Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
         return False;
   end Unexport;

   function Set_Direction (This : Device_Type; Direction : Direction_Type) return Boolean is
      Full_Name : constant String :=
        GPIO_BASE_PATH & "/gpio" &
        Format (GPIO_Number_Type'Image (TO_GPIO_NUMBER (TO_GPIO (This.Pin))))
        & "/direction";
      Curr_File : Text_IO.File_Type;
   begin
      Text_IO.Open (Curr_File, Text_IO.Out_File, Full_Name);
      case Direction is
         when GPIO_IN  => Text_IO.Put (Curr_File, "in");
         when GPIO_OUT => Text_IO.Put (Curr_File, "out");
      end case;
      Text_IO.Close (Curr_File);

      return True;
   exception
      when The_Error : others =>
         Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
         return False;
   end Set_Direction;

   function Set_State (This : Device_Type; State : State_Type) return Boolean is
      Full_Name : constant String :=
        GPIO_BASE_PATH & "/gpio" &
        Format (GPIO_Number_Type'Image (TO_GPIO_NUMBER (TO_GPIO (This.Pin))))
        & "/value";
      Curr_File : Text_IO.File_Type;
   begin
      if This.Assigned then
         Text_IO.Open (Curr_File, Text_IO.Out_File, Full_Name);
         Text_IO.Put_Line (Curr_File, Format (Integer'Image (State_Type'Pos (State))));
         Text_IO.Close (Curr_File);
         return True;
      else
         Text_IO.Put_Line ("Gpio value set error.");
         return False;
      end if;

   exception
      when The_Error : others =>
         Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
         return False;
   end Set_State;

   function Get_Value (This : Device_Type) return Integer is
      Full_Name : constant String :=
        GPIO_BASE_PATH & "/gpio" &
        Format (GPIO_Number_Type'Image (TO_GPIO_NUMBER (TO_GPIO (This.Pin))))
        & "/value";
      Curr_File : Text_IO.File_Type;
      Value : Integer := 0;
   begin
      if This.Assigned then
         Text_IO.Open (Curr_File, Text_IO.In_File, Full_Name);
         Value := Integer'Value (Text_IO.Get_Line (Curr_File));
         Text_IO.Close (Curr_File);
      else
         Text_IO.Put_Line ("Gpio value get error.");
      end if;

      return Value;

   exception
      when The_Error : others =>
         Text_IO.Put_Line("!!! "&Ada.Exceptions.Exception_Information (The_Error));
         return 0;
   end Get_Value;

end DEVS.SYSFS;
