# Налаштування виконання програми через Docker-контейнер

## Мета
Запустити Java-клієнтську програму, яка підключається до бази даних Oracle XE, у окремому Docker-контейнері з використанням спільної мережі.

## Кроки роботи

1. **Створення віртуальної мережі Docker**
   Для забезпечення взаємодії між контейнерами створюємо окрему мережу:
   docker network create healthnet

2. **Запуск контейнера з Oracle XE у створеній мережі**
   Запускаємо контейнер з СУБД, пробрасуючи порт 1521 та монтуємо папку зі скриптами ініціалізації:
   docker run --name alexberlimenko-oracle --network healthnet -d -p 1521:1521 -e ORACLE_PASSWORD=1234 -v "${PWD}/scripts:/scripts" gvenzl/oracle-xe

3. **Виконання скрипта ініціалізації БД**
   Після запуску бази даних (чекаємо ~15 секунд) виконуємо скрипт створення користувача, таблиці та вставки тестових даних:
   docker exec -it alexberlimenko-oracle sqlplus "system/1234@localhost:1521/XEPDB1" @/scripts/init_db.sql

4. **Побудова Docker-образу для Java-клієнта**
   Переходимо до папки з клієнтом та будуємо образ на основі OpenJDK 17:
   cd 3.2-Docker-containers
   docker build -t alexberlimenko-client .

5. **Запускаємо клієнтський контейнер, який автоматично підключається до БД через назву контейнера alexberlimenko-oracle:**
   docker run --network healthnet --rm alexberlimenko-client

## Результат
Програма успішно підключається до бази даних, виконує SQL-запит до таблиці PLAN_HARCHUVANNIA та виводить результат:
✅ Успішне підключення до Oracle XE у Docker!
ID: 1, Сніданок: Yaytsia, Калорії: 2000
