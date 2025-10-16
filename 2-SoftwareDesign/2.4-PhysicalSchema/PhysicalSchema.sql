-- Створення таблиці Користувач
CREATE TABLE Користувач (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ім’я VARCHAR(100) NOT NULL,
    вік INT CHECK (вік > 0),
    алергії TEXT,
    ціль VARCHAR(100)
);

-- Дані про здоров’я
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

-- План харчування
CREATE TABLE ПланХарчування (
    id INT PRIMARY KEY AUTO_INCREMENT,
    користувач_id INT,
    сніданок TEXT,
    обід TEXT,
    вечеря TEXT,
    калорійність INT,
    FOREIGN KEY (користувач_id) REFERENCES Користувач(id)
);

-- Рекомендації
CREATE TABLE Рекомендації (
    id INT PRIMARY KEY AUTO_INCREMENT,
    план_id INT,
    обсяг_води_на_день FLOAT,
    фізична_активність VARCHAR(100),
    FOREIGN KEY (план_id) REFERENCES ПланХарчування(id)
);

-- Досягнення
CREATE TABLE Досягнення (
    id INT PRIMARY KEY AUTO_INCREMENT,
    користувач_id INT,
    кількість_тренувань INT,
    виконані_вправи TEXT,
    нагороди TEXT,
    FOREIGN KEY (користувач_id) REFERENCES Користувач(id)
);

-- Самоповага
CREATE TABLE Самоповага (
    id INT PRIMARY KEY AUTO_INCREMENT,
    користувач_id INT,
    рівень FLOAT,
    впевненість VARCHAR(100),
    FOREIGN KEY (користувач_id) REFERENCES Користувач(id)
);

-- Танцювальні події
CREATE TABLE ТанцювальніПодії (
    id INT PRIMARY KEY AUTO_INCREMENT,
    користувач_id INT,
    назва VARCHAR(100),
    тип_танцю VARCHAR(100),
    дата_проведення DATE,
    місце_проведення VARCHAR(100),
    FOREIGN KEY (користувач_id) REFERENCES Користувач(id)
);
