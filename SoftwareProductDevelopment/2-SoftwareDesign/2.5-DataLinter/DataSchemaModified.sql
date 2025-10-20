CREATE TABLE user_data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    user_age INT CHECK (user_age > 0),
    allergies TEXT,
    goal VARCHAR(100)
);

CREATE TABLE health_data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    weight FLOAT CHECK (weight > 0),
    height INT CHECK (height > 0),
    bmi FLOAT,
    activity_level VARCHAR(100),
    diet_restrictions TEXT,
    FOREIGN KEY (user_id) REFERENCES user_data (id)
);

CREATE TABLE meal_plan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    breakfast TEXT,
    lunch TEXT,
    dinner TEXT,
    calories INT CHECK (calories > 0),
    FOREIGN KEY (user_id) REFERENCES user_data (id)
);

CREATE TABLE recommendations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    plan_id INT,
    daily_water FLOAT CHECK (daily_water > 0),
    physical_activity VARCHAR(100),
    FOREIGN KEY (plan_id) REFERENCES meal_plan (id)
);

CREATE TABLE achievements (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    workouts_count INT CHECK (workouts_count >= 0),
    exercises_done TEXT,
    awards TEXT,
    FOREIGN KEY (user_id) REFERENCES user_data (id)
);

CREATE TABLE self_esteem (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    esteem_level FLOAT CHECK (esteem_level BETWEEN 0 AND 10),
    confidence VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES user_data (id)
);

CREATE TABLE dance_events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_title VARCHAR(100),
    dance_type VARCHAR(100),
    event_date DATE,
    event_location VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES user_data (id)
);
