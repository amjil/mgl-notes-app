-- Place your queries here. Docs available https://www.hugsql.org/

-- :name query-server-sync-data :? :*
-- :doc query server sync-data
select 
    a.*
from waiting_for_sync a 
    left join user_devices b on a.user_id = b.user_id
    left outer join sync_devices c on c.sync_id = a.id
where 1 = 1
    and b.device_id = :device_id
    and a.user_id = :user_id
    and c.sync_id is null
order by a.created_at desc


-- :name query-server-sync-count :? :*
-- :doc query server sync-count
select 
    count(a.id) as num
from waiting_for_sync a 
    left join user_devices b on a.user_id = b.user_id
    left outer join sync_devices c on c.sync_id = a.id
where 1 = 1
    and b.device_id = :device_id
    and a.user_id = :user_id
    and c.sync_id is null