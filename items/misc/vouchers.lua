local marked = {
    dependencies = {
        items = {
          "set_entr_vouchers",
          "set_entr_inversions",
        }
    },
	object_type = "Voucher",
    order = -2000,
    key = "marked",
    atlas = "vouchers",
    pos = {x=0, y=0},
    redeem = function(self, card)
        G.GAME.Marked = true
    end,
    unredeem = function(self, card) 
        G.GAME.Marked = nil
    end
}

local trump_card = {
    dependencies = {
        items = {
          "set_entr_vouchers",
          "set_entr_inversions",
        }
    },
	object_type = "Voucher",
    order = -2000+1,
    key = "trump_card",
    atlas = "vouchers",
    pos = {x=1, y=0},
    requires = {"v_entr_marked"},
    redeem = function(self, card)
        G.GAME.TrumpCard = true
    end,
    unredeem = function(self, card) 
        G.GAME.TrumpCard = nil
    end
}

local supersede = {
    dependencies = {
        items = {
          "set_entr_vouchers",
          "set_entr_inversions",
          "set_cry_tier3"
        }
    },
	object_type = "Voucher",
    order = -2000+2,
    key = "supersede",
    atlas = "vouchers",
    pos = {x=2, y=0},
    requires = {"v_entr_trump_card"},
    redeem = function(self, card)
        G.GAME.Supersede = true
    end,
    unredeem = function(self, card) 
        G.GAME.Supersede = nil
    end,
    loc_vars = function(self, info_queue, card)
    end
}

local alt_path = {
    dependencies = {
        items = {
          "set_entr_vouchers",
          "set_entr_inversions",
        }
    },
	object_type = "Voucher",
    order = 10000,
    key = "alt_path",
    atlas = "vouchers",
    pos = {x=3, y=0},
    cost = 0,
    no_doe = true,
    redeem = function(self, card)
        G.GAME.alt_path = true
    end,
    in_pool = function()
        return false
    end
}

return {
    items = {
        marked,
        trump_card,
        supersede,
        alt_path
    }
}