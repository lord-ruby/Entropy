return {
	descriptions = {
		Enhanced = {

		},
		Joker = {
			j_entr_stillicidium = {
				name = "Stillicidium",
				text = {
					"Transform {C:attention}Jokers{} to the right",
					"and all {C:attention}consumables{} into the",
					"card that precedes them in the",
					"collection at the end of the shop",
					"Reduce the rank of {C:attention}scored cards{} by 1",
					"reduce blind sizes by {C:attention}30%{}"
				}
			},
			j_entr_ruby = {
				name = "Ruby",
				text = {
					"{V:1,E:1}You may never lose.{}",
					"{C:inactive}(#1#){}",
					"{C:inactive}(Prevents losing unconditionally)"
				}
			},
			j_entr_surreal_joker = {
				name = "Surreal Joker",
				text = {
 					"Mult {X:entr_eqmult,C:white} = #1#{}"
				}
			},
			j_entr_acellero = {
				name = "Epitachyno",
				text = {
 					"{X:dark_edition,C:white}^#1#{} to all other Joker values",
					"at the end of the {C:attention}shop{}",
					"then increase {C:attention}exponent{} by {X:dark_edition,C:white}#2#{}"
				}
			},
			j_entr_helios= {
				name = "Helios",
				text = {
 					"{X:dark_edition,C:white}Infinite{} {C:attention}card selection limit{}",
					"Ascension formula is now {X:dark_edition,C:white}X(#1#^^#2#n){}",
					"{C:attention}All cards{} contribute to {C:Attention}Ascension power{}"
				}
			},
			j_entr_xekanos = {
				name = "Xekanos",
				text = {
 					"{X:dark_edition,C:white}#1#X{} {C:attention}Ante gain{}",
					"increases by {X:dark_edition,C:white}#2#{}",
					"when the Ante changes",
					"{X:dark_edition,C:white}Halve{} this value when",
					"a {C:attention}Rare{} or higher rarity {C:attention}Joker{}",
					"is sold"
				}
			},
			j_entr_ieros = {
				name = "Ieros",
				text = {
 					"{X:dark_edition,C:white}33%{} chance to upgrade",
					"Joker {C:attention}rarities{} in the shop recursively",
					"Gain {X:dark_edition,C:white}^^Chips{} when buying a Joker",
					"Based on the Joker's {C:attention}rarity{}",
					"{C:inactive}(Currently: {}{X:dark_edition,C:white}^^#1#{}{C:inactive}){}",
				}
			},
			j_entr_perkeo = {
				name = "Oekrep",
				text = {
					"Destroy a {C:attention}random{} consumable and",
					"create a corresponding {C:dark_edition}Negative{}",
					"Mega Booster Pack at the end of the {C:attention}shop{}"
				}
			},
			j_entr_yorick = {
				name = "Kciroy",
				text = {
					"{C:dark_edition}X#1#{} Hand size, {C:dark_edition}+#2#{} card selection limit",
					"This Joker gains {X:dark_edition,C:white}^#3#{} Chips every",
					"{C:attention}#4#{} {C:inactive}[#5#]{} cards discarded",
					"{C:inactive}(Currently{} {X:dark_edition,C:white}^#6#{} {C:inactive}Chips){}"
				}
			},
			j_entr_chicot = {
				name = "Tocihc",
				text = {
					"Create the {C:attention}current{} Blind's skip",
					"tag when Blind is selected",
					"Reduce non-Boss Blind sizes by {C:attention}80%{}",
					"{C:inactive}(Currently: #1#){}"
				}
			},
			j_entr_triboulet = {
				name = "Teluobirt",
				text = {
					"Scored {C:attention}Jacks{} give {X:chips,C:white}XChips{}",
					"equal to the {C:attention}number{} of played Jacks in the hand",
					"Retrigger {C:attention}scored{} Jacks based on their",
					"order in the played hand"
				}
			},
			j_entr_canio = {
				name = "Oinac",
				text = {
					"This Joker gains {X:dark_edition,C:white}^#1#{} Chips",
					"when a {C:attention}face{} card is destroyed",
					"{C:attention}Played{} playing cards are destroyed",
					"and a card with +1 rank is drawn to the {C:attention}hand{}",
					"{C:inactive}(Currently: {}{X:dark_edition,C:white}^#2#{} {C:inactive}Chips){}"
				}
			},

		},
		Blind = {
			bl_entr_red = {
				name = "Red Room",
				text = {
					"???"
				}
			}	
		},
		Back = {
			b_entr_twisted = {
				name = "Twisted Deck",
				text =  {
								"All {C:red}invertable{} consumables",
								"are automatically {C:red}inverted{}",
							}
			},
			b_entr_ccd2 = {
				name = "Redefined Deck",
				text =  {
								"Every card is also a random",
								"{C:attention}Joker{}, {C:attention}Booster Pack{},",
								"{C:attention}Voucher{}, or {C:attention}consumable{}"
							}
			},
			b_entr_doc = {
				name = "Deck of Containment",
				text =  {
								"{C:red}Beyond{} has higher chances of showing",
								"up and {X:blue,C:white}Chips{} are lowered",
								"based on how high your {X:dark_edition,C:white}Entropy{} is",
								"Gain {X:dark_edition,C:white}Entropy{} when playing",
								"editioned/enhanced cards, secret hands",
								"or using consumables"
							}
			}
		},
		RTarot = {
			c_entr_fool = {
				name = "The Fool?",
				text = {
					"Reverse {C:attention}1{} selected",
					"Tarot or reverse Tarot"
				}
			}
			
		},
		Voucher = {
			v_entr_marked = {
				name = "Marked Cards",
				text = {
					"{C:red}Inverted{} consumables have a",
					"fixed {C:red}10%{} chance to replace",
					"their regular counterparts"
				},
			},
			v_entr_trump_card = {
				name = "Trump Card",
				text = {
					"{C:red}Flipside{} can appear in",
					"{C:attention}Planet{}, {C:attention}Tarot{}, and {C:attention}Code{} packs",
				},
			},
			v_entr_supersede = {
				name = "Supersede",
				text = {
					"{C:red}Twisted{} Booster Packs have a",
					"fixed {C:red}20%{} chance to replace",
					"any other Booster Pack in the shop"
				},
			},
		},
		RCode = {
			c_entr_memory_leak = {
				name = "(~)$ memoryleak",
				text = {
					"{C:red}int *m = new int{}",
				}
			},
			c_entr_root_kit = {
				name = "(~)$ rootkit",
				text = {
					"For the next defeated Blind,",
					"spare Hands give {C:red}$#1#{}",
				}
			},
			c_entr_break = {
				name = "(~)$ break;",
				text = {
					"Return to the {C:red}Blind selection{} screen",
					"The {C:red}current Blind{} is still upcoming",
				}
			},
			c_entr_interference = {
				name = "(~)$ interference",
				text = {
					"{C:red}Randomizes{} {C:attention}played hands{}, {C:attention}Blind size{}",
					"and {C:attention}payout{} for the remainder of",
					"the {C:red}current round{}"
				}
			},
			c_entr_fork = {
				name = "(~)$ fork",
				text = {
					"create a {C:red}Glitched{} copy of",
					"a selected {C:attention}playing card{} with",
					"a new {C:red}random Enhancement{}"
				}
			},
			c_entr_push = {
				name = "(~)$ push -f",
				text = {
					"{C:red}Destroy{} all held {C:attention}Jokers{}, {C:red}create{} a",
					"new {C:attention}Joker{} based on their {C:red}rarities{}",
					
				}
			},
			c_entr_increment = {
				name = "(~)$ increment",
				text = {
					"{C:red}+1{} {C:attention}shop slots{}",
					"for the remainder of {C:attention}this Ante{}",
				}
			},
			c_entr_decrement = {
				name = "(~)$ decrement",
				text = {
					"Transform {C:red}#1#{} selected {C:attention}Joker#2#{}",
					"to the {C:red}Joker{} that appears",
					"before #3# in the {C:red}Collection{}"
				}
			},
			c_entr_cookies = {
				name = "(~)$ cookies",
				text = {
					"Create a {C:dark_edition}Negative{} {C:red}Candy Joker{}",
				}
			},
			c_entr_overflow = {
				name = "(~)$ overflow",
				text = {
					"{C:red}Infinite{} {C:attention}card selection limit{}",
					"until the end of the {C:red}current Blind{}",
				}
			},
			c_entr_refactor = {
				name = "(~)$ refactor",
				text = {
					"Apply the {C:attention}Edition of a selected",
					"{C:red}Joker{} to a random {C:red}Joker{}",
				}
			},
			c_entr_ctrl_x = {
				name = "(~)$ ctrl+x",
				text = {
					"{C:red}#1#{} #2# {C:attention}card{},",
					"{C:attention}Booster{}, or {C:attention}Voucher{}",
					"{C:inactive}(Currently: #3#){}"
				}
			},
			c_entr_segfault = {
				name = "(~)$ segfault",
				text = {
					"Create a random {C:attention}playing card{}",
					"with a {C:red}random{} {C:attention}consumable{}, {C:attention}Joker{},",
					"{C:attention}Booster Pack{}, or {C:attention}Voucher{} applied",
					"as an {C:red}Enhancement{}",
					"then put it in the {C:attention}deck{}"
				}
			},
			c_entr_sudo = {
				name = "(~)$ sudo",
				text = {
					"{C:red}Permanently{} modify {C:attention}one{} selected",
					"{C:red}poker hand{} to always score as",
					"{C:attention}another{} {C:red}poker hand{}"
				}
			},
			c_entr_constant = {
				name = "(~)$ constant",
				text = {
					"Convert all {C:red}cards{} with the same",
					"rank as {C:attention}1{} selected card into",
					"the {C:red}selected card{}"
				}
			},
			c_entr_new = {
				name = "(~)$ new()",
				text = {
					"Adds an {C:attention}extra{} {C:red}Red Room{} Blind",
					"before the {C:attention}upcoming{} Blind", -- removed "next" because "next upcoming" is redundant
				}
			},
			c_entr_multithread = {
				name = "(~)$ multithread",
				text = {
					"Create temporary {C:dark_edition}Negative{} copies",
					"of all {C:red}selected{} cards in {C:red}hand{}",
				}
			},
			c_entr_invariant = {
				name = "(~)$ invariant",
				text = {
					"Apply an {C:red}Invariant{} sticker to",
					"1 selected card in the {C:red}shop{}",
				}
			},
			c_entr_inherit = {
				name = "(~)$ inherit",
				text = {
					"Convert {C:red}all{} cards with the same",
					"{C:red}Enhancement{} as 1 selected card",
					"into a {C:red}chosen Enhancement",
				}
			},
			c_entr_autostart = {
				name = "(~)$ autostart",
				text = {
					"Gain {C:red}#1#{} random skip Tags",
					"obtained {C:red}previously{} in the run",
				}
			},
			c_entr_quickload = {
				name = "(~)$ quickload",
				text = {
					"{C:red}Retrigger{} the payout screen",
					"with {C:red}no{} Blind money",
				}
			},
			c_entr_hotfix = {
				name = "(~)$ hotfix",
				text = {
					"Apply a {C:red}Hotfix{} sticker to",
					"1 selected card",
				}
			},
			c_entr_pseudorandom = {
				name = "(~)$ pseudorandom",
				text = {
					"Apply a {C:red}Pseudorandom{} sticker to",
					"{C:red}all{} cards on screen",
				}
			},
			c_entr_bootstrap = {
				name = "(~)$ bootstrap",
				text = {
					"The final {C:blue}Chips{} and {C:red}Mult{} of",
					"{C:red}this{} hand are applied to the",
					"base {C:blue}Chips{} and {C:red}Mult{} of the next hand"
				}
			}
		},
		RPlanet = {
			c_entr_pluto = {
				name = "Regulus",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_mercury = {
				name = "CZ Hydrae",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_venus = {
				name = "Vega",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_earth = {
				name = "Polaris",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_mars = {
				name = "Rho Cassiopeiae",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_jupiter = {
				name = "UU Pegasi",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_saturn = {
				name = "RS Persei",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_uranus = {
				name = "RT Ophiuchi",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_neptune = {
				name = "V349 Carinae",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_ceres = {
				name = "Procyon B",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_planet_x = {
				name = "Tauri",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_eris = {
				name = "Sirius B",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_universe = {
				name = Cryptid_config.family_mode and "Multiverse" or "The Multiverse In Its Fucking Entirety",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_marsmoons = {
				name = "Mizar & Alcor",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_void = {
				name = "Dark Matter",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_asteroidbelt = {
				name = "Dyson Swarm",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_planetlua = {
				name = "Star.lua",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"upgrade every",
					"{C:legendary,E:1}poker hand{}",
					"{C:gold}+#3#{} Ascension Power",
				}
			},
			c_entr_nstar = {
				name = "Strange Star",
				text = {
					"Upgrade a random",
					"{C:legendary,E:1}poker hand{}",
					"{C:attention}+#2#{} {C:gold}Ascension Power{} for each",
					"{C:attention}Strange Star{} used",
					"in this run",
					"{C:inactive}(Currently{C:attention} #1#{C:inactive}){}",
				}
			},
			c_entr_sunplanet = {
				name = "Nemesis",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){}",
					"Increase exponent of",
					"{C:attention}Ascended{} hands by {X:gold,C:white}+X#2#{}",
					"{C:inactive}(Currently {X:gold,C:white}X(#3#^#4#asc){C:inactive})",
				}
			},
			c_entr_Sydan = {
				name = "Paras",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"Level up",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"and {C:attention}#3#{}",
					"{C:gold}+#7#{} Ascension Power"
				},
			},
			c_entr_Timantti = {
				name = "Jatka",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"Level up",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"and {C:attention}#3#{}",
					"{C:gold}+#7#{} Ascension Power"
				},
			},
			c_entr_Klubi = {
				name = "Roua",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"Level up",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"and {C:attention}#3#{}",
					"{C:gold}+#7#{} Ascension Power"
				},
			},
			c_entr_Lapio = {
				name = "Assa",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"Level up",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"and {C:attention}#3#{}",
					"{C:gold}+#7#{} Ascension Power"
				},
			},
			c_entr_Kaikki = {
				name = "Kivi",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"Level up",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"and {C:attention}#3#{}",
					"{C:gold}+#7#{} Ascension Power"
				},
			},
		},
		RSpectral = {
			c_entr_define = {
				name = "#1#define",
				text = {
					"Replace all future instances of",
					"a {V:1}selected card{} with",
					"a card of {V:1}your choice{}",
					"{C:inactive}(Rare consumables and{}",
					"{C:inactive}>=Exotic jokers excluded){}"
				}
			},
			c_entr_beyond = {
				name = "Beyond",
				text = {
					"Create a random",
					"{V:1,E:1}Entropic {}Joker",
					"Banish all other held Jokers"
				}
			},
			c_entr_fervour={
                name="Fervour",
                text={
                    "Creates a",
                    "{V:1,E:1}Legendary? {}Joker",
                    "{C:inactive}(Must have room){}",
                },
            },
			c_entr_pulsar = {
				name = "Pulsar",
				text = {
					"Upgrade every",
					"{C:legendary,E:1}poker hand{}",
					"{C:gold}+#1#{} Ascension Power",
				}
			},
			c_entr_quasar = {
				name = "Quasar",
				text = {
					"Upgrade your most played",
					"{C:legendary,E:1}poker hand{} based",
					"on its current level",
					"{C:gold}+#1#{} Ascension Power",
				}
			},
		},
		Spectral = {
			c_entr_flipside = {
				name = "Flipside",
				text = {
					"Converts #1#{C:attention}#2#{}#3#",
					"Into an {C:red}Inverted{} variant",
				}
			},
		},
		Stake = {
			stake_entr_entropic = {
				name = "Entropic Stake",
				colour = "Ascendant",
				text = {
					"{C:red}Entropic{} joker blind scaling",
					"{C:red}always{} applies"
				},
			},
		},
		Tag= {
			tag_entr_dog = {
				name = "Dog Tag",
				text = { "Woof.", "{C:inactive}Level {C:dark_edition}#1#" },
			},
		},
		Other = {
			inversion_allowed = {
				name = "Flipside",
				text = {
					"Can be {C:red}Inverted{}"
				}
			},
			p_entr_twisted_pack_normal = { 
				name = "Twisted Pack",
				group_name = "Inverted Card",
				text={
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{V:1} Inverted{} cards to",
					"be used immediately or taken",
				}
			},
			p_entr_twisted_pack_jumbo = { 
				name = "Jumbo Twisted Pack",
				group_name = "Inverted Card",
				text={
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{V:1} Inverted{} cards to",
					"be used immediately or taken",
				},
			},
			p_entr_twisted_pack_mega = { 
				name = "Mega Twisted Pack",
				group_name = "Inverted Card",
				text={
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{V:1} Inverted{} cards to",
					"be used immediately or taken",
				},
			},
			entr_pinned = {
				name = "Invariant",
				text = {
					"{C:attention}Cannot{} be rerolled",
					"{C:attention}returns{} in the next",
					"round's shop"
				}
			},
			entr_hotfix = {
				name = "Hotfix",
				text = {
					"{C:attention}Cannot{} be debuffed",
				}
			},
			entr_pseudorandom = {
				name = "Pseudorandom",
				text = {
					"All {C:red}probabilities{} are",
					"{C:red}guaranteed{} until the",
					"next round"
				}
			},
			temporary = {
				name = "Temporary",
				text = {
					"{C:red}Destroyed{} at the end",
					"of the round"
				}
			},
			entr_entropic_sticker = {
                ['name'] = 'Entropic Sticker',
                ['text'] = {
                    [1] = 'Used this Joker',
                    [2] = 'to win on {C:attention}Entropic',
                    [3] = '{C:attention}Stake{} difficulty'
                }
            },
		}
	},
	misc = {
		achievement_names = {
			ach_entr_unstable_concoction = "Unstable Concoction"
		},
		achievement_descriptions = {
			ach_entr_unstable_concoction = "Use define to turn Obelisk into Sob"
		},
		dictionary = {
			k_entr_hyper_exotic = "Entropic",
			k_entr_reverse_legendary = "Legendary?",
			k_entr_zenith = "Zenith",
			k_rtarot = "Tarot?",
			k_rtarot_pack = "Tarot Pack?",
			b_rtarot_cards = "Tarot Cards?",

			k_rcode = "Code?",
			k_rcode_pack = "Code Pack?",
			b_rcode_cards = "Code Cards?",

			k_rspectral = "Spectral?",
			k_rspectral_pack = "Spectral Pack?",
			b_rspectral_cards = "Spectral Cards?",

			a_eqmult = { "Mult = #1#" },

			b_select_custom = "Take",

			k_inverted = "Inverted",
			k_inverted_pack = "Twisted Pack",
			b_inverted_cards = "Twisted Cards",

			entr_code_sudo = "OVERRIDE",
			entr_code_sudo_previous = "OVERRIDE AS PREVIOUS",
			k_saved_ruby_1 = "The power of friendship saves you",
			k_saved_ruby_2 = "You believe in yourself",
			k_saved_ruby_3 = "All deaths retconned",
			k_saved_ruby_4 = "Dont eat that apple",
			k_saved_ruby_5 = "Is there poker in eden?",
			k_saved_ruby_6 = "Deny your fate",
			k_saved_ruby_7 = "Thanks for playing!",
			k_saved_ruby_8 = "",

			k_entr_faster_ante_scaling = "Scale Blind scores quicker if you have an Entropic Joker",
			k_entr_entropic_music = "Entropic Jokers (Joker in Greek by gemstonez)",

			k_rplanet = "Star",
			b_rplanet_cards = "Star Cards?",	
			k_planet_multiverse = Cryptid_config.family_mode and "Multiverse" or "The Actual Fucking Multiverse",
			k_planet_binary_star = "Binary Star System",
			k_planet_dyson_swarm = "Stellar Megastructure",

			k_entropy = "Entropy",
		},
		v_dictionary = {
			card_art = "Card Art: #1#"
		},
		labels = {
			entr_pinned = "Invariant",
			entr_hotfix = "Hotfixed",
			temporary = "Temporary",
			entr_pseudorandom = "Pseudorandom"
		}
	},
}
