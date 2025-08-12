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
insert into notes (id, user_id, content, block_ids, created_at, updated_at, sync_version)
values (:id, :user_id, :content, :block_ids, :created_at, :updated_at, :sync_version)
on conflict (id) do update set
content = :content,
block_ids = :block_ids,
created_at = :created_at,
updated_at = :updated_at,
sync_version = :sync_version

-- :name delete-note! :! :n
update notes
set is_deleted = true, deleted_at = :deleted_at
where id = :id

-- :name get-note :? :1
-- :doc retrieves a note record given the id and user_id
SELECT * FROM notes
WHERE id = :id AND user_id = :user_id AND is_deleted = false

-- :name get-notes-since :? :*
-- :doc retrieves notes updated since specified time for a user
SELECT * FROM notes
WHERE user_id = :user_id AND updated_at > :since AND is_deleted = false
ORDER BY updated_at ASC

-- :name get-notes-by-user :? :*
-- :doc retrieves all notes for a user
SELECT * FROM notes
WHERE user_id = :user_id AND is_deleted = false
ORDER BY updated_at DESC


