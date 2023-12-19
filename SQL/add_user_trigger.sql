DECLARE
user_role_id INTEGER = 1;
default_event_category_id INTEGER = 1;

date1 Date = NOW() + INTERVAL '1 day';
date2 Date = NOW() + INTERVAL '2 day';
date3 Date = NOW() + INTERVAL '3 day';

BEGIN
-- INSERT INTO app.activity (uuid, activated, user_id) VALUES (gen_random_uuid(), 0, NEW.id);

-- Задаем роль пользователю
INSERT INTO app.user_role (user_id, role_id) VALUES (NEW.id, user_role_id);

-- Создаем событие пользователя
INSERT INTO app.event (title, event_date, event_category_id, user_id) VALUES ('Новое событие', date1, default_event_category_id, NEW.id);
INSERT INTO app.event (title, event_date, event_category_id, user_id) VALUES ('Тренировка', date2, 2, NEW.id);
INSERT INTO app.event (title, event_date, event_category_id, user_id) VALUES ('Тур по барам', date3, 3, NEW.id);
-- INSERT INTO app.event (title, user_id) VALUES ('Тренажерный зал', NEW.id) RETURNING id into categoryId2;


RETURN NEW;
END