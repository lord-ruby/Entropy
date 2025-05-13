local decs = {
	descriptions = {
		Enhanced = {
			m_entr_flesh = {
				name = "Flesh Card",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"destroy this card",
					"when {C:attention}discarded{}"
				}
			},
			m_entr_disavowed = {
				name = "Disavowed",
				text = {
					"Cannot change Enhancements"
				}
			},
			m_entr_prismatic = {
				name = "Prismatic Card",
				text = {
					"{X:dark_edition,C:white}^^#1#{} Mult",
					"increase by {X:dark_edition,C:white}+^^#2#{}",
					"when card is scored."
				}
			}
		},
		["Content Set"] = {
			set_entr_inversions = {
				name = "Inversions",
				text = {
					"{C:attention}Consumable{} inversions",
					"added by Entropy"
				}
			},
			set_entr_tags = {
				name = "Tags",
				text = {
					"{C:attention}Tags{} added",
					"by Entropy"
				}
			},
			set_entr_blinds = {
				name = "Blinds",
				text = {
					"{C:attention}Boss Blinds{} added",
					"by Entropy"
				}
			},
			set_entr_decks = {
				name = "Decks",
				text = {
					"{C:attention}Decks{} added",
					"by Entropy"
				}
			},
			set_entr_misc = {
				name = "Misc",
				text = {
					"Things that don't",
					"fit in any other",
					"{C:cry_ascendant}Thematic Set",
				},
			},
			set_entr_entropics = {
				name = "Entropic Jokers",
				text = {
					"Powerful Jokers with",
					"{C:entr_entropic}Entropic{} rarity",
				},
			},
			set_entr_vouchers = {
				name = "Vouchers",
				text = {
					"{C:attention}Vouchers{} added",
					"by Entropy"
				}
			},
			set_entr_spectrals = {
				name = "Spectral Cards",
				text = {
					"{C:attention}Spectral{} cards",
					"added by Entropy"
				}
			},
			set_entr_misc_jokers = {
				name = "Misc. Jokers",
				text = {
					"{C:attention}Jokers{} that don't",
					"fit in any other",
					"{C:cry_ascendant}Thematic Set",
				},
			},
		},
		Joker = {
			j_cry_redeo = {
				name = "Redeo",
				text = {
					"{C:attention}#1#{} Ante when",
					"{C:money}$#2#{} {C:inactive}($#3#){} spent",
					"{s:0.8}Requirements increase",
					"{C:attention,s:0.8}exponentially{s:0.8} per use",
					"{C:money,s:0.8}Next increase: {s:1,c:money}$#4#",
				},
			},
			j_cry_circus = {
				name = "Circus",
				text = {
					"{C:red}Rare{} Jokers each give {X:mult,C:white} X#1# {} Mult",
					"{C:cry_epic}Epic{} Jokers each give {X:mult,C:white} X#2# {} Mult",
					"{C:legendary}Legendary{} Jokers each give {X:mult,C:white} X#3# {} Mult",
					"{C:cry_exotic}Exotic{} Jokers each give {X:mult,C:white} X#4# {} Mult",
					"{C:entr_entropic}Entropic{} jokers each give {X:mult,C:white} X#5# {} Mult"
				},
				unlock = {
					"Obtain a {C:red}Rare{},",
					"{C:cry_epic}Epic{} and {C:legendary}Legendary{}",
					"Joker before {C:attention}Ante 9",
				},
			},
			j_entr_stillicidium = {
				name = "Stillicidium",
				text = {
					"Transform {C:attention}Jokers{} to the right",
					"and all {C:attention}consumables{} into the",
					"card that precedes them in the",
					"Collection at the end of the shop",
					"Reduce the rank of {C:attention}scored cards{} by 1",
					"Reduce Blind sizes by {C:attention}30%{}"
				}
			},
			j_entr_surreal_joker = {
				name = "Surreal Joker",
				text = {
 					"Mult {X:entr_eqmult,C:white} = #1#{}"
				}
			},
			j_entr_tesseract = {
				name = "Tesseract",
				text = {
 					"Rotates Mult by {X:dark_edition,C:white}#1#{}",
					"degrees counterclockwise",
					"and Chips by {X:dark_edition,C:white}#1#{}",
					"degrees clockwise"
				}
			},
			j_entr_epitachyno = {
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
			j_entr_dekatria = {
				name = "Dekatria",
				text = {
 					"{X:dark_edition,C:white}#1#{} Mult",
					"All cards are {C:dark_edition}Jolly{}",
					"Increase operator once for every",
					"{C:attention}#2#{} Pairs in played hand",
					"{C:inactive}(Currently: #3#){}"
				}
			},
			j_entr_oekrep = {
				name = "Oekrep",
				text = {
					"Destroy a {C:attention}random{} consumable and",
					"create a corresponding {C:dark_edition}Negative{}",
					"Mega Booster Pack at the end of the {C:attention}shop{}"
				}
			},
			j_entr_kciroy = {
				name = "Kciroy",
				text = {
					"{C:dark_edition}X#1#{} Hand size, {C:dark_edition}+#2#{} card selection limit",
					"This joker gains {X:dark_edition,C:white}^#3#{} Chips every",
					"{C:attention}#4#{} {C:inactive}[#5#]{} cards discarded",
					"{C:inactive}(Currently{} {X:dark_edition,C:white}^#6#{} {C:inactive}Chips){}"
				}
			},
			j_entr_tocihc = {
				name = "Tocihc",
				text = {
					"Create the {C:attention}current{} Blind's skip",
					"Tag when Blind is selected",
					"Reduce non-Boss Blind sizes by {C:attention}80%{}",
					"{C:inactive}(Currently: #1#){}"
				}
			},
			j_entr_teluobirt = {
				name = "Teluobirt",
				text = {
					"Scored {C:attention}Jacks{} give {X:chips,C:white}XChips{}",
					"equal to the {C:attention}number{} of played Jacks in the hand",
					"Retrigger {C:attention}scored{} Jacks based on their",
					"order in the played hand"
				}
			},
			j_entr_oinac = {
				name = "Oinac",
				text = {
					"This Joker gains {X:dark_edition,C:white}^#1#{} Chips",
					"when a {C:attention}face{} card is destroyed by this Joker",
					"{C:attention}Played{} playing cards are destroyed",
					"and a card with +1 rank is drawn to the {C:attention}hand{}",
					"{C:inactive}(Currently: {}{X:dark_edition,C:white}^#2#{} {C:inactive}Chips){}"
				}
			},
			j_entr_entropy_card = {
				name = "Drac Pihsrebmem",
				text = {
					"{X:gold,C:white}X#1#{} Ascension Power for",
					"each {C:attention}sun_with_face{} emoji in",
					"Entropy's ascended hands channel",
					"{C:inactive}(Currently:{} {X:gold,C:white}X#2#{}{C:inactive}){}",
					"{C:blue,s:0.7}https://discord.gg/beqqy4Bb7m{}",
				}
			},
			j_entr_solarflare = {
				name = "Solar Flare",
				text = {
					"Other {C:dark_edition}Solar{} cards",
					"each give {X:gold,C:white}X#1#{} Ascension Power",
				},
			},
			j_entr_burnt_m= {
				name = "Burnt M",
				text = {
					"If played hand {C:attention}contains{} a Pair",
					"apply {C:dark_edition}Solar{} to the first card",
					"Apply {C:dark_edition}Solar{} to 1 more card for",
					"each {C:dark_edition}Jolly{} Joker"
				},
			},
			j_entr_anaptyxi= {
				name = "Anaptyxi",
				text = {
					"Scaling Jokers scale as a quadratic",
					"Scaling Jokers scale all other Jokers by",
					"{X:dark_edition,C:white}X#1#{} the same amount, then increase",
					"this by {X:dark_edition,C:white}X#2#{} at the end of round",
					"{C:inactive}(Anaptyxi exlcuded){}",
				},
			},
			j_entr_chaos= {
				name = "Chaos",
				text = {
					"When a card is {C:attention}created{}",
					"instead create a card of",
					"a {C:attention}random type{}"
				},
			},
			j_entr_parakmi = {
				name = "Parakmi",
				text = {
					"{C:attention}Anything{} can appear",
					"in the place of any card"
				}
			},
			j_entr_exousia = {
				name = "Exousia",
				text = {
					"{C:attention}Ascends{} all Tags",
					"Gain {C:attention}#1#{} skip Tags when",
					"any Blind is selected"
				}
			},
			j_entr_akyros = {
				name = "Akyros",
				text = {
					"Joker slots can be {C:attention}bought{}",
					"for {C:gold}$#1#{} and {C:attention}sold{} for {C:gold}$#2#{}",
					"Gain money based on how many",
					"empty Joker slots you have",
					"{C:inactive}(Currently{} {X:gold,C:white}#3#{}{C:inactive}){}"
				}
			},
			j_entr_dni = {
				name = "DNI",
				text = {
					"Chooses one suit per hand",
					"Destroy all {C:attention}scored{} cards with that suit",
					"{C:inactive}(Currently:{} {V:1}#1#{}{C:inactive}){}"
				}
			},
			j_entr_strawberry_pie = {
				name = "Strawberry Pie",
				text = {
					"Other hand level-ups are",
					"redirected to {C:attention}High Card{}",
				}
			},
			j_entr_recursive_joker = {
				name = "Recursive Joker",
				text = {
					"When this Joker is {C:attention}sold{},",
					"create a copy of this Joker",
					"{C:red}Works once per round{}",
					"{C:inactive}(Currently: #1#){}"
				}
			},
			j_entr_trapezium_cluster = {
				name = "Trapezium Cluster",
				text = {
					"Other {C:dark_edition}Fractured{} cards",
					"each force-trigger {C:dark_edition}#1#{}",
					"random cards"
				},
			},
			j_entr_katarraktis = {
				name = "Katarraktis",
				text = {
					"Retrigger the {C:attention}Joker{} to",
					"the right {C:attention}#1#{} time#<s>1# then",
					"retrigger each subsequent",
					"{C:attention}Joker{} {X:dark_edition,C:white}Twice{} as",
					"many times as the previous"
				}
			},
			j_entr_dr_sunshine = {
				name = "Dr. Sunshine",
				text = {
					"This {C:attention}Joker{} gains",
					"{C:gold}+#1#{} Ascension Power",
					"when a playing card is {C:attention}destroyed{}",
					"{C:inactive}(Currently: {}{C:gold}+#2#{}{C:inactive}){}"
				}
			},
			j_entr_sunny_joker = {
				name = "Sunny Joker",
				text = {
					"{C:gold}+#1#{} Ascension Power"
				}
			},
			j_entr_metanoia = {
				name = "Metanoia",
				text = {
					"Discarded cards become",
					"{C:attention}flesh{} cards"
				}
			},
			j_entr_antidagger = {
				name = "Anti-Dagger",
				text = {
					"Unbanish a random banished Joker",
					"when a {C:attention}blind{} is selected",
					"{C:green}#1# in #2#{} chance to {C:attention}banish{}",
					"this Joker and {C:attention}another{} Joker"
				}
			},
			j_entr_solar_dagger = {
				name = "Solar Dagger",
				text = {
					"When {C:attention}Blind{} is selected",
					"destroy Joker to the right",
					"and permanently add {C:attention}one tenth{}",
					"its sell value to this Jokers {C:gold}Ascension Power{}",
					"{C:inactive}(Currently: {X:gold,C:white}X#1#{} {C:inactive}Ascension Power){}"
				}
			},
			j_entr_insatiable_dagger = {
				name = "Insatiable Dagger",
				text = {
					"When {C:attention}Blind{} is selected",
					"banish rightmost Joker",
					"Joker to the left gains {C:attention}5%{}",
					"of its sell value as {C:purple}xValues{}"
				}
			},
			j_entr_rusty_shredder = {
				name = "Rusty Shredder",
				text = {
					"{C:green}#1# in #2#{} chance to create",
					"a {C:attention}temporary{} {C:dark_edition}Negative{}",
					"copy of discarded cards"
				}
			},
			j_entr_chocolate_egg = {
				name = "Chocolate Egg",
				text = {
					"Create a random {C:dark_edition}Sunny{} {C:red}Rare{} Joker",
					"when this joker is destroyed",
					"create a random {C:dark_edition}Sunny{} {C:cry_epic}Epic{} Joker instead",
					"when this Joker is {C:red}banished{}"
				}
			},
			j_entr_antireal = {
				name = "Antireal Joker",
				text = {
					"{X:gold,C:white}+^#1#{} Ascension Power per",
					"empty Joker slot",
					"{s:0.8}Antireal Joker included{}",
					"{C:inactive}(Currently{} {X:gold,C:white}^#2#{}{C:inactive}){}"
				}
			},
			j_entr_jokerinyellow = {
				name = "The Joker in Yellow",
				text = {
					"{C:green}#1# in #2#{} chance for drawn cards",
					"to be given a {C:diamonds}Yellow Sign{} sticker",
					"Played {C:diamonds}Diamonds{} {C:red}Banish{} a random Joker",
					"Selected {C:diamonds}Diamonds{} give {C:dark_edition}Temporary{}",
					"to a random card of any type.",
					"Self destructs if {C:attention}7 Diamonds{} are held when hand played"
				}
			},
			j_entr_apeirostemma = {
				name = "Apeirostemma",
				text = {
					"Cards in the {C:attention}shop{}",
					"now cycle between 5 random cards",
					"of the same type",
					"changing every {C:attention}2{} seconds"
				}
			},
			j_entr_lotteryticket = {
				name = "Lottery Ticket",
				text = {
					"Lose {C:gold}$#4#{} at the end of round",
					"{C:green}#1# in #2#{} Chance to earn {C:gold}$#5#{}",
					"{C:green}#1# in #3#{} Chance to earn {C:gold}$#6#{} instead"
				}
			},
			j_entr_ruby = {
				name = "Ruby, Lord of Hope",
				text = {
					"{C:green}Fixed 50%{} chance to be revived",
					"any time you would lose",
					"{C:entr_zenith}+666{} Mult then,",
					"{X:entr_zenith,C:white}#1#25000#2#666{} Mult",
					"{s:0.8,C:entr_zenith}Dont you know, hope is the strongest aspect{}"
				}
			},
			j_entr_devilled_suns = {
				name = "Devilled Suns",
				text = {
					"{C:gold}+#1#{} Ascension Power",
					"{C:gold}+#2#{} more for every",
					"{C:dark_edition}Sunny{} Joker owned"
				}
			},
			j_entr_eden = {
				name = "The Garden of Eden",
				text = {
					"Other {C:dark_edition}Sunny{} cards",
					"each give {C:gold}+#1#{} Ascension Power",
				},
			},
			j_entr_exelixi = {
				name = "Exelixi",
				text = {
					"upgrade the {C:attention}enhancement{}",
					"of playing cards when scored",
					"{C:attention}enhancements{} are given to adjacent cards",
					"when {C:attention}discarding{} cards"
				}
			},
			j_entr_seventyseven = {
				name = "77+33",
				text = {
					"{X:entr_eqchips,C:white}=#1#{} Chips"
				}
			},
			j_entr_jokezmann_brain = {
				name = "Jokezmann Brain",
				text = {
					"When exiting the shop there is a",
					"{C:green}#1# in #2#{} chance for each",
					"empty joker slot to be filled with",
					"a random {C:dark_edition}Perishable, Oversaturated{} Joker"
				}
			}
		},
		Blind = {
			bl_entr_red = {
				name = "Red Room",
				text = {
					"???"
				}
			},
			bl_entr_scarlet_sun = {
				name = "Scarlet Sun",
				text = {
					"All cards add Ascension Power",
					"-1X Ascension Power"
				}
			},
			bl_entr_burgundy_baracuda = {
				name = "Burgundy Baracuda",
				text = {
					"1 in 2 played cards are destroyed",
				}
			},
			bl_entr_diamond_dawn = {
				name = "Diamond Dawn",
				text = {
					"Remove the rank and suit",
					"of all discarded cards"
				}
			},
			bl_entr_olive_orchard = {
				name = "Olive Orchard",
				text = {
					"Cards in hand become disavowed",
					"when playing or discarding"
				}
			},
			bl_entr_citrine_comet = {
				name = "Citrine Comet",
				text = {
					"Selected cards destroy adjacent cards",
					"with a 1 in 2 chance"
				}
			},
			bl_entr_endless_entropy_phase_one = {
				name = "Burning Brimstone",
				text = {
					"???",
				}
			},
			bl_entr_endless_entropy_phase_two = {
				name = "Deceitful Decay",
				text = {
					"All you know shall crumble,",
					"Dust to dust.",
					"(Joker values decay over time)"
				}
			},
			bl_entr_endless_entropy_phase_three = {
				name = "Nameless Nadir",
				text = {
					"Void subsumes you,",
					"(Debuff leftmost Joker slot(s),",
					"Must not score more than #1#)"
				}
			},
			bl_entr_endless_entropy_phase_four = {
				name = "Endless Entropy",
				text = {
					"You are but a speck of dust",
					"in the face of the universe.",
					"(Applies all showdown effects)"
				}
			},
		},
		Edition = {
			e_entr_solar = {
				name = "Solar",
				text = {
					"{X:gold,C:white}X#1#{} Ascension Power",
				},
			},
			e_entr_fractured = {
				name = "Fractured",
				text = {
					"{C:dark_edition}Force-trigger{} #1# random cards",
					"when scored"
				},
			},
			e_entr_sunny = {
				name = "Sunny",
				text = {
					"{C:gold}+#1#{} Ascension Power",
					"Ever heard of {X:gold,C:white}ascendant{}",
					"humor buddy?"
				}
			},
			e_entr_freaky = {
				name = "Freaky",
				text = {
					"Chips {X:entr_freaky,C:white}Xlog_#1#(Chips){}"
				},
			},
		},
		Back = {
			b_entr_twisted = {
				name = "Twisted Deck",
				text =  {
								"All {C:red}Invertable{} consumables",
								"are automatically {C:red}Inverted{}",
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
								"{C:entr_entropic}Beyond{} has higher chances of showing",
								"up and {X:blue,C:white}Chips{} are lowered",
								"based on how high your {X:dark_edition,C:white}Entropy{} is",
								"Gain {X:dark_edition,C:white}Entropy{} when playing",
								"Editioned/Enhanced cards, secret hands",
								"or using consumables"
							}
			},
			b_entr_crafting = {
				name = "Deck of Destiny",
				text =  {
					"Jokers may no longer appear naturally",
					"Start with an {C:dark_edition}Absolute, Negative{} Destiny",
					"Cards have a higher chance to be Enhanced"
				}
			},
			b_entr_butterfly = {
				name = "Butterfly Deck",
				text =  {
					"All {c:attention}Random{} outcomes",
					"can affect eachother",
					"Gain a {C:dark_edition}Negative{} {C:attention}Revert{}",
					"when a Boss-Blind is selected"
				}
			},
			b_entr_ambisinister = {
				name = "Ambisinister Deck",
				text =  {
					"{C:attention}Joker Slots{} and",
					"{C:dark_edition}Card Selection Limit{}",
					"are now a shared resource",
					"{C:attention}+3{} Joker Slots"
				}
			}
		},
		Sleeve = {
			sleeve_entr_twisted = {
				name = "Twisted Sleeve",
				text = {
					"All {C:red}Invertable{} consumables",
					"are automatically {C:red}Inverted{}",
				},
			},
			sleeve_entr_ccd2 = {
				name = "Redefined Sleeve",
				text = {
					"Every card is also a random",
					"{C:attention}Joker{}, {C:attention}Booster Pack{},",
					"{C:attention}Voucher{}, or {C:attention}consumable{}"
				},
			},
			sleeve_entr_doc = {
				name = "Anomalous Sleeve",
				text = {
					"{C:entr_entropic}Beyond{} has higher chances of showing up and",
					"{X:blue,C:white}Chips{} are lowered based on how high",
					"your {X:dark_edition,C:white}Entropy{} is, Gain {X:dark_edition,C:white}Entropy{}",
					"when playing Editioned/Enhanced cards, secret hands",
					"or using consumables"
				},
			},
			sleeve_entr_butterfly = {
				name = "Butterfly Sleeve",
				text = {
					"All {c:attention}Random{} outcomes",
					"can affect eachother",
					"Gain a {C:dark_edition}Negative{} {C:attention}Revert{}",
					"when a Boss-Blind is selected"
				},
			},
			sleeve_entr_ambisinister = {
				name = "Ambisinister Sleeve",
				text = {
					"{C:attention}Joker Slots{} and",
					"{C:dark_edition}Card Selection Limit{}",
					"are now a shared resource",
					"{C:attention}+3{} Joker Slots"
				},
			},
		},
		RTarot = {
			c_entr_master = {
				name = "The Master",
				text = {
					"Creates the last",
					"{C:red}Inverted{} card",
					"used during this run",
					"{s:0.8,C:red}The Master{} {s:0.8}excluded{}"
				}
			},
			c_entr_statue = {
				name = "The Statue",
				text = {
					"Convert {C:attention}#1#{} random card#<s>1#",
					"in the whole deck to {C:attention}#2#{}",
					"selected card#<s>2# then transform the",
					"selected card#<s>2# into a blank {C:attention}Stone Card{}"
				}
			},
			c_entr_whetstone = {
				name = "Whetstone",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"randomly {C:attention}upgrade{} the enhancement",
					"of up to #3# selected card#<s>1#"
				}
			},
			c_entr_feast = {
				name = "The Feast",
				text = {
					"{C:attention}Sell{} and {C:attention}Destroy{}",
					"#<up to >1##1# selected card#<s>1#",
					"from the {C:attention}shop{}"
				}
			},
			c_entr_servant = {
				name = "The Servant",
				text = {
					"Create {C:attention}#1#{} random consumable#<s>1# of an",
					"{C:red}Inversed{} type of #<up to >2#{C:attention}#2#{} selected card#<s>2#",
					"{C:inactive}(Must have room){}"
				}
			},
			c_entr_endurance = {
				name = "Endurance",
				text = {
					"Multiply #1# selected card#<s>1#",
					"values by {C:attention}#2#{} then",
					"apply perishable"
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
					"{C:attention}Celestial{}, {C:attention}Arcana{}, and {C:attention}Program{} Packs",
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
					"For the next defeated Blind",
					"spare hands give {C:red}$#1#{}",
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
					"Transform {C:red}#1#{} selected {C:attention}Joker#<s>1#{}",
					"to the {C:red}Joker{} that appears",
					"previously in the {C:red}collection{}"
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
					"before the next {C:attention}upcoming{} Blind",
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
			},
			c_entr_local = {
				name = "(~)$ local",
				text = {
					"Apply {C:red}Temporary{} to",
					"#1# selected playing cards"
				}
			},
			c_entr_transpile = {
				name = "(~)$ transpile",
				text = {
					"{C:dark_edition}#1#{} Joker Slots",
					"{C:dark_edition}+#2#{} Consumable Slots",
					"{C:dark_edition}+#3#{} Hand Size"
				}
			}
		},
		RPlanet = {
			c_entr_regulus = {
				name = "Regulus",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_hydrae = {
				name = "CZ Hydrae",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_vega = {
				name = "Vega",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_polaris = {
				name = "Polaris",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_cassiopeiae = {
				name = "Rho Cassiopeiae",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_pegasi = {
				name = "UU Pegasi",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_persei = {
				name = "RS Persei",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_ophiuchi = {
				name = "RT Ophiuchi",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_carinae = {
				name = "V349 Carinae",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_procyon = {
				name = "Procyon B",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_tauri = {
				name = "Tauri",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_sirius = {
				name = "Sirius B",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_multiverse = {
				name = Cryptid_config.family_mode and "Multiverse" or "The Multiverse In Its Fucking Entirety",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_binarystars = {
				name = "Mizar & Alcor",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_dark_matter = {
				name = "Dark Matter",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_dyson_swarm = {
				name = "Dyson Swarm",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_starlua = {
				name = "Star.lua",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"upgrade every",
					"{C:legendary,E:1}poker hand{}",
					"{C:gold}+#3#{} Ascension Power",
				}
			},
			c_entr_strange_star = {
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
			c_entr_nemesis = {
				name = "Nemesis",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){}",
					"Increase exponent of",
					"{C:attention}Ascended{} hands by {X:gold,C:white}+X#2#{}",
					"{C:inactive}(Currently {X:gold,C:white}X(#3#^#4#asc){C:inactive})",
				}
			},
			c_entr_paras = {
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
			c_entr_jatka = {
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
			c_entr_rouva = {
				name = "Rouva",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"Level up",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"and {C:attention}#3#{}",
					"{C:gold}+#7#{} Ascension Power"
				},
			},
			c_entr_assa = {
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
			c_entr_kivi = {
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
					"a {C:entr_rspectral}selected card{} with",
					"a card of {C:entr_rspectral}your choice{}",
					"then {C:attention}destroy{} the selected card",
					"{C:inactive}(Rare consumables and{}",
					"{C:inactive}>=Exotic Jokers excluded){}"
				}
			},
			c_entr_beyond = {
				name = "Beyond",
				text = {
					"Create a random",
					"{C:entr_entropic,E:1}Entropic{} Joker",
					"Banish all other held Jokers"
				}
			},
			c_entr_fervour={
                name="Fervour",
                text={
                    "Creates a",
                    "{C:entr_reverse_legendary,E:1}Legendary? {}Joker",
                    "{C:inactive}(Must have room)",
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

			c_entr_weld = {
				name = "Weld",
				text = {
					"Apply {C:legendary,E:1}Absolute{}",
					"to {C:attention}#1#{} selected Joker",
					"{C:red}#2#{} discard"
				}
			},
			c_entr_cleanse = {
				name = "Cleanse",
				text = {
					"{C:attention}Strip{} the suit and rank",
					"from {C:attention}all{} cards in hand",
					"{C:gold}$#1#{} for each Chip taken"
				}
			},

			c_entr_insignia = {
				name = "Insignia",
				text = {
					"Adds a {V:1}Silver Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_rendezvous = {
				name = "Rendezvous",
				text = {
					"Adds a {V:1}Crimson Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_eclipse = {
				name = "Veil",
				text = {
					"Adds a {V:1}Sapphire Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_calamity = {
				name = "Calamity",
				text = {
					"Adds a {V:1}Pink Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_downpour = {
				name = "Downpour",
				text = {
					"Adds a {V:1}Cerulean Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_script = {
				name = "Script",
				text = {
					"Adds a {V:1}Verdant Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_inscribe = {
				name = "Inscribe",
				text = {
					"Multiply the {C:attention}base{} Chips",
					"of number cards in hand by {X:chips,C:white}X#1#{}",
					"then {C:attention}debuff{} all number cards",
					"in hand"
				}
			},
			c_entr_siphon = {
				name = "Siphon",
				text = {
					"Destroy 1 selected {C:attention}Editioned{}",
					"Joker then apply the {C:attention}previous{} Edition",
					"to all cards in hand",
					"{C:inactive}(Currently: #1#){}"
				}
			},
			c_entr_changeling = {
				name = "Changeling",
				text = {
					"Convert {C:attention}#1#{} cards in hand",
					"to {C:attention}random{} Editioned face cards",
				}
			},
			c_entr_ward = {
				name = "Ward",
				text = {
					"Destroy {C:attention}all{} Jokers then",
					"Give {X:gold,C:white}X#1#{} their buy",
					"value in dollars"
				}
			},
			c_entr_ichor = {
				name = "Ichor",
				text = {
					"Banish a {C:attention}random{} held",
					"{C:dark_edition}Negative{} Joker",
					"{C:dark_edition}+#1#{} Joker slots"
				}
			},
			c_entr_pact = {
				name = "Pact",
				text = {
					"{C:attention}Link{} up to {C:attention}#1#{}",
					"cards together, all modifications",
					"affect all of the linked cards"
				}
			},
			c_entr_rend = {
				name = "Rend",
				text = {
					"Convert up to {C:attention}#1#{}",
					"selected cards to",
					"{C:attention}Flesh{} cards"
				}
			},
			c_entr_rejuvenate = {
				name = "Rejuvenate",
				text = {
					"Add a random {C:attention}Seal{},",
					"{C:attention}Enhancement{}, and {C:attention}Edition{}",
					"to 1 selected card, then",
					"convert {C:attention}#1#{} other cards",
					"into this card, {C:gold}#2#{}",
				}
			},
			c_entr_crypt = {
				name = "Crypt",
				text = {
					"Select {C:attention}#1#{} Jokers",
					"convert the {C:attention}left{} Joker",
					"into the {C:attention}right{} Joker",
					"then {C:attention}strip{} its edition",
				}
			},
			c_entr_charm = {
				name = "Charm",
				text = {
					"Apply {C:attention}Astral{} and",
					"{C:attention}Eternal{} to a selected",
					"Joker then {C:attention}Banish{}",
					"a random other Joker",
				}
			},
			c_entr_entropy = {
				name = "Entropy",
				text = {
					"Completely {C:attention}randomize{}",
					"up to #1# selected cards",
				}
			},
			c_entr_fusion = {
				name = "Fusion",
				text = {
					"{C:attention}#1#{} random cards in hand",
					"become random cards of 1",
					"selected cards type"
				}
			},
			c_entr_substitute = {
				name = "Substitute",
				text = {
					"{C:attention}Unredeem{} a random Voucher",
					"and all lower tiers, then redeem the next",
					"tier of Voucher"
				}
			},
			c_entr_evocation = {
				name = "Evocation",
				text = {
					"{C:attention}Upgrade{} #1# selected Jokers",
					"rarity then destroy all other Jokers",
					"{C:blue}#2#{} hands"
				}
			},
			c_entr_mimic = {
				name = "Mimic",
				text = {
					"Create a {C:attention}Banana Perishable{} copy",
					"of #1# selected cards",
				}
			},
			c_entr_superego = {
				name = "Project",
				text = {
					"Apply a {C:attention}Projected{}",
					"sticker to 1 selected Joker, then",
					"debuff it"
				}
			},
			c_entr_engulf = {
				name = "Engulf",
				text = {
					"Apply {C:dark_edition}Solar{} effect",
					"to {C:attention}1{} selected card",
					"in hand"
				}
			},
			c_entr_offering = {
				name = "Offering",
				text = {
					"All Jokers become {C:attention}Rental{}",
					"{X:gold,C:white}X#1#{} shop costs",
				}
			},
			c_entr_entomb = {
				name = "Entomb",
				text = {
					"Create a {C:attention}Mega Booster Pack{}",
					"corresponding to the type of #1# selected",
					"consumable"
				}
			},
			c_entr_conduct = {
				name = "Conduct",
				text = {
					"Apply the {C:attention}previous{} Edition",
					"to adjacent cards of 1 selected card",
					"or consumable",
					"{C:inactive}(Currently: #1#){}"
				}
			},
			c_entr_disavow = {
				name = "Disavow",
				text = {
					"Boost cards held in {C:attention}hand{} based",
					"on their Enhancement, then strip their",
					"Enhancement {C:attention}permanently{}",
				}
			},
			c_entr_regenerate = {
				name = "Regenerate",
				text = {
					"Completely reset up to",
					"{C:attention}#1#{} selected cards",
					"or Jokers",
					"{C:inactive}(Doesn't remove absolute){}"
				}
			},
		},
		Spectral = {
			c_entr_flipside = {
				name = "Flipside",
				text = {
					"Converts {C:attention}#1#{} selected consumable#<s>1#",
					"Into an {C:red}Inverted{} variant",
				}
			},
			c_entr_destiny = {
				name = "Destiny",
				text = {
					"Sacrifice 5 playing cards to craft",
					"one Joker based on their Enhancements",
					"{C:inactive}(Currently: #1#){}"
				}
			},
			c_entr_shatter = {
				name = "Shatter",
				text = {
					"Apply {C:dark_edition}Fractured{} to",
					"{C:attention}#1#{} selected cards in hand",
				}
			},
		},
		Stake = {
			stake_entr_entropic = {
				name = "Entropic Stake",
				colour = "Ascendant",
				text = {
					"{C:entr_entropic}Entropic{} Joker blind scaling",
					"{C:red}always{} applies"
				},
			},
			stake_entr_zenith = {
				name = "Zenith Stake",
				colour = "Ascendant",
				text = {
					"{E:1,C:entr_zenith}All Blinds are Endless Entropy{}",
				},
			},
		},
		Tag= {
			tag_entr_dog = {
				name = "Dog Tag",
				text = { "Woof.", "{C:inactive}Level {C:dark_edition}#1#" },
			},
			tag_entr_sunny = {
				name = "Sunny Tag",
				text = { 
					"Next base Edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Sunny{}"	
				},
			},
			tag_entr_solar = {
				name = "Solar Tag",
				text = { 
					"Next base Edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Solar{}"	
				},
			},
			tag_entr_fractured = {
				name = "Fractured Tag",
				text = { 
					"Next base Edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Fractured{}"	
				},
			},
			tag_entr_freaky = {
				name = "Freaky Tag",
				text = { 
					"Next base Edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Freaky{}"	
				},
			},
			tag_entr_ascendant_rare = {
				name = "{C:gold}Rare Tag{}",
				text = { "Shop has a free", "{C:rare}Rare Joker{}" },
			},
			tag_entr_ascendant_epic = {
				name = "{C:gold}Epic Tag{}",
				text = { "Shop has a free", "{C:cry_epic}Epic Joker{}" },
			},
			tag_entr_ascendant_legendary = {
				name = "{C:gold}Legendary Tag{}",
				text = { "Shop has a free", "{C:legendary}Legendary Joker{}" },
			},
			tag_entr_ascendant_exotic = {
				name = "{C:gold}Exotic Tag{}",
				text = { "Shop has a free", "{C:cry_exotic}Exotic Joker{}" },
			},
			tag_entr_ascendant_entropic = {
				name = "{C:gold}Entropic Tag{}",
				text = { "Shop has a free", "{C:entr_entropic}Entropic Joker{}" },
			},
			tag_entr_ascendant_copying = {
				name = "{C:gold}Duplicate Tag{}",
				text = { "Gives {C:attention}#1#{} copies of the", "next selected Tag", "{C:inactive}(Copying tags excluded){}" },
			},
			tag_entr_ascendant_voucher = {
				name = "{C:gold}Golden Voucher Tag{}",
				text = { "Adds one Tier {C:attention}3{} Voucher", "to the next shop" },
			},
			tag_entr_ascendant_better_voucher = {
				name = "{C:gold}Pristine Voucher Tag{}",
				text = { "Adds 2 Tier {C:attention}3{} Vouchers", "to the next shop" },
			},
			tag_entr_ascendant_saint = {
				name = "{C:gold}Saint Tag{}",
				text = { "Shop has a free", "{C:attention}Editioned Candy Joker{}" },
			},
			tag_entr_ascendant_negative = {
				name = "{C:gold}Negative Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Negative{}" },
			},
			tag_entr_ascendant_foil = {
				name = "{C:gold}Foil Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Foil{}" },
			},
			tag_entr_ascendant_holo = {
				name = "{C:gold}Holographic Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Holographic{}" },
			},
			tag_entr_ascendant_poly = {
				name = "{C:gold}Polychrome Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Polychrome{}" },
			},
			tag_entr_ascendant_glass = {
				name = "{C:gold}Fragile Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Fragile{}" },
			},
			tag_entr_ascendant_glitched = {
				name = "{C:gold}Glitched Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Glitched{}" },
			},
			tag_entr_ascendant_gold = {
				name = "{C:gold}Golden Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Golden{}" },
			},
			tag_entr_ascendant_blurry = {
				name = "{C:gold}Blurred Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Blurred{}" },
			},
			tag_entr_ascendant_m = {
				name = "{C:gold}M Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}JolLy{}", "{C:inactive}M{}" },
			},
			tag_entr_ascendant_mosaic = {
				name = "{C:gold}Mosaic Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Mosaic{}" },
			},
			tag_entr_ascendant_astral = {
				name = "{C:gold}Astral Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Astral{}" },
			},
			tag_entr_ascendant_oversat = {
				name = "{C:gold}Oversaturated Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Oversaturated{}" },
			},
			tag_entr_ascendant_sunny = {
				name = "{C:gold}Sunny Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Sunny{}" },
			},
			tag_entr_ascendant_solar = {
				name = "{C:gold}Solar Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Solar{}" },
			},
			tag_entr_ascendant_fractured = {
				name = "{C:gold}Fractured Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Fractured{}" },
			},
			tag_entr_ascendant_freaky = {
				name = "{C:gold}Freaky Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Freaky{}" },
			},
			tag_entr_ascendant_infdiscard = {
				name = "{C:gold}Discard Tag{}",
				text = { "{C:attention}+3{} discards", "next round" },
			},
			tag_entr_ascendant_cat = {
				name = "{C:gold}Cat Tag{}",
				text = { "{C:gold}Meow.{}", "{C:inactive}Level {C:dark_edition}#1#" },
			},
			tag_entr_ascendant_dog = {
				name = "{C:gold}Dog Tag{}",
				text = { "{C:red}Woof.{}", "{C:inactive}Level {C:dark_edition}#1#" },
			},
			tag_entr_ascendant_canvas = {
				name = "{C:gold}Canvas Tag{}",
				text = { "Shop has a", "{C:attention}Canvas{}" },
			},
			tag_entr_ascendant_unbounded = {
				name = "{C:gold}Unbounded Tag{}",
				text = {"Gives a free {C:spectral}Spectral Pack",
				"with {C:green,E:1}Pointer{} and {C:entr_entropic,E:1}Beyond{}", },
			},
			tag_entr_ascendant_ejoker = {
				name = "{C:gold}Buffoon Tag{}",
				text = { "Gives a free Editioned", "{C:attention}Mega Buffoon Pack{}" },
			},
			tag_entr_ascendant_universal = {
				name = "{C:gold}Universal Tag{}",
				text = { "Level up {C:attention}#1#{}", "{C:gold}+6{} Ascension Power" },
			},
			tag_entr_ascendant_ebundle = {
				name = "{C:gold}Bundle Tag{}",
				text = {"Create a {C:attention}Console Tag{}, {C:attention}Ethereal Tag{},",
				"{C:attention}Twisted Tag{}, and {C:attention}Bundle Tag{}", },
			},
			tag_entr_ascendant_twisted = {
				name = "{C:gold}Twisted Tag{}",
				text = {"Gives a free","{C:red}Twisted Pack{}", },
			},
			tag_entr_ascendant_stock = {
				name = "{C:gold}Stock Tag{}",
				text = {"Multiplies your money by 2.5X", },
			},
			tag_entr_ascendant_blind = {
				name = "{C:gold}Blind Tag{}",
				text = {"Gives a free","{C:attention}Blind Pack{}", },
			},
			tag_entr_ascendant_reference = {
				name = "{C:gold}Reference Tag{}",
				text = {"Gives a free","{C:green}Reference Pack{}", },
			},
			tag_entr_ascendant_cavendish = {
				name = "{C:gold}Cavendish Tag{}",
				text = {"Gives a free","{C:attention}Cavendish{}", },
			},
			tag_entr_ascendant_credit = {
				name = "{C:gold}Credit Tag{}",
				text = {"Initial cards and", "Booster Packs in the next", "shop are free", "Rerolls start at {C:gold}-$5{}" },
			},

			tag_entr_ascendant_topup = {
				name = "{C:gold}Top-Up Tag{}",
				text = {
					"Creates up to {C:attention}3{}",
					"{C:green}Uncommon{} Jokers",
					"{C:inactive}(Must have room){}",
				},
			},
			tag_entr_ascendant_better_topup = {
				name = "{C:gold}Better Top-Up Tag{}",
				text = {
					"Creates up to {C:attention}3{}",
					"{C:red}Rare{} Jokers",
					"{C:inactive}(Must have room){}",
				},
			},
			tag_entr_ascendant_booster = {
				name = "{C:gold}Booster Tag{}",
				text = {
					"Next {C:cry_code}Booster Pack{} has",
					"{C:attention}triple{} cards and",
					"{C:attention}triple{} choices",
				},
			},
			tag_entr_ascendant_effarcire = {
				name = "{C:gold}Infinite Tag{}",
				text = {
					"Draw {C:green}full deck{} to hand", "next round"
				},
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
			p_entr_blind = { 
				name = "Blind Pack",
				group_name = "Blinds",
				text={
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:attention}Blinds{} to",
					"be used immediately or taken",
				}
			},
			p_entr_unbounded = {
				name = "Unbounded Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:spectral} Spectral{} card#<s>2#",
					"{s:0.8,C:inactive}(Generated by Unbounded Tag)",
				},
			},
			p_entr_reference_pack = { 
				name = "Reference Pack",
				group_name = "Inverted Card",
				text={
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:attention}Reference Jokers{}",
				}
			},
			entr_pinned = {
				name = "Invariant",
				text = {
					"{C:attention}Cannot{} be rerolled",
					"{C:attention}Returns{} in the next",
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
			superego = {
				name = "Projected",
				text = {
					"Create {C:attention}#1#{} copies",
					"of this card when sold",
					"Increase every 2 rounds"
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
			entr_crimson_seal = {
				name = "Crimson Seal",
				text = {
					"Effect TBD"
				}
			},
			entr_sapphire_seal = {
				name = "Sapphire Seal",
				text = {
					"Create the {C:purple}Star{} card",
					"for played hand if this",
					"card is {C:attention}part{}",
					"of the poker hand",
					"{C:inactive}(Must have room){}"
        		}
			},
			entr_silver_seal = {
				name = "Silver Seal",
				text = {
					"Gives {C:gold}$4{} if",
					"card is {C:attention}played{}",
					"and {C:attention}unscoring{}",
        		}
			},
			entr_pink_seal = {
				name = "Pink Seal",
				text = {
					"Creates an {C:red}Inverted{}",
					"card when discarded",
					"and is then {C:attention}destroyed{}",
					"{C:inactive}(Must have room){}"
				}
			},
			entr_verdant_seal = {
				name = "Verdant Seal",
				text = {
					"Creates a {C:red}Code?{}",
					"card when played {C:attention}if{}",
					"this is the {C:attention}only{}",
					"scored card"
				}
			},
			entr_cerulean_seal = {
				name = "Cerulean Seal",
				text = {
					"Create 3 {C:dark_edition}Negative{} {C:purple}Star{} cards",
					"for played hand if this",
					"card is {C:attention}part{}",
					"of the poker hand,",
					"then {C:attention}destroy{}",
					"the played hand"
				}
			},
			link = {
				name = "Linked",
				text = {
					"Shares modifications",
					"with other cards that",
					"share the same link",
					"{C:inactive}(#1#){}"
				}
			},
			xmult_bonus = {
				name = "Bonus Mult",
				text = {
					"{X:red,C:white}X#1#{} extra",
					"Mult"
				}
			},
			entr_yellow_sign = {
				name = "Yellow sign",
				text = {
					"{C:attention}Temporarily{} counts",
					"as {C:diamonds}Diamonds{}"
				}
			},
		},
		DescriptionDummy = {
			dd_entr_zenith_blind  = {
                name="Zenith Blind",
                text={
                    "{C:red}Run.{}"
                },
            },
		},
		Partner = {
			pnr_entr_parakmi = {
				name = "Tyhaois",
				text = {
					"Booster packs may",
					"may be randomised",
					"to another random",
					"booster pack"
				}
			}
		}
	},
	misc = {
		tutorial = {
			cry_intro_1 = {
				"Hello, I'm {C:attention}Joseph J. Joker{}!",
				"Welcome to {C:entr_entropic,E:1}Entropy{}!",
			},
			cry_intro_2 = {
				"It looks like you've never",
				"played {C:entr_entropic,E:1}Entropy{} on this profile before.",
				"Let me show you how things work!",
			},
			cry_intro_3 = {
				"*grows hands*",
			},
			cry_intro_4 = {
				"It's hard to summarize this mod in",
				"a few sentences, but what I will say",
				"is that you're in for an {C:entr_entropic,E:1}even wilder{} ride!",
				"This isn't the same {C:attention}Cryptid{} you've played before...",
			},
			cry_intro_5 = {
				"As you might be able to tell by these",
				"{C:entr_entropic}gamesets{}, I like the letter {C:attention}E{}.",
				"Select a gameset for me to explain...",
				"{s:0.8}Note: Gameset balancing is a heavy work in progress.",
				"{s:0.8}Expect things to change frequently!",
			},
			cry_modest_1 = {
				"Seeking an experience close to vanilla?",
				"Then the {C:entr_entropic}Ethereal{} gameset is for you!",
			},
			cry_modest_2 = {
				"Still, be careful of the gimmicks hiding",
				"throughout Entropy! You never know",
				"what you'll find on the next round...",
			},
			cry_mainline_1 = {
				"Wanna {E:1,C:attention}break{} the game? Good news, you can",
				"do it without going off the deep end!",
			},
			cry_mainline_2 = {
				"Things are still nuts here, but you'll have",
				"the chance to experience the {C:entr_entropic}progression{}",
				"system. Just don't get too comfortable...",
			},
			cry_mainline_3 = {
				"Because you'll definitely be stronger, but",
				"I've crafted some {E:1,C:dark_edition}bosses{} that",
				"might make you regret selecting this {C:entr_entropic}gameset{}...",
			},
			cry_madness_1 = {
				"You lookin' to completely {C:red,E:1}annihilate{} your hard drive?",
				"Oh, how fun! The {C:entr_entropic}Exalted{} gameset says",
				"'Balance? {E:1,C:red}WHAT'S THAT!?{}'",
			},
			cry_madness_2 = {
				"I've spent weeks of sleepless, {C:green}Monster Energy{}-fueled",
				"nights working to ensure this gameset is",
				"{C:entr_entropic}PERFECTLY BALANCED{}, just for you!",
			},
			cry_madness_3 = {
				"You'll start with everything unlocked, so you",
				"can unleash the {C:red,E:1}full power{} of Entropy!",
				"Just be careful not to {C:attention,E:1}crash{} the game,",
				"as that'll probably happen before you lose...",
			},
		},
		achievement_names = {
			ach_entr_unstable_concoction = "Unstable Concoction"
		},
		achievement_descriptions = {
			ach_entr_unstable_concoction = "Use define to turn Obelisk into Sob"
		},
		suits_plural = {
			entr_nilsuit = "Nil",
		},
		suits_singular = {
			entr_nilsuit = "Nil",
		},
		ranks = {
			entr_nilrank = "Nil"
		},
		dictionary = {
			k_entr_entropic = "Entropic",
			k_entr_reverse_legendary = "Legendary?",
			k_entr_zenith = "Zenith",
			k_rtarot = "Tarot?",
			k_rtarot_pack = "Arcana Pack?",
			b_rtarot_cards = "Tarot Cards?",

			k_rcode = "Code?",
			k_rcode_pack = "Program Pack?",
			b_rcode_cards = "Code Cards?",

			k_rspectral = "Spectral?",
			k_rspectral_pack = "Spectral Pack?",
			b_rspectral_cards = "Spectral Cards?",

			a_eqmult = { "Mult = #1#" },

			k_inverted = "Inverted",
			k_inverted_pack = "Twisted Pack",
			b_inverted_cards = "Inverted Cards",

			entr_code_sudo = "OVERRIDE",
			entr_code_sudo_previous = "OVERRIDE AS PREVIOUS",

			k_entr_faster_ante_scaling = "Scale Blind scores quicker if you have an Entropic Joker",
			k_entr_entropic_music = "Entropic Jokers (Joker in Greek by gemstonez)",
			k_entr_blind_tokens = "Enable Blind Tokens",

			k_rplanet = "Star",
			b_rplanet_cards = "Star Cards?",	
			k_planet_multiverse = Cryptid_config.family_mode and "Multiverse" or "The Actual Fucking Multiverse",
			k_planet_binary_star = "Binary Star System",
			k_planet_dyson_swarm = "Stellar Megastructure",

			k_entropy = "Entropy",

			k_cblind = "Blind Token",
			b_cblind_cards = "Blind Tokens",
			k_entr_base = "Base",

			k_blind_pack = "Blind Pack",
			b_blind_cards = "Blinds",

			k_reference_pack = "Reference Pack",
			b_reference_cards = "Reference Jokers",
			b_buy_slot = "+Joker Slot",
			b_sell_slot = "-Joker Slot",
			
			b_cant_reroll="Dont even try",

			ph_blind_score_less_than="Score less than",
			entr_nadir_placeholder = "3X Base",

			ph_no_decks = "No decks bought this run",
			ph_decks_bought = "Decks bought this run",

			ph_cards_defined = "Redefinitions this run",
			ph_definitions = "No redefinitions this run", 
			ph_leftright = "The left card always converts to the right card",
			b_definitions = "Definitions",
			entr_ascended = "Ascended!",
			k_entr_freebird = "Antireal (Freebird by Lynyrd Skynyrd - Copyrighted)",

			cry_gameset_modest = "Ethereal",
			cry_gameset_mainline = "Elysian",
			cry_gameset_madness = "Exalted",
			cry_gameset_custom = "Emergent",

			b_reset_gameset_modest = "Reset Gameset Config (Ethereal)",
			b_reset_gameset_mainline = "Reset Gameset Config (Elysian)",
			b_reset_gameset_madness = "Reset Gameset Config (Exalted)",

			entr_opened = "Opened!",
			entr_kiy_banished = "Banished.",

			k_saved_heoric = "Not Heroic!",
			k_saved_just = "Not Just!",
			b_on = "Enable",
			b_off = "Disable",
		},
		v_dictionary = {
			card_art = "Card Art: #1#",
			shader = "Shader: #1#"
		},
		labels = {
			entr_pinned = "Invariant",
			entr_hotfix = "Hotfixed",
			temporary = "Temporary",
			entr_pseudorandom = "Pseudorandom",
			link = "Linked",
			superego = "Projected",
			entr_sunny = "Sunny",
			entr_solar = "Solar",
			entr_fractured = "Fractured",
			entr_freaky = "Freaky",
			entr_yellow_sign = "Yellow Sign",

			entr_crimson_seal = "Crimson Seal",
			entr_sapphire_seal = "Sapphire Seal",
			entr_silver_seal = "Silver Seal",
			entr_pink_seal = "Pink Seal",
			entr_verdant_seal = "Verdant Seal",
			entr_cerulean_seal = "Cerulean Seal",
		},
		poker_hands = {
			["entr_All"] = Cryptid_config.family_mode and "All" or "Literally Fucking Everything",
			["entr-Flesh"] = "Flesh",
			["entr-Straight_Flesh"] = "Straight Flesh",
			["entr-Flesh_House"] = "Flesh House",
			["entr-Flesh_Five"] = "Flesh Five",
		},
		poker_hand_descriptions = {
			entr_All = {
				"A hand that contains every single",
				"card found in a 52-card deck.",
				"plus an entire full set of Optics",
				"and Nils, plus one Nil rank of each suit",
				Cryptid_config.family_mode and "God is Dead" or "Fuck You, God is Dead",
			}
		},
		challenge_names = {
			c_entr_hyperbolic_chamber = "Hyperbolic Hell-Tier Chamber"
		},
		v_text = {
			ch_c_entr_starting_ante_mten = { "Start on Ante -10" },
			ch_c_entr_reverse_redeo = { "Invert Redeo's ante change" },
		}
	},
}
local CBlind = {}
for i, v in pairs(decs.descriptions.Blind) do 
	local text = {}
	for i2, v2 in pairs(v.text or {}) do text[#text+1]=v2 end
	CBlind["c_entr_"..i] = {
		name=(v.name or "Blind").." Token",
		text={
			"Use to change the upcoming Blind",
		}
	}
end
for i, v in pairs(G.localization.descriptions.Blind) do 
	local text = {}
	for i2, v2 in pairs(v.text or {}) do text[#text+1]=v2 end
	CBlind["c_entr_"..i] = {
		name=(v.name or "Blind").." Token",
		text={
			"Use to change the upcoming Blind",
		}
	}
end
decs.descriptions.CBlind = CBlind
return decs