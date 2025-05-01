local event_horizon = SMODS.Achievement{
	key = "unstable_concoction",
	order = 1,
	bypass_all_
	--reset_on_startup = true,
	unlock_condition = function(self, args)
		if args.type == "unstable_concoction" then
			return true
		end
	end,
}