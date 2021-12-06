with Ada.Containers.Vectors;

package Six is
   package Fish_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Natural);
   use Fish_Vectors;
   type Fish_Vector_Access is access Fish_Vectors.Vector;

   protected Protected_Fish is
      procedure Append(To_Append : Fish_Vectors.Vector);
      procedure Set_Fish_At(I : Natural; Value : Natural);
      procedure Clear;
      procedure Image;

      function Fish_At(I : Natural) return Natural;
      function Count return Ada.Containers.Count_Type;
   private
      Fishes : Fish_Vectors.Vector;
   end;

   task type Count_Range ( Range_Start, Range_End : Integer );
   type Count_Range_Pointer is access Count_Range;

   procedure Process;

   procedure Part(Days : Positive);
end Six;
