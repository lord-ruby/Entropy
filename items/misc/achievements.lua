local here_comes_the_sun = {
	object_type = "Achievement",
	key = "here_comes_the_sun",
	order = 1,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
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
	unlock_condition = function(self, args)
        if args.type == "wunjo_duplication" then
		    return true
        end
	end,
}

local suburban_jungle = {
	object_type = "Achievement",
	key = "suburban_jungle",
	order = 4,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
	unlock_condition = function(self, args)
        if args.type == "suburban_jungle" then
		    return true
        end
	end,
}

local f_x = {
	object_type = "Achievement",
	key = "f_x",
	order = 5,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
	unlock_condition = function(self, args)
        if args.type == "anti_derivative" then
		    return true
        end
	end,
}

local c_sharp = {
	object_type = "Achievement",
	key = "c_sharp",
	order = 1000,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
	pos = {x=1,y=1},
	unlock_condition = function(self, args)
        if args.type == "entr_all_unlocked" then
		    return true
        end
	end,
}

function Entropy.total_completions()
	local total = 0
	local u_ds = 0
	for i, v in pairs(G.P_CENTERS) do
		if not v.original_mod or v.original_mod.id == "entr" then
			total = total + 1
			u_ds = u_ds + (v.discovered and v.unlocked and 1 or 0)
		end
	end
	for i, v in pairs(G.P_BLINDS) do
		if not v.original_mod or v.original_mod.id == "entr" then
			total = total + 1
			u_ds = u_ds + (v.discovered and v.unlocked and 1 or 0)
		end
	end
	for i, v in pairs(G.P_TAGS) do
		if not v.original_mod or v.original_mod.id == "entr" then
			total = total + 1
			u_ds = u_ds + (v.discovered and v.unlocked and 1 or 0)
		end
	end
	return u_ds, total
end

local discover_ref = discover_card
function discover_card(card, ...)
	discover_ref(card, ...)
	local u, t = Entropy.total_completions()
	if u >= t then
		check_for_unlock({type = "entr_all_unlocked"})
	end
end


if (SMODS.Mods["Cryptid"] or {}).can_load then
	local event_horizon = {
		object_type = "Achievement",
		key = "event_horizon",
		order = 500,
		bypass_all_unlocked = true,
		atlas = "entr_achievements",
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
		pos = {x=1,y=1},
		hidden_text = true,
		unlock_condition = function(self, args)
			if args.type == "parakmi_transcend" then
				return true
			end
		end,
	}
end

local acheros = {
	object_type = "Achievement",
	key = "acheros",
	order = 999,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
	pos = {x=1,y=1},
	hidden_text = true,
	unlock_condition = function(self, args)
		if args.type == "beat_ee" then
			return true
		end
	end,
}

return {
    items = {
        here_comes_the_sun,
        event_horizon,
        acheros,
		rift,
		katevaino,
		joy_to_the_world,
		suburban_jungle,
		f_x,
		c_sharp
    }
}