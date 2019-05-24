DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS schedule CASCADE;
DROP TABLE IF EXISTS days CASCADE;
DROP TABLE IF EXISTS hour CASCADE;
DROP TABLE IF EXISTS task CASCADE;
DROP TABLE IF EXISTS hour_task CASCADE;
DROP FUNCTION IF EXISTS count_days();
DROP FUNCTION IF EXISTS count_hours;

CREATE TABLE users (
	user_id SERIAL NOT NULL PRIMARY KEY,
	username TEXT NOT NULL,
	email TEXT NOT NULL,
	user_password TEXT NOT NULL,
	administrator BOOLEAN DEFAULT FALSE,
	CONSTRAINT email_not_empty CHECK (email <> ''),
	CONSTRAINT pw_not_empty CHECK (user_password <> '')
);

CREATE TABLE schedule (
	schedule_id SERIAL NOT NULL PRIMARY KEY,
	schedule_published BOOLEAN DEFAULT FALSE,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE days (
	day_id SERIAL NOT NULL PRIMARY KEY,
	day_name TEXT NOT NULL,
	schedule_id INT NOT NULL,
	FOREIGN KEY (schedule_id) REFERENCES schedule(schedule_id) ON DELETE CASCADE
);

CREATE TABLE task (
	task_id SERIAL NOT NULL PRIMARY KEY,
	task_name TEXT NOT NULL,
	task_content TEXT NOT NULL,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE

);

CREATE TABLE hour (
	hour_id SERIAL NOT NULL PRIMARY KEY,
	hour_value INT DEFAULT 0,
	day_id INT NOT NULL,
	FOREIGN KEY (day_id) REFERENCES days(day_id) ON DELETE CASCADE,
	CHECK (hour_value BETWEEN 0 AND 24)
);

CREATE TABLE hour_task (
    hour_id INT,
    task_id INT,
    FOREIGN KEY (hour_id) REFERENCES hour(hour_id),
    FOREIGN KEY (task_id) REFERENCES task(task_id)
);



INSERT INTO users (username, email, user_password, administrator) VALUES
('Péter', 'user1@user1', 'user1', TRUE), -- 1
('Gábor', 'user2@user2', 'user2', FALSE), -- 2
('Andris', 'user2@user3', 'user3', TRUE); -- 3

INSERT INTO schedule (schedule_published, user_id) VALUES
(TRUE, 1),  -- 1
(TRUE, 1),  -- 2
(FALSE, 2), -- 3
(FALSE, 2), -- 4
(TRUE, 2),  -- 5
(FALSE, 3), -- 6
(true, 3);  -- 7

INSERT INTO days (day_name, schedule_id) VALUES
('Monday', 1),('Tuesday', 1),
('Wednesday', 3),('Thursday', 4),
('Wednesday', 5),('Wednesday', 6),('Friday', 7);

INSERT INTO task (task_name, task_content, user_id) VALUES
('First', 'Feed the birds',1),('Second', 'Go to gym',1),
('Third', 'Cook something',2),('Fourth', 'Write some code',2),
('Fifth', 'Do homework',3),('Sixth', 'Do relax',3);

INSERT INTO hour (hour_value, day_id)
VALUES (8,1),(9,1),(11,2);

INSERT INTO hour_task(hour_id, task_id) VALUES
(1, 1), (2, 2);