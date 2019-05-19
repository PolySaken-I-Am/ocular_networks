
minetest.register_craftitem("ocular_networks:inspector", {
	description = "Ocular Inspection Tool\n"..minetest.colorize("#00affa", "Sneak and rightclick on a node to \ninspect it"),
	inventory_image = "poly_inspector.png",
	stack_max=1,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type=="node" then
			local meta = minetest.get_meta(minetest.get_pointed_thing_position(pointed_thing, nil))
			local pseudodata=meta:to_table().fields
			if pseudodata.formspec then
				pseudodata.formspec="omitted"
			end
			minetest.show_formspec(placer:get_player_name(), "", "size[7,8;]background[0,0;0,0;poly_gui_formbg.png;true]textarea[0,0.5;7.5,9;arb;Ocular Inspector;"..dump(pseudodata).."]")
		end
	end
})

minetest.register_craftitem("ocular_networks:save_disk", {
	description = "Metadata Save Disk\n"..minetest.colorize("#00affa", "Sneak and rightclick on a node to \nsave it's metadata.\nhold 'use', sneak and right click on a node to load meta to it from the disk.\nhold 'use', and rightclick to view saved meta.\nEXPERIMENTAL"),
	inventory_image = "poly_disk.png",
	not_in_creative_inventory=1,
	stack_max=1,
	on_place = function(itemstack, placer, pointed_thing)
		if placer:get_player_control().aux1 == true and placer:get_player_control().sneak == false then
			if ocular_networks.player_temp_disk[placer:get_player_name()] and ocular_networks.player_temp_disk[placer:get_player_name()].fields then
				local pseudodata=ocular_networks.player_temp_disk[placer:get_player_name()].fields
				if pseudodata.formspec then
					pseudodata.formspec="omitted"
				end
				minetest.show_formspec(placer:get_player_name(), "", "size[7,8;]background[0,0;0,0;poly_gui_formbg.png;true]textarea[0,0.5;7.5,9;arb;experimental metadata transfer disk 3.1;"..dump(pseudodata).."]")
			end
		else
			if pointed_thing.type=="node" then
				local meta = minetest.get_meta(minetest.get_pointed_thing_position(pointed_thing, above))
				if placer:get_player_control().sneak == true and placer:get_player_control().aux1 == false then
					ocular_networks.player_temp_disk[placer:get_player_name()] = meta:to_table()
					minetest.chat_send_player(placer:get_player_name(),  minetest.colorize("#00affa","NodeMetaRef saved to disk"))
				elseif placer:get_player_control().aux1 == true and placer:get_player_control().sneak == true then
					meta:from_table(ocular_networks.player_temp_disk[placer:get_player_name()])
					minetest.chat_send_player(placer:get_player_name(),  minetest.colorize("#00affa","NodeMetaRef loaded from disk"))
				end
			end
		end
	end
})


minetest.register_craftitem("ocular_networks:healer", {
	description = "Suspicious Healing Gimble\n"..minetest.colorize("#00affa", "click to heal yourself, uses personal power network.\nIt looks suspicious, like it has more to it."),
	inventory_image = "poly_gimble.png",
	stack_max=1,
	on_use = function(itemstack, user, pointed_thing)
		if user:get_attribute("personal_ocular_power") and tonumber(user:get_attribute("personal_ocular_power")) > 99 then
			user:set_attribute("personal_ocular_power", tonumber(user:get_attribute("personal_ocular_power"))-10)
			user:set_hp(user:get_hp()+2)
		end
	end
})

minetest.register_craftitem("ocular_networks:placeholder_power", {
	description = "OcularNetworks Power\n"..minetest.colorize("#00affa", "Recipe requires this much OCP"),
	inventory_image = "poly_gui_icon_pwr.png",
	groups = {not_in_creative_inventory=1}
})

minetest.register_tool("ocular_networks:angmallen_hammer", {
	description = minetest.colorize("#00affa", "Angmallen Destroyer"),
	inventory_image = "poly_angmallen_hammer.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 0.01,
		max_drop_level=10,
		groupcaps={
			cracky = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=250, maxlevel=10},
			hekatonium_ore = {times={[1]=3}, uses=150, maxlevel=10}
		},
		damage_groups = {fleshy=19},
	},
	sound = {breaks = "default_tool_breaks"},
})


minetest.register_tool("ocular_networks:angmallen_axe", {
	description = minetest.colorize("#00affa", "Angmallen Deforester"),
	inventory_image = "poly_angmallen_axe.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 0.01,
		max_drop_level=10,
		groupcaps={
			choppy = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=250, maxlevel=10},
		},
		damage_groups = {fleshy=20},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:angmallen_sword", {
	description = minetest.colorize("#00affa", "Angmallen Decapitator\n")..minetest.colorize("#ff0000", "290 Melee Damage"),
	inventory_image = "poly_angmallen_sword.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=10,
		groupcaps={
			snappy = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=250, maxlevel=10},
		},
		damage_groups = {fleshy=290},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_craftitem("ocular_networks:pipe_wrench", {
	description = "C-Type Square Wrench\n"..minetest.colorize("#00affa", "This wrench can be used to rotate pipes."),
	inventory_image = "poly_wrench.png",
	stack_max=1,
})

