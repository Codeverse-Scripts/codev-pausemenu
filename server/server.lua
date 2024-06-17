local Framework = Config.Framework == "esx" and exports['es_extended']:getSharedObject() or exports['qb-core']:GetCoreObject()

local avatars = {}
function getPlayerAvatar(player)
	if not avatars[player] then
		local identifiers = {}
		local numId = GetNumPlayerIdentifiers(player) - 1

		for i = 0, numId, 1 do
			local identifier = {}

			for id in string.gmatch(GetPlayerIdentifier(player, i), "([^:]+)") do
				table.insert(identifier, id)
			end

			identifiers[identifier[1]] = identifier[2]
		end

		local discord = identifiers["discord"]
		local avatar

		if discord then
			local p = promise.new()

			PerformHttpRequest("https://discordapp.com/api/users/" .. discord, function(statusCode, data)
				if statusCode == 200 then
					data = json.decode(data or "{}")

					if data.avatar then
						local animated = data.avatar:gsub(1, 2) == "a_"

						avatar = "https://cdn.discordapp.com/avatars/" ..
							discord .. "/" .. data.avatar .. (animated and ".gif" or ".png")
					end
				end

				p:resolve()
			end, "GET", "", {
				Authorization = "Bot " .. Config.BotToken
			})

			Citizen.Await(p)
		end

		avatars[player] = avatar or "assets/user-default.png"
	end

	return avatars[player] ~= "assets/user-default.png" and avatars[player] or nil
end

function registerServerCallback(...)
	if Config.Framework == "qb" then
		Framework.Functions.CreateCallback(...)
	else
		Framework.RegisterServerCallback(...)
	end
end

registerServerCallback("codev-pausemenu:getPlayerData", function(src, cb)
	local avatar = getPlayerAvatar(src)
    local xPlayer = Config.Framework == "esx" and Framework.GetPlayerFromId(src) or Framework.Functions.GetPlayer(src)
	local cash = Config.Framework == "esx" and xPlayer.getAccount('money').money or xPlayer.PlayerData.money["cash"]
	local bank = Config.Framework == "esx" and xPlayer.getAccount('bank').money or xPlayer.PlayerData.money["bank"]

	cb({
		cash = cash,
		bank = bank,
		avatar = avatar
	})
end)

RegisterServerEvent("codev-pausemenu:exit", function()
	DropPlayer(source, "You have been disconnected.")
end)