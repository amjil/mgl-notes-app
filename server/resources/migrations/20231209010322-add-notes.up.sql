CREATE TABLE notes (
    "id" uuid,
    folder_id uuid,
    user_id uuid not null,
    content text,
    flag smallint DEFAULT 0,
    "status" smallint DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
--;;
create index notes_user_id_index on notes(user_id);
--;;
create index notes_id_index on notes(id);