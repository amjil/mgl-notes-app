CREATE TABLE note_tags (
    user_id uuid not null,
    tag_id uuid,
    note_id uuid
);
--;;
create index note_tags_user_id_index on note_tags(user_id);