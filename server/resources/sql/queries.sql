-- :name create-user! :! :n
-- :doc creates a new user record
INSERT INTO users
(id, user_name, email, pass)
VALUES (:id, :user_name, :email, :pass)

-- :name update-user! :! :n
-- :doc updates an existing user record
UPDATE users
SET user_name = :user_name, email = :email
WHERE id = :id

-- :name get-user :? :1
-- :doc retrieves a user record given the id
SELECT * FROM users
WHERE id = :id

-- :name delete-user! :! :n
-- :doc deletes a user record given the id
DELETE FROM users
WHERE id = :id

-- Notes related queries
-- :name pull-notes :? :*
select id, content, block_ids, created_at, updated_at 
from notes
where updated_at > :since
order by updated_at asc

-- :name upsert-note! :! :n
insert into notes (id, content, block_ids, created_at, updated_at)
values (:id, :content, :block_ids, :created_at, :updated_at)
on conflict (id) do update set
content = :content,
block_ids = :block_ids,
created_at = :created_at,
updated_at = :updated_at

-- :name delete-note! :! :n
update notes
set is_deleted = true, deleted_at = :deleted_at
where id = :id


