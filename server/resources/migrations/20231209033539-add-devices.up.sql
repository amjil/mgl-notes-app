CREATE TABLE user_devices (
    user_id uuid not null,
    device_id text
);
--;;
create index user_devices_user_id_index on user_devices(user_id);
--;;
create index user_devices_device_id_index on user_devices(device_id);
--;;
create index user_devices_user_device_index on user_devices(user_id, device_id);