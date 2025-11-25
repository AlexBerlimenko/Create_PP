-- GeneratePlan_Body.sql
-- Тіло типу ПланХарчування з реалізацією методу генерувати_план

CREATE OR REPLACE TYPE BODY ПланХарчування AS

    MEMBER PROCEDURE генерувати_план IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        v_вага      FLOAT;
        v_ціль      VARCHAR2(50);
        v_user_id   NUMBER := користувач_id;
        v_bmi       FLOAT;
    BEGIN
        -- Отримання даних (приклад через запит)
        SELECT dz.вага, k.ціль, (dz.вага / POWER(dz.зріст/100, 2))
        INTO v_вага, v_ціль, v_bmi
        FROM Користувачі k
        JOIN ДаніПроЗдоров'я dz ON k.id = dz.користувач_id
        WHERE k.id = v_user_id;

        -- Логіка генерації плану
        IF v_ціль = 'схуднення' THEN
            сніданок := 'Яйця з авокадо';
            обід := 'Куряча грудка з овочами';
            вечеря := 'Риба на пару';
            калорійність := 1600;
        ELSIF v_ціль = 'набір маси' THEN
            сніданок := 'Вівсянка з горіхами та медом';
            обід := 'Стейк з картоплею';
            вечеря := 'Білковий коктейль + банан';
            калорійність := 2800;
        ELSE
            сніданок := 'Тости з авокадо та яйцем';
            обід := 'Суп з крупами';
            вечеря := 'Йогурт з фруктами';
            калорійність := 2200;
        END IF;

        -- Оновлення запису в БД
        UPDATE ПланиХарчування
        SET сніданок = сніданок,
            обід = обід,
            вечеря = вечеря,
            калорійність = калорійність
        WHERE користувач_id = v_user_id;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('План успішно згенеровано для користувача ID=' || v_user_id);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Помилка: не знайдено даних для користувача ID=' || v_user_id);
            ROLLBACK;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Невідома помилка при генерації плану');
            ROLLBACK;
    END генерувати_план;

    MEMBER PROCEDURE надати_план IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Сніданок: ' || сніданок);
        DBMS_OUTPUT.PUT_LINE('Обід: ' || обід);
        DBMS_OUTPUT.PUT_LINE('Вечеря: ' || вечеря);
        DBMS_OUTPUT.PUT_LINE('Калорійність: ' || калорійність || ' ккал');
    END надати_план;

    MEMBER PROCEDURE оновити_план IS
    BEGIN
        NULL; -- Заглушка
    END оновити_план;

END;
/
