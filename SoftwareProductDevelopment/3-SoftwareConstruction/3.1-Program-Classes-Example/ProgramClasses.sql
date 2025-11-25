-- ProgramClasses.sql
-- Конструювання програмних класів на основі UML-діаграми прототипів
-- Мова: Oracle PL/SQL (об'єктні типи)

SET SERVEROUTPUT ON;
SET LINESIZE 2000;
SET PAGESIZE 100;

-- Тип: ПланХарчування
CREATE OR REPLACE TYPE ПланХарчування AS OBJECT (
    id              NUMBER,
    користувач_id   NUMBER,
    сніданок        VARCHAR2(100),
    обід            VARCHAR2(100),
    вечеря          VARCHAR2(100),
    калорійність    NUMBER,
    MEMBER PROCEDURE генерувати_план,
    MEMBER PROCEDURE надати_план,
    MEMBER PROCEDURE оновити_план
);
/

-- Тип: ДаніПроЗдоров'я
CREATE OR REPLACE TYPE ДаніПроЗдоров'я AS OBJECT (
    id                      NUMBER,
    користувач_id           NUMBER,
    вага                    FLOAT,
    зріст                   NUMBER,
    індекс_маси_тіла        FLOAT,
    рівень_активності       VARCHAR2(50),
    дієтичні_обмеження      VARCHAR2(200),
    MEMBER FUNCTION аналізувати_дані RETURN VARCHAR2,
    MEMBER FUNCTION валідувати_дані RETURN BOOLEAN
);
/

-- Колекція досягнень
CREATE OR REPLACE TYPE Досягнення_List IS TABLE OF VARCHAR2(100);
/

-- Тип: Користувач
CREATE OR REPLACE TYPE Користувач AS OBJECT (
    id                  NUMBER,
    ім'я                VARCHAR2(50),
    вік                 NUMBER,
    алергії             VARCHAR2(200),
    ціль                VARCHAR2(50),
    -- Агрегація
    дані_про_здоров'я   ДаніПроЗдоров'я,
    план_харчування     ПланХарчування,
    досягнення         Досягнення_List,

    MEMBER FUNCTION отримати_персоналізований_план
        RETURN ПланХарчування,
    MEMBER FUNCTION передати_дані_про_здоров'я
        RETURN ДаніПроЗдоров'я,
    MEMBER FUNCTION отримати_оцінку_самоповаги
        RETURN FLOAT
);
/
