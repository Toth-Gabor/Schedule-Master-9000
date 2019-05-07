DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS schedule CASCADE;
DROP TABLE IF EXISTS days CASCADE;
DROP TABLE IF EXISTS hour CASCADE;
DROP TABLE IF EXISTS task CASCADE;
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

CREATE TABLE hour (
	hour_id SERIAL NOT NULL PRIMARY KEY,
	hour_value INT NOT NULL,
	task_id INT NOT NULL,
	day_id INT NOT NULL,
	FOREIGN KEY (task_id) REFERENCES task(task_id),
	FOREIGN KEY (day_id) REFERENCES days(day_id),
	CHECK (hour_value BETWEEN 0 AND 24)
);

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