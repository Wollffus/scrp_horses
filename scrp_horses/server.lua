local Inventory = {}
TriggerEvent("redemrp_inventory:getData",function(table)
	Inventory = table
end)

RegisterServerEvent("RegisterUsableItem:brush")
AddEventHandler("RegisterUsableItem:brush", function(source)
	TriggerClientEvent('scrp_horses:Brush', source)
end)

local FeedItem = Config.FeedItem
RegisterServerEvent("RegisterUsableItem:"..FeedItem)
AddEventHandler("RegisterUsableItem:"..FeedItem, function(source)
	TriggerClientEvent('scrp_horses:Feed', source, false, Config.FeedPercentage)
end)

RegisterServerEvent("scrp_horses:Consume")
AddEventHandler("scrp_horses:Consume", function(item)
    local _source = source
    if Config.Redemrp_inventory2 == true then
        local ItemData = Inventory.getItem(_source, FeedItem)
        ItemData.RemoveItem(1)
    else
        Inventory.delItem(_source, FeedItem, 1)
    end
end)

RegisterServerEvent("scrp_horses:requestbrush")
AddEventHandler("scrp_horses:requestbrush", function(horse)
    local _source = source
    if Config.Redemrp_inventory2 == true then
        local ItemData = Inventory.getItem(_source, 'brush')
        if ItemData.ItemAmount > 0 then
            TriggerClientEvent('scrp_horses:Brush', _source, horse)
        else
            TriggerClientEvent('redemrp_notification:start', _source, "you dont have a brush", 5, 'error')
        end
    else
        local amount = Inventory.checkItem(_source,'brush')
        if amount > 0 then
            TriggerClientEvent('scrp_horses:Brush', _source, horse)
        else
            TriggerClientEvent('redemrp_notification:start', _source, "you dont have a brush", 5, 'error')
        end
    end
end)

RegisterServerEvent("scrp_horses:requestfeed")
AddEventHandler("scrp_horses:requestfeed", function(horse)
	local _source = source
    if Config.Redemrp_inventory2 == true then
        local ItemData = Inventory.getItem(_source, FeedItem)
        if ItemData.ItemAmount > 0 then
            TriggerClientEvent('scrp_horses:Feed', _source, horse, Config.FeedPercentage)
        else
            TriggerClientEvent('redemrp_notification:start', _source, "you dont any food for your horse", 5, 'error')
        end
    else
        local amount = Inventory.checkItem(_source, FeedItem)
        if amount > 0 then
            TriggerClientEvent('scrp_horses:Feed', _source, horse, Config.FeedPercentage)
        else
            TriggerClientEvent('redemrp_notification:start', _source, "you dont any food for your horse", 5, 'error')
        end
    end
end)
