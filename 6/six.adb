with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;

with Ada.Assertions; use Ada.Assertions;

package body Six is
   protected body Protected_Fish is
      procedure Append(To_Append : Fish_Vectors.Vector) is
      begin
         Fishes.Append(To_Append);
      end Append;

      procedure Set_Fish_At(I : Natural; Value : Natural) is
      begin
         Fishes(I) := Value;
      end Set_Fish_At;

      procedure Clear is
      begin
         Fishes.Clear;
      end;

      procedure Image is
      begin
         for Fish of Fishes loop
            Put(Fish'Image);
            Put(" ");
         end loop;
         Put_Line("");
      end;

      function Fish_At(I : Natural) return Natural is
      begin
         return Fishes(I);
      end Fish_At;

      function Count return Ada.Containers.Count_Type is
      begin
         return Fishes.Length;
      end Count;
   end;

   task body Count_Range is
      New_Fishes : Fish_Vectors.Vector;
   begin
      for I in Range_Start .. Range_end loop
         if Protected_Fish.Fish_At(I) = 0 then
            Protected_Fish.Set_Fish_At(I, 6);

            New_Fishes.Append(8);
         else
            Protected_Fish.Set_Fish_At(I, Protected_Fish.Fish_At(I) - 1);
         end if;
      end loop;
      Protected_Fish.Append(New_Fishes);
   end;

   procedure Process is
      Task_Count : constant Integer := 4;
      Tasks : array (1 .. Task_Count) of Count_Range_Pointer;

      Slice_Size : Natural;
      Last_Slice_Additional : Natural;
   begin
      Slice_Size := Natural(Protected_Fish.Count) / Task_Count;
      Last_Slice_Additional := Natural(Protected_Fish.Count) mod Task_Count;

      for I in 0 .. Task_Count - 1 loop
         Tasks(I + 1) := new Count_Range
           ( Range_Start => Slice_Size * I + (if I = 0 then 0 else 1),
            Range_End => (Slice_Size * (I + 1)) +
              (if I = Task_Count - 1 then Last_Slice_Additional - 1 else 0)
           );
      end loop;

      for A_Task of Tasks loop
         while not A_Task'Terminated loop
            -- Wait..
            null;
         end loop;
      end loop;

      -- Put_Line(Slice_Size'Image);
      -- Put_Line(Last_Slice_Additional'Image);

      -- Fishes.
   end Process;

   procedure Part(Days : Positive) is
      Input : File_Type;
      Read_Number : Integer;
      Read_Character : Character;

      Temp_Fishes : Fish_Vectors.Vector;
   begin
      Open(Input, Mode => In_File, Name => "6.txt");

      loop
         Get(Input, Read_Number);
         Temp_Fishes.Append(Read_Number);

         exit when End_Of_File(Input);
         Get(Input, Read_Character);
         Assert(Read_Character = ',');
      end loop;
      Protected_Fish.Append(Temp_Fishes);

      for I in 1..Days loop
         Process;

         Put_Line(I'Image);
         -- Protected_Fish.Image;
      end loop;

      Put_Line(Protected_Fish.Count'Image);
      Protected_Fish.Clear;

      Close(Input);
   end Part;
end Six;
