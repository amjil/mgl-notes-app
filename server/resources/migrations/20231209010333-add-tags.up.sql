CREATE TABLE tags (
    "id" uuid,
    user_id uuid not null,
    "name" text,
    related_num integer default 0
);
--;;
create index tags_user_id_index on tags(user_id);