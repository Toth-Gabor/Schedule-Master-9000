DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS schedule CASCADE;
DROP TABLE IF EXISTS days CASCADE;
DROP TABLE IF EXISTS hour CASCADE;
DROP TABLE IF EXISTS task CASCADE;
DROP TABLE IF EXISTS hour_task CASCADE;
DROP FUNCTION IF EXISTS count_days();
DROP FUNCTION IF EXISTS count_hours;

CREATE TABLE users
(
    user_id       SERIAL NOT NULL PRIMARY KEY,
    username      TEXT   NOT NULL,
    email         TEXT   NOT NULL unique ,
    user_password TEXT,
    administrator BOOLEAN DEFAULT FALSE,
    CONSTRAINT email_not_empty CHECK (email <> '')
);

CREATE TABLE schedule
(
    schedule_id        SERIAL NOT NULL PRIMARY KEY,
    schedule_published BOOLEAN DEFAULT FALSE,
    user_id            INT    NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE TABLE days
(
    day_id      SERIAL NOT NULL PRIMARY KEY,
    day_name    TEXT   NOT NULL,
    schedule_id INT    NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES schedule (schedule_id) ON DELETE CASCADE
);

CREATE TABLE task
(
    task_id      SERIAL NOT NULL PRIMARY KEY,
    task_name    TEXT   NOT NULL,
    task_content TEXT   NOT NULL,
    user_id      INT    NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE

);

CREATE TABLE hour
(
    hour_id    SERIAL NOT NULL PRIMARY KEY,
    hour_value INT DEFAULT 0,
    day_id     INT    NOT NULL,
    FOREIGN KEY (day_id) REFERENCES days (day_id) ON DELETE CASCADE,
    CHECK (hour_value BETWEEN 0 AND 24)
);

CREATE TABLE hour_task
(
    hour_id INT,
    task_id INT,
    FOREIGN KEY (hour_id) REFERENCES hour (hour_id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES task (task_id) ON DELETE CASCADE
);

INSERT INTO public.users (username, email, user_password, administrator)
VALUES ('Péter', 'user1@user1', 'user1', TRUE);
INSERT INTO public.users (username, email, user_password, administrator)
VALUES ('Gábor', 'user2@user2', 'user2', FALSE);
INSERT INTO public.users (username, email, user_password, administrator)
VALUES ('Andris', 'user2@user3', 'user3', TRUE);

INSERT INTO public.schedule (schedule_published, user_id)
VALUES (TRUE, 1);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (TRUE, 1);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (FALSE, 2);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (FALSE, 2);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (TRUE, 2);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (FALSE, 3);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (TRUE, 3);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (FALSE, 1);

INSERT INTO public.days (day_name, schedule_id)
VALUES ('Monday', 1);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('Tuesday', 1);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('Wednesday', 3);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('Thursday', 4);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('Wednesday', 5);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('Wednesday', 6);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('Friday', 7);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('first', 8);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('second', 8);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('third', 8);

INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('First', 'Feed the birds', 1);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Second', 'Go to gym', 1);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Third', 'Cook something', 2);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Fourth', 'Write some code', 2);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Fifth', 'Do homework', 3);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Sixth', 'Do relax', 3);


INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 8);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 9);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 10);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 10);

INSERT INTO public.hour_task (hour_id, task_id)
VALUES (1, 1);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (2, 2);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (4, 2);
