local here_comes_the_sun = {
	object_type = "Achievement",
	key = "here_comes_the_sun",
	order = 1,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
	--reset_on_startup = true,
	unlock_condition = function(self, args)
        if args.type == "sunny_joker" then
		    return true
        end
	end,
}


local rift = {
	object_type = "Achievement",
	key = "rift",
	order = 2,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
	--reset_on_startup = true,
	unlock_condition = function(self, args)
        if args.type == "rift" then
		    return true
        end
	end,
}

local joy_to_the_world = {
	object_type = "Achievement",
	key = "joy_to_the_world",
	order = 3,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
	--reset_on_startup = true,
	unlock_condition = function(self, args)
        if args.type == "wunjo_duplication" then
		    return true
        end
	end,
}

if (SMODS.Mods["Cryptid"] or {}).can_load then
	local event_horizon = {
		object_type = "Achievement",
		key = "event_horizon",
		order = 500,
		bypass_all_unlocked = true,
		atlas = "entr_achievements",
		--reset_on_startup = true,
		unlock_condition = function(self, args)
			if args.type == "event_horizon" then
				return true
			end
		end,
	}

	local katevaino = {
		object_type = "Achievement",
		key = "katevaino",
		order = 600,
		bypass_all_unlocked = true,
		atlas = "entr_achievements",
		--reset_on_startup = true,
		pos = {x=1,y=1},
		hidden_text = true,
		unlock_condition = function(self, args)
			if args.type == "parakmi_transcend" then
				return true
			end
		end,
	}

	local acheros = {
		object_type = "Achievement",
		key = "acheros",
		order = 999,
		bypass_all_unlocked = true,
		atlas = "entr_achievements",
		--reset_on_startup = true,
		pos = {x=1,y=1},
		hidden_text = true,
		unlock_condition = function(self, args)
			if args.type == "beat_ee" then
				return true
			end
		end,
	}


	local outopia = {
		object_type = "Achievement",
		key = "outopia",
		order = 1000,
		bypass_all_unlocked = true,
		atlas = "entr_achievements",
		--reset_on_startup = true,
		pos = {x=1,y=1},
		hidden_text = true,
		unlock_condition = function(self, args)
			if args.type == "zenith_ascension" then
				return true
			end
		end,
	}
end

return {
    items = {
        here_comes_the_sun,
        event_horizon,
        outopia,
        acheros,
		rift,
		katevaino,
		joy_to_the_world
    }
}