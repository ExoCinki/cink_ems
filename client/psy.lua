CreateThread(function()

    local EmsPsy = AddBlipForCoord(Config.BlipsPsy.position.x, Config.BlipsPsy.position.y, Config.BlipsPsy.position.z)
      
      SetBlipSprite(EmsPsy, Config.BlipsPsy.sprite)
      SetBlipDisplay(EmsPsy, Config.BlipsPsy.display)
      SetBlipScale(EmsPsy, Config.BlipsPsy.scale)
      SetBlipColour(EmsPsy, Config.BlipsPsy.colour)
      SetBlipAsShortRange(EmsPsy, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(Config.BlipsPsy.title)
      EndTextCommandSetBlipName(EmsPsy)
end)