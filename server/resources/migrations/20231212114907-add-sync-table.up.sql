CREATE TABLE waiting_for_sync (
    id uuid,
    user_id uuid not null,
    table_id varchar(20), row_id text, 
    types_of smallint,
    "status" smallint default 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--;;
create index waiting_for_sync_user_id_index on waiting_for_sync(user_id);