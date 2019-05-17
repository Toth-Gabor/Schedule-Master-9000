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
    email         TEXT   NOT NULL,
    user_password TEXT   NOT NULL,
    administrator BOOLEAN DEFAULT FALSE,
    CONSTRAINT email_not_empty CHECK (email <> ''),
    CONSTRAINT pw_not_empty CHECK (user_password <> '')
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
    FOREIGN KEY (hour_id) REFERENCES hour (hour_id),
    FOREIGN KEY (task_id) REFERENCES task (task_id)
);
INSERT INTO public.users (user_id, username, email, user_password, administrator)
VALUES (1, 'Péter', 'user1@user1', 'user1', TRUE);
INSERT INTO public.users (user_id, username, email, user_password, administrator)
VALUES (2, 'Gábor', 'user2@user2', 'user2', FALSE);
INSERT INTO public.users (user_id, username, email, user_password, administrator)
VALUES (3, 'Andris', 'user2@user3', 'user3', TRUE);

INSERT INTO public.schedule (schedule_id, schedule_published, user_id)
VALUES (1, TRUE, 1);
INSERT INTO public.schedule (schedule_id, schedule_published, user_id)
VALUES (2, TRUE, 1);
INSERT INTO public.schedule (schedule_id, schedule_published, user_id)
VALUES (3, FALSE, 2);
INSERT INTO public.schedule (schedule_id, schedule_published, user_id)
VALUES (4, FALSE, 2);
INSERT INTO public.schedule (schedule_id, schedule_published, user_id)
VALUES (5, TRUE, 2);
INSERT INTO public.schedule (schedule_id, schedule_published, user_id)
VALUES (6, FALSE, 3);
INSERT INTO public.schedule (schedule_id, schedule_published, user_id)
VALUES (7, TRUE, 3);
INSERT INTO public.schedule (schedule_id, schedule_published, user_id)
VALUES (8, FALSE, 1);

INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (1, 'Monday', 1);
INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (2, 'Tuesday', 1);
INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (3, 'Wednesday', 3);
INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (4, 'Thursday', 4);
INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (5, 'Wednesday', 5);
INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (6, 'Wednesday', 6);
INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (7, 'Friday', 7);
INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (8, 'first', 8);
INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (9, 'second', 8);
INSERT INTO public.days (day_id, day_name, schedule_id)
VALUES (10, 'third', 8);

INSERT INTO public.task (task_id, task_name, task_content, user_id)
VALUES (1, 'First', 'Feed the birds', 1);
INSERT INTO public.task (task_id, task_name, task_content, user_id)
VALUES (2, 'Second', 'Go to gym', 1);
INSERT INTO public.task (task_id, task_name, task_content, user_id)
VALUES (3, 'Third', 'Cook something', 2);
INSERT INTO public.task (task_id, task_name, task_content, user_id)
VALUES (4, 'Fourth', 'Write some code', 2);
INSERT INTO public.task (task_id, task_name, task_content, user_id)
VALUES (5, 'Fifth', 'Do homework', 3);
INSERT INTO public.task (task_id, task_name, task_content, user_id)
VALUES (6, 'Sixth', 'Do relax', 3);


INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (1, 8, 1);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (2, 9, 1);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (3, 11, 2);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (4, 0, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (5, 1, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (6, 2, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (7, 3, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (8, 4, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (9, 5, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (10, 6, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (11, 7, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (12, 8, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (13, 9, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (14, 10, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (15, 11, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (16, 12, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (17, 13, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (18, 14, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (19, 15, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (20, 16, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (21, 17, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (22, 18, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (23, 19, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (24, 20, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (25, 21, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (26, 22, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (27, 23, 8);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (28, 0, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (29, 1, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (30, 2, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (31, 3, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (32, 4, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (33, 5, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (34, 6, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (35, 7, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (36, 8, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (37, 9, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (38, 10, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (39, 11, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (40, 12, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (41, 13, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (42, 14, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (43, 15, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (44, 16, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (45, 17, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (46, 18, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (47, 19, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (48, 20, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (49, 21, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (50, 22, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (51, 23, 9);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (52, 0, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (53, 1, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (54, 2, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (55, 3, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (56, 4, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (57, 5, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (58, 6, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (59, 7, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (60, 8, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (61, 9, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (62, 10, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (63, 11, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (64, 12, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (65, 13, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (66, 14, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (67, 15, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (68, 16, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (69, 17, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (70, 18, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (71, 19, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (72, 20, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (73, 21, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (74, 22, 10);
INSERT INTO public.hour (hour_id, hour_value, day_id)
VALUES (75, 23, 10);

INSERT INTO public.hour_task (hour_id, task_id)
VALUES (1, 1);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (2, 2);
INSERT INTO public.hour_task (hour_id, task_id)
VALUES (4, 2);
