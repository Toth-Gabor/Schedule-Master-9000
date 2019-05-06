DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS schedule CASCADE;
DROP TABLE IF EXISTS days CASCADE;
DROP TABLE IF EXISTS slot CASCADE;
DROP TABLE IF EXISTS task CASCADE;

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
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE days (
	day_id SERIAL NOT NULL PRIMARY KEY,
	day_name TEXT NOT NULL,
	schedule_id INT NOT NULL,
	FOREIGN KEY (schedule_id) REFERENCES schedule(schedule_id)
);

CREATE TABLE task (
	task_id SERIAL NOT NULL PRIMARY KEY,
	task_name TEXT NOT NULL,
	task_content TEXT NOT NULL,
	schedule_id INT NOT NULL,
	FOREIGN KEY (schedule_id) REFERENCES schedule(schedule_id)
);

CREATE TABLE slot (
	slot_id SERIAL NOT NULL PRIMARY KEY,
	slot_value INT NOT NULL,
	task_id INT NOT NULL,
	day_id INT NOT NULL,
	FOREIGN KEY (task_id) REFERENCES task(task_id),
	FOREIGN KEY (day_id) REFERENCES days(day_id),
	CHECK (slot_value BETWEEN 0 AND 24)
);