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
					"{X:dark_edition,C:white}^#1#{} Mult",
					"increase by {X:dark_edition,C:white}^#2#{}",
					"when card is scored."
				}
			},
			m_entr_dark = {
				name = "Dark Card",
				text = {
					"{X:blue,C:white}X#2#{} Chips when held in hand",
					"Increase by {X:blue,C:white}X#1#{} for each",
					"{C:attention}unique{} suit in scoring hand"
				}
			},
			m_entr_ceramic = {
				name = "Ceramic Card",
				text = {
					"Has its own {C:attention}Rank{}, and",
					"counts as every {C:attention}Suit{}",
					"When scored {C:red}destroy{} this card",
					"When destroyed create a {C:attention}random{} consumable"
				}
			},
			m_entr_radiant = {
				name = "Radiant Card",
				text = {
					"{C:gold}+#1#{} Ascension Power"
				}
			},
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
			set_entr_altpath = {
				name = "Alternate Path",
				text = {
					"{C:attention}Content{} related to",
					"an {C:entr_entropic}alternative path{} of",
					"progression during runs",
				},
			},
			set_entr_dice_jokers = {
				name = "Dice Jokers",
				text = {
					"{C:attention}Jokers{} that modify",
					"probabilities based on dices",
					"added by Entropy"
				},
			},
			set_entr_runes = {
				name = "Runes",
				text = {
					"A new {C:attention}Consumable Type{}",
					"added by Entropy",
				},
			},
			set_entr_actives = {
				name = "Activated Jokers",
				text = {
					"{C:attention}Jokers{} that are",
					"{C:attention}manually{} activated",
					"added by Entropy"
				},
			},
		},
		Joker = {
			--Crossmod Jokers
			j_entr_compositor = {
				name = "Compositor",
				text = {
					"When {C:attention}Blind{} is selected","print a random {C:attention}Twisted Card{}"
				}
			},

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
					"Ascension formula is now {X:dark_edition,C:white}^(#1#X#2#n){}",
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
					"Gain {X:dark_edition,C:white}^Chips{} when buying a Joker",
					"based on the Joker's {C:attention}rarity{}",
					"{C:inactive}(Currently: {}{X:dark_edition,C:white}^#1#{}{C:inactive}){}",
				}
			},
			j_entr_dekatria = {
				name = "Dekatria",
				text = {
					"This Joker gives {X:dark_edition,C:white}^#1#{} mult",
					"for every {C:attention}Pair{} in played hand",
					"All cards are {C:dark_edition}Jolly{}",
				}
			},
			j_entr_oekrep = {
				name = "Oekrep",
				text = {
					"create a {C:dark_edition}Negative{} Mega Booster Pack ",
					"at the end of the {C:attention}shop{}",
					"based on one {C:attention}random{} consumable"
				}
			},
			j_entr_kciroy = {
				name = "Kciroy",
				text = {
					"{C:dark_edition}+#1#{} Hand size, {C:dark_edition}+#2#{} card selection limit",
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
					"{C:inactive}(Anaptyxi excluded){}",
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
					"in the place of any card",
					"{C:dark_edition}+#1#{} Shop Slots"
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
					"Gain money at end of round based on how",
					"many empty Joker slots you have",
					"{C:inactive}(Currently{} {C:money}#3#{}{C:inactive}){}"
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
					"{C:green}#1# in #2#{} chance for",
					"Other hand level-ups to be",
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
					"{C:attention}Joker{} {X:dark_edition,C:white}twice{} as",
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
					"{C:attention}Flesh{} cards"
				}
			},
			j_entr_antidagger = {
				name = "Anti-Dagger",
				text = {
					"Unbanish a random banished Joker",
					"when a {C:attention}blind{} is selected",
					"{C:green}#1# in #2#{} chance to {C:attention}banish{}",
					"this Joker instead"
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
					"Create a random {C:dark_edition}Sunny{} {C:cry_epic}Epic{} Joker instead",
					"when this Joker is {C:red}banished{}"
				}
			},
			j_entr_chocolate_egg_cryptidless = {
				name = "Chocolate Egg",
				text = {
					"Create a random {C:dark_edition}Sunny{} {C:red}Rare{} Joker",
					"when this joker is destroyed",
				}
			},
			j_entr_antireal = {
				name = "Antireal Joker",
				text = {
					"{X:gold,C:white}+X#1#{} Ascension Power per",
					"empty Joker slot",
					"{s:0.8}Antireal Joker included{}",
					"{C:inactive}(Currently{} {X:gold,C:white}X#2#{}{C:inactive}){}"
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
			j_entr_lotteryticket = {
				name = "Lottery Ticket",
				text = {
					"Lose {C:gold}$#5#{} at the end of round",
					"{C:green}#1# in #2#{} Chance to earn {C:gold}$#6#{}",
					"{C:green}#3# in #4#{} Chance to earn {C:gold}$#7#{} instead"
				}
			},
			j_entr_ruby = {
				name = "Ruby, Lord of Hope",
				text = {
					"This Joker gains {X:mult,C:white}X#1#{} Mult",
					"Whenever you Enter or Exit {C:attention}The Flipside{}",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
				}
			},
			j_entr_slipstream = {
				name = "Slipstream, Heir of Time",
				text = {
					"Create an {C:red}Omen{} card",
					"when blind is selected",
					"Held {C:red}Omens{} give {X:mult,C:white}X#1#{} Mult"
				}
			},
			j_entr_cass = {
				name = "Cassknows, Muse of Void",
				text = {
					"Add {C:attention}#7#{} to a random",
					"stat when a {C:planet}Planet{} or {C:purple}Star{} card is used",
					"{C:inactive}({C:blue}+#1#{C:inactive} Hand Size, {C:attention}+#2#{C:inactive} Card Selection Limit)",
					"{C:inactive}({C:blue}+#3#{C:inactive} Hands and {C:red}+#4#{C:inactive} Discards)",
					"{C:inactive}({C:dark_edition}+#5#{C:inactive} Consumable Slots, {C:attention}+#6#{C:inactive} Shop Slots)"
				}
			},
			j_entr_crabus = {
				name = "Crabus, Heir of Doom",
				text = {
					"Unscoring cards become {C:attention}Dark Cards{}",
					"{C:attention}Dark Cards{} scale when played",
					"This Joker gains {X:chips,C:white}X#1#{} chips",
					"whenever a {C:attention}Dark Card{} is added",
					"{C:inactive}(Currently: {X:chips,C:white}X#2#{C:inactive} Chips)"
				}
			},
			j_entr_devilled_suns = {
				name = "Devilled Suns",
				text = {
					"Gold Cards Give",
					"{C:gold}+#1#{} Ascension Power",
					"and {C:gold}+#2#{} more for every",
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
					"Upgrade the {C:attention}enhancement{}",
					"of playing cards when scored",
					"{C:attention}Enhancements{} are given to adjacent cards",
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
			},
			j_entr_libra = {
				name = "Libra",
				text = {
					"Scored {C:dark_edition}Wild{} and {C:attention}Face{} cards",
					"balance their values with {C:attention}this{} Joker",
					"{C:inactive}(Currently: {X:dark_edition,C:white}^#1#{} {C:inactive}Chips){}"
				}
			},
			j_entr_scorpio = {
				name = "Scorpio",
				text = {
					"Scored {C:attention}8s{} temporarily boost probabilities",
					"Grant {X:dark_edition,C:white}^Chips{} based on {C:attention}8 d8s{}",
					"Rolling {C:attention}Eight{} 8s instead grants {X:dark_edition,C:white}^#1#{} Chips"
				}
			},
			j_entr_ridiculus_absens = {
				name = "Ridiculus Absens",
				text = {
					"{C:green}#1# in #2#{} Scored non {C:dark_edition}Glitched{} cards",
					"become {C:dark_edition}Glitched{} and gain an extra effect",
					"{C:attention}Randomise{} this probability when hand is {c:attention}played{}"
				}
			},

			j_entr_endlessentropy = {
				name = "Endless Entropy",
				text = {
					"Cycles through the {C:attention}following{} effects",
					"when {C:blue}Hand{} is played and when {C:red}Discarding{} respectively",
					"#1#",
					"#2#"
				}
			},
			j_entr_skullcry = {
				name = ":skullcry:",
				text = {
					"Prevents death if chips scored are",
					"greater than {C:attention}log_#1#(Blind Requirement){}",
					"{C:red}self destructs{} if chips are not",
					"within {C:attention}#2#%{} of {C:attention}log_#1#(Blind Requirement){}"
				}
			},
			j_entr_dating_simbo = {
				name = "Dating Sim-Bo",
				text = {
					"Scored {C:hearts}Hearts{} are destroyed",
					"and their {C:blue}chips{} are {C:attention}added{} to this Joker",
					"{C:inactive}(Currently: {}{C:blue}+#1#{} {C:inactive}Chips){}"
				}
			},
			j_entr_bossfight = {
				name = "Bossfight",
				text = {
					"If exactly {C:attention}#1#{} cards are played",
					"all cards held in {C:attention}hand{}",
					"gain {C:blue}+#2#{} chip#<s>2#"
				}
			},
			j_entr_sweet_tooth = {
				name = "Sweet Tooth",
				text = {
					"{C:blue}+#1#{} Chip#<s>1#",
					"at the end of the {C:attention}shop{}",
					"destroy all {C:attention}Food{} or {C:attention}Candy{} Jokers",
					"then increase this Jokers chips by {X:dark_edition,C:white}^#2#{}",
					"if any {c:attention}Food{} or {C:attention}Candy{} Jokers were destroyed"
				}
			},
			j_entr_phantom_shopper = {
				name = "Phantom Shopper",
				text = {
					"Sell this Joker to create a",
					"{C:attention}#1#{} Rarity Joker",
					"Increases every {C:attention}#2#{} {C:inactive}[#3#]{}",
					"shops visited"
				}
			},
			j_entr_sunny_side_up = {
				name = "Sunny Side Up",
				text = {
					"{C:gold}+#1#{} Ascension Power",
					"{C:gold}-#2#{} Ascension Power per",
					"hand played"
				}
			},
			j_entr_atomikos = {
				name = "Atomikos",
				text = {
					"{C:attention}High Card's{} {C:dark_edition}operator{} is set to {C:attention}^{}",
					"{C:attention}Played{} poker hands are {C:red}deleted{}",
					"and their stats are {C:attention}added{} to {C:attention}High Card{}",
				}
			},
			j_entr_code_m = {
				name = "M()",
				text = {
					"When a {C:green}Code{} Card is used",
					"apply {C:dark_edition}Jolly{} to a",
					"{C:attention}random{} Joker"
				}
			},

			j_entr_sunflower_seeds = {
				name = "Sunflower Seeds",
				text = {
					"After playing {C:attention}#1#{} {C:inactive}[#2#]{}",
					"{C:gold}Ascended{} hands apply {C:dark_edition}Sunny{}",
					"to a {C:attention}random{} Joker and {C:red}Self Destruct{}"
				}
			},
			j_entr_tenner = {
				name = "Tenner",
				text = {
					"$ = {X:gold,C:white}#1#{}"
				}
			},
			j_entr_sticker_sheet = {
				name = "Sticker Sheet",
				text = {
					"Gives {C:mult}+#1#{} Mult",
					"for each applied {C:attention}sticker{}",
					"Apply a {C:attention}random{} sticker to",
					"a {C:attention}random{} scored card",
					"{C:inactive}(Currently:{} {C:mult}+#2#{} {C:inactive}Mult){}"
				}
			},

			j_entr_metamorphosis = {
				name = "Metamorphosis",
				text = {
					"Main Joker {C:attention}scoring{} effects",
					"instead trigger when {C:attention}#1#{}'s are scored",
					"rank changes every hand"
				}
			},

			j_entr_fourbit = {
				name = "4Bit Joker",
				text = {
					"Every {C:attention}#1#{}th {C:inactive}[#2#]{} Scoring Card",
					"has a {C:attention}random{} card applied",
					"as an {C:attention}enhancement{}"
				}
			},
			j_entr_scenic_route = {
				name = "Scenic Route",
				text = {
					"Create a {C:red}(~)$ new(){}",
					"When a {C:attention}Boss Blind{}",
					"is defeated",
					"{C:inactive}(Must have room){}"
				}
			},
			j_entr_crimson_flask = {
				name = "Crimson Flask",
				text = {
					"This Joker gains {X:mult,C:white}X#1#{} Mult when a Joker",
					"is {C:attention}debuffed{} and {X:mult,C:white}X#2#{} when a {C:attention}debuffed{}",
					"playing card is drawn to hand",
					"Debuff a {C:attention}random{} Joker each round",
					"{C:inactive}(Currently{} {X:mult,C:white}X#3#{} {C:inactive}Mult){}",
				},
			},
			j_entr_grotesque_joker = {
				name = "Grotesque Joker",
				text = {
					"This Joker gains {X:mult,C:white}X#1#{} Mult when a Flesh Card is",
					"added and {X:chips,C:white}X#2#{} Chips when a Flesh Card is destroyed",
					"{C:inactive}(Currently{} {X:mult,C:white}X#3#{}, {X:chips,C:white}X#4#{}{C:inactive}){}",
				},
			},
			j_entr_nyctophobia = {
				name = "Nyctophobia",
				text = {
					"When blind is selected, destroy",
					"a random {C:attention}consumable{} and draw two",
					"random {C:dark_edition}Dark{} cards to hand for every time",
					"that consumable was {C:attention}used{} previously"
				},
			},
			j_entr_dog_chocolate = {
				name = "Dog Chocolate",
				text = {
					"When {C:attention}Dog Tags{} are merged",
					"instead create a {C:attention}Candy{} Joker",
					"and {C:red}destroy{} both of the {C:attention}Dog Tags{}",
					"{C:attention}Dog Tags{} appear more frequently"
				},
			},
			j_entr_nucleotide = {
				name = "Nucleotide",
				text = {
					"Draw a copy of the first discarded",
					"card per round with an {C:attention}inversed{} rank",
					"and suit and an upgraded {C:dark_edition}Edition{} to {C:attention}hand{}"
				},
			},
			j_entr_caviar = {
				name = "Caviar",
				text = {
					"{C:attention}Ascend{} the next {C:attention}#1#{}",
					"obtained Tags"
				},
			},
			j_entr_afterimage = {
				name = "Afterimage",
				text = {
					"Scored cards have a {C:green}#1# in #2#{}",
					"chance to draw a {C:attention}Banana{}",
					"{C:attention}Perishable{} copy to hand"
				},
			},

			j_entr_apeirostemma = {
				name = "Apeirostemma",
				text = {
					"This Joker may cycle",
					"between {C:attention}6{} different",
					"effects"
				}
			},
			j_entr_apeirostemma_1 = {
				name = "Apeirostemma (D1)",
				text = {
					"Copy a {C:attention}random{} Joker and",
					"a {C:attention}random{} consumable at",
					"the end of the shop then apply negative",
					"to the copied cards",
					"{C:inactive}(Apeirostemma excluded){}"
				}
			},
			j_entr_apeirostemma_2 = {
				name = "Apeirostemma (D2)",
				text = {
					"{C:green}#1# in #2#{} chance",
					"to {C:dark_edition}Force-Trigger{}",
					"all other Jokers"
				}
			},
			j_entr_apeirostemma_3 = {
				name = "Apeirostemma (D3)",
				text = {
					"This Joker gains {X:dark_edition,C:white}^#1#{} Chips",
					"if exactly {C:attention}3{} cards are played",
					"{C:inactive}(Currently{} {X:dark_edition,C:white}^#2#{}{C:inactive}){}"
				}
			},
			j_entr_apeirostemma_4 = {
				name = "Apeirostemma (D4)",
				text = {
					"Reroll all Jokers to the {C:attention}Right{}",
					"of this Joker when blind is selected"
				}
			},
			j_entr_apeirostemma_5 = {
				name = "Apeirostemma (D5)",
				text = {
					"When a shop item is bought",
					"increase this Jokers values by",
					"{C:attention}X(1 - 1.1){} excluding this effect"
				}
			},
			j_entr_apeirostemma_6 = {
				name = "Apeirostemma (D6)",
				text = {
					"Retrigger all cards {C:attention}3-9{} Times"
				}
			},

			j_entr_qu= {
				name = "Qu",
				text = {
					"One {C:attention}random{} card in hand",
					"gains a random {C:red}Twisted{} card",
					"as an enhancement when {C:attention}blind{}",
					"is selected"
				}
			},
			j_entr_memento_mori= {
				name = {
					"A Knee Slapping Joke Joker Title",
					"Referring to how Entropy Joker",
					"Effects are always kinda like that",
					"(Memento Mori Entropic Edit)"
				},
				text = {
					"The {C:attention}First{} played card",
					"each round is {C:attention}destroyed{}"
				}
			},
			j_entr_broadcast = {
				name = "Broadcast",
				text = {
					"Copies the {C:attention}#1#{}#2# Jokers effect",
					"Increases by {C:attention}1{} when hand played",
					"Resets after reaching your {C:attention}last{} Joker"
				}
			},
			j_entr_d0 = {
				name = "D0",
				text = {
					"Multiplies all {C:attention}listed{}",
					"{C:green,E:1}probabilities{} by {C:attention}0",
					"{C:inactive}(ex. {C:green}1 in 3{C:inactive} -> {C:green}0 in 3{C:inactive})"
				}
			},
			j_entr_d1 = {
				name = "D1",
				text = {
					"The {C:attention}First{} Probability Roll",
					"each round is {C:green}Guaranteed{}"
				}
			},
			j_entr_d4 = {
				name = "D4",
				text = {
					"Probability Rolls are rolled {C:attention}Twice{}",
					"with only {C:attention}one{} success needed"
				}
			},

			j_entr_d6 = {
				name = "D6",
				text = {
					"This Joker Gains {C:green}+#2#{} Numerator",
					"when a Probability {C:red}fails{}",
					"and resets when a Probability {C:green}succeeds{}",
					"{C:inactive}(Currently {C:green}+#1#{C:inactive})"
				}
			},

			j_entr_eternal_d6 = {
				name = "Eternal D6",
				text = {
					"When rerolling {C:green}#1# in #2#{} Chance",
					"to {C:red}destroy{} a random shop card else gain",
					"{C:green}+#4#{} Numerator, resets at the end of the ante",
					"{C:inactive}(Currently {C:green}+#3#{C:inactive})"
				}
			},

			j_entr_d7 = {
				name = "D7",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"Retrigger each {C:green}Probability{}",
					"based {C:attention}Joker{} and {C:attention}Enhancement{}"
				}
			},
			j_entr_d8 = {
				name = "D8",
				text = {
					"Probabilities are rolled with",
					"a {C:green}Denominator{} lowered by {C:attention}#1#{}",
				}
			},
			j_entr_d10 = {
				name = "D10",
				text = {
					"Probabilities are rolled with",
					"{C:attention}randomly{} offset {C:green}Numerators{} and {C:green}Denominators{}",
				}
			},
			j_entr_d12 = {
				name = "D12",
				text = {
					"{C:green}+#1#{} Numerator",
					"for every {C:attention}held{} Consumable"
				}
			},
			j_entr_d100 = {
				name = "D100",
				text = {
					"Permanently {C:attention}randomize{} probabilities",
					"when they are triggered"
				}
			},
			j_entr_capsule_machine = {
				name = "Capsule Machine",
				text = {
					"When blind is selected",
					"create a {C:attention}Perishable{} {C:green}Dice{} {C:attention}Joker{}",
					"{C:inactive}(Must have room){}"
				}
			},

			j_entr_milk_chocolate = {
                name = "Milk Chocolate",
                text = {
                    "Sell this card to",
                    "create a free",
                    "{C:attention}#1#",
                },
            },

			j_entr_insurance_fraud = {
                name = "Insurance Fraud",
                text = {
                    "Create a random {C:red}Fraud{} card",
					"when a {C:purple}Tarot{} card is sold"
                },
            },

			j_entr_free_samples = {
                name = "Free Samples",
                text = {
                    "{C:green}#1# in #2#{} chance for",
					"opened {C:attention}Booster Packs{}",
					"to be {C:attention}copied{} to your consumables",
					"{C:inactive}(Must have room){}"
                },
            },
			j_entr_fused_lens = {
                name = "Fused Lens",
                text = {
                    "{C:green}#1# in #2#{} chance to create",
					"the {C:purple}Star{} card for your played hand",
					"{C:inactive}(Must have room){}"
                },
            },
			j_entr_opal = {
                name = "Opal",
                text = {
                    "Suitless cards may be used",
					"to form poker hands",
					"{C:attention}Retrigger{} suitless cards"
                },
            },
			j_entr_inkbleed = {
                name = "Inkbleed",
                text = {
                    "Cards that {C:attention}share{} a",
					"{C:attention}Rank{} or {C:attention}Modification{}",
					"count as eachothers suit"
                },
            },
			j_entr_roulette = {
                name = "Roulette",
                text = {
                    "{C:green}#1# in #2#{} chance for",
					"each scored card to gain {C:red}+#3#{} Bonus Mult",
					"Destroy every {C:attention}#4#{}th scoring card"
                },
            },
			j_entr_debit_card = {
                name = "Debit Card",
                text = {
                    "Earn {C:money}$#1#{} for every",
					"{C:money}$#2#{} {C:inactive}[$#3#]{} spent",
					"{C:inactive}(Currently {C:money}$#4#{C:inactive}){}"
                },
            },
			j_entr_birthday_card = {
                name = "Birthday Card",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if you have",
					"atleast {C:attention}#2#{} held Consumables"
                },
            },
			j_entr_sandpaper = {
                name = "Sandpaper",
                text = {
                    "If played hand contains a {C:attention}Stone Card{}",
					"{C:red}destroy{} all played {C:attention}Stone Cards{}",
					"and create a {C:attention}random{} {C:purple}Rune Card{}"
                },
            },
			j_entr_purple_joker = {
                name = "Purple Joker",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
					"whenever a {C:purple}Rune{} triggers",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
                },
            },
			j_entr_chalice_of_blood = {
                name = "Chalice of Blood",
                text = {
                    "{X:mult,C:white}X#1#{} Mult per {C:red}Pact{}",
					"card used this run",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
                },
            },
			j_entr_torn_photograph = {
                name = "Torn Photograph",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
					"whenever a {C:red}Twisted{} card is sold",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
                },
            },
			j_entr_chuckle_cola = {
                name = "Chuckle Cola",
                text = {
                    "Multiply the {C:blue}Chips{} of {C:attention}scored{}",
					"cards by {X:blue,C:white}X#1#{}, {C:red}Self Destructs{}",
					"after {C:attention}#2#{} card#<s>2# scored"
                },
            },
			j_entr_antiderivative = {
                name = "Antiderivative",
                text = {
                    "{C:attention}Ranks{} and {C:attention}Suits{} are swapped",
					"for {C:attention}Jokers{} and {C:attention}Poker Hand{} detection",
					"{C:inactive,s:0.8}Spades, Hearts, Clubs, and Diamonds{}",
					"{C:inactive,s:0.8}count as Ace, King, Queen, Jack respectively{}"
                },
            },
			j_entr_alles = {
                name = "Oops all e's!",
                text = {
                    "Earn {C:money}$#1#{} at end of round if",
					"you take {C:attention}more{} than {C:blue}1{} hand",
					"to beat the {C:attention}Blind{}"
                },
            },
			j_entr_verbophobia = {
                name = "Verbophobia",
                text = {
                    "The first {C:attention}5{} letter or lower",
					"Word each round is {C:red}always{} counted",
					"as a {C:attention}Valid{} Word"
                },
            },
			j_entr_feynman_point = {
                name = "Feynman Point",
                text = {
                    "Round Joker {C:attention}decimals{} to",
					"the next {X:dark_edition,C:white}#1#{} increasing",
					"by {X:dark_edition,C:white}#2#{} whenever a",
					"probability {C:green}succeeds{}"
                },
            },
			j_entr_neuroplasticity = {
                name = "Neuroplasticity",
                text = {
                    "Poker hands Calculate",
					"as a {C:attention}random{} Hand which",
					"Shuffles {C:attention}every round{}"
                },
            },
			j_entr_dragonfruit = {
                name = "Dragonfruit",
                text = {
                    "{C:attention}+#1#{} Card Selection Limit",
					"{C:attention}-#2#{} Card Selection Limit",
					"after every played hand"
                },
            },
			j_entr_prismatikos = {
                name = "Prismatikos",
                text = {
                    "Chooses an effect randomly when triggered",
					"{X:chips,C:white}???{} Chips, {X:mult,C:white}???{} Mult, {X:money,C:white}???{} Ascension Power",
					"{X:money,C:white}???{} Money, {X:blue,C:white}???{} Hands",
					"Create {C:attention}2{} Twisted Cards, Played Hand gains random {C:dark_edition}Editions{}",
					"{X:attention,C:white}X0.9{} Blind Size. ...",
                },
            },
			j_entr_jestradiol = {
                name = "Jestradiol",
                text = {
                    "Use this Joker to turn up to {C:attention}#1#{}",
					"selected cards into {C:attention}Queens{}",
					"gains {C:attention}#2#{} use#<s>2# when defeating a Boss Blind"
                },
            },
			j_entr_penny = {
                name = "Lost Penny",
                text = {
                    "{C:blue}+#1#{} Chips",
					"{C:dark_edition}Doubles{} when Boss Blind",
					"is defeated"
                },
            },
			j_entr_slothful_joker = {
                name = "Slothful Joker",
                text = {
                    "Played {C:purple}suitless{} cards give",
                    "{C:mult}+#1#{} Mult when scored",
                },
            },
			j_entr_radar = {
                name = "Radar",
                text = {
                    "Earn {C:money}$#1#{} for each",
					"Poker Hand played more than",
					"{C:attention}5{} times, at end of round",
					"{C:inactive}(Currently {C:money}$#2#{C:inactive})"
                },
            },
			j_entr_abacus = {
                name = "Abacus",
                text = {
                    "Scored number cards give",
					"one half of their",
					"base {C:blue}chips{} as {C:red}mult{}"
                },
            },
			j_entr_matryoshka_dolls = {
                name = "Matryoshka Dolls",
                text = {
                    "{C:red}+#1#{} Mult",
					"When Blind is selected",
					"create a {C:attention}copy{} of this Joker",
					"with {C:red}1{} fewer mult",
					"{C:inactive}(Must have room)"
                },
            },
			j_entr_menger_sponge = {
                name = "Menger Sponge",
                text = {
                    "{C:blue}+#1#{} Chips",
					"Multiplies by {X:attention,C:white}X#2#{} at end of round",
					"{C:red}Resets{} when the Boss Blind is defeated"
                },
            },
			j_entr_arbitration = {
                name = "Arbitration",
                text = {
                    "Create a {C:attention}Judgement{}",
					"when a {C:attention}Glass Card{}",
					"is destroyed",
					"{C:inactive}(Must have room)"
                },
            },
			j_entr_masterful_gambit = {
                name = "Masterful Gambit",
                text = {
                    "Earn {C:money}$#1#{}",
					"if played hand contains",
					"{C:attention}only{} a single card"
                },
            },
			j_entr_fourty_benadryls = {
                name = "Fourty Benadryls",
                text = {
                    "{C:blue}+#1#{} Chip#<s>1#",
					"for each ante",
					"{C:inactive}(Currently: {C:blue}#2#{C:inactive} Chip#<s>2#)"
                },
            },
			j_entr_red_fourty = {
                name = "Red-40",
                text = {
                    "{C:red}+#1#{} Mult",
					"{C:red}-#2#{} Mult when",
					"spending money in The Shop"
                },
            },
			j_entr_promotion = {
                name = "Promotion",
                text = {
                    "Create a {C:attention}random{} Booster Pack",
					"in the Consumables tray when",
					"The Boss Blind is defeated",
					"{C:inactive}(Must have room)"
                },
            },
			j_entr_offbrand = {
                name = "Offbrand",
                text = {
                    "{C:red}-#1#{} Mult",
					"Earn {C:money}$#2#{} at",
					"end of round"
                },
            },
			j_entr_girldinner = {
                name = "Girldinner",
                text = {
                    "The first scored {C:attention}Queen{}",
					"each round gives {C:mult}+#1#{} Mult",
					"and {C:blue}+#2#{} Chips"
                },
            },
			j_entr_recycling_bin = {
                name = "Recycling Bin",
                text = {
                    "This Joker gains {C:red}+#1#{} Mult",
					"per each {C:attention}discarded{} card and",
					"{C:red}resets{} at the end of round",
					"{C:inactive}(Currently: {C:red}#2#{C:inactive} Mult)"
                },
            },
			j_entr_gold_bar = {
                name = "Gold Bar",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
					"decreases by {C:red}$#2#{} when triggered"
                },
            },
			j_entr_scribbled_joker = {
                name = "Scribbled Joker",
                text = {
                    "{C:blue}+#1#{} Chips",
					"if scored hand contains",
					"an {C:attention}Enhanced{} card"
                },
            },
			j_entr_jokers_against_humanity = {
                name = "Jokers Against Humanity",
                text = {
                    "First scored card each",
					"hand becomes {C:attention}Eternal{}",
					"Scored {C:attention}Eternal{} Cards give",
					"{C:blue}+#1#{} Chips and",
					"{C:red}+#2#{} Mult"
                },
            },
			j_entr_blind_collectible_pack = {
                name = "Blind Collectible Pack",
                text = {
                    "Sell this card to",
					"create a free",
					"{C:attention}Blind Token{}",
					"{C:inactive}(Must have room)"
                },
            },
			j_entr_prayer_card = {
                name = "Prayer Card",
                text = {
                    "{C:attention}-#1#{} Blind Requirement",
					"for each ante",
					"{C:inactive}(Currently: {C:attention}#2#{C:inactive})"
                },
            },
			j_entr_desert = {
                name = "Desert",
                text = {
                    "This Joker gains {C:gold}+#1#{}",
					"Ascension Power if played hand",
					"contains exactly {C:attention}1{} Card",
					"{C:inactive}(Currently: {C:gold}#2#{C:inactive} Ascension Power)"
                },
            },
			j_entr_rugpull = {
                name = "Rugpull",
                text = {
                    "Earn no Payout",
					"{X:attention,C:white}X#1#{} The Payout amount",
					"is added to this Jokers",
					"{C:attention}sell value{} instead"
                },
            },
			j_entr_grape_juice = {
                name = "Grape Juice",
                text = {
                    "Use this Joker to",
					"turn a random card held in hand",
					"into a {C:attention}Bonus{}, {C:attention}Mult{}, or {C:attention}Wild{} card",
					"gains {C:attention}#2#{} use#<s>2# when defeating a Boss Blind",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive} use#<s>1#)"
                },
            },
			j_entr_petrichor = {
                name = "Petrichor",
                text = {
                    "Non-Scored Cards",
					"give {C:blue}+#1#{} Chips"
                },
            },
			j_entr_otherworldly_joker = {
                name = "Otherworldly Joker",
                text = {
                    "Create a {C:red}Twisted{} Card",
					"when any {C:attention}Booster Pack{}",
					"is skipped",
					"{C:inactive}(Must have room){}"
                },
            },
			j_entr_error = {
                name = "ERROR",
                text = {
                    "Calculated Effects are",
					"slightly {C:attention}offset{}",
					"{C:inactive,S:0.8}(Ex. {C:blue}+30{C:inactive} Chips or {X:red,C:white}X2{C:inactive} Mult)"
                },
            },
			j_entr_thirteen_of_stars = {
                name = "Thirteen of Stars",
                text = {
                    "Gives a {C:attention}Quarter{} the",
					"played Poker Hands {C:purple}Level{}",
					"as {C:gold}Ascension Power{}"
                },
            },
			j_entr_diode_red = {
                name = "LED (Red)",
                text = {
                    "{C:red}+#1#{} Mult",
					"{C:inactive,S:0.8}Switches after hand played"
                },
            },
			j_entr_diode_blue = {
                name = "LED (Blue)",
                text = {
                    "{C:blue}+#1#{} Chips",
					"{C:inactive,S:0.8}Switches after hand played"
                },
            },
			j_entr_prismatic_shard = {
                name = "Prismatic Shard",
                text = {
                    "Scored Cards give",
					"{C:mult}+#1#{} Mult,",
					"{C:blue}+#2#{} Chips, or",
					"{C:gold}+#3#{} Ascension Power"
                },
            },
			j_entr_chameleon = {
                name = "Chameleon",
                text = {
                    "Scores as a",
					"Random {C:attention}Enhancement{}"
                },
            },
			j_entr_thanatophobia = {
                name = "Thanatophobia",
                text = {
                    "Gives half of the {C:attention}sell value{} of all",
					"sold or destroyed {C:attention}Jokers{} as mult",
					"{C:inactive}(Currently: {C:mult}+#1#{C:inactive})"
                },
            },
			j_entr_redkey= {
                name = "Red Key",
                text = {
					"Use this Joker to add an {C:attention}extra{} ",
					"{C:red}Red Room{} Blind",
					"gains {C:attention}#2#{} use#<s>2# when defeating a Boss Blind",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive} use#<s>1#)"
                },
            },
			j_entr_polaroid = {
                name = "Polaroid",
                text = {
					"Use this Joker to copy another {C:attention}Jokers{}",
					"abilities until next used",
					"gains {C:attention}#2#{} use#<s>2# when defeating a Blind",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive} use#<s>1#)"
                },
            },
			j_entr_car_battery = {
                name = "Car Battery",
                text = {
					"Useable {C:attention}Jokers{} and {C:attention}Consumables{}",
					"Gain {C:attention}#1#{} extra use",
					"When defeating a Boss Blind",
                },
            },
			j_entr_chair = {
                name = "Chair",
                text = {
					"If Played hand is {C:attention}Three of a Kind",
					"Apply {C:attention}Freaky{} to the {C:attention}third{}",
					"scoring card"
                },
            },
			j_entr_captcha = {
                name = "Captcha",
                text = {
					"Use this Joker to apply a random",
					"{C:attention}Joker{}, {C:attention}Consumable{}, {C:attention}Booster Pack{} or {C:attention}Voucher{}",
					"as an Enhancement to a {C:attention}Random{} Card held in hand",
					"gains {C:attention}#2#{} use#<s>2# when defeating a Blind",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive} use#<s>1#)"
                },
            },
			j_entr_deck_enlargement_pills = {
                name = "Deck Enlargement Pills",
                text = {
					"After {C:attention}#1#{} {C:inactive}[#2#]{} Rounds",
					"sell this card to",
					"{C:attention}Apply{} a random {C:attention}Deck's{} Effects"
                },
            },
			j_entr_photocopy = {
                name = "Photocopy",
                text = {
					"The first card in {C:attention}Standard Packs{}",
					"always has your most common",
					"{C:attention}Suit{} and {C:attention}Rank{}"
                },
            },

			j_entr_hexa = {
                name = "HexaCryonic, Witch of Light",
                text = {
					"Extra played cards provide",
					"{C:gold}+3{} Ascension Power",
					"{C:attention}+3{} Card Selection Limit"
                },
            },
			j_entr_hexa_cryptid = {
                name = "HexaCryonic, Knight of Mind",
                text = {
					"Extra played cards provide {X:gold,C:white}X3{}",
					"as much Ascension Power",
					"{C:attention}+#1#{} Card Selection Limit"
                },
            },

			j_entr_ybur = {
                name = "Ybur",
                text = {
					"Prevents Death once per Ante",
					"if no blinds were skipped",
					"This Joker gains {X:dark_edition,C:white}^#2#{} Chips",
					"when death is prevented",
					"{C:inactive}(Currently: {X:dark_edition,C:white}^#1#{C:inactive} Chips, #3#)"
                },
            },
			j_entr_zelavi = {
                name = "Zelavi",
                text = {
					"This Joker gains {X:blue,C:white}X#2#{} Chips",
					"whenever a {C:spectral}Spectral Pack{} is opened",
					"Each shop always contains a {C:spectral}Mega Spectral Pack{}",
					"{C:inactive}(Currently: {X:blue,C:white}X#1#{C:inactive} Chips)"
                },
            },
			j_entr_ssac = {
                name = "Swonkssac",
                text = {
					"{C:attention}Forcetrigger{} the Rightmost",
					"{C:attention}Joker{}, {C:attention}Playing Card{}, and {C:attention}Consumable{}",
					"once for every two Base Ranks missing in the deck",
					"{C:inactive}(Currently: {C:attention}#1#{C:inactive})"
                },
            },
			j_entr_subarc = {
                name = "Subarc",
                text = {
					"{C:attention}Retriggered{} Playing Card Editions are",
					"Upgraded to {C:attention}Sunny{} and then {C:attention}Solar{}",
					"Retriggered {C:attention}Solar{} cards gain",
					"{X:gold,C:white}X#1#{} Ascension Power"
                },
            },
			j_entr_axeh = {
                name = "CinoyrcAxeh",
                text = {
					"Creates a {C:attention}Sunny Joker{}",
					"when obtained",
					"{X:gold,C:white}X#1#{} to all sources",
					"of Ascension Power"
                },
            },

			j_entr_enlightenment = {
                name = "Enlightenment",
                text = {
					"Allows {C:attention}The Fool{} to copy",
					"any {C:red}Non Inverted{} or {C:red}Hidden{} Consumable",
					"or Booster Pack. Allows {C:red}The Master{} to copy",
					"{C:red}Twisted Packs{}"
                },
            },
			j_entr_black_rose_green_sun = {
                name = "Black Rose, Green Sun",
                text = {
					"{C:spades}Spades{} and {C:clubs}Clubs{}",
					"held in hand give",
					"{C:gold}+#1#{} Ascension Power"
                },
            },

			j_entr_heimartai = {
                name = "Heimartai",
                text = {
                    "Probabilities are {C:attention}retriggered{}",
					"until they {C:green}succeed{}",
					"gain {X:dark_edition,C:white}^Chips{} equal to the {C:attention}number of rolls{}",
					"divided by the {C:green}probabilities denominator{}",
					"{C:inactive}(Currently: {X:dark_edition,C:white}^#1#{C:inactive} Chips)"
                },
            },
			j_entr_jack_off = {
                name = "Jack-Off",
                text = {
                    "Scored {C:attention}Jacks{} discard",
					"a {C:attention}random{} card held",
					"in hand"
                },
            },
			j_entr_fast_food = {
                name = "Fast Food",
                text = {
					"When {C:attention}Blind{} is selected",
                    "create a {C:attention}Perishable Food{} Joker",
					"{C:inactive}(Must have room)"
                },
            },
			j_entr_antipattern= {
                name = "Antipattern",
                text = {
					"This Joker gains {X:blue,C:white}X#1#{} Chips",
					"for each {C:attention}Unique{} pair of {C:attention}Poker Hands{} played",
					"{C:inactive}(Currently: {X:blue,C:white}X#2#{C:inactive} Chips)"
                },
            },
			j_entr_spiral_of_ants = {
                name = "Spiral of Ants",
                text = {
					"This Joker gains {C:blue}+#1#{} Chips",
					"for each {C:attention}consecutive{} hand with {C:attention}fewer{}",
					"cards than the previous hand",
					"{C:inactive}(Currently: {C:blue}+#2#{C:inactive} Chips)"
                },
            },
			j_entr_fork_bomb = {
                name = "Fork Bomb",
                text = {
					"When {C:attention}Blind{} is selected",
					"Create a {C:attention}copy{} of this Joker",
					"{C:inactive}(Does not need room, Max of 16)"
                },
            },
			j_entr_solar_panel = {
                name = "Solar Panel",
                text = {
					"Discarded {C:attention}Sunny{} and {C:attention}Radiant{}",
					"cards give {C:money}$#1#{}"
                },
            },
			j_entr_kintsugi = {
                name = "Kintsugi",
                text = {
					"{C:attention}Ceramic{} cards are turned",
					"to {C:attention}Gold{} cards instead",
					"of {C:red}self destructing{}"
                },
            },
			j_entr_blooming_crimson = {
                name = "Blooming Crimson",
                text = {
                    "Scored Cards give",
					"{X:mult,C:white}X#1#{} Mult,",
					"{X:blue,C:white}X#2#{} Chips, or",
					"{X:gold,C:white}X#3#{} Ascension Power"
                },
            },
			j_entr_overpump = {
                name = "Overpump",
                text = {
                    "{X:mult,C:white}X#1#{} Mult on {C:attention}final{}",
					"{C:attention}hand{} of round",
					"Increases by {X:mult,C:white}X#2#{} for each",
					"{C:attention}unique{} poker hand played this round"
                },
            },
			j_entr_shadow_crystal = {
                name = "Shadow Crystal",
                text = {
                    "Consumables have a {C:green}#1# in #2#{} chance",
					"to also trigger their {C:red}Inverted{} counterparts",
					"{C:inactive}(If Possible, Hidden consumables excluded)"
                },
            },
			j_entr_miracle_berry = {
                name = "Miracle Berry",
                text = {
                    "The next {C:attention}#1#{} consumables to",
					"appear will be {C:spectral}Spectrals{}",
                },
            },
			j_entr_meridian = {
                name = "Meridian",
                text = {
                    "Gives Mult based on",
					"{C:attention}position{} in the Jokers tray",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                },
            },
			j_entr_mango = {
                name = "Mango",
                text = {
                    "Copy the {C:attention}first played{} card",
					"of the next {C:attention}#1#{} hands",
					"then draw it to {C:attention}hand{}"
                },
            },
			j_entr_kitchenjokers = {
                name = "Kitchen Joker",
                text = {
                    "Food Jokers are {C:attention}more likely{}",
					"to appear are {C:attention}X#1#{} as expensive",
					"and are {C:dark_edition}Low-Res{}"
                },
            },
			j_entr_hash_miner = {
                name = "Hash Miner",
                text = {
                    "{C:green}#1# in #2#{} chance to corrupt",
					"played hands, Corrupted hands have a",
					"{C:green}#3# in #4#{} chance to recover",
					"Gain {C:money}$#5#{} of sell value",
					"per corrupted hand at the end of round",
                },
            },
			j_entr_dice_shard = {
                name = "Dice Shard",
                text = {
					"Use this Joker to transform a Selected",
					"{C:attention}Joker{} into the previous Joker",
					"according to the collection order",
					"gains {C:attention}#2#{} use#<s>2# when defeating a Blind",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive} use#<s>1#, #3#)"
                },
            },
		},
		Blind = {
			bl_entr_red = {
				name = "Red Room",
				text = {
					"???"
				}
			},
			bl_entr_void = {
				name = "???",
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
				name = "Burgundy Barracuda",
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
					"Cards in hand become Disavowed",
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
					"(Jokers and hand levels removed)"
				}
			},
			bl_entr_endless_entropy_phase_three = {
				name = "Nameless Nadir",
				text = {
					"Void subsumes you,",
					"(Debuff leftmost Joker slot(s),",
					"You must lose this blind.)"
				}
			},
			bl_entr_endless_entropy_phase_four = {
				name = "Endless Entropy",
				text = {
					"You are but a speck of dust",
					"in the face of the universe.",
					"(Entropy is endless)"
				}
			},
			bl_entr_alabaster_anchor = {
				name = "Alabaster Anchor",
				text = {
					"Playing Hands, Discarding, and Select/Unselecting playing cards",
					"Temporarily decreases joker values by 5%"
				}
			},
			--alt blinds
			bl_entr_alpha = {
				name = "Alpha",
				text = {
					"First scored card each hand",
					"is destroyed"
				}
			},
			bl_entr_beta = {
				name = "Beta",
				text = {
					"-1 Hand Size",
					"-1 more Hand Size per hand played"
				}
			},
			bl_entr_gamma = {
				name = "Gamma",
				text = {
					"Divide base mult based on the",
					"number of unplayed suits"
				}
			},
			bl_entr_delta = {
				name = "Delta",
				text = {
					"Divide final mult based on the",
					"number of played hands",
					"in this blind"
				}
			},
			bl_entr_epsilon = {
				name = "Epsilon",
				text = {
					"Divide final mult based on the",
					"number of played cards"
				}
			},
			bl_entr_zeta = {
				name = "Zeta",
				text = {
					"Hand must not contain",
					"3 or 5 cards"
				}
			},
			bl_entr_eta = {
				name = "Eta",
				text = {
					"#1# cards are debuffed",
					"changes when hand played"
				}
			},
			bl_entr_theta = {
				name = "Theta",
				text = {
					"Mult operations now",
					"affect chips instead"
				}
			},
			bl_entr_iota = {
				name = "Iota",
				text = {
					"Applies the effects of #1#",
					"changes every hand played"
				}
			},
			bl_entr_kappa = {
				name = "Kappa",
				text = {
					"Scoring cards dont score",
					"Unscored cards score instead"
				}
			},
			bl_entr_lambda = {
				name = "Lambda",
				text = {
					"Scored cards become",
					"debuffed for 5 rounds"
				}
			},
			bl_entr_mu = {
				name = "Mu",
				text = {
					"Sum of selected ranks",
					"must not exceed 30"
				}
			},
			bl_entr_nu = {
				name = "Nu",
				text = {
					"0.8x interest per",
					"card trigger"
				}
			},
			bl_entr_xi = {
				name = "Xi",
				text = {
					"First discarded hand",
					"becomes eternal"
				}
			},
			bl_entr_omicron = {
				name = "Omicron",
				text = {
					"First played hand",
					"gives no Score"
				}
			},
			bl_entr_pi = {
				name = "Pi",
				text = {
					"Discarded cards",
					"return to Deck"
				}
			},
			bl_entr_rho = {
				name = "Rho",
				text = {
					"Divide final mult based on the",
					"number of played ranks"
				}
			},
			bl_entr_sigma = {
				name = "Sigma",
				text = {
					"Hands and discards are now",
					"a shared resource"
				}
			},
			bl_entr_tau = {
				name = "Tau",
				text = {
					"+1 Selection Limit",
					"-1 Selection Limit",
					"when discarding"
				}
			},
			bl_entr_upsilon = {
				name = "Upsilon",
				text = {
					"Scored cards give",
					"-0.25 Ascension Power"
				}
			},
			bl_entr_phi = {
				name = "Phi",
				text = {
					"Ranks that arent",
					"Ace, 3, 6, 8, or 9",
					"are debuffed"
				}
			},
			bl_entr_chi = {
				name = "Chi",
				text = {
					"The first scored card",
					"of each rank is debuffed"
				}
			},
			bl_entr_psi = {
				name = "Psi",
				text = {
					"#1# in 2 chance for",
					"scored cards to become",
					"disavowed"
				}
			},
			bl_entr_omega = {
				name = "Omega",
				text = {
					"Playing a #1#",
					"multiplies score",
					"requirements by 2x"
				}
			},

			bl_entr_styx = {
				name = "Sorrowful Styx",
				text = {
					"Jokers and Playing cards",
					"cannot be rearranged",
					"Move 1 Joker and Playing Card",
					"before hand is scored"
				}
			},
			bl_entr_choir = {
				name = "Callous Chorus",
				text = {
					"Triggered Jokers are",
					"debuffed for this round"
				}
			},
			bl_entr_pandora = {
				name = "Pristine Pandora",
				text = {
					"#1# in 3 chance for",
					"when cards are drawn",
					"to instead draw a random",
					"temporary card"
				}
			},
			bl_entr_cassandra = {
				name = "Condemned Cassandra",
				text = {
					"Discarded cards return",
					"to the deck, #1# in 5",
					"Jokers are debuffed",
					"before scoring"
				}
			},
			bl_entr_labyrinth = {
				name = "Limitless Labyrinth",
				text = {
					"+3 Hand Size, +1 Selection limit.",
					"Cards cannot be unhighlighted",
					"Highlight a random card when a",
					"card is highlighted"
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
			e_entr_neon = {
				name = "Neon",
				text = {
					"Passively provides",
					"{C:attention}X#1#{} Shop Costs"
				},
			},
			e_entr_lowres = {
				name = "Low-Res",
				text = {
					"{C:attention}Retrigger{} this cards {C:attention}#1#{} times",
					"{C:attention}X#2#{} Card values {C:inactive}(If Possible){}"
				},
			},
			e_entr_kaleidoscopic = {
				name = "Kaleidoscopic",
				text = {
					"Retrigger {C:attention}#1#{} random",
					"cards in this cards area"
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
								"Gain {X:dark_edition,C:white}Entropy{} when playing",
								"Editioned/Enhanced cards, secret hands or",
								"using consumables. {C:entr_entropic}Beyond{}, {C:cry_exotic}Gateway{}",
								"and {C:spectral}Spectral Packs{} show up more often",
								"chips are lowered based on {X:dark_edition,C:white}Entropy{}"
						}
			},
			b_entr_crafting = {
				name = "Deck of Destiny",
				text =  {
					"Jokers may no longer appear naturally",
					"Start with an {C:dark_edition}Aleph, Negative{} Destiny",
					"Cards have a higher chance to be Enhanced"
				}
			},
			b_entr_butterfly = {
				name = "Butterfly Deck",
				text =  {
					"{C:attention}-2{} Joker Slots",
					"Sold Jokers have a {C:green}#1# in 2{}",
					"chance to still trigger"
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
			},
			b_entr_gemstone = {
				name = "Gemstone Deck",
				text =  {
					"Non Rune Consumables have a {C:green}1 in 3{}",
					"chance to {C:red}fail{}, create a",
					"random {C:purple}Rune Card{} every",
					"{C:attention}2{} Non Rune Consumables used"
				}
			},
			b_entr_corrupted = {
				name = "Corrupted Deck",
				text =  {
					"{C:attention}Jokers{} and {C:attention}Consumables{}",
					"Cycle between {C:attention}3{} options"
				}
			},
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
					"Gain {X:dark_edition,C:white}Entropy{} when playing",
					"Editioned/Enhanced cards, secret hands or",
					"using consumables. {C:entr_entropic}Beyond{}, {C:cry_exotic}Gateway{}",
					"and {C:spectral}Spectral Packs{} show up more often",
					"chips are lowered based on {X:dark_edition,C:white}Entropy{}"
				}
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
			sleeve_entr_crafting = {
				name = "Sleeve of Fate",
				text =  {
					"Jokers may no longer appear naturally",
					"Start with an {C:dark_edition}Aleph, Negative{} Destiny",
					"Cards have a higher chance to be Enhanced"
				}
			},
			sleeve_entr_butterfly = {
				name = "Butterfly Sleeve",
				text =  {
					"{C:attention}-2{} Joker Slots",
					"Sold Jokers have a {C:green}#1# in 2{}",
					"chance to still trigger"
				}
			},
			sleeve_entr_gemstone  = {
				name = "Gemstone Sleeve",
				text = {
					"Non Rune Consumables have a {C:green}1 in 3{}",
					"chance to {C:red}fail{}, create a",
					"random {C:purple}Rune Card{} every",
					"{C:attention}2{} Non Rune Consumables used"
				},
			},
			sleeve_entr_corrupted = {
				name = "Corrupted Sleeve",
				text =  {
					"{C:attention}Jokers{} and {C:attention}Consumables{}",
					"Cycle between {C:attention}2{} options"
				}
			},
		},
		Fraud = {
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
					"of up to #3# selected card#<s>3#"
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
					"debuff it for {C:attention}#3#{} rounds"
				}
			},
			c_entr_scar = {
				name = "The Scar",
				text = {
					"Apply a {C:dark_edition}Scarred{} sticker",
					"to up to {C:attention}#1#{} selected card#<s>1#",
					"selected in hand"
				}
			},
			c_entr_dagger = {
				name = "The Dagger",
				text = {
					"Destroy {C:attention}#1#{} selected Playing Card#<s>1#",
					"and add {X:dark_edition,C:white}X#2#{} the chips",
					"to your {C:attention}most played{} hand's chips"
				}
			},
			c_entr_penumbra = {
				name = "Penumbra",
				text = {
					"Banish the enhancement of {C:attention}#1#{}",
					"selected card#<s>1# in hand",
					"then {C:attention}destroy{} the selected card#<s>1#"
				}
			},
			c_entr_integrity = {
				name = "Integrity",
				text = {
					"Remove the {C:attention}enhancement#<s>1#{} of",
					"{C:attention}#1#{} selected card#<s>1# then",
					"add a random {C:dark_edition}seal and edition{}"
				}
			},
			c_entr_forgiveness = {
				name = "Forgiveness",
				text = {
					"Create a random {C:attention}previously sold{} Joker",
					"{C:inactive}(May overflow){}"
				}
			},
			c_entr_feud = {
				name = "The Feud",
				text = {
					"Select {C:attentiom}#1#{} card#<s>1#",
					"Add {X:chips,C:white}X#3#{} the {C:attention}right{} cards {C:blue}chips{}",
					"to the {C:attention}left{} card then",
					"{C:attention}destroy{} the right card#<s>2#"
				}
			},
			c_entr_advisor = {
				name = "The Advisor",
				text = {
					"Create a {C:attention}temporary{} copy",
					"of your most played hands {C:attention}example{}",
					"and {C:attention}draw{} it to hand"
				}
			},
			c_entr_heretic = {
				name = "The Heretic",
				text = {
					"Randomize one {C:attention}aspect{} or {C:attention}modification{}",
					"of up to {C:attention}#1#{} selected card#<s>1#",
					"held in hand"
				}
			},
			c_entr_earl = {
				name = "The Earl",
				text = {
					"Lose all but {C:attention}1{}",
					"Discard and Hand for the next round",
					"Gain {C:money}Money{} based on how many taken",
					"{C:inactive}(Currently: {C:money}$#1#{C:inactive})"
				}
			},
			c_entr_mason = {
				name = "The Mason",
				text = {
					"Create {C:attention}#1# Stone{} card#<s>1#",
					"with a random {C:attention}edition{}"
				}
			},
			c_entr_princess = {
				name = "The Princess",
				text = {
					"For the {C:attention}remainder{} of the {C:attention}current{} ante",
					"{C:planet}Planet{} cards are replaced by {C:purple}Star{} cards"
				}
			},
			c_entr_imp = {
				name = "The Imp",
				text = {
					"Enhance {C:attention}#1#{} Selected card#<s>1#",
					"into {C:attention}Dark{} Cards"
				}
			},
			c_entr_oracle = {
				name = "The Oracle",
				text = {
					"Enhance {C:attention}#1#{} random card#<s>1# held in",
					"hand into {C:attention}Editioned{} {C:purple}CCD Star{} Cards"
				}
			},
			c_entr_ocean = {
				name = "The Ocean",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}Diamonds",
					"{C:blue}+#4#{} Chips"
				}
			},
			c_entr_forest = {
				name = "The Forest",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}Clubs",
					"{C:blue}+#4#{} Chips"
				}
			},
			c_entr_mountain = {
				name = "The Mountain",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}Hearts",
					"{C:blue}+#4#{} Chips"
				}
			},
			c_entr_tent = {
				name = "The Tent",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}Spades",
					"{C:blue}+#4#{} Chips"
				}
			},
			c_entr_companion = {
				name = "The Companion",
				text = {
					"Raise the {C:attention}interest{} cap by {C:gold}#1##2#{}",
					"then gain {C:gold}money{} based on the interest cap"
				}
			},
			c_entr_prophecy = {
				name = "The Prophecy",
				text = {
					"The next {C:attention}#1#{} {C:red}Inverted{} card#<s>1#",
					"become the last used {C:red}Fraud{} card"
				}
			},
			c_entr_mallet = {
				name = "The Mallet",
				text = {
					"Destroy {C:attention}#1#{} random card#<s>1# in hand",
					"and create {C:attention}#1#{} random {C:red}Command{} card#<s>1#",
					"{C:inactive}(Must have room){}"
				}
			},
			c_entr_village = {
				name = "The Village",
				text = {
					"Give cards {C:attention}held{} in hand",
					"{C:blue}+#1#{} bonus chips"
				}
			},
			c_entr_frail = {
				name = "Frail",
				text = {
					"Destroy {C:attention}#1#{} selected card#<s>1#",
					"and {C:attention}distribute{} their modifications",
					"between {C:attention}other{} cards held in hand"
				}
			},
			c_entr_inferno = {
				name = "Inferno",
				text = {
					"Destroy {C:attention}all{} Selected Cards",
					"lost {C:money}$#1#{} for every card",
					"past {C:attention}2{}"
				}
			}
		},
		Planet = {
			c_entr_wormhole = {
				name = "Wormhole",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chip#<s>4#",
				},
			},
			c_entr_tyche = {
				name = "Tyche",
				text = {
					"Level up the {C:blue}Chips{} and {C:red}Mult{}",
					"per level of a {C:attention}random{} Poker Hand",
					"{C:mult}+#2#{} Mult per level and",
					"{C:chips}+#1#{} Chips per level"
				},
			},
			c_entr_theia = {
				name = "Theia",
				text = {
					"Level up the {C:blue}Chips{} and {C:red}Mult{}",
					"per level of your {C:attention}highest{}",
					"level Poker Hand",
					"{C:mult}+#2#{} Mult per level and",
					"{C:chips}+#1#{} Chips per level"
				},
			},
			c_entr_chiron = {
				name = "Chiron",
				text = {
					"Level up the {C:blue}Chips{} per level",
					"of a {C:attention}random{} Poker Hand",
					"{C:chips}X#1#{} Chips per level"
				},
			},
			c_entr_neith = {
				name = "Neith",
				text = {
					"Level up the {C:red}Mult{} per level",
					"of a {C:attention}random{} Poker Hand",
					"{C:mult}X#1#{} Mult per level"
				},
			},
			c_entr_sputnik = {
				name = "Sputnik I",
				text = {
					"Level up {C:attention}#1#{}",
					"random Poker Hands",
					"{C:mult}+???{} Mult and",
					"{C:chips}+???{} chips",
				},
			},
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
					"{C:attention}Celestial{} and {C:attention}Arcana{} Packs",
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

			v_entr_diviner = {
				name = "Diviner",
				text = {
					"The chance for {C:purple}Runes{} to",
					"show up in Booster Packs is increased"
				},
			},
			v_entr_providence = {
				name = "Providence",
				text = {
					"Runes have {C:purple,E:1}Enhanced{} effects",
				},
			},
			v_entr_ascension = {
				name = "Ascension",
				text = {
					"Copy the {C:attention}First",
					"used {C:purple}Rune{} each round"
				},
			},
		},
		Command = {
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
					"Create a {C:red}Glitched{} copy of",
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
					"previously in the {C:red}collection{}",
					"{C:inactive}(Currently: #2#){}"
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
			},
			c_entr_detour = {
				name = "(~)$ detour",
				text = {
					"Create a {C:attention}card, booster, or voucher{}",
					"with a type {C:attention}corresponding{} to the",
					"{C:attention}last obtained{} card, booster or voucher",
					"{C:inactive}(Currently: #1#){}"
				}
			},
			c_entr_mbr = {
				name = "(~)$ mbr",
				text = {
					"Add a {C:dark_edition}Banana Voucher Pack{}",
					"to the booster packs of the current shop"
				}
			},
			c_entr_desync = {
				name = "(~)$ desync",
				text = {
					"Apply a {C:red}Desync{} sticker to",
					"1 selected Joker or Consumable",
				}
			},
			c_entr_badarg = {
				name = "(~)$ bad arg*",
				text = {
					"{C:red}Stop{} a {C:attention}selected{} poker hand from {C:red}scoring{}",
					"or using up hands for the",
					"{C:attention}remainder{} of the run"
				}
			},
			c_entr_interpolate = {
				name = "(~)$ interpolate",
				text = {
					"Select and {C:red}Destroy{} #1# selected {C:attention}Joker#<s>1#{}",
					"or {C:attention}Consumable#<s>1#{}, This card may",
					"appear in future {C:red}Twisted{} or {C:cry_code}Program{} packs"
				}
			},
			c_entr_overload = {
				name = "(~)$ overload",
				text = {
					"The {C:attention}Next{} played hand",
					"counts as containing {C:red}all{}",
					"other hands"
				}
			},
			c_entr_echo = {
				name = "(~)$ echo",
				text = {
					"Select {C:attention}Two{} consumables",
					"Two {C:dark_edition}trigger{} each-others effects",
					"when they are used",
					"{C:inactive}(including from the shop){}"
				}
			},
		},
		Star = {
			c_entr_regulus = {
				name = "Proxima Centauri",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_hydrae = {
				name = "Alpha Centauri",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_vega = {
				name = "Polaris",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_polaris = {
				name = "Dabih",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_cassiopeiae = {
				name = "Capella",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_pegasi = {
				name = "Trappist-1",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_persei = {
				name = "Kepler-90",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_ophiuchi = {
				name = "55 Cancri",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_carinae = {
				name = "Betelgeuse",
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
				name = "W33A",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_sirius = {
				name = "Sirius",
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
				name = "Mizar",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_deadcore = {
				name = "Dead Core",
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
					"{C:inactive}(Currently {X:gold,C:white}#3#{C:inactive})",
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
			c_entr_chunk = {
				name = "Chunk",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"Level up",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"and {C:attention}#3#{}",
					"{C:gold}+#7#{} Ascension Power"
				},
			},
			c_entr_supernova = {
				name = "Collapse",
				text = {
					"Remove #1# {C:gold}Ascension Power{} from",
					"your {X:purple,C:white}Nemesis'{}",
					"highest {C:gold}Ascension Power{}",
					"{C:legendary,E:1}poker hand{}",
				},
			},
			c_entr_pocket_dimension = {
				name = "Pocket Dimension",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} Level up",
					"{C:attention}#3#",
					"{C:gold}+#4#{} Ascension Power"
				}
			},
			c_entr_black_dwarf = {
				name = "Black Dwarf",
				text = {
					"Level up {C:gold}Ascension Power{}",
					"Per Level of all Poker Hands",
					"{C:gold}+#1#{} Ascension Power"
				}
			},
			c_entr_frozen_star = {
				name = "Frozen Star",
				text = {
					"Level up your {C:attention}highest{} level",
					"Poker Hand {C:gold}+#1#{} Ascension Power"
				}
			},
			c_entr_coatlicue = {
				name = "Coatlicue",
				text = {
					"Level up a {C:attention}random{} Poker Hands",
					"{C:gold}Ascension Power{} by {C:attention}1/20{}th",
					"of its {C:chips}Chips{} per Level"
				}
			},
			c_entr_threefour = {
				name = "34 Tauri",
				text = {
					"Level up a {C:attention}random{} Poker Hands",
					"{C:gold}Ascension Power{} by {C:attention}1/3{}th",
					"of its {C:mult}Mult{} per Level"
				}
			},
			c_entr_fuzzball = {
				name = "Fuzzball",
				text = {
					"Level up {C:attention}#1#{}",
					"random Poker Hands",
					"{C:gold}+#2#{} Ascension Power",
				}
			},
		},
		Omen = {
			c_entr_rift = {
				name = "Rift",
				text = {
					"Apply a {C:attention}random{} {C:dark_edition}Edition{}",
					"to {C:attention}#1#{} selected card#<s>1#"
				}
			},
			c_entr_define = {
				name = "#1#define",
				text = {
					"Replace all future instances of",
					"a {C:entr_omen}selected card{} with",
					"a card of {C:entr_omen}your choice{}",
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
					"Destroy all other held Jokers"
				}
			},
			c_entr_fervour={
                name="Fervour",
                text={
                    "Create a",
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

			c_entr_dispel = {
				name = "Dispel",
				text = {
					"Banish {C:attention}#1#{} selected Joker#<s>1#",
					"{C:inactive}(Bypasses Eternal){}"
				}
			},
			c_entr_weld = {
				name = "Weld",
				text = {
					"Apply {C:dark_edition}Negative{} and {C:purple,E:1}Aleph{}",
					"to #1# selected Joker#<s>1#"
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
					"Add a {V:1}Silver Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_rendezvous = {
				name = "Rendezvous",
				text = {
					"Add a {V:1}Crimson Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_eclipse = {
				name = "Veil",
				text = {
					"Add a {V:1}Sapphire Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_calamity = {
				name = "Calamity",
				text = {
					"Add a {V:1}Pink Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_downpour = {
				name = "Downpour",
				text = {
					"Add a {V:1}Cerulean Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_script = {
				name = "Script",
				text = {
					"Add a {V:1}Verdant Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_inscribe = {
				name = "Inscribe",
				text = {
					"Multiply the {C:attention}base{} Chips",
					"of number cards in hand by {X:chips,C:white}X#1#{}",
					"then {C:attention}debuff{} all number cards",
					"in hand for 1 round"
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
					"Debuff {C:attention}all{} Jokers for {C:attention}#2#{} rounds",
					"then give {X:gold,C:white}X#1#{} their buy",
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
				name = "Bind",
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
					"and debuff it for {C:attention}#2#{} rounds"
				}
			},
			c_entr_charm = {
				name = "Charm",
				text = {
					"Apply {C:attention}Kaleidoscopic{} and",
					"{C:attention}Eternal{} to a selected Joker",
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
					"selected card's type"
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
					"{C:inactive}(Doesn't remove Aleph){}"
				}
			},
			c_entr_purity = {
				name = "Purity",
				text = {
					"Apply a {C:dark_edition}Pure{} sticker to",
					"{C:attention}#1#{} selected joker#<s>1#"
				}
			},
			c_entr_transcend = {
				name = "Transcend",
				text = {
					"Convert {C:attention}#1#{} selected card#<s>1#",
					"to a {C:attention}random{} {C:red}object{}"
				}
			},
			c_entr_malediction = {
				name = "Malediction",
				text = {
					"Add an {V:1}Amber Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_serpents = {
				name = "Pact of Serpents",
				text = {
					"Create a random {C:attention}Rare{} Consumable",
					"{C:inactive}(May overflow){}"
				}
			},

			c_entr_splinter = {
				name = "Splinter",
				text = {
					"One {C:attention}random{} card in full deck",
					"becomes a random {C:attention}Shattered{} Joker"
				}
			},
			c_entr_dream = {
				name = "Dream",
				text = {
					"Draw {C:attention}#1#{} random",
					"{C:attention}Enhanced{} {C:purple}Eye#<s>1#{}",
					"to hand"
				}
			},
			c_entr_void = {
				name = "Void",
				text = {
					"Add a {V:1}Mini Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_sharpen = {
				name = "Sharpen",
				text = {
					"Add a {V:1}Sharp Seal{}",
					"to #1# selected card",
				}
			},
			c_entr_singularity = {
				name = "Singularity",
				text = {
					"Add an {V:1}Vantablack Seal{}",
					"to #1# selected card",
				}
			},
		},
		Transient = {
			c_entr_cage = {
				name = "Cage",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then change their suit into the",
					"{C:attention}leftmost{} Selected Card's suit"
				}
			},
			c_entr_implode = {
				name = "Implode",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then turn them into {C:attention}Ace of Nils{}"
				}
			},
			c_entr_meteor = {
				name = "Meteor",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} random Card#<s>1# in hand",
					"Then give them {C:purple}Sapphire{} Seals"
				}
			},
			c_entr_concentrate = {
				name = "Concentrate",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}All{} Selected Cards",
					"Then copy them to hand"
				}
			},
			c_entr_pyrite = {
				name = "Pyrite",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then turn them into {C:attention}Gold Cards{}"
				}
			},
			c_entr_set = {
				name = "Set",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then change their rank into the",
					"{C:attention}leftmost{} Selected Card's rank"
				}
			},
			c_entr_trickster = {
				name = "Trickster",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then turn them into a",
					"random {C:red}Rare{} {C:attention}Joker{}"
				}
			},
			c_entr_sundial = {
				name = "Sundial",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then turn them into {C:attention}Glass Cards{}"
				}
			},
			c_entr_candle = {
				name = "Candle",
				text = {
					"{C:attention}+#1#{} Hand Size",
					"for this Blind"
				}
			},
			c_entr_faith = {
				name = "Faith",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then turn them into {C:attention}Lucky Cards{}"
				}
			},
			c_entr_oasis = {
				name = "Oasis",
				text = {
					"Apply {C:attention}Temporary{} to",
					"A Selected Card then",
					"Copy it {C:attention}#1#{} times"
				}
			},
			c_entr_ragtag = {
				name = "Ragtag",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then turn them into a",
					"random {C:blue}Common{} {C:attention}Joker{}"
				}
			},
			c_entr_burn = {
				name = "Burn",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} random Card#<s>1# in hand",
					"Then give them {C:purple}Pink{} Seals"
				}
			},
			c_entr_escape = {
				name = "Escape",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} random Card#<s>1# in hand",
					"Then randomize them"
				}
			},
			c_entr_gbdecay = {
				name = "Decay",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then turn them into {C:attention}Steel Cards{}"
				}
			},
			c_entr_visage = {
				name = "Visage",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then turn them into {C:attention}Stone Cards{}"
				}
			},
			c_entr_nebula = {
				name = "Nebula",
				text = {
					"Create {C:attention}#1#{} Random",
					"{C:attention}Temporary{} Blind Tokens"
				}
			},
			c_entr_essence = {
				name = "Essence",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} Selected Card#<s>1#",
					"Then turn them into {C:attention}Random{}",
					"suited Kings"
				}
			},
			c_entr_manifest = {
				name = "Manifest",
				text = {
					"{C:attention}+#1#{} Selection Limit",
					"for this Blind"
				}
			},
			c_entr_hope = {
				name = "Hope",
				text = {
					"Apply {C:attention}Temporary{} to",
					"{C:attention}#1#{} random Card#<s>1# in hand",
					"Then give them {V:1}Silver{} Seals"
				}
			},
		},
		Tarot = {
			c_entr_kiln = {
				name = "Kiln",
				text = {
					"Enhances {C:attention}#1#{} selected",
					"card#<s>1# into a",
					"{C:attention}Ceramic Card{}"
				}
			},
			c_entr_comet = {
				name = "The Comet",
				text = {
					"Enhances {C:attention}#1#{} selected",
					"card#<s>1# into a",
					"{C:attention}Radiant Card{}"
				}
			},
		},
		Spectral = {
			c_entr_flipside = {
				name = "Flipside",
				text = {
					"Convert {C:attention}#1#{} selected consumable#<s>1#",
					"Into an {C:red}Inverted{} variant",
				}
			},
			c_entr_destiny = {
				name = "Destiny",
				text = {
					"Sacrifice {C:attention}5{} playing cards to craft",
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
			c_entr_lust = {
				name = "Lust",
				text = {
					"Apply {C:dark_edition}Freaky{} to",
					"{C:attention}#1#{} selected cards in hand",
				}
			},
			c_entr_null = {
				name = "Null",
				text = {
					"Destroy {C:attention}1{} random card ",
					"in your hand, add {C:attention}#1#{}",
					"random {C:attention}Enhanced Nil of Nil{}",
					"card#<s>1# to your hand",
				}
			},
			c_entr_antithesis = {
				name = "Antithesis",
				text = {
					"Toggle {C:purple,E:1}Eternal{}",
					"for {C:attention}all{} held Jokers"
				}
			},
			c_entr_oss = {
				name = "Rune of Oss",
				text = {
					"The next opened {C:attention}Booster Pack{}",
					"will contain a {C:purple}Rare{} consumable",
					"{C:inactive}(If Possible)"
				}
			},
			c_entr_oss_providence = {
				name = "Rune of Oss{C:purple}+{}",
				text = {
					"The next opened {C:attention}Booster Pack{}",
					"will contain a {C:purple}Rare{} consumable",
					"and a {C:purple}Rune{} is {C:purple,E:1}Generated{} when this occurs",
					"{C:inactive}(If Possible)"
				}
			},
			c_entr_enchant = {
				name = "Enchant",
				text = {
					"Add an {C:purple}Ornate Seal{}",
					"to {C:attention}#1#{} selected",
					"card in your hand"
				}
			},
		},
		Stake = {
			stake_entr_copper = {
				name = "Copper Stake",
				text = {
					"{C:attention}Copied{} playing cards may become {C:red}Disavowed{}",
					"{s:0.8}Applies all previous Stakes",
				},
			},
			stake_entr_platinum = {
				name = "Platinum Stake",
				text = {
					"Jokers cost {C:red}20%{} more",
					"{s:0.8}Applies all previous Stakes",
				},
			},
			stake_entr_meteorite = {
				name = "Meteorite Stake",
				text = {
					"Hand leveling may {C:red}fail{}",
					"{s:0.8}Applies all previous Stakes",
				},
			},
			stake_entr_obsidian = {
				name = "Obsidian Stake",
				text = {
					"Always obtain a {C:red}Curse{} when",
					"defeating the Boss Blind",
					"{s:0.8}Applies all previous Stakes",
				},
			},
			stake_entr_iridium = {
				name = "Iridium Stake",
				text = {
					"Win Ante is {C:red}10{}",
					"{s:0.8}Applies all previous Stakes",
					"{s:0.7}Trans Rights",
				},
			},
			stake_entr_zenith = {
				name = "Zenith Stake",
				text = {
					"{E:1,C:entr_zenith}All Blinds are Endless Entropy{}",
					"{s:0.8}Applies all previous Stakes",
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

			tag_entr_neon = {
				name = "Neon Tag",
				text = { 
					"Next base Edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Neon{}"	
				},
			},

			tag_entr_lowres = {
				name = "Low-Res Tag",
				text = { 
					"Next base Edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Low-Res{}"	
				},
			},
			tag_entr_kaleidoscopic = {
				name = "Kaleidoscopic Tag",
				text = { 
					"Next base Edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Kaleidoscopic{}"	
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
				name = "{C:gold}Voucher Tag{}",
				text = { "Adds one Tier {C:attention}3{} Voucher", "to the next shop" },
			},
			tag_entr_ascendant_voucher_cryptidless = {
				name = "{C:gold}Voucher Tag{}",
				text = { "Adds {C:attention}Two{} Vouchers", "to the next shop" },
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
				text = { "{C:attention}All{} shop items are {C:dark_edition}Jolly{}", "{C:inactive}M{}" },
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

			tag_entr_ascendant_neon = {
				name = "{C:gold}Neon Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Neon{}" },
			},
			tag_entr_ascendant_lowres = {
				name = "{C:gold}Low-Res Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Low-Res{}" },
			},
			tag_entr_ascendant_kaleidoscopic = {
				name = "{C:gold}Kaleidoscopic Tag{}",
				text = { "{C:attention}All{} shop items are {C:dark_edition}Kaleidoscopic{}" },
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
				text = {"Creates a {C:attention}Console Tag{}, {C:attention}Ethereal Tag{},",
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
			tag_entr_arcane = {
				name = "Arcane Tag",
				text = {
					"Obtain a random {C:purple}Rune{}"
				},
			},
			tag_entr_ascendant_arcane = {
				name = "{C:gold}Arcane Tag{}",
				text = {
					"Obtain {C:attention}Two{} random {C:purple}Runes{}"
				},
			},
		},
		["Rune Tag"] = {
			rune_entr_fehu = {
				name = "Fehu",
				text = {
					"The next {C:attention}sold{} card",
					"adds {C:attention}Half{} its sell",
					"value to your Jokers"
				}
			},
			rune_entr_fehu_providence = {
				name = "Fehu{C:purple}+{}",
				text = {
					"The next {C:attention}sold{} card",
					"adds its {C:purple,E:1}Full{} sell",
					"value to your Jokers"
				}
			},
			rune_entr_uruz = {
				name = "Uruz",
				text = {
					"Increases the next",
					"{C:attention}payout{} by {X:gold,C:white}50%{}",
					"{C:inactive}(Stacks additively){}"
				}
			},
			rune_entr_uruz_providence = {
				name = "Uruz{C:purple}+{}",
				text = {
					"Increases the next",
					"{C:attention}payout{} by {X:purple,C:white,E:1}100%{}",
					"{C:inactive}(Stacks additively){}"
				}
			},
			rune_entr_thurisaz = {
				name = "Thurisaz",
				text = {
					"Copies the next",
					"{C:attention}discarded{} card"
				}
			},
			rune_entr_thurisaz_providence = {
				name = "Thurisaz{C:purple}+{}",
				text = {
					"Copies the next",
					"{C:attention}discarded{} card {C:purple,E:1}Twice{}"
				}
			},
			rune_entr_ansuz = {
				name = "Ansuz",
				text = {
					"Copies the next",
					"{C:attention}obtained{} tag or rune"
				}
			},
			rune_entr_ansuz_providence = {
				name = "Ansuz{C:purple}+{}",
				text = {
				"Copies the next",
					"{C:attention}obtained{} tag or rune {C:purple,E:1}Twice{}"
				}
			},
			rune_entr_raido = {
				name = "Raido",
				text = {
					"Prevents the next",
					"change of Ante",
				}
			},
			rune_entr_raido_providence = {
				name = "Raido{C:purple}+{}",
				text = {
					"{C:purple,E:1}Inverts{} the next",
					"change of Ante",
				}
			},
			rune_entr_kaunan = {
				name = "Kaunan",
				text = {
					"Levels up the",
					"next {C:attention}played{} hand"
				}
			},
			rune_entr_kaunan_providence = {
				name = "Kaunan{C:purple}+{}",
				text = {
					"Levels up the",
					"next {C:attention}played{} hand",
					"{C:purple,E:1}Twice{}"
				}
			},
			rune_entr_gebo = {
				name = "Gebo",
				text = {
					"Creates a card of",
					"the same type as the",
					"next {C:attention}sold{} card",
					"{C:inactive}(Must have room){}"
				}
			},
			rune_entr_gebo_providence = {
				name = "Gebo{C:purple}+{}",
				text = {
					"Creates a card of",
					"the same type as the",
					"next {C:attention}sold{} card",
					"{C:purple,E:1}(May Overflow){}"
				}
			},

			rune_entr_wunjo = {
				name = "Wunjo",
				text = {
					"Creates a {C:attention}random{} {C:purple}Rune{}",
					"when the next consumable",
					"is used"
				}
			},
			rune_entr_wunjo_providence = {
				name = "Wunjo{C:purple}+{}",
				text = {
					"Creates {C:purple}2{} {C:attention}random{} {C:purple}Runes{}",
					"when the next consumable",
					"is used"
				}
			},

			rune_entr_haglaz = {
				name = "Haglaz",
				text = {
					"{C:red}Destroys{} the next",
					"played hand"
				}
			},
			rune_entr_haglaz_providence = {
				name = "Haglaz{C:purple}+{}",
				text = {
					"{C:red}Destroys{} the next",
					"played or {C:purple,E:1}discarded{} hand"
				}
			},

			rune_entr_naudiz = {
				name = "Naudiz",
				text = {
					"Next item can",
					"be bought {C:attention}regardless{}",
					"of your current money"
				}
			},
			rune_entr_naudiz_providence = {
				name = "Naudiz{C:purple}+{}",
				text = {
					"Next item can",
					"be bought {C:attention}regardless{}",
					"of your current money",
					"{C:purple,E:1}Obtain no debt from this{}"
				}
			},

			rune_entr_isaz = {
				name = "Isaz",
				text = {
					"Adds an additional",
					"{C:attention}Voucher{} to the",
					"next shop"
				}
			},
			rune_entr_isaz_providence = {
				name = "Isaz{C:purple}+{}",
				text = {
					"Adds an additional",
					"{C:purple,E:1}Half Price{} {C:attention}Voucher{} to",
					"the next shop"
				}
			},

			rune_entr_jera = {
				name = "Jera",
				text = {
					"Copies the next",
					"{C:attention}used{} Consumable"
				}
			},
			rune_entr_jera_providence = {
				name = "Jera{C:purple}+{}",
				text = {
					"Copies the next",
					"{C:attention}used{} Consumable",
					"{C:purple,E:1}Twice{}"
				}
			},

			rune_entr_ihwaz = {
				name = "Ihwaz",
				text = {
					"Randomizes one aspect of",
					"the next {C:attention}played{} card"
				}
			},
			rune_entr_ihwaz_providence = {
				name = "Ihwaz{C:purple}+{}",
				text = {
					"{C:purple,E:1}Fully{} Randomizes",
					"the next {C:attention}played{} card"
				}
			},

			rune_entr_perthro = {
				name = "Perthro",
				text = {
					"Restocks {C:attention}Booster Packs{}",
					"on the next {C:attention}reroll{}"
				}
			},
			rune_entr_perthro_providence = {
				name = "Perthro{C:purple}+{}",
				text = {
					"Restocks {C:attention}Booster Packs{}",
					"and grants {C:purple,E:1}+1{} temporary",
					"shop slot on the next {C:attention}reroll{}"
				}
			},

			rune_entr_algiz = {
				name = "Algiz",
				text = {
					"Prevents the next {C:red}Death{}",
					"and grants {C:money}$5{} when this occurs"

				}
			},
			rune_entr_algiz_providence = {
				name = "Algiz{C:purple}+{}",
				text = {
					"Prevents the next {C:red}Death{}",
					"and grants {C:purple,E:1}$10{} when this occurs"
				}
			},

			rune_entr_sowilo = {
				name = "Sowilo",
				text = {
					"Gives the next {C:attention}discarded{} hand",
					"{C:gold}+2{} Ascension Power"

				}
			},
			rune_entr_sowilo_providence = {
				name = "Sowilo{C:purple}+{}",
				text = {
					"Gives the next {C:attention}discarded{} hand",
					"{C:purple,E:1}+4{} Ascension Power"
				}
			},

			rune_entr_tiwaz = {
				name = "Tiwaz",
				text = {
					"Randomly {C:attention}modifies{}",
					"the next {C:attention}drawn card{}"

				}
			},
			rune_entr_tiwaz_providence = {
				name = "Tiwaz{C:purple}+{}",
				text = {
					"Randomly {C:attention}modifies{}",
					"the next {C:attention}drawn card{}",
					"{C:purple,E:1}Twice{}"
				}
			},

			rune_entr_berkano = {
				name = "Berkano",
				text = {
					"Creates {C:attention}Two{} copies",
					"of the next {C:red}Destroyed{} card"

				}
			},
			rune_entr_berkano_providence = {
				name = "Berkano{C:purple}+{}",
				text = {
					"Creates {C:purple,E:1}Three{} copies",
					"of the next {C:red}Destroyed{} card"
				}
			},

			rune_entr_ehwaz = {
				name = "Ehwaz",
				text = {
					"Gives access to a {C:attention}Payout{} and a {C:attention}Shop{}",
					"on the next {C:attention}skipped{} Blind"

				}
			},
			rune_entr_ehwaz_providence = {
				name = "Ehwaz{C:purple}+{}",
				text = {
					"Gives access to a {C:attention}Payout{} and a {C:attention}Shop{}",
					"with {C:purple,E:1}+1{} Shop Slot",
					"on the next {C:attention}skipped{} Blind"
				}
			},

			rune_entr_mannaz = {
				name = "Mannaz",
				text = {
					"Adds a {C:spectral}Spectral{} Card to",
					"the next {C:attention}opened{} Booster Pack"

				}
			},
			rune_entr_mannaz_providence = {
				name = "Mannaz{C:purple}+{}",
				text = {
					"Adds {C:purple,E:1}Two{} {C:spectral}Spectral{} Cards to",
					"the next {C:attention}opened{} Booster Pack"
				}
			},

			rune_entr_laguz = {
				name = "Laguz",
				text = {
					"Refunds the next {C:attention}discard{}"
				}
			},
			rune_entr_laguz_providence = {
				name = "Laguz{C:purple}+{}",
				text = {
					"Refunds the next {C:attention}discard{}",
					"and temporarily gives {C:purple,E:1}+1{} Hand"
				}
			},

			rune_entr_ingwaz = {
				name = "Ingwaz",
				text = {
					"The next {C:attention}probability{} roll",
					"will {C:green}succeed{}"
				}
			},
			rune_entr_ingwaz_providence = {
				name = "Ingwaz{C:purple}+{}",
				text = {
					"The next {C:attention}probability{} roll",
					"will {C:green}succeed{} with a",
					"{C:purple,E:1}33%{} chance to not consume",
					"this rune when triggered"
				}
			},

			rune_entr_dagaz = {
				name = "Dagaz",
				text = {
					"Inverts the next",
					"{C:attention}obtained{} Consumable"
				}
			},
			rune_entr_dagaz_providence = {
				name = "Dagaz{C:purple}+{}",
				text = {
					"Inverts the next",
					"{C:attention}obtained{} Consumable",
					"{C:purple,E:1}Create{} a random inverted",
					"consumable when this occurs",
					"{C:inactive}(Must have room){}"
				}
			},

			rune_entr_othila = {
				name = "Othila",
				text = {
					"The next {C:attention}sold{} card gives",
					"{X:gold,C:white}X3{} as much money"
				}
			},
			rune_entr_othila_providence = {
				name = "Ohtila{C:purple}+{}",
				text = {
					"The next {C:attention}sold{} card gives",
					"{X:purple,C:white,E:1}X5{} as much money"
				}
			},

			rune_entr_oss = {
				name = "Oss",
				text = {
					"The next opened {C:attention}Booster Pack{}",
					"will contain a {C:purple}Rare{} consumable",
					"{C:inactive}(If Possible)"
				}
			},
			rune_entr_oss_providence = {
				name = "Oss{C:purple}+{}",
				text = {
					"The next opened {C:attention}Booster Pack{}",
					"will contain a {C:purple}Rare{} consumable",
					"and a {C:purple}Rune{} is {C:purple,E:1}Generated{} when this occurs",
					"{C:inactive}(If Possible)"
				}
			},
			--pacts
			rune_entr_avarice = {
				name = "Mark of Avarice",
				text = {
					{
						"Marked by {C:red}Avarice{}"
					},
					{
						"All sell values are {C:red}0{}"
					}
				}
			},
			rune_entr_rage = {
				name = "Mark of Rage",
				text = {
					"Marked by {C:red}Rage{}"
				}
			},
			rune_entr_thorns = {
				name = "Mark of Thorns",
				text = {
					"Marked by {C:red}Thorns{}"
				}
			},
			rune_entr_denial = {
				name = "Mark of Denial",
				text = {
					"Marked by {C:red}Thorns{}"
				}
			},
			rune_entr_chains = {
				name = "Mark of Chains",
				text = {
					{
						"Marked by {C:red}Chains{}"
					},
					{
						"Retrigger all {C:attention}Eternal{} Playing Cards",
						"The first {C:attention}drawn{} card each round becomes {C:attention}Eternal{}"
					}
				}
			},
			rune_entr_decay = {
				name = "Mark of Decay",
				text = {
					"Marked by {C:red}Decay{}"
				}
			},
			rune_entr_envy = {
				name = "Mark of Envy",
				text = {
					{
						"Marked by {C:red}Envy{}"
					},
					{
						"Retrigger a {C:attention}random{} Joker",
						"Which {C:attention}changes{} every round"
					}
				}
			},
			rune_entr_youth = {
				name = "Mark of Youth",
				text = {
					"Marked by {C:red}Youth{}"
				}
			},
			rune_entr_shards = {
				name = "Mark of Shards",
				text = {
					{
						"Marked by {C:red}Shards{}"
					},
					{
						"Playing card {C:red}destruction{}",
						"may {C:red}fail{}"
					}
				}
			},
			rune_entr_desire = {
				name = "Mark of Desire",
				text = {
					{
						"Marked by {C:red}Desire{}"
					},
					{
						"{C:attention}Booster Packs{} are",
						"more {C:red}Expensive{}"
					}
				}
			},
			rune_entr_ice = {
				name = "Mark of Ice",
				text = {
					{
						"Marked by {C:red}Ice{}"
					},
					{
						"Your most {C:attention}levelled{} hand",
						"{C:red}cannot{} change levels"
					}
				}
			},
			rune_entr_gluttony = {
				name = "Mark of Gluttony",
				text = {
					{
						"Marked by {C:red}Gluttony{}"
					},
					{
						"{C:red}All{} Consumables are {C:attention}Eternal"
					}
				}
			},
			rune_entr_rebirth = {
				name = "Mark of Rebirth",
				text = {
					{
						"Marked by {C:red}Rebirth{}"
					},
					{
						"Playing Cards are {C:attention}Duplicated{}",
						"instead of being {C:red}Destroyed{}"
					}
				}
			},
			rune_entr_despair = {
				name = "Mark of Despair",
				text = {
					"Marked by {C:red}Despair{}"
				}
			},
			rune_entr_strength = {
				name = "Mark of Strength",
				text = {
					"Marked by {C:red}Strength{}"
				}
			},			
			rune_entr_darkness = {
				name = "Mark of Darkness",
				text = {
					{
						"Marked by {C:red}Darkness{}"
					},
					{
						"Playing Cards may be",
						"drawn Face {C:red}Down{}"
					}
				}
			},
			rune_entr_freedom = {
				name = "Mark of Freedom",
				text = {
					"Marked by {C:red}Freedom{}"
				}
			},
			rune_entr_eternity = {
				name = "Mark of Eternity",
				text = {
					"Marked by {C:red}Eternity{}"
				}
			},
			rune_entr_loyalty = {
				name = "Mark of Loyalty",
				text = {
					{
						"Marked by {C:red}Loyalty{}"
					},
					{
						"Interest Rate is now every {C:money}$4{}",
						"{X:mult,C:white}X0.5{} Mult every other hand"
					}
				}
			},
			rune_entr_brimstone = {
				name = "Mark of Brimstone",
				text = {
					{
						"Marked by {C:red}Brimstone{}"
					},
					{
						"{X:mult,C:white}X3.6{} Mult after hand played"
					}
				}
			},
			rune_entr_dreams = {
				name = "Mark of Dreams",
				text = {
					{
						"Marked by {C:red}Dreams{}"
					},
					{
						"Small Blinds give no {C:attention}Reward{}"
					}
				}
			},
			rune_entr_energy = {
				name = "Mark of Energy",
				text = {
					"Marked by {C:red}Energy{}"
				}
			},
			rune_entr_blood = {
				name = "Blood of Blood",
				text = {
					"Marked by {C:red}Blood{}"
				}
			},
			rune_entr_awakening = {
				name = "Blood of Awakening",
				text = {
					"Marked by {C:red}Awakening{}"
				}
			},
			rune_entr_serpents = {
				name = "Mark of Serpents",
				text = {
					"Marked by {C:red}Serpents{}",
					"{C:red,E:1,s:0.8}Your Fate is sealed{}"
				}
			},
		},
		Rune = {
			c_entr_fehu = {
				name = "Rune of Fehu",
				text = {
					"The next {C:attention}sold{} card",
					"adds {C:attention}Half{} its sell",
					"value to your Jokers"
				}
			},
			c_entr_fehu_providence = {
				name = "Rune of Fehu{C:purple}+{}",
				text = {
					"The next {C:attention}sold{} card",
					"adds its {C:purple,E:1}Full{} sell",
					"value to your Jokers"
				}
			},
			c_entr_uruz = {
				name = "Rune of Uruz",
				text = {
					"The next {C:attention}payout{} is",
					"increased by {X:gold,C:white}50%{}",
					"{C:inactive}(Stacks additively){}"
				}
			},
			c_entr_uruz_providence = {
				name = "Rune of Uruz{C:purple}+{}",
				text = {
					"The next {C:attention}payout{} is",
					"increased by {X:purple,C:white,E:1}100%{}",
					"{C:inactive}(Stacks additively){}"
				}
			},
			c_entr_thurisaz = {
				name = "Rune of Thurisaz",
				text = {
					"Create a {C:attention}copy{} of",
					"the next {C:attention}discarded{} card",
					"and draw it to {C:attention}hand{}"
				}
			},
			c_entr_thurisaz_providence = {
				name = "Rune of Thurisaz{C:purple}+{}",
				text = {
					"Create {C:purple,E:1}Two{} {C:attention}copies{} of",
					"the next {C:attention}discarded{} card",
					"and draw it to {C:attention}hand{}"
				}
			},
			c_entr_ansuz = {
				name = "Rune of Ansuz",
				text = {
					"Create a {C:attention}copy{} of",
					"the next {C:attention}obtained{} tag or rune",
				}
			},
			c_entr_ansuz_providence = {
				name = "Rune of Ansuz{C:purple}+{}",
				text = {
					"Create {C:purple,E:1}Two{} {C:attention}copies{} of",
					"the next {C:attention}obtained{} tag or rune",
				}
			},
			c_entr_raido = {
				name = "Rune of Raido",
				text = {
					"The next {C:attention}change{} in",
					"Ante is prevented"
				}
			},
			c_entr_raido_providence = {
				name = "Rune of Raido{C:purple}+{}",
				text = {
					"The next {C:attention}change{} in",
					"Ante is {C:purple,E:1}Inverted{}"
				}
			},
			c_entr_kaunan = {
				name = "Rune of Kaunan",
				text = {
					"Level up the",
					"next {C:attention}played{} hand"
				}
			},
			c_entr_kaunan_providence = {
				name = "Rune of Kaunan{C:purple}+{}",
				text = {
					"Level up the",
					"next {C:attention}played{} hand",
					"{C:purple,E:1}Twice{}"
				}
			},

			c_entr_gebo = {
				name = "Rune of Gebo",
				text = {
					"Creates a card of",
					"the same type as the",
					"next {C:attention}sold{} card",
					"{C:inactive}(Must have room){}"
				}
			},
			c_entr_gebo_providence = {
				name = "Rune of Gebo{C:purple}+{}",
				text = {
					"Creates a card of",
					"the same type as the",
					"next {C:attention}sold{} card",
					"{C:purple,E:1}(May Overflow){}"
				}
			},

			c_entr_wunjo = {
				name = "Rune of Wunjo",
				text = {
					"Create a {C:attention}random{} {C:purple}Rune{}",
					"when the next consumable",
					"is used"
				}
			},
			c_entr_wunjo_providence = {
				name = "Rune of Wunjo{C:purple}+{}",
				text = {
					"Create {C:purple}2{} {C:attention}random{} {C:purple}Runes{}",
					"when the next consumable",
					"is used"
				}
			},

			c_entr_haglaz = {
				name = "Rune of Haglaz",
				text = {
					"{C:red}Destroy{} the next",
					"played hand"
				}
			},
			c_entr_haglaz_providence = {
				name = "Rune of Haglaz{C:purple}+{}",
				text = {
					"{C:red}Destroy{} the next",
					"played or {C:purple,E:1}discarded{} hand"
				}
			},

			c_entr_naudiz = {
				name = "Rune of Naudiz",
				text = {
					"The next {C:attention}bought{} shop card",
					"can be bought {C:attention}regardless{} of",
					"your current money, sending",
					"you into {C:attention}debt{} if needed"
				}
			},
			c_entr_naudiz_providence = {
				name = "Rune of Naudiz{C:purple}+{}",
				text = {
					"The next {C:attention}bought{} shop card",
					"can be bought {C:attention}regardless{} of",
					"your current money",
					"{C:purple,E:1}without gaining any debt{}"
				}
			},

			c_entr_isaz = {
				name = "Rune of Isaz",
				text = {
					"The next {C:attention}shop{}",
					"contains an additional {C:attention}Voucher{}"
				}
			},
			c_entr_isaz_providence = {
				name = "Rune of Isaz{C:purple}+{}",
				text = {
					"The next {C:attention}shop{}",
					"contains an additional {C:attention}Voucher{}",
					"at {C:purple,E:1}Half Price{}"
				}
			},

			c_entr_jera = {
				name = "Rune of Jera",
				text = {
					"Create a {C:attention}copy{} of",
					"the next {C:attention}used{}",
					"Consumable"
				}
			},
			c_entr_jera_providence = {
				name = "Rune of Jera{C:purple}+{}",
				text = {
					"Create {C:purple,E:1}Two{} {C:attention}copies{} of",
					"the next {C:attention}used{}",
					"Consumable"
				}
			},
			c_entr_ihwaz = {
				name = "Rune of Ihwaz",
				text = {
					"Randomize one aspect of",
					"the next {C:attention}played{} card"
				}
			},
			c_entr_ihwaz_providence = {
				name = "Rune of Ihwaz{C:purple}+{}",
				text = {
					"{C:purple,E:1}Fully{} Randomize the",
					"next {C:attention}played{} card"
				}
			},

			c_entr_perthro = {
				name = "Rune of Perthro",
				text = {
					"Restock {C:attention}Booster Packs{}",
					"on the next {C:attention}reroll{}"
				}
			},
			c_entr_perthro_providence = {
				name = "Rune of Perthro{C:purple}+{}",
				text = {
					"Restock {C:attention}Booster Packs{}",
					"and {C:attention}temporarily{} grant",
					"{C:purple,E:1}+1{} Shop slots",
					"on the next {C:attention}reroll{}"
				}
			},

			c_entr_algiz = {
				name = "Rune of Algiz",
				text = {
					"Prevent the next {C:red}Death{}",
					"and grant {C:money}$5{} when this occurs"
				}
			},
			c_entr_algiz_providence = {
				name = "Rune of Algiz{C:purple}+{}",
				text = {
					"Prevent the next {C:red}Death{}",
					"and grant {C:purple,E:1}$10{} when this occurs"
				}
			},

			c_entr_sowilo = {
				name = "Rune of Sowilo",
				text = {
					"The next {C:attention}discarded{} hand",
					"gains {C:gold}+2{} Ascension Power"
				}
			},
			c_entr_sowilo_providence = {
				name = "Rune of Sowilo{C:purple}+{}",
				text = {
					"The next {C:attention}discarded{} hand",
					"gains {C:purple,E:1}+4{} Ascension Power"
				}
			},

			c_entr_tiwaz = {
				name = "Rune of Tiwaz",
				text = {
					"The next {C:attention}draw{} card",
					"gains a {C:attention}random{} modification"
				}
			},
			c_entr_tiwaz_providence = {
				name = "Rune of Tiwaz{C:purple}+{}",
				text = {
					"The next {C:attention}draw{} card",
					"gains {C:purple,E:1}Two{} {C:attention}random{} modification"
				}
			},

			c_entr_berkano = {
				name = "Rune of Berkano",
				text = {
					"Create {C:attention}Two{} copies of",
					"the next {C:red}Destroyed{} card"
				}
			},
			c_entr_berkano_providence = {
				name = "Rune of Berkano{C:purple}+{}",
				text = {
					"Create {C:purple,E:1}Three{} copies of",
					"the next {C:red}Destroyed{} card"
				}
			},

			c_entr_ehwaz = {
				name = "Rune of Ehwaz",
				text = {
					"Gives access to a {C:attention}Payout{} and a {C:attention}Shop{}",
					"on the next {C:attention}skipped{} Blind"
				}
			},
			c_entr_ehwaz_providence = {
				name = "Rune of Ehwaz{C:purple}+{}",
				text = {
					"Gives access to a {C:attention}Payout{} and a {C:attention}Shop{}",
					"with {C:purple,E:1}+1 Shop Slots{}",
					"on the next {C:attention}skipped{} Blind"
				}
			},

			c_entr_mannaz = {
				name = "Rune of Mannaz",
				text = {
					"The next {C:attention}opened{} Booster Pack",
					"will contain a {C:spectral}Spectral{} Card"
				}
			},
			c_entr_mannaz_providence = {
				name = "Rune of Mannaz{C:purple}+{}",
				text = {
					"The next {C:attention}opened{} Booster Pack",
					"will contain {C:purple,E:1}Two{} {C:spectral}Spectral{} Cards"
				}
			},

			c_entr_laguz = {
				name = "Rune of Laguz",
				text = {
					"The next {C:attention}discard{}",
					"is refunded"
				}
			},
			c_entr_laguz_providence = {
				name = "Rune of Laguz{C:purple}+{}",
				text = {
					"The next {C:attention}discard{}",
					"is refunded and temporarily",
					"gives {C:purple,E:1}+1{} Hands"
				}
			},

			c_entr_ingwaz = {
				name = "Rune of Ingwaz",
				text = {
					"The next {C:attention}probability{} roll",
					"will {C:green}succeed{}"
				}
			},
			c_entr_ingwaz_providence = {
				name = "Rune of Ingwaz{C:purple}+{}",
				text = {
					"The next {C:attention}probability{} roll",
					"will {C:green}succeed{} with a",
					"{C:purple,E:1}33%{} chance to not consume",
					"this rune when triggered"
				}
			},

			c_entr_dagaz = {
				name = "Rune of Dagaz",
				text = {
					"Invert the next",
					"{C:attention}obtained{} Consumable"
				}
			},
			c_entr_dagaz_providence = {
				name = "Rune of Dagaz{C:purple}+{}",
				text = {
					"Invert the next",
					"{C:attention}obtained{} Consumable and",
					"{C:purple,E:1}Create{} a random inverted",
					"consumable when this occurs",
					"{C:inactive}(Must have room){}"
				}
			},
			c_entr_othila = {
				name = "Rune of Othila",
				text = {
					"The next {C:attention}sold{} card gives",
					"{X:gold,C:white}X3{} as much money"
				}
			},
			c_entr_othila_providence = {
				name = "Rune of Othila{C:purple}+{}",
				text = {
					"The next {C:attention}sold{} card gives",
					"{X:purple,C:white,E:1}X5{} as much money"
				}
			},
		},
		Pact = {
			c_entr_avarice = {
				name = "Pact of Avarice",
				text = {
					"Duplicated your highest {C:attention}Sell Value{}",
					"Joker then set all {C:attention}Current{} and {C:attention}Future{}",
					"sell values to {C:red}0{}",
					"{C:inactive}(Must have room, Strips negative)"
				}
			},
			c_entr_rage = {
				name = "Pact of Rage",
				text = {
					"Randomly {C:red}destroy{} {C:attention}20%{}",
					"of your {C:attention}full{} Deck",
					"{C:inactive}(Minimum of 5)"
				}
			},
			c_entr_thorns = {
				name = "Pact of Thorns",
				text = {
					"Apply {C:attention}Rental{} to {C:attention}#1#{} Random Jokers",
					"then give them {C:attention}Random{} Editions"
				}
			},
			c_entr_denial = {
				name = "Pact of Denial",
				text = {
					"Create a {C:attention}copy{} of the last {C:attention}sold{} card",
					"then {C:red}banish{} that card",
					"{C:inactive}(Must have room){}"
				}
			},
			c_entr_chains = {
				name = "Pact of Chains",
				text = {
					"Retrigger all {C:attention}Eternal{} Playing Cards",
					"The first {C:attention}drawn{} card each round becomes {C:attention}Eternal{}"
				}
			},
			c_entr_decay = {
				name = "Pact of Decay",
				text = {
					"{C:red}Remove{} {C:attention}#1#{} Level from {C:attention}#2#{} random hands",
					"Your most played hand gains {C:attention}#3#{} Levels"
				}
			},
			c_entr_envy = {
				name = "Pact of Envy",
				text = {
					"{C:red}Destroy{} a {C:attention}Random{} Joker",
					"Retrigger a {C:attention}random{} Joker",
					"which changes each round"
				}
			},
			c_entr_youth = {
				name = "Pact of Youth",
				text = {
					"{C:attention}-#1#{} Ante",
					"A random Joker is {C:red}debuffed{}",
					"for {C:attention}#2#{} round#<s>2#"
				}
			},
			c_entr_shards = {
				name = "Pact of Shards",
				text = {
					"Apply {C:dark_edition}Fractured{} to a",
					"random Joker, {C:attention}Future{} playing card",
					"destruction may {C:red}fail{}"
				}
			},
			c_entr_desire = {
				name = "Pact of Desire",
				text = {
					"Create {C:attention}#1#{} random",
					"{C:spectral}Spectral{} or {C:red}Omen{} cards",
					"{C:attention}Booster Packs{} cost {C:money}50%{} more",
					"{C:inactive}(Must have room){}"
				}
			},
			c_entr_ice = {
				name = "Pact of Ice",
				text = {
					"Redeem {C:attention}#1#{} random {C:attention}Vouchers{}",
					"Your most {C:attention}levelled{} hand {C:red}cannot{} change levels"
				}
			},
			c_entr_gluttony = {
				name = "Pact of Gluttony",
				text = {
					"{C:attention}+#1#{} Consumable Slots",
					"{C:red}All{} Consumables are {C:attention}Eternal{}"
				}
			},
			c_entr_rebirth = {
				name = "Pact of Rebirth",
				text = {
					"Playing Cards are {C:attention}Duplicated{}",
					"instead of being {C:red}Destroyed{}",
					"{C:blue}-#1#{} Hand Size"
				}
			},
			c_entr_despair = {
				name = "Pact of Despair",
				text = {
					"Enhance {C:attention}#1#{} random card#<s>1#",
					"in your {C:attention}full deck{}, Debuff {C:attention}#2#%{} of",
					"cards in your {C:attention}full deck{} for {C:attention}#3#{} rounds"
				}
			},	
			c_entr_strength = {
				name = "Pact of Strength",
				text = {
					"Copy your {C:attention}most played{} card {C:attention}#1#{} times",
					"apply {C:attention}Rental{} to a random Joker"
				}
			},	
			c_entr_darkness = {
				name = "Pact of Darkness",
				text = {
					"Apply {C:dark_edition}Negative{} to a random Joker",
					"Playing cards may be drawn Face {C:red}Down{}"
				}
			},	
			c_entr_freedom = {
				name = "Pact of Freedom",
				text = {
					"{C:attention}+#1#{} Card Selection Limit",
					"{C:attention}-#2#{} Hand Size"
				}
			},	
			c_entr_eternity = {
				name = "Pact of Eternity",
				text = {
					"{C:gold}+#1#{} Ascension Power to your",
					"most {C:attention}played{} hand, A random",
					"Joker becomes {C:attention}Eternal{}"
				}
			},	
			c_entr_loyalty = {
				name = "Pact of Loyalty",
				text = {
					"Interest Rate is now every {C:money}$4{}",
					"{X:mult,C:white}X0.5{} Mult every other hand"
				}
			},
			c_entr_brimstone = {
				name = "Pact of Brimstone",
				text = {
					"{X:mult,C:white}X3.6{} Mult after hand played",
					"{C:blue}-#1#{} Hands"
				}
			},
			c_entr_dreams = {
				name = "Pact of Dreams",
				text = {
					"Add {C:attention}#1#{} Random Tags",
					"Small Blinds give no {C:attention}Reward{}"
				}
			},
			c_entr_energy = {
				name = "Pact of Energy",
				text = {
					"Apply random {C:dark_edition}Editions{} to last discarded hand",
					"{C:red}-#1#{} Discard#<s>1#"
				}
			},	
			c_entr_blood = {
				name = "Pact of Blood",
				text = {
					"Randomly Link {C:attention}#1#{}",
					"playing cards from your {C:attention}full deck{} together"
				}
			},		
			c_entr_awakening = {
				name = "Pact of Awakening",
				text = {
					"Create a random {C:dark_edition}Negative{} Voucher",
					"{C:attention}-#1#{} Booster Pack Slot#<s>1#"
				}
			},
		},
		mtx = {
			c_entr_extrajoker = {
				name = "Extra Jokers",
				text = {
					"{C:attention}+#1# Joker Slot{}",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_unstick = {
				name = "Unstick",
				text = {
					"Remove ALL {C:attention}stickers{}",
					"from your {C:attention}Jokers{}",
					"{C:purple}-c.#1#{}"
				}
			},
			c_entr_extrahands = {
				name = "Extra Hands",
				text = {
					"{C:blue}+#1# Hand{}",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_moneybundle = {
				name = "Bundle of Dollars",
				text = {
					"{C:money}+$#1#{}",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_biggerpockets = {
				name = "Bigger Pockets",
				text = {
					"{C:attention}+#1# Consumable Slot{}",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_deckfix = {
				name = "Deckfix",
				text = {
					"Destroy up to {C:attention}#1#{}",
					"selected cards",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_generousdonation = {
				name = "Generous Donation",
				text = {
					"{C:purple}-c.#1#{}"
				}
			},
		},
		Other = {
			antipattern_pair = {
				name = "Poker hand Pair",
				text = {
					"Already Played",
					"#1#, #2#"
				}
			},
			cry_multiuse = {
				name = "m",
				text = {
					"{C:inactive}Multiuse: ({V:1}#1#{C:inactive} remaining)",
				},
			},
			cry_banana_booster = {
				name = "Banana",
				text = {
					"All cards in pack",
					"are {C:attention}Banana{}",
				},
			},
			cry_banana_voucher = {
				name = "Banana",
				text = {
					"{C:green}#1# in #2#{} chance of being",
					"unredeemed each round",
				},
			},
			cry_banana_consumeable = {
				name = "Banana",
				text = {
					"{C:green}#1# in #2#{} chance to do",
					"nothing on use",
				},
			},
			banana = {
				name = "Banana",
				text = {
					"{C:green}#1# in #2#{} chance of being",
					"destroyed each round",
				},
			},
			echo_tooltip = {
				name = "(~)$ echo",
				text = {
					"When this card is used",
					"Also trigger {C:attention}#1#{}"
				}
			},
			temporary_debuff_tooltip = {
				name = "Temporary Debuff",
				text = {
					"Debuffed for the",
					"next {C:attention}#1#{} rounds"
				}
			},
			inversion_allowed = {
				name = "Inversion",
				text = {
					"Can be {C:red}Inverted{}",
					"into {C:red}#1#{}"
				}
			},
			no_downside = {
				name = "Downside Negated",
				text = {
					"Downside is Removed",
				}
			},
			no_downside_cond = {
				name = "Downside Negated",
				text = {
					"Downside is Removed",
					"When {X:dark_edition,C:white}Entropy{}",
					"is higher than {C:attention}100{}"
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
			p_entr_voucher_pack = {
				name = "Voucher Pack",
				group_name = "Voucher",
				text={
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:attention}Vouchers{}",
				}
			},
			undiscovered_rune = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
			undiscovered_pact = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
			undiscovered_fraud = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
			undiscovered_omen = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
			undiscovered_star = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
			undiscovered_command = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
			undiscovered_transient = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
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
			desync = {
				name = "Desync",
				text = {
					"{C:dark_edition}Forcetrigger{}",
					"during {C:attention}#1#{}",
					"Randomises when hand played"
				}
			},
			entr_aleph = {
				name = "Aleph",
				text = {
					"Cannot be {C:attention}removed{} {C:red}ever{}"
				}
			},
			entr_copper_sticker = {
                name = 'Copper Sticker',
                text = {
                    'Used this Joker',
                    'to win on {C:attention}Copper',
                    '{C:attention}Stake{} difficulty'
                }
            },
			entr_platinum_sticker = {
                name = 'Platinum Sticker',
                text = {
                    'Used this Joker',
                    'to win on {C:attention}Platinum',
                    '{C:attention}Stake{} difficulty'
                }
            },
			entr_meteorite_sticker = {
                name = 'Meteorite Sticker',
                text = {
                    'Used this Joker',
                    'to win on {C:attention}Meteorite',
                    '{C:attention}Stake{} difficulty'
                }
            },
			entr_obsidian_sticker = {
                name = 'Obsidian Sticker',
                text = {
                    'Used this Joker',
                    'to win on {C:attention}Obsidian',
                    '{C:attention}Stake{} difficulty'
                }
            },
			entr_iridium_sticker = {
                name = 'Iridium Sticker',
                text = {
                    'Used this Joker',
                    'to win on {C:attention}Iridium',
                    '{C:attention}Stake{} difficulty'
                }
            },
			entr_zenith_sticker = {
                name = 'Zenith Sticker',
                text = {
                    'Used this Joker',
                    'to win on {C:entr_zenith}Zenith',
                    '{C:attention}Stake{} difficulty'
                }
            },
			entr_crimson_seal = {
				name = "Crimson Seal",
				text = {
					"Retrigger {C:attention}adjacent{} cards"
				}
			},
			entr_sapphire_seal = {
				name = "Sapphire Seal",
				text = {
					"Give {C:attention}+0.25{} Ascension ",
					"Power to the played hand",
					"if {C:attention}held{} in hand",
					"at end of round"
        		}
			},
			entr_silver_seal = {
				name = "Silver Seal",
				text = {
					"Gives {C:gold}$1{} for each",
					"card held in {C:attention}hand{} when scored",
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
					"Creates a {C:red}Command{}",
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
			entr_ornate_seal = {
				name = "Ornate Seal",
				text = {
					"Creates a {C:purple}Rune{} Card",
					"when {C:red}destroyed{}",
					"{C:inactive}(Must have room){}"
				}
			},
			entr_amber_seal = {
				name = "Amber Seal",
				text = {
					"Creates a {C:red}Pact{} Card",
					"and {C:red}destroys{} itself",
					"when {C:attention}Copied{} or {C:attention}Duplicated{}",
					"{C:inactive}(Must have room){}"
				}
			},
			entr_mini_seal = {
				name = "Mini Seal",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"{C:red}destroy{} {C:attention}adjacent{} cards",
					"after scoring"
				}
			},
			entr_sharp_seal = {
				name = "Sharp Seal",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"upgrade this cards {C:attention}Enhancement{}",
					"before scoring"
				}
			},
			entr_vantablack_seal = {
				name = "Vantablack Seal",
				text = {
					"{C:attention}+1{} Card Selection Limit",
					"when highlighted"
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
			scarred = {
				name = "Scarred",
				text = {
					"{C:attention}Not{} removed from",
					"hand when discarding",
					"extra cards are {C:attention}still{} drawn"
				}
			},
			tmtrainer_dummy = {
				name = "Glitched Effect",
				text = {
					"#1#",
					"#2#"
				}
			},
			entr_pure = {
				name = "Pure",
				text = {
					"This Jokers values",
					"cannot change"
				}
			},
			entr_perma_plus_asc = {
				text = {
					"{C:gold}#1#{} Ascension Power"
				}
			},
			entr_perma_h_plus_asc = {
				text = {
					"{C:gold}#1#{} Ascension Power while held in hand"
				}
			},
			entr_perma_asc = {
				text = {
					"{X:money,C:white}X#1#{} Ascension Power"
				}
			},
			entr_perma_h_asc = {
				text = {
					"{X:money,C:white}X#1#{} Ascension Power while held in hand"
				}
			},
			entr_perma_exp_asc = {
				text = {
					"{X:money,C:white}^#1#{} Ascension Power" --i have no idea what colour this should be, just guessing
				}
			},
			entr_perma_h_exp_asc = {
				text = {
					"{X:money,C:white}^#1#{} Ascension Power while held in hand"
				}
			}
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
		},
		TheFamily_Tab = {
            entr_rune_tags = {
                name = "Rune Tags",
                text = {
                    "Hide or Display rune tags"
                }
            }
        },
		TheFamily_Group = {
            entr_misc_group = {
                name = "Miscelaneous Items (Entropy)",
                text = {
                    "Toggles for various UI elements added by Entropy"
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
			ach_entr_event_horizon = "Event Horizon",
			ach_entr_here_comes_the_sun = "Here comes The Sun",
			ach_entr_megalyteri = "Megalyteri",
			ach_entr_acheros = "Acheros",
			ach_entr_rift = "Rift",
			ach_entr_katevaino = "Katevaino",
			ach_entr_joy_to_the_world = "Joy To The World",
			ach_entr_suburban_jungle = "Suburban Jungle",
			ach_entr_f_x = "f(x)",
			ach_entr_c_sharp = "Completionist#"
		},
		achievement_descriptions = {
			ach_entr_event_horizon = "Use define to turn Obelisk into Sob",
			ach_entr_here_comes_the_sun = "Obtain a Sunny Joker",
			ach_entr_megalyteri = "Reach {50000} on Dekatria",
			ach_entr_acheros = "Beat Ante 32s boss blind, Endless Entropy",
			ach_entr_rift = "Beat Ante 8 on The Alternate Path",
			ach_entr_katevaino = "Use Transcend on Parakmi",
			ach_entr_joy_to_the_world = "Have the Wunjo Rune create another Wunjo Rune",
			ach_entr_suburban_jungle = "Play a Full House whilst holding: Ruby, Slipstream, Cassknows, or Crabus",
			ach_entr_f_x= "Play a Derivate whilst holding Antiderivative",
			ach_entr_c_sharp = "Discover and Unlock all Vanilla and Entropy collection entries"
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
			k_corrupted_ex = "Corrupted!",
			k_recovered_ex = "Recovered!",
			cry_demicolon = "Demitrigger!",
			k_ee_hand_1 = "When hand is played, a random card becomes sunny",
			k_ee_hand_2 = "Cards cannot be debuffed",
			k_ee_hand_3 = "X1.666 All Joker values when hand played",
			k_ee_hand_4 = "Forcetrigger a random Joker",

			k_ee_discard_1 = "Spread discarded card edition if 1 card discarded",
			k_ee_discard_2 = "Create negatve banana copies of played cards",
			k_ee_discard_3 = "Gain an Ascended Tag for each discarded card",
			k_ee_discard_4 = "^^3 Mult",


			k_before = "Before Scoring:",
			k_pre_joker = "Before Joker Scoring:",
			k_joker_main = "During Main Scoring:",
			k_individual = "When a this card triggers:",
			k_pre_discard = "When discarding cards:",
			k_remove_playing_cards = "When playing cards are destroyed:",
			k_setting_blind = "When entering a blind:",
			k_ending_shop = "When leaving the shop:",
			k_reroll_shop = "When rerolling:",
			k_selling_card = "When a card is sold:",
			k_using_consumeable = "When a consumable is used:",
			k_playing_card_added = "When a playing card is added:",

			k_tmtmult = "+??? Mult",
			k_tmtchips = "+??? Chips",

			k_tmtxmult = "X??? Mult",
			k_tmtxchips = "X??? Chips",

			k_tmtemult = "^??? Mult",
			k_tmtechips = "^??? Chips",

			k_tmtdollars = "+??? Dollars",
			k_tmtjoker_random = "Create a random joker",
			k_tmtjoker_choose_rarity = "Create a joker of a random rarity",
			k_tmtedition = "Apply a random edition to a random joker",
			k_tmtante = "-??? Ante",
			k_tmtconsumable = "Create a random consumable",
			k_tmtenhancement_play = "One played card gets a new enhancement",
			k_tmtenhancement_hand = "One card held in hand gets a new enhancement",
			k_tmtrandom = "Trigger 3 random effects",

			k_entr_entropic = "Entropic",
			k_entr_reverse_legendary = "Legendary?",
			k_entr_zenith = "Zenith",
			k_fraud = "Fraud",
			b_fraud_cards = "Fraud Cards",

			k_command = "Command",
			b_command_cards = "Command Cards",

			k_omen = "Omen",
			b_omen_cards = "Omen Cards",

			k_transient = "Transient",
			b_transient_cards = "Transient Cards",

			k_mtx = "MTX",
			b_mtx_cards = "MTX Cards",

			k_inverted = "Inverted",
			k_inverted_pack = "Twisted Pack",
			k_voucher_pack = "Voucher Pack",
			b_inverted_cards = "Inverted Cards",

			entr_code_sudo = "OVERRIDE",
			entr_code_sudo_previous = "OVERRIDE AS PREVIOUS",

			k_entr_faster_ante_scaling = "Scale Blind scores quicker if you have an Entropic Joker",
			k_entr_entropic_music = "Entropic Jokers (Joker in Greek by gemstonez)",
			k_entr_blind_tokens = "Enable Blind Tokens",
			k_credits = "Credits",
			k_code = "Code",
			k_idea = "Ideas",
			k_art = "Art",
			k_music = "Music",

			k_star = "Star",
			b_star_cards = "Star Cards",	
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
			b_transition = "Transition",
			
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

			entr_gameset_modest = "Ethereal",
			entr_gameset_mainline = "Elysian",
			entr_gameset_madness = "Exalted",
			entr_gameset_custom = "Emergent",

			entr_b_reset_gameset_modest = "Reset Gameset Config (Ethereal)",
			entr_b_reset_gameset_mainline = "Reset Gameset Config (Elysian)",
			entr_b_reset_gameset_madness = "Reset Gameset Config (Exalted)",

			entr_opened = "Opened!",
			entr_kiy_banished = "Banished.",

			k_saved_heroic = "Not Heroic!",
			k_saved_just = "Not Just!",
			b_on = "Enable",
			b_off = "Disable",
			b_enabled = "Enabled",
			b_disabled = "Disabled",
			b_cycle = "Cycle",
			b_true_endless = "True Endless Mode",
			k_entr_glitched = "Use new Glitched Shader (by cassknows)",
			ph_hand_notreal = "Bad argument to function pokerhand",


			cry_notif_antireal_1 = "Antireal Joker",
			cry_notif_antireal_2 = "Copyright Notice",
			cry_notif_antireal_d1 = 'Antireal Joker plays the song "Freebird",',
			cry_notif_antireal_d2 = "which is copyrighted and can't be",
			cry_notif_antireal_d3 = "used for streams and videos.",

			k_entr_omega_aleph = "Aleph sticker stops Self Destruction (Unstable, Must Restart Game)",

			k_saved_skullcry = "The power of Zenith Stake saves you",

			b_change_path_1 = "Enter The",
			b_change_path_2 = "Flip-Side",
			b_change_path_3 = "Return",
			b_infinity = "Infinity",

			b_daily_challenge = "Daily Challenge",

			flipside_none = 'None',
			flipside_minimal = 'Minimal',
			flipside_full = 'Full',
			
			flipside_info = 'Inversion display when holding Flipside',
			curses_enabled = "Enable Curses outside of Obsidian Stake",

			b_stat_CBlind = "Blind Token",
			b_stat_Fraud = "Fraud",
			b_stat_Star = "Star",
			b_stat_Omen = "Omen",
			b_stat_Command = "Command",
			k_upgrade_atomikos = "Destroyed!",
			k_destroyed_ex = "Destroyed!",
			k_new = "new();",
			k_ascended_ex = "Ascended",

			k_rune = "Rune",
			k_rune_pack = "Rune Pack",
			b_rune_cards = "Runes",
			k_pact = "Pact",
			k_pact_pack = "Devil Deal",
			b_pact_cards = "Pacts",

			cry_set_music = "Music",

			k_inactive = "Inactive!",
			k_randomised = "Randomized!",
			k_saved_algiz = "Saved by Algiz",
			k_undebuffed_ex = "Undebuffed!",
			k_spatial_anomaly = "Spatial Anomaly",

			k_curse_blind = "Curse of The Blind",
			k_curse_blind_desc = "Shop Cards may be Hidden",

			k_curse_darkness = "Curse of Darkness",
			k_curse_darkness_desc = "Booster Packs have Less Choices",

			k_curse_lost = "Curse of The Lost",
			k_curse_lost_desc = "No Small Blind",

			k_curse_maze = "Curse of The Maze",
			k_curse_maze_desc = "Blind order is Randomised",
			k_level_chips = "Chips per Level",
			k_level_mult = "Mult per Level",
			k_level_asc = "Ascension Power per Level",
			k_star_q = "Star?",
			k_moon = "Moon",
			k_satellite = "Satellite",

			k_joker_in_greek = "Jokers in Greek",
			k_mirrored_in_crimson = "Mirrored in Crimson",
			k_freebird = "Freebird",
			k_portal_reference = "The Part Where She Kills You",
			k_entropy_is_endless = "Entropy Is Endless",

			k_switch_ex = "Switch!",
		},
		v_dictionary = {
			card_art = "Card Art: #1#",
			shader = "Shader: #1#",
			wish = "Wish: #1#",
			cry_art = { "Art: #1#" },
			cry_code = { "Code: #1#" },
			cry_idea = { "Idea: #1#" },
			a_eqmult = { "Mult = #1#" },
			a_twisted = {"+#1# Twisted"},
		},
		labels = {
			banana = "Banana",
			entr_pinned = "Invariant",
			entr_hotfix = "Hotfixed",
			temporary = "Temporary",
			entr_pseudorandom = "Pseudorandom",
			link = "Linked",
			superego = "Projected",
			entr_sunny = "Sunny",
			entr_solar = "Solar",
			entr_neon = "Neon",
			entr_lowres = "Low-Res",
			entr_kaleidoscopic = "Kaleidoscopic",
			entr_fractured = "Fractured",
			entr_freaky = "Freaky",
			entr_yellow_sign = "Yellow Sign",
			scarred = "Scarred",
			desync = "Desynced",
			entr_aleph = "Aleph",
			entr_pure = "Pure",
			entr_crimson_seal = "Crimson Seal",
			entr_sapphire_seal = "Sapphire Seal",
			entr_silver_seal = "Silver Seal",
			entr_pink_seal = "Pink Seal",
			entr_verdant_seal = "Verdant Seal",
			entr_cerulean_seal = "Cerulean Seal",
			entr_ornate_seal = "Ornate Seal",
			entr_amber_seal = "Amber Seal",
			entr_mini_seal = "Mini Seal",
			entr_sharp_seal = "Sharp Seal",
			entr_vantablack_seal = "Vantablack Seal",
		},
		poker_hands = {
			["entr_All"] = Cryptid_config.family_mode and "All" or "Literally Fucking Everything",
			["entr-Flesh"] = "Flesh",
			["entr-Straight_Flesh"] = "Straight Flesh",
			["entr-Flesh_House"] = "Flesh House",
			["entr-Flesh_Five"] = "Flesh Five",
			["entr_derivative"] = "Derivative"
		},
		poker_hand_descriptions = {
			entr_All = {
				"A hand that contains every single",
				"card found in a 52-card deck.",
				"plus an entire full set of Optics",
				"and Nils, plus one Nil rank of each suit",
				Cryptid_config.family_mode and "God is Dead" or "Fuck You, God is Dead",
			},
			entr_derivative = {
				"5 Non-Standard Ranks or Suits"
			}
		},
		challenge_names = {
			c_entr_lifelight = "Lifelight",
			c_entr_vesuvius = "Vesuvius",
			c_entr_hyperaccelerated_bongcloud_opening = "Hyperaccelerated Bongcloud Opening",
			c_entr_hyperbolic_chamber = "Hyperbolic Hell-Tier Chamber",
			c_entr_daily = "Daily Challenge"
		},
		v_text = {
			ch_c_entr_no_planets = { "No Planets in the Shop" },
			ch_c_entr_starting_ante_mten = { "Start on Ante -10" },
			ch_c_entr_reverse_redeo = { "Invert Redeo's ante change" },
			ch_c_entr_set_seed = {"Set Seed: #1#"}
		},
		quips={
			entr_lq_ee_1={
                "Skill Issue"
            },
            entr_lq_ee_2={
                "If you wish",
				"to defeat me,",
				"you must train",
				"for 1000 years!"
            },
            entr_lq_ee_3={
                "Should have",
				"held R!"
            },
            entr_lq_ee_4={
                "And in the end",
				"everything succumbs",
				"to entropy..."
            },
            entr_lq_ee_5={
                "Looks like you",
				"werent entropic",
				"enough!"
            },
            entr_lq_ee_6={
                "Maybe you should",
				"have gotten a",
				"few more retriggers!"
            },
            entr_lq_ee_7={
                "Maybe try adding",
				"a few other mods!"
            },
            entr_lq_ee_8={
                "Dont cry, its",
				"just a game...",
            },
            entr_lq_ee_9={
                "Were you even",
				"trying?"
            },
			entr_lq_ee_10={
                "Maybe you should",
				"stop trying to",
				"beat me!"
            },
			entr_lq_ee_revived = {
				"Did you really",
				"think that would",
				"work?"
			},
			entr_wq_ee_1={
                "Huh?",
            },
            entr_wq_ee_2={
                "What!?"
            },
            entr_wq_ee_3={
                "How..."
            },
            entr_wq_ee_4={
                "Reveal your",
				"secrets!"
            },
            entr_wq_ee_5={
                "Well that was",
				"entropious!"
            },

			entr_lq_1 = {
				"Look like fate",
				"caught up to you."
			},
			entr_lq_2 = {
				"An inevitability."
			},
			entr_lq_3 = {
				"Just one",
				"more run"
			},
			entr_lq_4 = {
				"Better luck",
				"next time"
			},

			entr_wq_1 = {
				"You really are",
				"something huh?"
			},
			entr_wq_2 = {
				"The power of entropy",
				"shines within you"
			},
			entr_wq_3 = {
				"I was right to",
				"believe in you"
			},
			entr_wq_4 = {
				"Good Job now do",
				"Iridium Stake"
			},
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
