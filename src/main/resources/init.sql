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
    email         TEXT   NOT NULL UNIQUE,
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
INSERT INTO public.users (username, email, user_password, administrator)
VALUES ('Gábor Tóth', 'upcgabor@gmail.com', '', FALSE);

INSERT INTO public.schedule (schedule_published, user_id)
VALUES (TRUE, 1);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (FALSE, 1);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (TRUE, 2);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (FALSE, 2);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (TRUE, 4);
INSERT INTO public.schedule (schedule_published, user_id)
VALUES (FALSE, 4);

INSERT INTO public.days (day_name, schedule_id)
VALUES ('first', 1);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('second', 1);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('third', 1);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('forth', 1);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('fifth', 1);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('sixth', 1);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('seventh', 1);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('first', 2);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('second', 2);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('third', 2);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('forth', 2);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('fifth', 2);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('first', 3);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('second', 3);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('first', 4);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('second', 4);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('third', 4);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('forth', 4);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('first', 5);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('second', 5);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('third', 5);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('first', 6);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('second', 6);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('third', 6);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('forth', 6);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('fifth', 6);
INSERT INTO public.days (day_name, schedule_id)
VALUES ('sixth', 6);

INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('CodeWars', 'Do some Java', 1);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('HeckerRank', 'Do some SQL', 1);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('SI excercise', 'Complete this week tasks', 1);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Test your skills', 'Answear 4 intervew questions', 2);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Walk the dog', 'Go outside', 2);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Do chores', 'Take out the trash', 2);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Watch tv series', 'Watch new Attack on Titan', 4);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Get Ready for Pa', 'Practice, practice, practice', 4);
INSERT INTO public.task (task_name, task_content, user_id)
VALUES ('Family time', 'Take a walk in the park', 4);

INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 1);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 2);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 3);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 4);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 5);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 6);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 7);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 7);
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
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 11);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 12);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 13);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 14);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 15);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 16);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 17);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 18);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 19);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 20);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 21);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 22);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 23);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 24);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 25);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 26);
INSERT INTO public.hour (hour_value, day_id)
VALUES (0, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (1, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (2, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (3, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (4, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (5, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (6, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (7, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (8, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (9, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (10, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (11, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (12, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (13, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (14, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (15, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (16, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (17, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (18, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (19, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (20, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (21, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (22, 27);
INSERT INTO public.hour (hour_value, day_id)
VALUES (23, 27);

INSERT INTO public.hour_task (hour_id, task_id)
VALUES (38, 1);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (87, 2);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (84, 3);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (294, 5);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (329, 6);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (303, 4);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (454, 7);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (467, 8);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (497, 9);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (571, 7);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (513, 8);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (617, 9);
