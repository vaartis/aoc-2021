with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;

with Ada.Assertions; use Ada.Assertions;

package body Seven is
   function Determine_Fuel_For_Position(Wanted_Position : Natural; Increasing : Boolean) return Natural is
      Total_Fuel_Needed : Natural := 0;
   begin
      for Crab_I in Crab_Vector.Iterate loop
         declare
            Fuel_Use : Natural := 1;
            Fuel_Used_This_Time : Natural := 0;
            Current_Pos : Natural := Crab_Vector(Crab_I);
         begin
            if Increasing then
            while Current_Pos /= Wanted_Position loop
               Current_Pos := (if Current_Pos > Wanted_Position then Current_Pos - 1 else Current_Pos + 1);
               Fuel_Used_This_Time := Fuel_Used_This_Time + Fuel_use;

                  Fuel_Use := Fuel_Use + 1;
               end loop;
            else
               Fuel_Used_This_time := abs(Crab_Vector(Crab_I) - Wanted_Position);
            end if;

            Total_Fuel_Needed := Total_Fuel_Needed + Fuel_Used_This_Time;
         end;
      end loop;

      return Total_Fuel_Needed;
   end Determine_Fuel_For_Position;

   procedure Part(Which : Which_Part) is
      Input : File_Type;

      Read_Number : Natural;
      Read_Character : Character;

      Fuel_Used : Natural_Vectors.Vector;
   begin
      Open(Input, Mode => In_File, Name => "7.txt");

      loop
         Get(Input, Read_Number);
         Crab_Vector.Append(Read_Number);

         exit when End_Of_File(Input);
         Get(Input, Read_Character);
         Assert(Read_Character = ',');
      end loop;

      declare
         Max_Pos : natural := 0;
      begin
         for Pos of Crab_Vector loop
            Max_Pos := (if Pos > Max_Pos then Pos else Max_Pos);
         end loop;

         for I in 0..Max_Pos loop
            Fuel_Used.Append(case Which is
                                when 1 => Determine_Fuel_For_Position(I, Increasing => False),
                                when 2 => Determine_Fuel_For_Position(I, Increasing => True));
         end loop;
      end;

      -- Sort, smallest first. Display that
      Natural_Vectors_Sorting.Sort(Fuel_Used);
      Put_Line(Fuel_Used.First_Element'Image);

      Crab_Vector.Clear;
      Close(Input);
   end Part;
end Seven;
