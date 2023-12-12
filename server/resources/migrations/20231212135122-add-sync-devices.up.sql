CREATE TABLE sync_devices (
    sync_id uuid,
    user_id uuid not null,
    "status" smallint default 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--;;
create index sync_devices_user_id_index on sync_devices(user_id);