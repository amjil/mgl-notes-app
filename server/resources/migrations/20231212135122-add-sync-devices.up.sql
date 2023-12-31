CREATE TABLE sync_devices (
    sync_id uuid,
    device_id text not null,
    "status" smallint default 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--;;
create index sync_devices_device_id_index on sync_devices(device_id);