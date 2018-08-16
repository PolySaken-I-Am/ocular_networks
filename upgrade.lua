minetest.register_craftitem("ocular_networks:armor_pendant", {
	description = "Angmallen Armor Upgrade Pendant\n"..minetest.colorize("#00affa", "Click to open your upgrade menu.\nPut Upgrade tokens in the inventory to use them."),
	inventory_image = "poly_armor_angmallen_a_upgrade_pendant.png",
	stack_max=1,
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if inv:get_lists().ocn_armor_upgrades then
			minetest.show_formspec(user:get_player_name(), "ocn_armor_upgrades", "size[8,9;]"..default.gui_bg..default.gui_bg_img.."list[current_player;main;0,5;8,4;]label[0,4.2;These upgrades will only take effect if you are wearing a full set of angmallen armor.\nShield upgrade modules will only work if you have the shield.]list[current_player;ocn_armor_upgrades;0,0;8,4;]")
		else
			inv:set_list("ocn_armor_upgrades", {})
			inv:set_size("ocn_armor_upgrades", 32)
		end
	end
})

local function has_armor_prerequisites(p)
	local inv = minetest.get_inventory({type="detached", name=p:get_player_name().."_armor"})
	return inv:contains_item("armor", "ocular_networks:angmallen_helm") and inv:contains_item("armor", "ocular_networks:angmallen_boots") and inv:contains_item("armor", "ocular_networks:angmallen_chest") and inv:contains_item("armor", "ocular_networks:angmallen_legs")
end

--prepare for lag if armor enabled

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if has_armor_prerequisites(player) then
			local inv = player:get_inventory() 
			local playerPhysics = player:get_physics_override()
			if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_speed") then
				playerPhysics.speed=2
				player:set_physics_override(playerPhysics)
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_speed2") then
				playerPhysics.speed=2.5
				player:set_physics_override(playerPhysics)
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_speed3") then
				playerPhysics.speed=3.5
				player:set_physics_override(playerPhysics)
			else
				playerPhysics.speed=1
				player:set_physics_override(playerPhysics)
			end
		end
	end
end)

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if has_armor_prerequisites(player) then
			local inv = player:get_inventory() 
			local playerPhysics = player:get_physics_override()
			if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_jump") then
				playerPhysics.jump=1.5
				player:set_physics_override(playerPhysics)
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_jump2") then
				playerPhysics.jump=1.7
				player:set_physics_override(playerPhysics)
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_jump3") then
				playerPhysics.jump=2
				player:set_physics_override(playerPhysics)
			else
				playerPhysics.jump=1
				player:set_physics_override(playerPhysics)
			end
		end
	end
end)

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if has_armor_prerequisites(player) then
			local inv = player:get_inventory() 
			local playerPhysics = player:get_physics_override()
			if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_float") then
				playerPhysics.gravity=0.5
				player:set_physics_override(playerPhysics)
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_float2") then
				playerPhysics.gravity=0.3
				player:set_physics_override(playerPhysics)
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_float3") then
				playerPhysics.gravity=0.2
				player:set_physics_override(playerPhysics)
			else
				playerPhysics.gravity=1
				player:set_physics_override(playerPhysics)
			end
		end
	end
end)

minetest.register_craftitem("ocular_networks:angmallen_shield", {
	description = "Angmallen Shield",
	inventory_image = "poly_angmallen_shield.png",
	texture = "poly_angmallen_shield_real.png",
	preview = "poly_angmallen_shield_preview.png",
	groups = {armor_shield=1, armor_use=0, armor_heal=12},
	armor_groups = {fleshy=5},
	damage_groups = {cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage = true,
	stack_max=1,
})

armor:register_armor("ocular_networks:angmallen_shield1", {
	description = "Angmallen Shield",
	inventory_image = "poly_angmallen_shield.png",
	texture = "poly_angmallen_shield_real.png",
	preview = "poly_angmallen_shield_preview.png",
	groups = {armor_shield=1, armor_use=0, armor_heal=12, not_in_creative_inventory=1},
	armor_groups = {fleshy=10},
	damage_groups = {cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage = true,
	stack_max=1,
})

armor:register_armor("ocular_networks:angmallen_shield2", {
	description = "Angmallen Shield",
	inventory_image = "poly_angmallen_shield.png",
	texture = "poly_angmallen_shield_real.png",
	preview = "poly_angmallen_shield_preview.png",
	groups = {armor_shield=1, armor_use=100, armor_heal=12, not_in_creative_inventory=1},
	armor_groups = {fleshy=15},
	damage_groups = {cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage = true,
	stack_max=1
})

armor:register_armor("ocular_networks:angmallen_shield3", {
	description = "Angmallen Shield",
	inventory_image = "poly_angmallen_shield.png",
	texture = "poly_angmallen_shield_real.png",
	preview = "poly_angmallen_shield_preview.png",
	groups = {armor_shield=1, armor_use=100, armor_heal=12, not_in_creative_inventory=1},
	armor_groups = {fleshy=25},
	damage_groups = {cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage = true,
	stack_max=1
})




minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local inv2 = minetest.get_inventory({type="detached", name=player:get_player_name().."_armor"})
		local inv = player:get_inventory()
		if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_defense") then
			if inv2:contains_item("armor", "ocular_networks:angmallen_shield") or inv2:contains_item("armor", "ocular_networks:angmallen_shield2") or inv2:contains_item("armor", "ocular_networks:angmallen_shield3") then
				inv2:remove_item("armor", "ocular_networks:angmallen_shield")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield1")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield2")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield3")
				inv2:add_item("armor", "ocular_networks:angmallen_shield1")
				armor:set_player_armor_defense(player)
			end
		elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_defense2") then
			if inv2:contains_item("armor", "ocular_networks:angmallen_shield") or inv2:contains_item("armor", "ocular_networks:angmallen_shield1") or inv2:contains_item("armor", "ocular_networks:angmallen_shield3") then
				inv2:remove_item("armor", "ocular_networks:angmallen_shield")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield1")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield2")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield3")
				inv2:add_item("armor", "ocular_networks:angmallen_shield2")
				armor:set_player_armor_defense(player)
			end
		elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_defense3") then
			if inv2:contains_item("armor", "ocular_networks:angmallen_shield") or inv2:contains_item("armor", "ocular_networks:angmallen_shield1") or inv2:contains_item("armor", "ocular_networks:angmallen_shield2") then
				inv2:remove_item("armor", "ocular_networks:angmallen_shield")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield1")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield2")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield3")
				inv2:add_item("armor", "ocular_networks:angmallen_shield3")
				armor:set_player_armor_defense(player)
			end
		else
			if inv2:contains_item("armor", "ocular_networks:angmallen_shield1") or inv2:contains_item("armor", "ocular_networks:angmallen_shield2") or inv2:contains_item("armor", "ocular_networks:angmallen_shield3") then
				inv2:remove_item("armor", "ocular_networks:angmallen_shield")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield1")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield2")
				inv2:remove_item("armor", "ocular_networks:angmallen_shield3")
				inv2:add_item("armor", "ocular_networks:angmallen_shield")
				armor:set_player_armor_defense(player)
			end
		end
	end
