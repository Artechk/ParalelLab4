with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Semaphores; use GNAT.Semaphores;

procedure Dinner_Philosophers is
   task type Philosopher is
      entry Start(Id : Integer);
   end Philosopher;

   Forks : array (1..5) of Counting_Semaphore(1, Default_Ceiling);

   task body Philosopher is
      Id : Integer;
      Left_Fork, Right_Fork : Integer;
   begin
      accept Start (Id : in Integer) do
         Philosopher.Id := Id;
      end Start;
      Left_Fork := Id;
      Right_Fork := Id rem 5 + 1;

      for I in 1..10 loop
         Put_Line("Philosopher " & Id'Img & " thinking " & I'Img & " time");

         Forks(Left_Fork).Seize;
         Forks(Right_Fork).Seize;

         Put_Line("Philosopher " & Id'Img & " took forks and is eating " & I'Img & " time");

         Forks(Right_Fork).Release;
         Forks(Left_Fork).Release;
      end loop;
   end Philosopher;

   Philosophers : array (1..5) of Philosopher;
begin
   for I in Philosophers'Range loop
      Philosophers(I).Start(I);
   end loop;

end Dinner_Philosophers;
