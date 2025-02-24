
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(60000)

    if IsPlayerPlaying(PlayerId()) and LocalPlayer.state.isLoggedIn and not LocalPlayer.state.not_save_custom then      
      BRserver._updateCustomization(tBR.getCustomization())
    end
  end
end)

function BR.toggleCommand(state)
  LocalPlayer.state:set('enable_command', state, true)
end

function tBR.getCustomization()
  return exports.sw_appearance:getPedAppearance(PlayerPedId())
end

function tBR.setCustomization(custom)
  local health = GetEntityHealth(cache.ped)
  local armour = GetPedArmour(cache.ped)  
  exports.sw_appearance:setPedAppearance(cache.ped, custom)
  cache.ped = PlayerPedId()
  SetEntityHealth(cache.ped, health)
  SetPedArmour(cache.ped, armour)
  return true
end

RegisterNetEvent('br_core:client:weapon_sync', function(_t, _w, _data)
  if GetInvokingResource() then return end
  if _t == "LIVERY" then
    for _, lv in next, _data or {} do
      if IsPedWeaponComponentActive(cache.ped, _w, lv) then
        SetPedWeaponLiveryColor(cache.ped, _w, lv.comp, lv.color or 0)
      end
    end
  elseif _t == 'TINT' then
    SetPedWeaponTintIndex(cache.ped, _w, _data)
  end
end)
