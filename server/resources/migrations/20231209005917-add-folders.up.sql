CREATE TABLE folders (
    "id" uuid,
    parent_id uuid,
    user_id uuid,
    name text,
    order_num smallint default 0,
    related_num integer default 0
);
--;;
create index folders_user_id_index on folders(user_id);