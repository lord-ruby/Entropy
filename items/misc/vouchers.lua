Entropy.Voucher{
    dependencies = {
        items = {
          "set_entr_vouchers",
          "set_entr_inversions",
        }
    },
    order = -2000,
    key = "marked",
    atlas = "vouchers",
    pos = {x=0, y=0},
    redeem = function(self, card)
        G.GAME.Marked = true
    end,
    unredeem = function(self, card) 
        G.GAME.Marked = nil
    end,
    entr_credits = {
        art = {"Grahkon"}
    }
}

Entropy.Voucher{
    dependencies = {
        items = {
          "set_entr_vouchers",
          "set_entr_inversions",
        }
    },
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

Entropy.Voucher{
    dependencies = {
        items = {
          "set_entr_vouchers",
          "set_entr_runes",
        }
    },
    order = -2000+3,
    key = "diviner",
    atlas = "vouchers",
    pos = {x=0, y=1},
    redeem = function(self, card)
        G.GAME.entr_diviner = true
    end,
    unredeem = function(self, card) 
        G.GAME.entr_diviner = nil
    end,
}

Entropy.Voucher{
    dependencies = {
        items = {
          "set_entr_vouchers",
          "set_entr_runes",
        }
    },
    order = -2000+4,
    key = "providence",
    atlas = "vouchers",
    pos = {x=1, y=1},
    requires = {"v_entr_diviner"},
    redeem = function(self, card)
        G.GAME.providence = true
    end,
    unredeem = function(self, card) 
        G.GAME.providence = nil
    end
}

Entropy.Voucher{
    dependencies = {
        items = {
          "set_entr_vouchers",
        }
    },
    order = -2000+5,
    key = "starter_kit",
    atlas = "vouchers",
    pos = {x=0, y=2},
    redeem = function(self, card)
        G.GAME.booster_rate = 8
    end,
    unredeem = function(self, card) 
        G.GAME.booster_rate = nil
    end
}

Entropy.Voucher{
    dependencies = {
        items = {
          "set_entr_vouchers",
        }
    },
    order = -2000+6,
    key = "expansion_pack",
    atlas = "vouchers",
    pos = {x=1, y=2},
    requires = {"v_entr_starter_kit"},
    redeem = function(self, card)
        G.GAME.deck_voucher_rate = 2
    end,
    unredeem = function(self, card) 
        G.GAME.deck_voucher_rate = nil
    end
}