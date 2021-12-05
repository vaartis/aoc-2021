with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Assertions; use Ada.Assertions;

with Ada.Containers.Vectors;

procedure Five is
   type Coordinate is record
      X : Integer;
      Y : Integer;
   end record;

   type Line is record
      Start : Coordinate;
      Ending : Coordinate;
   end record;

   package Line_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Line);
   use Line_Vectors;

   Line_Vector : Line_Vectors.Vector;
   Input_File : File_Type;

   function Image(The_Coord : Coordinate) return String is
   begin
      return The_Coord.X'Image & "," & The_Coord.Y'Image;
   end Image;

   function Image(The_Line : Line) return String is
   begin
      return Image(The_Line.Start) & " -> " & Image(The_Line.Ending);
   end Image;

   procedure Read_Coordinate(The_Coordinate : out Coordinate) is
      Read_Char : Character;
   begin
      Get(Input_File, The_Coordinate.X);

      Get(Input_File, Read_Char);
      Assert(Read_Char = ',');

      Get(Input_File, The_Coordinate.Y);
   end Read_Coordinate;

   -- Consider_Angled = False for part 1, True for part 2
   function Part(Consider_Angled : Boolean) return Integer is
      -- 1000 for my input data, 10 for the example on the page
      Grid_Size : constant Integer := 1000;

      type Coordinate_Grid_Type is array (0 .. Grid_Size - 1, 0 .. Grid_Size - 1) of Natural;
      -- Initialize everything to 0 by default
      Coordinate_Grid : Coordinate_Grid_Type := (others => (others => 0));
   begin
      -- Apply the lines
      for Current_Line of Line_Vector loop
         declare
            Current_X : Integer := Current_Line.Start.X;
            Current_Y : Integer := Current_Line.Start.Y;

            End_X : Integer renames Current_Line.Ending.X;
            End_Y : Integer renames Current_Line.Ending.Y;
         begin
            -- For now, only consider horizontal and vertical lines
            if Consider_Angled or (Current_X = End_X or Current_Y = End_Y) then
               -- Increment the very first input
               Coordinate_Grid(Current_X, Current_Y) := Coordinate_Grid(Current_X, Current_Y) + 1;

               while Current_X /= End_X or Current_Y /= End_Y loop
                  Current_X :=
                    (if Current_X = End_X then Current_X
                     elsif Current_X > End_X then Current_X - 1
                     else Current_X + 1);
                  Current_Y := (if Current_Y = End_Y then Current_Y
                                elsif Current_Y > End_Y then Current_Y - 1
                                else Current_Y + 1);

                  -- Increment the next input
                  Coordinate_Grid(Current_X, Current_Y) := Coordinate_Grid(Current_X, Current_Y) + 1;
               end loop;
            end if;
         end;
      end loop;

      declare
         Result : Integer := 0;
      begin
         for Coord of Coordinate_Grid loop
            if Coord >= 2 then
               Result := Result + 1;
            end if;
         end loop;

         return Result;
      end;
   end Part;
begin
   Open(Input_File, Mode => In_File, Name => "5.txt");

   -- Read the lines
   while not End_Of_File(Input_File) loop
      declare
         Current_Line : Line;
         Separator_String : String(1..4);
      begin
         Read_Coordinate(Current_Line.Start);

         Get(Input_File, Separator_String);
         Assert(Separator_String = " -> ");

         Read_Coordinate(Current_Line.Ending);

         Line_Vector.Append(Current_Line);
      end;
   end loop;

   -- Part 1
   Put_Line(Part(False)'Image);
   -- Part 2
   Put_Line(Part(True)'Image);
end Five;