end)

ocular_networks.heal_pause = 0

minetest.register_globalstep(function(dtime)
	ocular_networks.heal_pause = ocular_networks.heal_pause + dtime
	for _,player in ipairs(minetest.get_connected_players()) do
		if has_armor_prerequisites(player) then
			if ocular_networks.heal_pause > 1.99 then
				local inv = player:get_inventory() 
				local playerPhysics = player:get_physics_override()
				local power = player:get_attribute("personal_ocular_power")
				if player:get_hp() < 20 then
					if power and tonumber(power) > 49 then
						if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_heal") then	
							player:set_attribute("personal_ocular_power", power-50)
							player:set_hp(player:get_hp()+1)
							ocular_networks.heal_pause = 0
						elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_heal2") then
							player:set_attribute("personal_ocular_power", power-50)
							player:set_hp(player:get_hp()+2)
							ocular_networks.heal_pause = 0
						end
					end
				end
			end
		end
	end
end)

minetest.register_craftitem("ocular_networks:upgrade", {
	description = "Armor Upgrade Base\n"..minetest.colorize("#00affa", "Used to make upgrade tokens for the angmallen armor."),
	inventory_image = "poly_upgrade.png",
})

minetest.register_craftitem("ocular_networks:upgrade_speed", {
	description = "Speed Upgrade L1 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "2x speed multiplier"),
	inventory_image = "poly_upgrade_speed.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_speed2", {
	description = "Speed Upgrade L2 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "2.5x speed multiplier"),
	inventory_image = "poly_upgrade_speed.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_speed3", {
	description = "Speed Upgrade L3 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "3x speed multiplier"),
	inventory_image = "poly_upgrade_speed.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_jump", {
	description = "Jump Upgrade L1 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "2x jump multiplier"),
	inventory_image = "poly_upgrade_jump.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_jump2", {
	description = "Jump Upgrade L2 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "3x jump multiplier"),
	inventory_image = "poly_upgrade_jump.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_jump3", {
	description = "Jump Upgrade L3 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "4x jump multiplier"),
	inventory_image = "poly_upgrade_jump.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_float", {
	description = "Hover Upgrade L1 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "0.5x gravity modifier"),
	inventory_image = "poly_upgrade_float.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_float2", {
	description = "Hover Upgrade L2 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "0.3x gravity modifier"),
	inventory_image = "poly_upgrade_float.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_float3", {
	description = "Hover Upgrade L3 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "0.2x gravity modifier"),
	inventory_image = "poly_upgrade_float.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_defense", {
	description = "Shield Upgrade L1 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen shield.\n")..minetest.colorize("#ff0000", "+5 defense"),
	inventory_image = "poly_upgrade_defense.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_defense2", {
	description = "Shield Upgrade L2 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen shield.\n")..minetest.colorize("#ff0000", "+10 defense"),
	inventory_image = "poly_upgrade_defense.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_defense3", {
	description = "Shield Upgrade L3 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen shield.\n")..minetest.colorize("#ff0000", "+20 defense"),
	inventory_image = "poly_upgrade_defense.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_heal", {
	description = "Healing Module\n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "+1 HP/50 OCP"),
	inventory_image = "poly_upgrade_heal.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})

minetest.register_craftitem("ocular_networks:upgrade_heal2", {
	description = "Healing Module L2\n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "+2 HP/50 OCP"),
	inventory_image = "poly_upgrade_heal.png",
	groups = {ocp_upgrade=1},
	stack_max=1
})
