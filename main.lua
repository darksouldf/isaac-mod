local MyMod = RegisterMod("plug",1)
local plug = Isaac.GetItemIdByName("Затычка")
got_item = false
function MyMod:postPeffectUpdate()
  if Game():GetFrameCount()==1 then
    got_item = false
  end
  
end
function MyMod:CacheUpdate(player, cacheFlag)
  local player = Isaac.GetPlayer(0)
  if player:HasCollectible(plug) then
    if cacheFlag == CacheFlag.CACHE_DAMAGE then
      player.Damage = player.Damage + 3.0;
    end
    if cacheFlag == CacheFlag.CACHE_SPEED then
      player.MoveSpeed = player.MoveSpeed - 0.3;
    end
    if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
      player.ShotSpeed = player.ShotSpeed + 0.5;
    end

  end
  end
function MyMod:GotItemFunc() 
  local player = Isaac.GetPlayer(0) 
  if player:HasCollectible(plug) and got_item == false then 
    got_item = true 
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, 39, Isaac.GetFreeNearPosition(player.Position, 10), Vector(0, 0), player) 

  end 
end
    
MyMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, MyMod.CacheUpdate)
MyMod:AddCallback(ModCallbacks.MC_POST_UPDATE, MyMod.GotItemFunc, EntityType.ENTITY_PLAYER)
MyMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, MyMod.postPeffectUpdate)