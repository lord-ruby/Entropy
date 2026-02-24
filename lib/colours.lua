G.C.Entropy = {}
G.C.Entropy.Star = HEX("845baa")
G.C.Entropy.Omen = HEX("ff00c4")
G.C.Entropy.Fraud = HEX("da7272")
G.C.Entropy.Command = HEX("ff0000")
G.C.Entropy.Rune = HEX("b47bbb")
G.C.Entropy.Pact = HEX("ab124c")
G.C.Entropy.Transient = HEX("81598c")
G.C.Entropy.Dissolve = {
    Star = G.C.Entropy.Star,
    Omen = G.C.Entropy.Omen,
    Command = G.C.Entropy.Command,
    Fraud = G.C.Entropy.Fraud,
    Transient = G.C.Entropy.Transient,
    Pact = G.C.Entropy.Pact,
    Rune = G.C.Entropy.Rune
}

G.C.ALTBG = HEX("41566f")

G.C.Entropy.ORANGE = HEX("ff5e00")

G.C.Entropy.DARK_GRAY = HEX("6a7895")
G.C.Entropy.LIGHT_GRAY = HEX("95ade0")

Entropy.entropic_gradient = SMODS.Gradient {
    key = "entropic_gradient",
    colours = {
        G.C.RED,
        G.C.GOLD,
        G.C.GREEN,
        G.C.BLUE,
        G.C.PURPLE
    }
}

Entropy.transgender_gradient = SMODS.Gradient {
    key = "transgender_gradient",
    colours = {
        HEX("5bcefa"),
        HEX("f5a9b8"),
    }
}

Entropy.reverse_legendary_gradient = SMODS.Gradient {
    key = "reverse_legendary_gradient",
    colours = {
        HEX("ff00c4"),
        HEX("FF00FF"),
        HEX("FF0000"),
    }
}

Entropy.zenith_gradient = SMODS.Gradient{
    key = "zenith_gradient",
    colours = {
        HEX("a20000"),
        HEX("a15000"),
        HEX("a3a101"),
        HEX("626262"),
        HEX("416600"),
        HEX("028041"),
        HEX("008284"),
        HEX("005683"),
        HEX("000056"),
        HEX("2b0157"),
        HEX("6a016a"),
        HEX("77003c"),
    }
}

Entropy.void_gradient = SMODS.Gradient {
    key = "void_gradient",
    colours = {
        HEX("c678b4"),
        HEX("c67886")
    }
}