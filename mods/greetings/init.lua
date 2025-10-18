minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local server_name = minetest.settings:get("server_name") or "Unknown Server"
    minetest.chat_send_player(name, "Welcome to " .. server_name .. "!")
end)
