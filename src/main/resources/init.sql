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
	FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE

);

CREATE TABLE hour (
	hour_id SERIAL NOT NULL PRIMARY KEY,
	hour_value INT NOT NULL,
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

INSERT INTO task (task_name, task_content) VALUES
('First', 'Feed the birds'),('Second', 'Go to gym'),
('Third', 'Cook something'),('Fourth', 'Write some code'),
('Fifth', 'Do homework'),('Sixth', 'Do relax'),
('Seventh', 'Do nothing'),('Eighth', 'Clean the room'),
('Nineth', 'Paint the fence'),('Tenth', 'Buy food'),
('Eleventh', 'Go to doctor'),('Twelfth', 'Wash car'),
('Thirteenth', 'Watch tv'),('Fourteenth', 'Mow the lawn');

INSERT INTO hour (hour_value, day_id)
VALUES (8,1),(9,1),(11,2);

CREATE OR REPLACE FUNCTION count_days() RETURNS TRIGGER AS '
DECLARE
	day_counter INTEGER := 0;
	need_to_check BOOLEAN := false;

BEGIN
	IF TG_OP = ''INSERT'' THEN
        need_to_check := true;
    END IF;
    IF TG_OP = ''UPDATE'' THEN
        IF (NEW.schedule_id != OLD.schedule_id) THEN
            need_to_check := true;
        END IF;
    END IF;
    IF need_to_check THEN
        SELECT INTO day_counter COUNT(*)
        FROM days
        WHERE OLD.schedule_id = NEW.schedule_id;
        IF count_days >= 7 THEN
            RAISE EXCEPTION ''Cannot create more than 7 days for a schedule!'';
        END IF;
    END IF;
    RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER count_days
    BEFORE INSERT OR UPDATE ON days
    FOR EACH ROW EXECUTE PROCEDURE count_days();


CREATE OR REPLACE FUNCTION count_hours() RETURNS TRIGGER AS '
DECLARE
	hour_counter INTEGER := 0;
	need_to_check BOOLEAN := false;

BEGIN
	IF TG_OP = ''INSERT'' THEN
        need_to_check := true;
    END IF;
    IF TG_OP = ''UPDATE'' THEN
        IF (NEW.day_id != OLD.day_id) THEN
            need_to_check := true;
        END IF;
    END IF;
    IF need_to_check THEN
        SELECT INTO hour_counter COUNT(*)
        FROM hour
        WHERE OLD.day_id = NEW.day_id;
        IF count_hour >= 24 THEN
            RAISE EXCEPTION ''Cannot create more than 24 task for a day!'';
        END IF;
    END IF;
    RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER count_hours
    BEFORE INSERT OR UPDATE ON hour
    FOR EACH ROW EXECUTE PROCEDURE count_hours();

CREATE OR REPLACE FUNCTION hour_check() RETURNS trigger AS '
		DECLARE
		    need_to_check BOOLEAN := false;
			result_hour INTEGER := 0;
		BEGIN
		    IF TG_OP = ''INSERT'' THEN
		        need_to_check := true;
		    END IF;
		    IF TG_OP = ''UPDATE'' THEN
		        IF (NEW.day_id != OLD.day_id) THEN
		            need_to_check := true;
		        END IF;
		    END IF;
		    IF need_to_check THEN
		        Select hour into result_hour  FROM hour
		        	WHERE day_id = NEW.day_id;
		        IF result_hour = NEW.hour THEN
		            RAISE EXCEPTION ''There is already a task scheduled for this time!'';
		        END IF;
		    END IF;
		    RETURN NEW;
		END;
		' LANGUAGE plpgsql;


CREATE TRIGGER hour_check
		BEFORE INSERT OR UPDATE ON hour
	    FOR EACH ROW EXECUTE PROCEDURE hour_check();
