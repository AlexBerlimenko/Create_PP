-- Таблиця Користувач
CREATE TABLE Користувач (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ім’я VARCHAR(100) NOT NULL,
    вік INT CHECK (вік > 0),
    алергії TEXT,
    ціль VARCHAR(100)
);

-- Таблиця ДаніПроЗдоров’я
CREATE TABLE ДаніПроЗдоров’я (
    id INT PRIMARY KEY AUTO_INCREMENT,
    користувач_id INT,
    вага FLOAT CHECK (вага > 0),
    зріст INT CHECK (зріст > 0),
    індекс_маси_тіла FLOAT,
    рівень_активності VARCHAR(100),
    дієтичні_обмеження TEXT,
    FOREIGN KEY (користувач_id) REFERENCES Користувач(id)
);

-- Таблиця ПланХарчування
CREATE TABLE ПланХарчування (
    id INT PRIMARY KEY AUTO_INCREMENT,
    користувач_id INT,
    сніданок TEXT,
    обід TEXT,
    вечеря TEXT,
    калорійність INT CHECK (калорійність > 0),
    FOREIGN KEY (користувач_id) REFERENCES Користувач(id)
);

-- Таблиця Рекомендації
CREATE TABLE Рекомендації (
    id INT PRIMARY KEY AUTO_INCREMENT,
    план_id INT,
    обсяг_води_на_день FLOAT CHECK (обсяг_води_на_день > 0),
    фізична_активність VARCHAR(100),
    FOREIGN KEY (план_id) REFERENCES ПланХарчування(id)
);

-- Таблиця Досягнення
CREATE TABLE Досягнення (
    id INT PRIMARY KEY AUTO_INCREMENT,
    користувач_id INT,
    кількість_тренувань INT CHECK (кількість_тренувань >= 0),
    виконані_вправи TEXT,
    нагороди TEXT,
    FOREIGN KEY (користувач_id) REFERENCES Користувач(id)
);

-- Таблиця Самоповага
CREATE TABLE Самоповага (
    id INT PRIMARY KEY AUTO_INCREMENT,
    користувач_id INT,
    рівень FLOAT CHECK (рівень BETWEEN 0 AND 10),
    впевненість VARCHAR(100),
    FOREIGN KEY (користувач_id) REFERENCES Користувач(id)
);

-- Таблиця ТанцювальніПодії
CREATE TABLE ТанцювальніПодії (
    id INT PRIMARY KEY AUTO_INCREMENT,
    користувач_id INT,
    назва VARCHAR(100),
    тип_танцю VARCHAR(100),
    дата_проведення DATE,
    місце_проведення VARCHAR(100),
    FOREIGN KEY (користувач_id) REFERENCES Користувач(id)
);

-- Обмеження з регулярними виразами

-- Ім’я: тільки літери, пробіли, дефіси
ALTER TABLE Користувач ADD CONSTRAINT name_format
CHECK (ім’я REGEXP '^[А-Яа-яІіЇїЄєҐґ\\- ]+$');

-- Ціль: тільки українські слова, без цифр
ALTER TABLE Користувач ADD CONSTRAINT goal_format
CHECK (ціль REGEXP '^[А-Яа-яІіЇїЄєҐґ ]+$');
