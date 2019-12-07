-- 2.Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим 
-- пользоваетелем.
select* from friendship;
select* from users;
select* from messages;

select (select concat(first_name, ' ', last_name) from users where id = from_user_id) as friend, count(*) as total_messages
	from messages 
		where to_user_id = 98
				and from_user_id in(
				select friend_id as id from friendship WHERE user_id = messages.to_user_id
				union
				select user_id as id from friendship where friend_id = messages.to_user_id)
	group by messages.from_user_id
    order by total_messages DESC limit 10
    ;

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
select*from likes;
select* from profiles;
select SUM(likes_per_user)AS likes_total FROM(
   SELECT COUNT(*) as likes_per_user 
   FROM likes 
     WHERE target_type_id = 3
       AND target_id IN (
        SELECT * FROM (
         SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10
       ) AS sorted_profiles 
    ) 
     GROUP BY target_id
     ) AS counted_likes;

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

select*from profiles;
select*from likes;
select*from users;

SELECT CASE(sex)
		WHEN 'm' THEN 'man'
		WHEN 'f' THEN 'woman'
	END AS sex, 
	COUNT(*) as likes_count 
	  FROM (
	    SELECT 
	      user_id as user, 
		    (SELECT sex FROM profiles WHERE user_id = user) as sex 
		  FROM likes) as dummy_table 
  GROUP BY sex
  ORDER BY likes_count
  LIMIT 1;

 -- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
SELECT * FROM users;
SELECT * FROM likes;
SELECT * FROM media;
SELECT * FROM messages;

SELECT CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) 
	AS overall_activity 
	FROM users
	ORDER BY overall_activity
	LIMIT 10;
