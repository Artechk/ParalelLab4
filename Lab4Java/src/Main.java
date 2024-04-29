class Philosopher extends Thread {
    private int id;
    private Object leftFork;   // Ліва виделка
    private Object rightFork;  // Права виделка

    public Philosopher(int id, Object leftFork, Object rightFork) {
        this.id = id;
        this.leftFork = leftFork;
        this.rightFork = rightFork;
    }

    // Метод, який описує процес їжі філософа
    private void eat(int times) {
        for (int i = 0; i < times; i++) {
            System.out.println("Philosopher " + id + " thinking " + (i + 1) + " time"); // Філософ міркує
            synchronized (leftFork) {  // Забирає ліву виделку
                synchronized (rightFork) { // Забирає праву виделку
                    System.out.println("Philosopher " + id + " took forks and is eating " + (i + 1) + " time"); // Філософ починає їсти
                }
            }
        }
    }

    // Потік філософа
    public void run() {
        eat(10); // Кожен філософ їсть 10 разів
    }
}

public class Main {
    public static void main(String[] args) {
        Object[] forks = new Object[5];  // Масив, що містить виделки

        // Ініціалізація виделок
        for (int i = 0; i < forks.length; i++) {
            forks[i] = new Object();
        }

        Philosopher[] philosophers = new Philosopher[5]; // Масив філософів

        // Ініціалізація філософів
        for (int i = 0; i < philosophers.length; i++) {
            Object leftFork = forks[i]; // Ліва виделка для філософа
            Object rightFork = forks[(i + 1) % forks.length]; // Права виделка для філософа
            philosophers[i] = new Philosopher(i, leftFork, rightFork); // Створення філософа
        }

        // Запуск потоків філософів
        for (Philosopher philosopher : philosophers) {
            philosopher.start();
        }
    }
}
