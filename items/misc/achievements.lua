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

local event_horizon = {
	object_type = "Achievement",
	key = "event_horizon",
	order = 2,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
	--reset_on_startup = true,
	unlock_condition = function(self, args)
        if args.type == "event_horizon" then
		    return true
        end
	end,
}

local megalyteri = {
	object_type = "Achievement",
	key = "megalyteri",
	order = 600 + 1,
	bypass_all_unlocked = true,
	atlas = "entr_achievements",
	--reset_on_startup = true,
    pos = {x=1,y=1},
    hidden_text = true,
	unlock_condition = function(self, args)
        if args.type == "dekatria_50k" then
		    return true
        end
	end,
}

return {
    items = {
        here_comes_the_sun,
        event_horizon,
        megalyteri
    }
}