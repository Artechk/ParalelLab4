-- Include necessary Ada packages
with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Semaphores; use GNAT.Semaphores;

-- Define a task type Philosopher
procedure Dinner_Philosophers is
   task type Philosopher is
      entry Start(Id : Integer); -- Entry to start a philosopher
   end Philosopher;

   -- Declare an array of counting semaphores for forks
   Forks : array (1..5) of Counting_Semaphore(1, Default_Ceiling);

   -- Task body for the philosopher
   task body Philosopher is
      Id : Integer;
      Left_Fork, Right_Fork : Integer;
   begin
      -- Accept the starting entry to initialize the philosopher's ID
      accept Start (Id : in Integer) do
         Philosopher.Id := Id;
      end Start;
      
      -- Assign left and right forks based on philosopher's ID
      Left_Fork := Id;
      Right_Fork := Id rem 5 + 1;

      -- Loop representing the philosopher's activities
      for I in 1..10 loop
         -- Print the philosopher's thinking activity
         Put_Line("Philosopher " & Id'Img & " thinking " & I'Img & " time");

         -- Seize the left and right forks
         Forks(Left_Fork).Seize;
         Forks(Right_Fork).Seize;

         -- Print the philosopher's eating activity
         Put_Line("Philosopher " & Id'Img & " took forks and is eating " & I'Img & " time");

         -- Release the forks after eating
         Forks(Right_Fork).Release;
         Forks(Left_Fork).Release;
      end loop;
   end Philosopher;

   -- Declare an array of philosophers
   Philosophers : array (1..5) of Philosopher;
begin
   -- Start each philosopher
   for I in Philosophers'Range loop
      Philosophers(I).Start(I);
   end loop;

end Dinner_Philosophers;
