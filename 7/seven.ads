with Ada.Containers.Vectors;

package Seven is
   subtype Which_Part is Natural range 1 .. 2;

   procedure Part(Which : Which_Part);
private
   package Natural_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Natural);
   package Natural_Vectors_Sorting is new Natural_Vectors.Generic_Sorting;

   function Determine_Fuel_For_Position(Wanted_Position : Natural; Increasing : Boolean) return Natural;

   Crab_Vector : Natural_Vectors.Vector;
end Seven;