minetest.register_tool("ocular_networks:hekaton_hammer", {
	description = minetest.colorize("#00affa", "4k Tonne Drumel"),
	inventory_image = "poly_hekaton_hammer.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 0.01,
		max_drop_level=10,
		groupcaps={
			cracky = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=500, maxlevel=10},
			hekatonium_ore = {times={[1]=3}, uses=250, maxlevel=10}
		},
		damage_groups = {fleshy=77},
	},
	sound = {breaks = "default_tool_breaks"},
})


minetest.register_tool("ocular_networks:hekaton_axe", {
	description = minetest.colorize("#00affa", "Erenic Axaw"),
	inventory_image = "poly_hekaton_axe.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 0.01,
		max_drop_level=10,
		groupcaps={
			choppy = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=500, maxlevel=10},
		},
		damage_groups = {fleshy=80},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:hekaton_sword", {
	description = minetest.colorize("#00affa", "Erenic Crindblade\n")..minetest.colorize("#ff0000", "20 Melee Damage")..minetest.colorize("#00affa", "\nRightclick to enable"),
	inventory_image = "poly_hekaton_sword_off.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=10,
		groupcaps={
			snappy = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=500, maxlevel=10},
		},
		damage_groups = {fleshy=20},
	},
	sound = {breaks = "default_tool_breaks"},
	on_secondary_use = function(itemstack, user, pointed_thing)
		itemstack:set_name("ocular_networks:hekaton_sword_on")
		return itemstack
	end
})

minetest.register_tool("ocular_networks:hekaton_sword_on", {
	description = minetest.colorize("#00affa", "Erenic Crindblade\n")..minetest.colorize("#ff0000", "500 Melee Damage")..minetest.colorize("#00affa", "\nRightclick to disable"),
	inventory_image = "poly_hekaton_sword.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=10,
		groupcaps={
			snappy = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=500, maxlevel=10},
		},
		damage_groups = {fleshy=500},
	},
	groups={not_in_creative_inventory=1},
	sound = {breaks = "default_tool_breaks"},
	on_secondary_use = function(itemstack, user, pointed_thing)
		itemstack:set_name("ocular_networks:hekaton_sword")
		return itemstack
	end
})

--

minetest.register_tool("ocular_networks:luminium_pick", {
	description = "Luminium Pickaxe",
	inventory_image = "poly_pick_lumi.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:luminium_shovel", {
	description = "Luminium Shovel",
	inventory_image = "poly_shovel_lumi.png",
	wield_image = "poly_shovel_lumi.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:luminium_axe", {
	description = "Luminium Axe",
	inventory_image = "poly_axe_lumi.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:luminium_sword", {
	description = "Luminium Cleaver",
	inventory_image = "poly_sword_lumi.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	},
	sound = {breaks = "default_tool_breaks"},
})

--

minetest.register_tool("ocular_networks:lumigold_pick", {
	description = "Lumigold Pickaxe",
	inventory_image = "poly_pick_lumig.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=17, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:lumigold_shovel", {
	description = "Lumigold Shovel",
	inventory_image = "poly_shovel_lumig.png",
	wield_image = "poly_shovel_lumig.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=17, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:lumigold_axe", {
	description = "Lumigold Axe",
	inventory_image = "poly_axe_lumig.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=17, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:lumigold_sword", {
	description = "Lumigold Scimitar",
	inventory_image = "poly_sword_lumig.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
	sound = {breaks = "default_tool_breaks"},
})

--

minetest.register_tool("ocular_networks:silicotin_pick", {
	description = "Silicotin Pickaxe",
	inventory_image = "poly_pick_silicotin.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:silicotin_shovel", {
	description = "Silicotin Shovel",
	inventory_image = "poly_shovel_silicotin.png",
	wield_image = "poly_shovel_silicotin.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:silicotin_axe", {
	description = "Silicotin Axe",
	inventory_image = "poly_axe_silicotin.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:silicotin_sword", {
	description = "Silicotin Glaive",
	inventory_image = "poly_sword_silicotin.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=11},
	},
	sound = {breaks = "default_tool_breaks"},
})

--

minetest.register_tool("ocular_networks:shimmering_pick", {
	description = "Shimmering Alloy Pickaxe",
	inventory_image = "poly_pick_shimmering.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:shimmering_shovel", {
	description = "Shimmering Alloy Shovel",
	inventory_image = "poly_shovel_shimmering.png",
	wield_image = "poly_shovel_shimmering.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:shimmering_axe", {
	description = "Shimmering Alloy Axe",
	inventory_image = "poly_axe_shimmering.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:shimmering_sword", {
	description = "Shimmering Alloy Rapier",
	inventory_image = "poly_sword_shimmering.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=11},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("ocular_networks:composite_scythe", {
	description = "Composite Alloy Scythe",
	inventory_image = "poly_composite_scythe.png",
	wield_scale = {x=2.0, y=2.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=27},
	},
	sound = {breaks = "default_tool_breaks"},
})