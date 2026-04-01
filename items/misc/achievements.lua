SMODS.Achievement{
	
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


SMODS.Achievement{
	
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

SMODS.Achievement{
	
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

SMODS.Achievement{
	
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

SMODS.Achievement{
	
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

SMODS.Achievement{
	
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
	SMODS.Achievement{
		
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

	SMODS.Achievement{
		
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

SMODS.Achievement{
	
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