local decs = {
	descriptions = {
		Enhanced = {
			m_entr_flesh = {
				name = "血肉牌",
				text = {
					"被{C:attention}弃掉{}时，",
					"有 {C:green}#1# / #2#{} 几率",
					"摧毁此牌"
				}
			},
			m_entr_disavowed = {
				name = "否认牌",
				text = {
					"无法更改增强效果"
				}
			},
			m_entr_prismatic = {
				name = "棱镜牌",
				text = {
					"{X:slib_emult,C:white}^#1#{} 倍率",
					"当此牌计分时，",
					"获得 {X:slib_emult,C:white}^#2#{} 倍率"
				}
			},
			m_entr_dark = {
				name = "黑暗牌",
				text = {
					"留在手中时提供 {X:blue,C:white}X#2#{} 筹码",
					"打出的手牌中每包含一种{C:attention}独特{}的",
					"花色，此牌获得 {X:blue,C:white}X#1#{} 筹码"
				}
			},
			m_entr_ceramic = {
				name = "陶瓷牌",
				text = {
					"此牌具有独立的{C:attention}点数{}",
					"且被视为所有{C:attention}花色{}",
					"计分后，{C:red}摧毁{}此牌",
					"被摧毁时，创造一张{C:attention}随机{}消耗牌"
				}
			},
			m_entr_radiant = {
				name = "辉光牌",
				text = {
					"{C:gold}+#1#{} 晋升强度"
				}
			},

			m_entr_ethereal = {
				name = "以太牌",
				text = {
					"当被修改时，",
					"创造一张{C:spectral}幻灵{}牌",
					"{C:inactive}(必须有空间){}"
				}
			},

			m_entr_samsara = {
				name = "轮回牌",
				text = {
					"被修改时{C:red}自毁{}",
					"被摧毁时，创造一张",
					"带有 {X:blue,C:white}+X#2#{} 筹码的此牌{C:attention}副本{}",
					"{C:inactive}(当前为 {X:blue,C:white}X#1#{C:inactive})"
				}
			},

			--BLINDSIDE
			m_entr_scarlet_sun = {
				name = "绯红之日",
				text = {
					"{X:red,C:white}红色{}",
					"当留在手中时，",
					"每有一个{C:attention}已打出{}的盲注",
					"提供 {C:gold}+#1#{} 晋升强度"
				}
			},
			m_entr_burgundy_baracuda = {
				name = "勃艮第梭鱼",
				text = {
					{
						"{X:red,C:white}红色{}",
						"{X:mult,C:white}X#1#{} 倍率",
					},
					{
						"重新触发 {C:attention}#2#{} 次",
						"打出后重置次数"
					},
					{
						"留在手中时",
						"{C:attention}燃烧{}计分手牌中的",
						"所有盲注并获得 {C:attention}#3#{}",
						"每有一个已打出的盲注",
						"就会重新触发"
					}
				}
			},
			m_entr_diamond_dawn = {
				name = "钻石黎明",
				text = {
					{
						"{X:chips,C:white}蓝色{}",
						"将相邻的计分盲注",
						"重新触发 {C:attention}#1#{} 次"
					},
					{
						"复制相邻盲注的",
						"{C:attention}色相{}"
					},
				}
			},
			m_entr_olive_orchard = {
				name = "橄榄果园",
				text = {
					"{X:green,C:white}绿色{}",
					"当此盲注被{C:attention}弃掉{}时",
					"手中持有的所有盲注获得",
					"{X:mult,C:white}X#1#{} 倍率"
				}
			},
			m_entr_citrine_comet = {
				name = "黄水晶彗星",
				text = {
					"{X:gold,C:white}黄色{}",
					"当另一个盲注被{C:attention}燃烧{}时",
					"获得 {C:gold}#2#{} 晋升强度",
					"{C:inactive}(当前为 {C:gold}#1#{C:inactive} 晋升强度){}"
				}
			},
			m_entr_alabaster_anchor = {
				name = "雪花石膏锚",
				text = {
					"{X:dark_edition,C:white}褪色{}",
					"如果是计分手牌的一部分",
					"则{C:dark_edition}强制{}升级",
					"最右侧的盲注",
					"{C:inactive}(如果可能的话)"
				}
			},
			m_entr_alabaster_anchor_two = {
				name = "雪花石膏锚",
				text = {
					"{X:dark_edition,C:white}褪色{}",
					"如果是计分手牌的一部分",
					"则{C:dark_edition}强制{}将最右侧的盲注",
					"升级两次",
					"{C:inactive}(如果可能的话)"
				}
			},
		},
		["Content Set"] = {
			set_entr_inversions = {
				name = "逆位系统",
				text = {
					"Entropy 添加的",
					"{C:attention}消耗牌{}逆位变体"
				}
			},
			set_entr_tags = {
				name = "标签",
				text = {
					"Entropy 添加的",
					"{C:attention}标签{}"
				}
			},
			set_entr_blinds = {
				name = "盲注",
				text = {
					"Entropy 添加的",
					"{C:attention}Boss盲注{}"
				}
			},
			set_entr_decks = {
				name = "牌组",
				text = {
					"Entropy 添加的",
					"{C:attention}牌组{}"
				}
			},
			set_entr_misc = {
				name = "杂项",
				text = {
					"无法归入任何其他",
					"{C:cry_ascendant}主题集合{}的内容"
				},
			},
			set_entr_entropics = {
				name = "熵增小丑",
				text = {
					"拥有 {C:entr_entropic}熵增{} 稀有度的",
					"强力小丑牌",
				},
			},
			set_entr_vouchers = {
				name = "优惠券",
				text = {
					"Entropy 添加的",
					"{C:attention}优惠券{}"
				}
			},
			set_entr_spectrals = {
				name = "幻灵牌",
				text = {
					"Entropy 添加的",
					"{C:attention}幻灵{}牌"
				}
			},
			set_entr_misc_jokers = {
				name = "杂项小丑",
				text = {
					"无法归入任何其他",
					"{C:cry_ascendant}主题集合{}的{C:attention}小丑{}"
				},
			},
			set_entr_altpath = {
				name = "分支路线",
				text = {
					"对局过程中与一条",
					"{C:entr_entropic}特殊分支进程路线{}",
					"相关的{C:attention}机制内容{}"
				},
			},
			set_entr_dice_jokers = {
				name = "骰子小丑",
				text = {
					"Entropy 添加的",
					"基于骰子修改概率的",
					"{C:attention}小丑{}"
				},
			},
			set_entr_runes = {
				name = "符文",
				text = {
					"Entropy 添加的",
					"一种全新的{C:attention}消耗牌类型{}",
				},
			},
			set_entr_actives = {
				name = "主动小丑",
				text = {
					"Entropy 添加的",
					"需要{C:attention}手动{}激活",
					"的{C:attention}小丑{}"
				},
			},
			set_entr_void_jokers = {
				name = "虚空小丑",
				text = {
					"Entropy 添加的",
					"{C:entr_void}逆位{}的 {C:attention}小丑{}"
				},
			},
		},
		Joker = {
			--Crossmod Jokers
			j_entr_compositor = {
				name = "排字工",
				text = {
					"选择{C:attention}盲注{}时",
					"印制一张随机的{C:attention}逆位牌{}"
				}
			},

			j_cry_redeo = {
				name = "回溯",
				text = {
					"花费 {C:money}$#2#{} {C:inactive}($#3#){} 时",
					"{C:attention}-#1#{} 底注",
					"{s:0.8}每次使用后所需的花费",
					"呈{C:attention,s:0.8}指数级{s:0.8}增长",
					"{C:money,s:0.8}下一次增加所需: {s:1,c:money}$#4#"
				},
			},
			j_entr_stillicidium = {
				name = "滴水穿石",
				text = {
					"在离开商店时，将右侧的{C:attention}小丑{}",
					"以及所有的{C:attention}消耗牌{}转换为",
					"收藏页面中位于它们前一项的卡牌",
					"使{C:attention}计分卡牌{}的点数降低 1",
					"盲注规模减少 {C:attention}30%{}"
				}
			},
			j_entr_surreal_joker = {
				name = "超现实小丑",
				text = {
 					"倍率 {X:entr_eqmult,C:white}=#1#{}"
				}
			},
			j_entr_tesseract = {
				name = "超立方体",
				text = {
 					"将倍率逆时针旋转 {X:dark_edition,C:white}#1#{} 度",
					"并将筹码顺时针旋转 {X:dark_edition,C:white}#1#{} 度"
				}
			},
			j_entr_tesseract_gfb = {
				name = "超立方体",
				text = {
					{
						"将倍率逆时针旋转 {X:dark_edition,C:white}#1#{} 度",
						"并将筹码顺时针旋转 {X:dark_edition,C:white}#1#{} 度"
					},
					{
						"如果打出的手牌{C:attention}刚好{}包含 4 张牌",
						"此小丑获得 {X:dark_edition,C:white}+#2#{} 度"
					}
				}
			},
			j_entr_epitachyno = {
				name = "埃庇塔基诺",
				text = {
					{
						"当选择{C:attention}盲注{}时，此小丑将",
						"变身为一张随机的",
						"{C:legendary,E:1}隐藏{}消耗牌"
					},
					{
                    	"使用此小丑来使用",
						"{C:attention}当前{}对应的消耗牌",
					},
					{
						"当击败Boss盲注时",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
				}
			},
			j_entr_helios= {
				name = "赫利俄斯",
				text = {
					{
						"当一张牌计分时，",
						"手中持有所有与之同{C:attention}点数{}的牌",
						"都会变成{C:attention}标记{}状态"
					},
					{
						"所有打出的牌均提供",
						"{C:gold}+#1#{} 晋升强度",
					}
				}
			},
			j_entr_xekanos = {
				name = "泽卡诺斯",
				text = {
 					"底注改变时，",
					"{C:attention}底注增益{} {X:dark_edition,C:white}#1#X{}",
					"增加 {X:dark_edition,C:white}#2#{}",
					"出售一张{C:attention}稀有{}或更高稀有度",
					"的{C:attention}小丑{}时，将此数值{X:dark_edition,C:white}减半{}"
				}
			},
			j_entr_ieros = {
				name = "伊厄罗斯",
				text = {
 					"商店里的小丑具有",
					"{C:entr_entropic}升级过后的{C:attention}稀有度",
				}
			},
			j_entr_dekatria = {
				name = "德卡特里亚",
				text = {
					"当另一个{C:attention}小丑{}触发时，",
					"自动使用一张对应打出{C:purple}扑克牌型{}",
					"的{C:planet}星球{}牌或{C:purple}恒星{}牌"
				}
			},
			j_entr_oekrep = {
				name = "波克热普",
				text = {
					"允许从所有补充包中",
					"{C:attention}选择{}消耗牌",
					"补充包有 {C:green}#1# / #2#{} 几率",
					"生成出{C:dark_edition}负片{}卡"
				}
			},
			j_entr_kciroy = {
				name = "卡西罗伊",
				text = {
					"{C:dark_edition}+#1#{} 手牌上限，{C:dark_edition}+#2#{} 选牌上限",
					"每弃掉 {C:attention}#4#{} {C:inactive}[#5#]{} 张牌",
					"此小丑获得 {X:slib_echips,C:white}^#3#{} 筹码",
					"{C:inactive}(当前为{} {X:slib_echips,C:white}^#6#{} {C:inactive}筹码){}"
				}
			},
			j_entr_tocihc = {
				name = "托西克",
				text = {
					"击败盲注时固定有 {C:green}50%{} 几率",
					"不推进底注进度，",
					"转而获得该盲注对应的{C:attention}跳过标签{}",
				}
			},
			j_entr_teluobirt = {
				name = "泰洛伯特",
				text = {
					"计分的 {C:attention}J{} 提供 {X:chips,C:white}X筹码{}",
					"数值等同于打出的 J 的{C:attention}数量{}。",
					"根据打出的顺序",
					"重新触发{C:attention}计分{}的 J"
				}
			},
			j_entr_oinac = {
				name = "欧伊纳克",
				text = {
					"当此小丑摧毁一张{C:attention}人头{}牌时，",
					"它获得 {X:slib_echips,C:white}^#1#{} 筹码",
					"{C:attention}打出的{}牌会被摧毁",
					"并将一张点数+1的牌抽入{C:attention}手中{}",
					"{C:inactive}(当前为 {X:slib_echips,C:white}^#2#{} {C:inactive}筹码){}"
				}
			},
			j_entr_entropy_card = {
				name = "卡会卡",
				text = {
					"Entropy Discord频道的 #ascended-hands-worship 区里",
					"每有一个 {C:attention}sun_with_face{} (🌞) 表情，",
					"提供 {X:gold,C:white}X#1#{} 晋升强度",
					"{C:inactive}(当前为 {X:gold,C:white}X#2#{}{C:inactive}){}",
					"{C:blue,s:0.7}https://discord.gg/beqqy4Bb7m{}",
				}
			},
			j_entr_solarflare = {
				name = "太阳耀斑",
				text = {
					"其他每张{C:dark_edition}烈阳{}卡",
					"各提供 {X:gold,C:white}X#1#{} 晋升强度",
				},
			},
			j_entr_burnt_m= {
				name = "烤焦的 M",
				text = {
					"如果打出的手牌{C:attention}包含{}一个对子",
					"将第一张牌变为{C:dark_edition}烈阳{}卡",
					"每有一张{C:dark_edition}欢愉{}小丑，",
					"就多将1张牌变为{C:dark_edition}烈阳{}卡"
				},
			},
			j_entr_anaptyxi= {
				name = "阿纳普提克西",
				text = {
					"成长型小丑会使所有其他小丑",
					"成长 {X:dark_edition,C:white}X#1#{} 相同的数值，",
					"然后在回合结束时将此倍率增加 {X:dark_edition,C:white}X#2#{}",
					"{C:inactive}(阿纳普提克西除外){}",
				},
			},
			j_entr_chaos= {
				name = "混沌",
				text = {
					"当一张卡牌被{C:attention}创造{}时",
					"改为创造一张",
					"{C:attention}随机类型{}的卡牌"
				},
			},
			j_entr_parakmi = {
				name = "帕拉科米",
				text = {
					"任何位置的任何卡牌",
					"都可能出现{C:attention}任何东西{}",
					"{C:dark_edition}+#1#{} 商店槽位"
				}
			},
			j_entr_exousia = {
				name = "艾克索西亚",
				text = {
					"{C:entr_entropic}晋升{}所有标签",
					"当选择任意盲注时，",
					"获得 {C:attention}#1#{} 个跳过标签"
				}
			},
			j_entr_akyros = {
				name = "阿基罗斯",
				text = {
					"可以花费 {C:gold}$#1#{} {C:attention}购买{}小丑槽位，",
					"并以 {C:gold}$#2#{} 的价格{C:attention}出售{}",
					"在回合结束时根据你拥有的",
					"空余小丑槽数量获得金钱",
					"{C:inactive}(当前为{} {C:money}#3#{}{C:inactive}){}"
				}
			},
			j_entr_dni = {
				name = "DNI",
				text = {
					"每次出牌指定一种花色",
					"摧毁所有具有该花色的{C:attention}计分{}卡牌",
					"{C:inactive}(当前为{} {V:1}#1#{}{C:inactive}){}"
				}
			},
			j_entr_strawberry_pie = {
				name = "草莓派",
				text = {
					"{C:attention}同花{}、{C:attention}顺子{}和{C:attention}葫芦{}",
					"的等级提升会被重定向至",
					"{C:attention}高牌{}",
				}
			},
			j_entr_recursive_joker = {
				name = "递归小丑",
				text = {
					"当此小丑被{C:attention}出售{}时，",
					"创造一个此小丑的副本",
					"{C:red}每回合可生效一次{}",
					"{C:inactive}(当前为 #1#){}"
				}
			},
			j_entr_recursive_joker_gfb = {
				name = "递归小丑",
				text = {
					"{CANVAS:DESC_CANVAS} {}"
				}
			},
			j_entr_trapezium_cluster = {
				name = "四边形星团",
				text = {
					"其他每张{C:dark_edition}碎裂{}牌",
					"各自强制触发 {C:dark_edition}#1#{} 张",
					"随机卡牌"
				},
			},
			j_entr_katarraktis = {
				name = "卡塔拉克提斯",
				text = {
					"将右侧的{C:attention}小丑{}",
					"重新触发 {C:attention}#1#{} 次，然后",
					"后续的每一个{C:attention}小丑{}",
					"重新触发的次数都是前一个的 {X:dark_edition,C:white,f:entr_phi}Xo{} 倍"
				}
			},
			j_entr_dr_sunshine = {
				name = "阳光博士",
				text = {
					"当一张扑克牌被{C:attention}摧毁{}时",
					"此{C:attention}小丑{}获得",
					"{C:gold}+#1#{} 晋升强度",
					"{C:inactive}(当前为 {}{C:gold}+#2#{}{C:inactive}){}"
				}
			},
			j_entr_sunny_joker = {
				name = "晴朗小丑",
				text = {
					"{C:gold}+#1#{} 晋升强度"
				}
			},
			j_entr_metanoia = {
				name = "梅塔诺亚",
				text = {
					"弃掉的牌变为",
					"{C:attention}血肉{}牌"
				}
			},
			j_entr_antidagger = {
				name = "反向匕首",
				text = {
					"选择{C:attention}盲注{}时，",
					"解禁一张随机被放逐的小丑",
					"有 {C:green}#1# / #2#{} 几率改为{C:attention}放逐{}",
					"此小丑本身"
				}
			},
			j_entr_solar_dagger = {
				name = "太阳匕首",
				text = {
					"选择{C:attention}盲注{}时",
					"摧毁右侧的小丑",
					"并将其售价的{C:attention}四分之一{}永久添加到",
					"此小丑的{C:gold}晋升强度{}中",
					"{C:inactive}(当前为 {C:gold}#1#{} {C:inactive}晋升强度){}"
				}
			},
			j_entr_insatiable_dagger = {
				name = "贪婪匕首",
				text = {
					"选择{C:attention}盲注{}时",
					"放逐最右侧的小丑",
					"其左侧的小丑获得它售价的 {C:attention}#1#%{}",
					"作为 {C:purple}x数值乘数{}",
					"随后此百分比减少 {C:attention}#2#{}"
				}
			},
			j_entr_insatiable_dagger_gfb = {
				name = "贪婪匕首",
				text = {
					"在离开商店时，",
					"将右侧{C:attention}小丑{}的各项数值",
					"增加 {X:attention,C:white}X#1#{}"
				}
			},
			j_entr_rusty_shredder = {
				name = "生锈碎纸机",
				text = {
					"有 {C:green}#1# / #2#{} 几率创造",
					"被弃卡牌的{C:attention}临时{} {C:dark_edition}负片{}",
					"副本"
				}
			},
			j_entr_chocolate_egg = {
				name = "巧克力彩蛋",
				text = {
					"当此小丑被摧毁时，",
					"创造一张随机的{C:dark_edition}晴朗{} {C:red}稀有{}小丑",
					"若此小丑被{C:red}放逐{}，则改为",
					"创造一张随机的{C:dark_edition}晴朗{} {C:cry_epic}史诗{}小丑"
				}
			},
			j_entr_chocolate_egg_cryptidless = {
				name = "巧克力彩蛋",
				text = {
					"当此小丑被摧毁时，",
					"创造一张随机的{C:dark_edition}晴朗{} {C:red}稀有{}小丑",
				}
			},
			j_entr_antireal = {
				name = "反现实小丑",
				text = {
					"每个空余的小丑槽位",
					"提供 {X:gold,C:white}+X#1#{} 晋升强度",
					"{s:0.8}反现实小丑本身也算作空位{}",
					"{C:inactive}(当前为{} {X:gold,C:white}X#2#{}{C:inactive}){}"
				}
			},
			j_entr_jokerinyellow = {
				name = "黄衣小丑",
				text = {
					"抽到的牌有 {C:green}#1# / #2#{} 几率",
					"被贴上{C:diamonds}黄印{}贴纸",
					"打出{C:diamonds}方块{}时{C:red}放逐{}一张随机小丑",
					"选中的{C:diamonds}方块{}会将{C:dark_edition}临时{}状态",
					"赋予任何类型的一张随机卡牌",
					"如果在打出手牌时持有 {C:attention}7 张方块{}，则自毁"
				}
			},
			j_entr_lotteryticket = {
				name = "彩票",
				text = {
					"在回合结束时失去 {C:gold}$#5#{}",
					"有 {C:green}#1# / #2#{} 几率赚取 {C:gold}$#6#{}",
					"或者有 {C:green}#3# / #4#{} 几率改为赚取 {C:gold}$#7#{}"
				}
			},
			j_entr_ruby = {
				name = "红玉，希望之主",
				text = {
					"每购买 {C:attention}#1#{} {C:inactive}[#2#]{} 张小丑，",
					"获得一个随机{C:attention}标签{}",
					"标签有几率随机变为",
					"{C:entr_entropic}晋升{}状态"
				}
			},
			j_entr_slipstream = {
				name = "滑流，时间继承者",
				text = {
					"选择盲注时",
					"创造一张{C:red}预兆{}牌",
					"手中持有的{C:red}预兆{}牌提供 {X:mult,C:white}X#1#{} 倍率"
				}
			},
			j_entr_cass = {
				name = "卡斯诺，虚空缪斯",
				text = {
					"当使用一张{C:planet}星球{}或{C:purple}恒星{}牌时，",
					"随机增加 {C:attention}#7#{} 到一项数值上",
					"{C:inactive}({C:blue}+#1#{C:inactive} 手牌上限，{C:attention}+#2#{C:inactive} 选牌上限)",
					"{C:inactive}({C:blue}+#3#{C:inactive} 次出牌 与 {C:red}+#4#{C:inactive} 次弃牌)",
					"{C:inactive}({C:dark_edition}+#5#{C:inactive} 消耗牌槽位，{C:attention}+#6#{C:inactive} 商店槽位)"
				}
			},
			j_entr_devilled_suns = {
				name = "魔鬼太阳",
				text = {
					"黄金牌提供",
					"{C:gold}+#1#{} 晋升强度",
					"每拥有一张{C:dark_edition}晴朗{}小丑，",
					"额外提供 {C:gold}+#2#{}"
				}
			},
			j_entr_eden = {
				name = "伊甸园",
				text = {
					"其他每张{C:dark_edition}晴朗{}卡牌",
					"提供 {C:gold}+#1#{} 晋升强度",
				},
			},
			j_entr_exelixi = {
				name = "进化论",
				text = {
					"当扑克牌计分时",
					"升级其{C:attention}增强{}效果",
					"{C:attention}弃牌{}时，将{C:attention}增强{}效果",
					"传递给相邻的卡牌"
				}
			},
			j_entr_seventyseven = {
				name = "77+33",
				text = {
					"{X:entr_eqchips,C:white}=#1#{} 筹码"
				}
			},
			j_entr_jokezmann_brain = {
				name = "小丑人脑",
				text = {
					"离开商店时，有",
					"{C:green}#1# / #2#{} 几率用随机的",
					"{C:dark_edition}易腐、过曝{}小丑",
					"填满所有空余的小丑槽位"
				}
			},
			j_entr_libra = {
				name = "天秤座",
				text = {
					"计分的{C:dark_edition}万能{}牌和{C:attention}人头{}牌",
					"会将它们的数值与{C:attention}此{}小丑平衡",
					"{C:inactive}(当前为 {X:slib_echips,C:white}^#1#{} {C:inactive}筹码){}"
				}
			},
			j_entr_scorpio = {
				name = "天蝎座",
				text = {
					"计分的 {C:attention}8{} 会暂时提升概率事件",
					"根据 {C:attention}8 次 d8{} 的掷点结果提供 {X:slib_echips,C:white}^筹码{}",
					"如果掷出{C:attention}八{}个 8，则改为提供 {X:slib_echips,C:white}^#1#{} 筹码"
				}
			},
			j_entr_ridiculus_absens = {
				name = "荒谬缺席",
				text = {
					"计分的非{C:dark_edition}故障{}牌有 {C:green}#1# / #2#{} 几率",
					"变为{C:dark_edition}故障{}状态并获得一个额外效果",
					"打出{c:attention}手牌{}时{C:attention}随机化{}此概率"
				}
			},

			j_entr_endlessentropy = {
				name = "无尽熵增",
				text = {
					"在{C:blue}出牌{}与{C:red}弃牌{}时，",
					"分别在{C:attention}以下{}效果中循环切换",
					"#1#",
					"#2#"
				}
			},

			j_entr_scarlet_sun = {
				name = "绯红之日",
				text = {
					{
						"计分的卡牌提供",
						"{C:attention}+#1#{} 晋升强度",
					},
					{
						"将{C:dark_edition}晴朗{}状态赋予",
						"计分的{C:hearts}红桃{}牌"
					}
				}
			},
			j_entr_burgundy_baracuda = {
				name = "勃艮第梭鱼",
				text = {
					"在商店结束时",
					"{C:red}摧毁{}一张随机消耗牌",
					"并获得 {X:mult,C:white}X#2#{} 倍率",
					"{C:inactive}(当前为 {X:mult,C:white}X#1#{C:inactive} 倍率)"
				}
			},
			j_entr_olive_orchard = {
				name = "橄榄果园",
				text = {
					{
						"选择盲注时，有 {C:green}#1# / #2#{} 几率创造",
						"一张随机小丑的",
						"{C:dark_edition}负片{} {C:attention}易腐{}副本",
						"{C:inactive}(不包含自身)"
					},
					{
						"当一张牌腐坏时",
						"此小丑获得 {X:mult,C:white}X#4#{} 倍率",
						"{C:inactive}(当前为 {X:mult,C:white}X#3#{C:inactive} 倍率)"
					}
				}
			},
			j_entr_citrine_comet = {
				name = "黄水晶彗星",
				text = {
					{
						"固定 {C:green}50%{} 几率",
						"为所有抽到的卡牌创造一个",
						"{C:red}临时{}的{C:dark_edition}负片{}副本"
					},
					{
						"{C:dark_edition}负片{}卡牌在被选中时",
						"提供 {C:attention}+1{} 选牌上限"
					}
				}
			},

			j_entr_diamond_dawn = {
				name = "钻石黎明",
				text = {
					{
						"每次出牌时剥夺{C:attention}最右侧{}",
						"计分牌的点数和花色，",
						"并将其加入此小丑的{C:money}金钱{}池中",
					},
					{
						"回合结束时赚取 {C:gold}$#1#{}"
					}
				}
			},

			j_entr_alabaster_anchor = {
				name = "雪花石膏锚",
				text = {
					"当一张牌被{C:red}弃掉{}时，",
					"一张随机小丑的数值获得 {X:attention,C:white}X#1#{}",
					"另一张随机小丑的数值获得",
					"{X:attention,C:white}X#2#{}",
					"{C:inactive}(不包含自身)"
				}
			},

			j_entr_skullcry = {
				name = ":skullcry:",
				text = {
					"如果获得的筹码大于",
					"{C:attention}log_#1#(盲注要求){}",
					"则可免于一死",
					"如果筹码不在 {C:attention}log_#1#(盲注要求){}",
					"的 {C:attention}#2#%{} 范围内，则{C:red}自毁{}"
				}
			},
			j_entr_dating_simbo = {
				name = "恋爱模拟波",
				text = {
					"计分的{C:hearts}红桃{}会被摧毁",
					"它们的{C:blue}筹码{}将被{C:attention}添加{}到此小丑上",
					"{C:inactive}(当前为 {}{C:blue}+#1#{} {C:inactive}筹码){}"
				}
			},
			j_entr_bossfight = {
				name = "首领战",
				text = {
					"如果打出的牌{C:attention}刚好{}是 {C:attention}#1#{} 张",
					"{C:attention}手{}中持有的所有牌",
					"获得 {C:blue}+#2#{} 筹码"
				}
			},
			j_entr_sweet_tooth = {
				name = "甜食爱好者",
				text = {
					"{C:blue}+#1#{} 筹码",
					"离开{C:attention}商店{}时，",
					"摧毁所有{C:attention}食物{}或{C:attention}糖果{}小丑，",
					"如果有任何{c:attention}食物{}或{C:attention}糖果{}小丑被摧毁，",
					"则此小丑的筹码增加 {X:blue,C:white}X#2#{}"
				}
			},
			j_entr_phantom_shopper = {
				name = "幻影购物者",
				text = {
					"出售此小丑以创造一张",
					"{C:attention}#1#{} 稀有度的小丑",
					"每逛过 {C:attention}#2#{} {C:inactive}[#3#]{} 次",
					"商店后，稀有度提升"
				}
			},
			j_entr_sunny_side_up = {
				name = "单面煎蛋",
				text = {
					"{C:gold}+#1#{} 晋升强度",
					"每打出一次手牌，",
					"{C:gold}-#2#{} 晋升强度"
				}
			},
			j_entr_atomikos = {
				name = "阿托米科斯",
				text = {
					"{C:attention}高牌{}的{C:dark_edition}运算符{}被设定为 {C:attention}^{}",
					"{C:attention}打出的{}扑克牌型将被{C:red}删除{}",
					"且它们的属性将{C:attention}添加{}到{C:attention}高牌{}上"
				}
			},
			j_entr_code_m = {
				name = "M()",
				text = {
					"当使用一张{C:green}代码{}牌时",
					"将{C:dark_edition}欢愉{}状态赋予一张",
					"{C:attention}随机{}小丑"
				}
			},

			j_entr_sunflower_seeds = {
				name = "葵花籽",
				text = {
					"在打出 {C:attention}#1#{} {C:inactive}[#2#]{} 次",
					"{C:gold}晋升{}牌型后，将{C:dark_edition}晴朗{}状态",
					"赋予一张{C:attention}随机{}小丑，并{C:red}自毁{}"
				}
			},
			j_entr_tenner = {
				name = "十元钞",
				text = {
					"$ = {X:gold,C:white}#1#{}"
				}
			},
			j_entr_sticker_sheet = {
				name = "贴纸贴画",
				text = {
					"每带有一个{C:attention}贴纸{}",
					"提供 {C:mult}+#1#{} 倍率",
					"为一张{C:attention}随机{}计分牌",
					"应用一个{C:attention}随机{}贴纸",
					"{C:inactive}(当前为{} {C:mult}+#2#{} {C:inactive}倍率){}"
				}
			},

			j_entr_metamorphosis = {
				name = "变形记",
				text = {
					"主小丑的{C:attention}计分{}效果改为",
					"在 {C:attention}#1#{} 计分时触发",
					"目标点数每次出牌后改变"
				}
			},

			j_entr_fourbit = {
				name = "4位小丑",
				text = {
					"每 {C:attention}#1#{} 张 {C:inactive}[#2#]{} 计分的牌",
					"都会被随机应用一张卡牌",
					"作为其{C:attention}增强{}效果"
				}
			},
			j_entr_scenic_route = {
				name = "观光路线",
				text = {
					"击败{C:attention}Boss盲注{}",
					"时创造一张 {C:red}(~)$ new(){}",
					"{C:inactive}(必须有空间){}"
				}
			},
			j_entr_crimson_flask = {
				name = "猩红烧瓶",
				text = {
					"当一个小丑被{C:attention}削弱{}时，此小丑获得 {X:mult,C:white}X#1#{} 倍率",
					"当一张被{C:attention}削弱{}的扑克牌被抽到手中时，获得 {X:mult,C:white}X#2#{} 倍率",
					"每回合随机{C:attention}削弱{}一张小丑",
					"{C:inactive}(当前为{} {X:mult,C:white}X#3#{} {C:inactive}倍率){}",
				},
			},
			j_entr_grotesque_joker = {
				name = "怪诞小丑",
				text = {
					"当添加一张血肉牌时，此小丑获得 {X:mult,C:white}X#1#{} 倍率",
					"当一张血肉牌被摧毁时，获得 {X:chips,C:white}X#2#{} 筹码",
					"{C:inactive}(当前为{} {X:mult,C:white}X#3#{}, {X:chips,C:white}X#4#{}{C:inactive}){}",
				},
			},
			j_entr_nyctophobia = {
				name = "黑夜恐惧症",
				text = {
					"选择盲注时，摧毁一张",
					"随机{C:attention}消耗牌{}，根据该消耗牌",
					"之前被{C:attention}使用{}过的次数，",
					"每次都会将两张随机{C:dark_edition}黑暗{}牌抽入手中"
				},
			},
			j_entr_dog_chocolate = {
				name = "小狗巧克力",
				text = {
					"当{C:attention}狗牌标签{}融合时，",
					"改为创造一张{C:attention}糖果{}小丑，",
					"并{C:red}摧毁{}这两张{C:attention}狗牌标签{}",
					"{C:attention}狗牌标签{}的出现频率提升"
				},
			},
			j_entr_nucleotide = {
				name = "核苷酸",
				text = {
					"每回合将第一张被弃掉的卡牌",
					"的点数和花色{C:attention}逆转{}，并获得",
					"升级的{C:dark_edition}版本{}后，抽入{C:attention}手中{}"
				},
			},
			j_entr_caviar = {
				name = "鱼子酱",
				text = {
					"使接下来的 {C:attention}#1#{} 个",
					"获得的标签变为{C:entr_entropic}晋升{}状态"
				},
			},
			j_entr_afterimage = {
				name = "残影",
				text = {
					"计分卡牌有 {C:green}#1# / #2#{} 几率",
					"将一张带有{C:attention}香蕉{}与{C:attention}易腐{}",
					"状态的副本抽入手中"
				},
			},

			j_entr_apeirostemma = {
				name = "阿佩罗斯特玛",
				text = {
					{
                    	"使用此小丑使所有选定的卡牌",
						"在{C:attention}一{}个回合内获得{C:attention}重新触发{}",
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
				}
			},

			j_entr_qu= {
				name = "库",
				text = {
					"当选择{C:attention}盲注{}时，",
					"手中{C:attention}随机{}的一张牌获得",
					"一张随机的{C:red}逆位{}牌作为增强效果"
				}
			},
			j_entr_memento_mori= {
				name = {
					"一个超级好笑的小丑名字",
					"提到Entropy的小丑",
					"效果总是像这样坑爹",
					"(勿忘你终有一死，熵增特供版)"
				},
				text = {
					"每回合{C:attention}第一张{}打出",
					"的卡牌会被{C:attention}摧毁{}"
				}
			},
			j_entr_broadcast = {
				name = "广播",
				text = {
					"复制第 {C:attention}#1#{}#2# 张小丑的效果",
					"在回合结束时增加 {C:attention}1{}",
					"达到你的{C:attention}最后{}一张小丑后重置"
				}
			},
			j_entr_d0 = {
				name = "D0",
				text = {
					"将所有{C:attention}列出{}的",
					"{C:green,E:1}概率{}乘以 {C:attention}0",
					"{C:inactive}(例如：{C:green}1 / 3{C:inactive} -> {C:green}0 / 3{C:inactive})"
				}
			},
			j_entr_d1 = {
				name = "D1",
				text = {
					"每回合的{C:attention}第一次{}概率判定",
					"{C:green}必定成功{}"
				}
			},
			j_entr_d4 = {
				name = "D4",
				text = {
					"概率判定会进行{C:attention}两次{}",
					"只需其中{C:attention}一次{}成功即可"
				}
			},

			j_entr_d6 = {
				name = "D6",
				text = {
					"当概率判定{C:red}失败{}时，",
					"此小丑获得 {C:green}+#2#{} 分子",
					"并在概率判定{C:green}成功{}时重置",
					"{C:inactive}(当前为 {C:green}+#1#{C:inactive})"
				}
			},

			j_entr_eternal_d6 = {
				name = "永恒 D6",
				text = {
					"重掷时，有 {C:green}#1# / #2#{} 几率",
					"{C:red}摧毁{}商店内一张随机卡牌，否则获得",
					"{C:green}+#4#{} 分子，在底注结束时重置",
					"{C:inactive}(当前为 {C:green}+#3#{C:inactive})"
				}
			},

			j_entr_d7 = {
				name = "D7",
				text = {
					"{C:green}#1# / #2#{} 几率",
					"重新触发基于{C:green}概率{}的",
					"{C:attention}小丑{}与{C:attention}增强{}效果"
				}
			},
			j_entr_d8 = {
				name = "D8",
				text = {
					"概率判定时的",
					"{C:green}分母{}降低 {C:attention}#1#{}",
				}
			},
			j_entr_d10 = {
				name = "D10",
				text = {
					"概率判定会带有",
					"{C:attention}随机{}偏移的{C:green}分子{}与{C:green}分母{}",
				}
			},
			j_entr_d12 = {
				name = "D12",
				text = {
					"每{C:attention}持有{}一张消耗牌，",
					"增加 {C:green}+#1#{} 分子"
				}
			},
			j_entr_d100 = {
				name = "D100",
				text = {
					"当概率触发时，",
					"永久{C:attention}随机化{}它们"
				}
			},
			j_entr_capsule_machine = {
				name = "扭蛋机",
				text = {
					"当选择盲注时，",
					"创造一张{C:attention}易腐{}的{C:green}骰子{} {C:attention}小丑{}",
					"{C:inactive}(必须有空间){}"
				}
			},

			j_entr_milk_chocolate = {
                name = "牛奶巧克力",
                text = {
                    "出售此卡以创造",
                    "一张免费的",
                    "{C:attention}#1#",
                },
            },

			j_entr_insurance_fraud = {
                name = "骗保",
                text = {
                    "当出售一张{C:purple}塔罗{}牌时，",
					"创造一张随机的{C:red}欺诈{}牌"
                },
            },

			j_entr_free_samples = {
                name = "免费试吃",
                text = {
                    "打开{C:attention}补充包{}时，有",
					"{C:green}#1# / #2#{} 几率被{C:attention}复制{}",
					"到你的消耗牌区",
					"{C:inactive}(必须有空间){}"
                },
            },
			j_entr_fused_lens = {
                name = "融合透镜",
                text = {
                    "有 {C:green}#1# / #2#{} 几率",
					"为你打出的手牌创造对应{C:purple}恒星{}牌",
					"{C:inactive}(必须有空间){}"
                },
            },
			j_entr_opal = {
                name = "蛋白石",
                text = {
                    "无花色卡牌可被用于",
					"组成扑克牌型",
					"{C:attention}重新触发{}无花色卡牌"
                },
            },
			j_entr_inkbleed = {
                name = "墨水晕染",
                text = {
                    "{C:attention}共享{}相同{C:attention}点数{}或",
					"{C:attention}修改{}效果的卡牌，",
					"将被视为拥有彼此的花色"
                },
            },
			j_entr_roulette = {
                name = "轮盘赌",
                text = {
                    "每张计分牌有 {C:green}#1# / #2#{} 几率",
					"获得 {C:red}+#3#{} 额外倍率",
					"摧毁每第 {C:attention}#4#{} 张计分牌"
                },
            },
			j_entr_debit_card = {
                name = "借记卡",
                text = {
                    "在回合结束时，",
					"每消费 {C:money}$#2#{} {C:inactive}[$#3#]{}",
					"就赚取 {C:money}$#1#{}",
					"{C:inactive}(当前为 {C:money}$#4#{C:inactive}){}"
                },
            },
			j_entr_birthday_card = {
                name = "生日贺卡",
                text = {
                    "如果你至少持有 {C:attention}#2#{} 张消耗牌，",
					"提供 {X:mult,C:white}X#1#{} 倍率"
                },
            },
			j_entr_sandpaper = {
                name = "砂纸",
                text = {
                    "如果打出的手牌包含一张{C:attention}石头牌{}",
					"{C:red}摧毁{}所有打出的{C:attention}石头牌{}",
					"并创造一张{C:attention}随机{}的{C:purple}符文牌{}"
                },
            },
			j_entr_purple_joker = {
                name = "紫色小丑",
                text = {
                    "每当一张{C:purple}符文{}牌触发时，",
					"此小丑获得 {X:mult,C:white}X#1#{} 倍率",
					"{C:inactive}(当前为 {X:mult,C:white}X#2#{C:inactive} 倍率){}"
                },
            },
			j_entr_chalice_of_blood = {
                name = "鲜血圣杯",
                text = {
                    "本局游戏中每使用一张{C:red}契约{}牌，",
					"提供 {X:mult,C:white}X#1#{} 倍率",
					"{C:inactive}(当前为 {X:mult,C:white}X#2#{C:inactive} 倍率){}"
                },
            },
			j_entr_chalice_of_blood_gfb = {
                name = "{C:red}鲜血{}圣杯",
                text = {
                    "'只为那些{C:entr_zenith}值得{}的人而备'"
                },
            },
			j_entr_torn_photograph = {
                name = "撕碎的照片",
                text = {
                    "每当一张{C:red}逆位{}牌被出售时，",
					"此小丑获得 {X:mult,C:white}X#1#{} 倍率",
					"{C:inactive}(当前为 {X:mult,C:white}X#2#{C:inactive} 倍率){}"
                },
            },
			j_entr_chuckle_cola = {
                name = "憨笑可乐",
                text = {
                    "将{C:attention}计分{}牌的{C:blue}筹码{}乘以 {X:blue,C:white}X#1#{}",
					"在 {C:attention}#2#{} 张牌计分后{C:red}自毁{}"
                },
            },
			j_entr_antiderivative = {
                name = "反导数",
                text = {
                    "对于{C:attention}小丑{}与{C:attention}扑克牌型{}的判定，",
					"{C:attention}点数{}与{C:attention}花色{}被互换",
					"{C:inactive,s:0.8}黑桃、红桃、梅花与方块{}",
					"{C:inactive,s:0.8}分别被视为 A、K、Q、J{}"
                },
            },
			j_entr_alles = {
                name = "哎呀，全是 e！",
                text = {
                    "如果你花费了{C:attention}超过{} {C:blue}1{} 手牌",
					"才击败{C:attention}盲注{}",
					"在回合结束时赚取 {C:money}$#1#{}"
                },
            },
			j_entr_verbophobia = {
                name = "文字恐惧症",
                text = {
                    "每回合第一个由 {C:attention}5{} 个字母",
					"或更少字母组成的单词，",
					"必定算作一个{C:attention}有效{}的单词"
                },
            },
			j_entr_feynman_point = {
                name = "费曼点",
                text = {
                    "将小丑数值的{C:attention}小数{}部分",
					"四舍五入至下一个倍数 {X:dark_edition,C:white}#1#{}",
					"每当概率事件{C:green}成功{}时，增加 {X:dark_edition,C:white}#2#{}"
                },
            },
			j_entr_neuroplasticity = {
                name = "神经可塑性",
                text = {
                    "扑克牌型的计分",
					"将作为一种{C:attention}随机{}牌型来计算",
					"{C:attention}每回合{}改变"
                },
            },
			j_entr_dragonfruit = {
                name = "火龙果",
                text = {
                    "{C:attention}+#1#{} 选牌上限",
					"每次打出手牌后",
					"{C:attention}-#2#{} 选牌上限"
                },
            },
			j_entr_prismatikos = {
                name = "棱光",
                text = {
                    "触发时随机选择一个效果",
					"{X:chips,C:white}???{} 筹码，{X:mult,C:white}???{} 倍率，{X:money,C:white}???{} 晋升强度",
					"{X:money,C:white}???{} 金钱，{X:blue,C:white}???{} 出牌次数",
					"创造 {C:attention}2{} 张逆位牌，打出的手牌获得随机{C:dark_edition}版本{}",
					"{X:attention,C:white}X0.9{} 盲注规模，等等...",
                },
            },
			j_entr_jestradiol = {
                name = "小丑雌二醇",
                text = {
					{
                    	"使用此小丑将最多 {C:attention}#1#{} 张",
						"选定的卡牌变成{C:entr_trans}Q{}",
					},
					{
						"击败Boss盲注时",
						"此小丑获得 {C:attention}#2#{} 次使用次数"
					}
                },
            },
			j_entr_penny = {
                name = "遗失的便士",
                text = {
                    "{C:blue}+#1#{} 筹码",
					"击败Boss盲注时",
					"{C:dark_edition}翻倍{}"
                },
            },
			j_entr_slothful_joker = {
                name = "怠惰小丑",
                text = {
                    "打出的{C:purple}无花色{}卡牌",
                    "在计分时提供 {C:mult}+#1#{} 倍率",
                },
            },
			j_entr_radar = {
                name = "雷达",
                text = {
                    "在回合结束时，将最后打出的",
					"{C:attention}扑克牌型{}的等级作为金钱赚取",
					"{C:inactive}(当前为 {C:money}$#1#{C:inactive})"
                },
            },
			j_entr_abacus = {
                name = "算盘",
                text = {
                    "计分的数字牌",
					"将它们一半的",
					"{C:blue}筹码{}作为{C:red}倍率{}提供"
                },
            },
			j_entr_matryoshka_dolls = {
                name = "俄罗斯套娃",
                text = {
                    "{C:red}+#1#{} 倍率",
					"选择盲注时，",
					"创造一个此小丑的{C:attention}副本{}",
					"但倍率减少 {C:red}1{}",
					"{C:inactive}(必须有空间)"
                },
            },
			j_entr_matryoshka_dolls_gfb = {
                name = "俄罗斯套娃",
                text = {
                    "{X:blue,C:white}X#1#{} 筹码",
					"选择盲注时，",
					"创造一个此小丑的{C:attention}副本{}",
					"但倍率乘数减少 {X:blue,C:white}0.5{}",
					"{C:inactive}(必须有空间)"
                },
            },
			j_entr_menger_sponge = {
                name = "门格海绵",
                text = {
                    "{C:blue}+#1#{} 筹码",
					"在回合结束时乘以 {X:attention,C:white}X#2#{}",
					"击败Boss盲注后{C:red}重置{}"
                },
            },
			j_entr_menger_sponge_gfb = {
                name = "门格海绵",
                text = {
                    "{C:blue}+#1#{} 筹码",
					"在回合结束时乘以 {X:attention,C:white}(sin(#1#)+1)X#2#{}",
                },
            },
			j_entr_arbitration = {
                name = "仲裁",
                text = {
                    "当一张{C:attention}玻璃牌{}",
					"被摧毁时，创造一张",
					"{C:attention}审判{}牌",
					"{C:inactive}(必须有空间)"
                },
            },
			j_entr_masterful_gambit = {
                name = "大师博弈",
                text = {
                    "如果打出的手牌{C:attention}只{}包含",
					"单单一张牌，",
					"赚取 {C:money}$#1#{}"
                },
            },
			j_entr_fourty_benadryls = {
                name = "40粒苯海拉明",
                text = {
                    "每一个底注",
					"提供 {C:blue}+#1#{} 筹码",
					"{C:inactive}(当前为 {C:blue}#2#{C:inactive} 筹码)"
                },
            },
			j_entr_fourty_benadryls_gfb = {
                name = "40粒苯海拉明",
                text = {
                    "直接跳至",
					"底注 {C:red}32{}"
                },
            },
			j_entr_red_fourty = {
                name = "红色40号",
                text = {
                    "{C:red}+#1#{} 倍率",
					"在商店中每消费一次",
					"{C:red}-#2#{} 倍率"
                },
            },
			j_entr_promotion = {
                name = "晋升",
                text = {
                    "击败Boss盲注时，",
					"在消耗牌槽中创造一个",
					"{C:attention}随机{}的补充包",
					"{C:inactive}(必须有空间)"
                },
            },
			j_entr_offbrand = {
                name = "杂牌",
                text = {
                    "{C:red}-#1#{} 倍率",
					"在回合结束时",
					"赚取 {C:money}$#2#{}"
                },
            },
			j_entr_girldinner = {
                name = "女孩晚餐",
                text = {
                    "每回合第一张计分的{C:attention}Q{}",
					"提供 {C:mult}+#1#{} 倍率",
					"和 {C:blue}+#2#{} 筹码"
                },
            },
			j_entr_recycling_bin = {
                name = "回收箱",
                text = {
                    "每{C:attention}弃掉{}一张牌，",
					"此小丑获得 {C:red}+#1#{} 倍率",
					"在回合结束时{C:red}重置{}",
					"{C:inactive}(当前为 {C:red}#2#{C:inactive} 倍率)"
                },
            },
			j_entr_gold_bar = {
                name = "金条",
                text = {
                    "回合结束时赚取 {C:money}$#1#{}",
					"每触发一次减少 {C:red}$#2#{}"
                },
            },
			j_entr_scribbled_joker = {
                name = "涂鸦小丑",
                text = {
                    "如果计分手牌中包含",
					"一张{C:attention}增强{}牌，",
					"获得 {C:blue}+#1#{} 筹码"
                },
            },
			j_entr_jokers_against_humanity = {
                name = "倒反天罡小丑",
                text = {
                    "每次出牌中第一张计分卡牌",
					"变为{C:attention}永恒{}状态",
					"计分的{C:attention}永恒{}卡牌提供",
					"{C:blue}+#1#{} 筹码与",
					"{C:red}+#2#{} 倍率"
                },
            },
			j_entr_blind_collectible_pack = {
                name = "盲注收集包",
                text = {
                    "出售此卡以创造",
					"一张免费的",
					"{C:attention}盲注代币{}",
					"{C:inactive}(必须有空间)"
                },
            },
			j_entr_blind_collectible_pack_gfb = {
                name = "植物收集包",
                text = {
                    "出售此卡以创造",
					"一张免费的",
					"{C:attention}植物盲注代币{}",
					"{C:inactive}(必须有空间)"
                },
            },
			j_entr_prayer_card = {
                name = "祈祷牌",
                text = {
                    "每个底注减少",
					"{C:attention}-#1#{} 盲注要求",
					"{C:inactive}(当前为 {C:attention}#2#{C:inactive})"
                },
            },
			j_entr_desert = {
                name = "荒漠",
                text = {
                    "如果打出的手牌",
					"恰好包含 {C:attention}1{} 张牌，",
					"此小丑获得 {C:gold}+#1#{} 晋升强度",
					"{C:inactive}(当前为 {C:gold}#2#{C:inactive} 晋升强度)"
                },
            },
			j_entr_rugpull = {
                name = "抽地毯",
                text = {
                    "不赚取结算资金",
					"结算金额的 {X:attention,C:white}X#1#{}",
					"将直接添加到此小丑的",
					"{C:attention}售价{}中"
                },
            },
			j_entr_grape_juice = {
                name = "葡萄汁",
                text = {
					{
						"使用此小丑将手中随机的一张牌",
						"变为{C:attention}奖励{}、{C:attention}倍率{}或{C:attention}万能{}牌",
					},
					{
						"击败Boss盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
                },
            },
			j_entr_petrichor = {
                name = "泥土芬芳",
                text = {
                    "不计分的卡牌",
					"提供 {C:blue}+#1#{} 筹码"
                },
            },
			j_entr_otherworldly_joker = {
                name = "异界小丑",
                text = {
                    "每当跳过任何",
					"{C:attention}补充包{}时，创造",
					"一张{C:red}逆位{}牌",
					"{C:inactive}(必须有空间){}"
                },
            },
			j_entr_error = {
                name = "错误",
                text = {
                    "计算效果会有",
					"轻微的{C:attention}偏差{}",
					"{C:inactive,S:0.8}(例如：提供 {C:blue}+30{C:inactive} 筹码或 {X:red,C:white}X2{C:inactive} 倍率)"
                },
            },
			j_entr_thirteen_of_stars = {
                name = "星之十三",
                text = {
                    "将打出扑克牌型",
					"{C:purple}等级{}的四分之一",
					"转化为 {C:gold}晋升强度{}"
                },
            },
			j_entr_diode_red = {
                name = "LED灯 (红)",
                text = {
                    "{C:red}+#1#{} 倍率",
					"{C:inactive,S:0.8}出牌后切换效果"
                },
            },
			j_entr_diode_blue = {
                name = "LED灯 (蓝)",
                text = {
                    "{C:blue}+#1#{} 筹码",
					"{C:inactive,S:0.8}出牌后切换效果"
                },
            },
			j_entr_prismatic_shard = {
                name = "棱光碎片",
                text = {
                    "计分的卡牌提供",
					"{C:mult}+#1#{} 倍率，",
					"{C:blue}+#2#{} 筹码，或",
					"{C:gold}+#3#{} 晋升强度"
                },
            },
			j_entr_chameleon = {
                name = "变色龙",
                text = {
                    "计分时作为一张",
					"随机{C:attention}增强{}牌"
                },
            },
			j_entr_thanatophobia = {
                name = "死神恐惧症",
                text = {
                    "提供所有出售或摧毁的",
					"{C:attention}小丑{}售价的一半作为倍率",
					"{C:inactive}(当前为 {C:mult}+#1#{C:inactive})"
                },
            },
			j_entr_redkey= {
                name = "红钥匙",
                text = {
					{
						"使用此小丑添加一个",
						"{C:attention}额外的{} {C:red}红房间{}盲注",
					},
					{
						"击败Boss盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
                },
            },
			j_entr_polaroid = {
                name = "拍立得",
                text = {
					{
					"使用此小丑复制另一张{C:attention}小丑{}的",
					"能力，直到下次使用为止",
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
                },
            },

			j_entr_polaroid_gfb = {
				name = "拍立得",
				text = {
					{
						"使用此小丑创造",
						"一张{C:attention}相片{}",
						"{C:inactive}(必须有空间)"
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
                },
			},
			j_entr_polaroid_gfbn = {
				name = "负片",
				text = {
					{
						"使用此小丑创造",
						"一张{C:attention}相片{}",
						"{C:inactive}(必须有空间)"
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
                },
			},
			j_entr_car_battery = {
                name = "汽车电瓶",
                text = {
					"击败Boss盲注时",
					"所有可使用的{C:attention}小丑{}与{C:attention}消耗牌{}",
					"获得 {C:attention}#1#{} 次额外使用次数"
                },
            },
			j_entr_chair = {
                name = "椅子",
                text = {
					"如果打出的手牌是{C:attention}三条{}",
					"将{C:attention}猎奇{}状态赋予",
					"{C:attention}第三张{}计分牌"
                },
            },
			j_entr_captcha = {
                name = "验证码",
                text = {
					{
						"使用此小丑将一张随机的",
						"{C:attention}小丑{}、{C:attention}消耗牌{}、",
						"{C:attention}补充包{}或{C:attention}优惠券{}",
						"作为增强效果赋予",
						"手中一张{C:attention}随机{}卡牌"
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
                },
            },
			j_entr_deck_enlargement_pills = {
                name = "牌组增大药丸",
                text = {
					"在 {C:attention}#1#{} {C:inactive}[#2#]{} 回合后",
					"出售此牌以",
					"{C:attention}应用{}一个随机{C:attention}牌组{}的效果"
                },
            },
			j_entr_photocopy = {
                name = "影印机",
                text = {
					"{C:attention}标准包{}中的第一张牌",
					"永远包含你最常用的",
					"{C:attention}花色{}与{C:attention}点数{}"
                },
            },

			j_entr_hexa = {
                name = "HexaCryonic，光之女巫",
                text = {
					"多余的打出卡牌提供",
					"{C:gold}+3{} 晋升强度",
					"{C:attention}+3{} 选牌上限"
                },
            },
			j_entr_hexa_cryptid = {
                name = "HexaCryonic，心之骑士",
                text = {
					"多余的打出卡牌提供 {X:gold,C:white}X3{}",
					"倍的晋升强度",
					"{C:attention}+#1#{} 选牌上限"
                },
            },
			j_entr_grahkon = {
                name = "第一守护者，Grahkon",
                text = {
					{
						"{C:attention}-#1#{} 盲注要求规模",
						"当一张扑克牌被摧毁时，乘以 {X:attention,C:white}X#2#{}。使用此小丑",
						"摧毁手中 {C:attention}#3#{} 张随机卡牌",
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#4#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#5#{C:inactive} 次使用次数)"
					}
                },
            },
			j_entr_ybur = {
                name = "伊布尔",
                text = {
					"如果你没有跳过任何盲注",
					"每个底注可防止一次死亡",
					"防止死亡时，此小丑获得 {X:slib_echips,C:white}^#2#{} 筹码",
					"{C:inactive}(当前为 {X:slib_echips,C:white}^#1#{C:inactive} 筹码, #3#)"
                },
            },
			j_entr_ybur_gfb = {
				name = "红宝石领主",
				text = {
					"老子能{C:red}硬抗{} {C:entr_zenith}任何{} 伤害"
				}
			},
			j_entr_zelavi = {
                name = "泽勒维",
                text = {
					"每当打开一个{C:spectral}幻灵包{}时",
					"此小丑获得 {X:blue,C:white}X#2#{} 筹码",
					"每个商店必定包含一个{C:spectral}究极幻灵包{}",
					"{C:inactive}(当前为 {X:blue,C:white}X#1#{C:inactive} 筹码)"
                },
            },
			j_entr_ssac = {
                name = "斯旺克萨克",
                text = {
					"整副牌中每缺失两个基础点数，",
					"就{C:attention}强制触发{}最右侧的",
					"{C:attention}小丑{}、{C:attention}扑克牌{}与{C:attention}消耗牌{}一次",
					"{C:inactive}(当前为 {C:attention}#1#{C:inactive})"
                },
            },
			j_entr_axeh = {
                name = "西诺雷克斯",
                text = {
					"获得时创造一张",
					"{C:attention}晴朗小丑{}",
					"所有晋升强度的来源",
					"乘以 {X:gold,C:white}X#1#{}"
                },
            },
			j_entr_nokharg = {
                name = "诺卡格",
                text = {
					"如果在{C:attention}本回合{}内没有使用过{C:red}弃牌{}",
					"则复制打出的手牌",
					"每复制一张卡牌，盲注规模 {X:attention,C:white}+X#2#{}",
					"{C:inactive}(当前为 {X:attention,C:white}X#1#{C:inactive} 盲注规模)"
                },
            },

			j_entr_enlightenment = {
                name = "顿悟",
                text = {
					"允许{C:attention}愚者{}复制任何",
					"{C:red}非逆位{}、或{C:red}隐藏{}的消耗牌或补充包，",
					"允许{C:red}大师{}复制",
					"{C:red}扭曲包{}"
                },
            },
			j_entr_black_rose_green_sun = {
                name = "黑玫瑰，绿太阳",
                text = {
					"手中持有的{C:spades}黑桃{}与{C:clubs}梅花{}",
					"提供 {C:gold}+#1#{} 晋升强度"
                },
            },

			j_entr_heimartai = {
                name = "黑玛泰",
                text = {
                    "概率事件会被{C:attention}重新判定{}",
					"直到它们{C:green}成功{}为止",
					"获得等于{C:attention}掷骰次数{}除以",
					"{C:green}概率分母{}的 {X:slib_echips,C:white}^筹码{}",
					"{C:inactive}(当前为 {X:slib_echips,C:white}^#1#{C:inactive} 筹码)"
                },
            },
			j_entr_jack_off = {
                name = "弃牌 J",
                text = {
                    "计分的 {C:attention}J{} 会",
					"弃掉手中持有的",
					"一张{C:attention}随机{}卡牌"
                },
            },
			j_entr_fast_food = {
                name = "快餐",
                text = {
					"选择{C:attention}盲注{}时",
                    "创造一张{C:attention}易腐{}的{C:attention}食物{}小丑",
					"{C:inactive}(必须有空间)"
                },
            },
			j_entr_antipattern= {
                name = "反面模式",
                text = {
					"打出的{C:attention}独特{}扑克牌型配对中，每有一对",
					"此小丑就获得 {X:blue,C:white}X#1#{} 筹码",
					"{C:inactive}(当前为 {X:blue,C:white}X#2#{C:inactive} 筹码)"
                },
            },
			j_entr_spiral_of_ants = {
                name = "蚂蚁螺旋",
                text = {
					"每有一次{C:attention}连续{}打出比上一手牌",
					"包含卡牌数量{C:attention}更少{}的手牌，",
					"此小丑获得 {C:blue}+#1#{} 筹码",
					"{C:inactive}(当前为 {C:blue}+#2#{C:inactive} 筹码)"
                },
            },
			j_entr_fork_bomb = {
                name = "分叉炸弹",
                text = {
					"选择{C:attention}盲注{}时",
					"创造一个此小丑的{C:attention}副本{}",
					"{C:inactive}(数量可以超出上限，最多 16 个)"
                },
            },
			j_entr_fork_bomb_gfb = {
				name = "分叉炸弹",
				text = {
					"选择{C:attention}盲注{}时",
					"创造一个此小丑的{C:attention}副本{}",
				}
			},
			j_entr_solar_panel = {
                name = "太阳能板",
                text = {
					"弃掉的{C:attention}晴朗{}与{C:attention}辉光{}卡牌",
					"提供 {C:money}$#1#{}"
                },
            },
			j_entr_kintsugi = {
                name = "金缮修复",
                text = {
					"{C:attention}陶瓷{}卡牌将被转换",
					"为{C:attention}黄金{}牌，而",
					"不是{C:red}自毁{}"
                },
            },
			j_entr_blooming_crimson = {
                name = "绽放猩红",
                text = {
                    "计分的卡牌提供",
					"{X:mult,C:white}X#1#{} 倍率，",
					"{X:blue,C:white}X#2#{} 筹码，或",
					"{X:gold,C:white}X#3#{} 晋升强度"
                },
            },
			j_entr_overpump = {
                name = "过度泵血",
                text = {
                    "在回合的{C:attention}最后{}一次{C:attention}出牌{}时",
					"提供 {X:mult,C:white}X#1#{} 倍率",
					"本回合内每打出一种{C:attention}独特{}的扑克牌型，",
					"倍率增加 {X:mult,C:white}X#2#{}"
                },
            },
			j_entr_shadow_crystal = {
                name = "暗影水晶",
                text = {
                    "消耗牌有 {C:green}#1# / #2#{} 几率",
					"额外触发它们",
					"{C:red}逆位{}变体的效果",
					"{C:inactive}(如果可能的话)",
					"{C:inactive}(排除隐藏的消耗牌)"
                },
            },
			j_entr_miracle_berry = {
                name = "奇迹果实",
                text = {
                    "接下来出现的 {C:attention}#1#{} 张消耗牌",
					"将必定是{C:spectral}幻灵{}牌",
                },
            },
			j_entr_meridian = {
                name = "子午线",
                text = {
                    "根据在小丑槽位中的",
					"{C:attention}位置{}提供倍率",
					"{C:inactive}(当前为 {C:mult}+#1#{C:inactive} 倍率)"
                },
            },
			j_entr_mango = {
                name = "芒果",
                text = {
                    "复制接下来 {C:attention}#1#{} 次出牌的",
					"{C:attention}第一张计分{}卡牌，",
					"并将其抽入{C:attention}手中{}"
                },
            },
			j_entr_kitchenjokers = {
                name = "厨房小丑",
                text = {
                    "食物小丑{C:attention}更容易{}出现，",
					"价格变为 {C:attention}X#1#{}，",
					"并且会附带{C:dark_edition}低清{}版本"
                },
            },
			j_entr_hash_miner = {
                name = "哈希矿工",
                text = {
                    "打出的手牌有 {C:green}#1# / #2#{} 几率被腐化，",
					"被腐化的手牌有 {C:green}#3# / #4#{} 几率恢复正常",
					"回合结束时，每有一手被腐化的手牌",
					"赚取等同于此卡售价 {C:money}$#5#{} 的金钱",
                },
            },
			j_entr_dice_shard = {
                name = "骰子碎片",
                text = {
					{
						"使用此小丑将一张选定的",
						"{C:attention}小丑{}转换为收藏列表中位于",
						"它前面的那一张小丑",
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数, #3#)"
					}
                },
            },
			j_entr_bell_curve = {
                name = "钟形曲线",
                text = {
					"重新触发除了",
					"{C:attention}第一张{}与{C:attention}最后一张{}之外的",
					"所有打出的卡牌"
                },
            },
			j_entr_pineapple = {
                name = "菠萝",
                text = {
					"在接下来的 {C:attention}#1#{} 回合结束时，",
					"为{C:attention}整副牌组{}中的 1 张随机卡牌",
					"添加一个{C:attention}永久{}的重新触发效果"
                },
            },
			j_entr_rubber_ball = {
                name = "橡胶球",
                text = {
					"每张计分牌有 {C:green}#1# / #2#{} 几率",
					"重新触发一次，",
					"触发时{C:red}逆转{}计分的{C:attention}顺序{}"
                },
            },
			j_entr_stand_arrow = {
                name = "替身之箭",
                text = {
					{
						"使用此小丑以 {C:green}#3# / #4#{} 几率{C:red}摧毁{}一张选定的小丑，",
						"否则为其应用 {C:dark_edition}多彩，负片{}",
						"{C:dark_edition}晴朗，烈阳，碎裂{} 或 {C:dark_edition}猎奇{} 版本",
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
                },
            },
			j_entr_dancer = {
                name = "舞者",
                text = {
					"{C:attention}+#1#{} 选牌上限",
					"{C:red}#2#{} 次弃牌"
                },
            },
			j_entr_kings_scepter = {
                name = "国王权杖",
                text = {
					"摧毁{C:attention}所有{}打出的",
					"{C:red}被削弱{}的卡牌"
                },
            },
			j_entr_monkeys_paw = {
                name = "猴爪",
                text = {
					"使用此小丑以创造",
					"一张随机的 {C:attention}永恒{} {C:red}契约{}牌",
					"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
                },
            },
			j_entr_magic_skin = {
                name = "魔法皮肤",
                text = {
					{
						"使用此小丑创造 {C:attention}#3#{} 张基于",
						"{C:attention}当前{}打开的补充包内容",
						"生成的{C:dark_edition}负片{}卡牌",
						"{C:inactive,s:0.8}每次使用后，它再次出现的几率都会提高",
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#4#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#2#{}, {C:attention}#1#{C:inactive} 次使用次数)"
					}
                },
            },
			j_entr_lambda_calculus = {
                name = "λ演算",
                text = {
					"每当另一张小丑{C:attention}触发{}时",
					"将其{C:attention}数值{}添加至此小丑的{C:blue}筹码{}中",
					"当此小丑触发时{C:red}重置{}",
					"{C:inactive}(当前为 {C:blue}+#1#{C:inactive} 筹码)"
                },
            },
			j_entr_elderberries = {
                name = "接骨木果",
                text = {
					"出售时强制使用",
					"{C:attention}#1#{} 张",
					"{C:spectral}幻灵{}牌"
                },
            },
			j_entr_elderberries_gfb = {
				name = "接骨木果",
				text = {
					"出售时强制使用 {C:spectral}十字圣甲虫{}",
					"有 {C:green}0.3%{} 几率改为使用 {C:spectral}灵魂{}"
				}
			},
			j_entr_nostalgic_d6 = {
                name = "怀旧 D6",
                text = {
					"花费 {C:money}$#1#{} 使用此小丑",
					"以{C:attention}重掷{}补充包的",
					"内容"
                },
            },
			j_entr_blood_orange = {
                name = "血橙",
                text = {
					"接下来摧毁的 {C:attention}#1#{} 张扑克牌",
					"每有一张就会创造一张",
					"{C:red}逆位{}消耗牌",
					"{C:inactive}(必须有空间)"
                },
            },
			j_entr_false_vacuum_collapse = {
                name = "伪真空衰变",
                text = {
					"此小丑将作为手牌中的{C:attention}第一张{}",
					"卡牌被打出，并在计分时{C:red}摧毁{}",
					"{C:attention}第二张{}打出的卡牌，",
					"随后返回原位"
                },
            },
			j_entr_mark_of_the_beast = {
                name = "野兽印记",
                text = {
					"每个商店均包含一个",
					"{C:red}大型扭曲包{}，购买它需要献祭",
					"{C:attention}整副牌组{}中的 {C:attention}1{} 张随机卡牌"
                },
            },

			j_entr_echo_chamber = {
                name = "回音室",
                text = {
					{
						"使用此小丑以摧毁一张选定的",
						"{C:attention}消耗牌{}，当另一张消耗牌",
						"被摧毁时，最后被此小丑摧毁的",
						"三张消耗牌将被再次{C:attention}触发{}",
						"{C:inactive}({V:1}#5#{}, {V:2}#6#{}, {V:3}#7#{C:inactive})",
						"{C:inactive}(隐藏的消耗牌除外)"
					},
					{
						"在商店消费 {C:money}$#3#{} 后，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:money}$#4#{}, {C:attention}#1#{C:inactive} 次使用次数)"
					}
                },
            },

			j_entr_milk = {
                name = "牛奶盒",
                text = {
					"如果在一回合内出牌次数大于{C:attention}一次{}并获胜，",
					"此小丑获得 {C:blue}+#2#{} 筹码",
					"在达到 {C:blue}#3#{} 筹码后",
					"变成{C:attention}酸奶{}",
					"{C:inactive}(当前为 {C:blue}+#1# {C:inactive}筹码)"
                },
            },
			j_entr_yogurt = {
                name = "酸奶",
                text = {
					"每当触发任何筹码效果时",
					"此小丑失去 {C:blue}#2#{} 筹码",
					"{C:inactive}(当前为 {C:blue}+#1# {C:inactive}筹码)"
                },
            },

			j_entr_milk_gfb = {
                name = "草莓牛奶",
                text = {
					"如果在一回合内出牌次数大于{C:attention}一次{}并获胜，",
					"此小丑获得 {C:red}+#2#{} 倍率",
					"在达到 {C:red}#3#{} 倍率后",
					"变成{C:attention}草莓酸奶{}",
					"{C:inactive}(当前为 {C:red}+#1# {C:inactive}倍率)"
                },
            },
			j_entr_yogurt_gfb = {
                name = "草莓酸奶",
                text = {
					"每当触发任何倍率效果时",
					"此小丑失去 {C:red}#2#{} 倍率",
					"{C:inactive}(当前为 {C:red}+#1# {C:inactive}倍率)"
                },
            },
			j_entr_box_of_chocolates = {
                name = "巧克力盒",
                text = {
					"在接下来的 {C:attention}#1#{} 个打开的",
					"{C:attention}补充包{}中，",
					"{C:attention}强制触发{}一张随机的卡牌"
                },
            },
			j_entr_carrot_cake = {
                name = "胡萝卜蛋糕",
                text = {
					"接下来的 {C:attention}#1#{} 张",
					"创造出的消耗牌将",
					"呈现{C:dark_edition}镀金{}版本"
                },
            },
			j_entr_twisted_pair = {
                name = "双绞线",
                text = {
					"重新触发所有打出的卡牌",
					"所有重新触发的卡牌在计分时",
					"其数值将临时乘以 {X:attention,C:white}X#1#{}"
                },
            },
			j_entr_texas_hold_em = {
                name = "德州扑克",
                text = {
					"{C:red}-#1#{} 选牌上限",
					"在每次盲注期间，",
					"将最先抽到的 {C:attention}#2#{} 张卡牌",
					"赋予{C:attention}标记{}状态"
                },
            },
			j_entr_fasciation = {
                name = "簇化",
                text = {
					"每张计分卡牌都会",
					"重新触发一次，次数等同于",
					"其前面{C:attention}之前{}计分过的",
					"同{C:attention}花色{}卡牌数量"
                },
            },
			j_entr_fasciation_gfb = {
				name = "为啥摆着个臭脸？"
			},
			j_entr_amaryllis = {name = "孤挺花", text = {""}},
			j_entr_amaryllis_white = {
                name = "白色孤挺花",
                text = {
					{
						"选择{C:attention}盲注{}时",
						"创造一张{C:purple}符文{}牌",
						"{C:inactive}(必须有空间)"
					},
					{
						"回合结束时",
						"改变颜色"
					}
                },
            },
			j_entr_amaryllis_red = {
                name = "红色孤挺花",
                text = {
					{
						"打出的卡牌会被",
						"转换为{C:hearts}红桃{}"
					},
					{
						"回合结束时",
						"改变颜色"
					}
                },
            },
			j_entr_amaryllis_pink = {
                name = "粉色孤挺花",
                text = {
					{
						"{C:attention}抽到{}的第一手牌中，",
						"一张随机卡牌将",
						"变成{C:entr_freaky}猎奇{}版本"
					},
					{
						"回合结束时",
						"改变颜色"
					}
                },
            },
			j_entr_amaryllis_orange = {
                name = "橙色孤挺花",
                text = {
					{
						"选择{C:attention}盲注{}时",
						"获得 {C:blue}+#1#{} 次出牌"
					},
					{
						"回合结束时",
						"改变颜色"
					}
                },
            },
			j_entr_amaryllis_purple = {
                name = "紫色孤挺花",
                text = {
					{
						"手中持有的每一张{C:attention}人头牌{}",
						"都会平衡当前的",
						"{C:blue}筹码{}与{C:red}倍率{}"
					},
					{
						"回合结束时",
						"改变颜色"
					}
                },
            },
			j_entr_amaryllis_yellow = {
                name = "黄色孤挺花",
                text = {
					{
						"在回合结束时",
						"赚取 {C:gold}$#2#{}",
					},
					{
						"回合结束时",
						"改变颜色"
					}
                },
            },
			j_entr_cooking_pot = {
                name = "烹饪锅",
                text = {
					"获得的{C:attention}食物{}小丑不会正常存入，",
					"而是直接添加到此小丑上且不再退化，",
					"在获得 {C:attention}3{} 张{C:attention}食物{}小丑后{C:red}自毁{}",
					"{C:inactive}(当前为 {C:attention}#1#{C:inactive}, {C:attention}#2#{C:inactive}, {C:attention}#3#{C:inactive})"
                },
            },
			j_entr_brownies = {
				name = "布朗尼",
				text = {
					"当接下来的 {C:attention}#2#{} 张消耗牌",
					"被使用时，赚取 {C:gold}$#1#{}"
				}
			},
			j_entr_redacted = {
				name = "{X:white,C:entr_transparent}______{} 小丑",
				text = {
					"选择盲注时，翻转一张随机小丑",
					"并为其应用{C:attention}租赁{}贴纸",
					"{C:attention}租赁{}状态的小丑提供",
					"{C:mult}+#1#{} 倍率"
				}
			},
			j_entr_void_cradle = {
				name = "虚空摇篮",
				text = {
					{
						"使用此小丑将一张选定的",
						"消耗牌{C:red}逆位{}",
						"这张消耗牌在{C:attention}未来{}的",
						"所有获取途径都会",
						"变为{C:red}逆位{}状态"
					},
					{
						"击败Boss盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
				}
			},
			j_entr_arachnophobia = {
				name = "蜘蛛恐惧症",
				text = {
					"如果在一次出牌中有 {C:attention}#1#{} 张",
					"或更多的 {C:attention}8{} 参与计分",
					"创造一张{C:entr_omen}预兆{}牌",
					"{C:inactive}(必须有空间)"
				}
			},
			j_entr_pound_of_flesh = {
				name = "一磅血肉",
				text = {
					"所有的{C:attention}补充包{}价格改为献祭",
					"{C:attention}整副牌组{}中的 {C:attention}1{} 张随机卡牌",
					"所有的{C:attention}优惠券{}价格改为献祭",
					"{C:attention}整副牌组{}中的 {C:attention}3{} 张随机卡牌"
				}
			},
			j_entr_fthof = {
				name = "命运之手",
				text = {
					"商店中的{C:attention}优惠券{}将被",
					"替换为{C:dark_edition}镀金{}的{C:red}稀有{}小丑",
					"当在{C:attention}商店{}购买任何其他卡牌时，",
					"有 {C:green}#1# / #2#{} 几率{C:red}自毁{} "
				}
			},
			j_entr_searing_joke = {
				name = "灼热笑话",
				text = {
					"此小丑允许被{C:red}逆位{}",
					"在被{C:red}逆位{}时",
					"获得 {X:mult,C:white}X#2#{} 倍率",
					"{C:inactive}(当前为 {X:mult,C:white}X#1#{C:inactive} 倍率)"
				}
			},
			j_entr_ancestral_recall = {
				name = "先祖回忆",
				text = {
					{
                    	"使用此小丑额外抽 {C:attention}三{} 张牌",
						"将它们变成{C:attention}标记{}状态，",
						"并在本回合剩余时间内失去 {C:red}#3#{} 次出牌",
					},
					{
						"击败盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
				}
			},

			j_entr_planetarium = {
				name = "天文馆",
				text = {
					"根据最后一张使用过的",
					"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
					"改变其{C:entr_ascended}效果{}"
				}
			},

			["j_entr_planetarium_High Card"] = {
				name = "天文馆：冥王星",
				text = {
					{
						"所有的手牌均作为{C:attention}高牌{}计分"
					},
					{
						"对所有未计分的卡牌",
						"应用{C:attention}标记{}状态"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Pair"] = {
				name = "天文馆：水星",
				text = {
					{
						"在出牌前，将{C:attention}最左侧{}",
						"的选定卡牌转换成",
						"{C:attention}最右侧{}的选定卡牌"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Two Pair"] = {
				name = "天文馆：天王星",
				text = {
					{
						"扑克牌型在计算时",
						"会额外包含打出的",
						"{C:attention}第一张{}与{C:attention}第二张{}卡牌的副本"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Three of a Kind"] = {
				name = "天文馆：金星",
				text = {
					{
						"如果打出卡牌的{C:attention}点数{}总和",
						"是 {C:attention}3{} 的倍数，",
						"计分的卡牌提供 {X:mult,C:white}X#1#{} 倍率"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Flush"] = {
				name = "天文馆：木星",
				text = {
					{
						"在出牌前，将另外两张随机",
						"选定卡牌的{C:attention}花色{}转换成",
						"最左侧选定卡牌的{C:attention}花色{}"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Straight"] = {
				name = "天文馆：土星",
				text = {
					{
						"打出的手牌中每包含一种",
						"{C:attention}独特{}点数，赚取 {C:money}$#1#{}"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Full House"] = {
				name = "天文馆：地球",
				text = {
					{
						"打出手牌中点数{C:attention}最低{}的牌",
						"在计分时赚取 {C:money}$#1#{}",
						"打出手牌中点数{C:attention}最高{}的牌",
						"提供 {X:mult,C:white}X#2#{} 倍率"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Straight Flush"] = {
				name = "天文馆：海王星",
				text = {
					{
						"在Boss盲注期间",
						"打出的扑克牌型",
						"{C:red}-1{} 等级"
					},
					{
						"扑克牌型的等级每有 {C:attention}3{} 级，",
						"形成该牌型所需的卡牌数量就",
						"减少 {C:attention}1{} 张"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Four of a Kind"] = {
				name = "天文馆：火星",
				text = {
					{
						"打出一手牌时",
						"获得 {C:red}+#1#{} 次弃牌"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Five of a Kind"] = {
				name = "天文馆：X号星",
				text = {
					{
						"如果打出的手牌{C:attention}刚好{}是 {C:attention}5{} 张，",
						"所有{C:attention}计分{}的卡牌都会获得",
						"一项随机的{C:attention}修改效果{}，并",
						"随机化它们的花色"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Flush House"] = {
				name = "天文馆：谷神星",
				text = {
					{
						"致胜手牌中每包含一个{C:attention}对子{}，",
						"此小丑获得 {X:mult,C:white}X#1#{} 倍率；",
						"致胜手牌中每包含一种{C:attention}花色{}，",
						"失去 {X:mult,C:white}X#2#{} 倍率",
						"{C:inactive}(当前为 {X:mult,C:white}X#3#{C:inactive} 倍率)"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_Flush Five"] = {
				name = "天文馆：阋神星",
				text = {
					{
						"复制每回合的",
						"{C:attention}第一张{}计分卡牌，",
						"然后将其加入你{C:attention}打出的手牌{}中"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			["j_entr_planetarium_entr_derivative"] = {
				name = "天文馆：闯入者",
				text = {
					{
						"在回合结束时，剥夺",
						"手中{C:attention}最左侧{}卡牌的{C:attention}点数{}与{C:attention}花色{}"
					},
					{
						"重新触发所有无论是",
						"留在手中还是打出的{C:attention}无花色{}卡牌"
					},
					{
						"根据最后一张使用过的",
						"特定牌型{C:planet}星球{}牌或{C:purple}恒星{}牌，",
						"改变其{C:entr_ascended}效果{}"
					}
				}
			},
			j_entr_double_down = {
				name = "加倍下注",
				text = {
					"将{C:attention}标记{}状态",
					"赋予计分的{C:attention}幸运{}牌"
				}
			},
			j_entr_wormwood = {
				name = "苦艾",
				text = {
					{
						"扑克牌在计分时永久",
						"失去 {C:red}#1#{} 倍率，",
					},
					{
						"计分的卡牌本身每带有一点{C:blue}筹码{}",
						"就提供 {C:gold}+#2#{} 晋升强度"
					}
				}
			},

			--void jokers
			j_entr_apoptosis = {
				name = "细胞凋亡",
				text = {
					{
						"手中持有的卡牌将被视为",
						"已{C:entr_void}打出{}来{C:attention}计分{}"
					},
					{
						"手中持有的无增强卡牌",
						"提供 {C:gold}+#1#{} 晋升强度"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_egocentrism = {
				name = "自我中心主义",
				text = {
					{
						"{C:entr_void}强制触发{}最右侧的",
						"小丑。削弱{C:attention}第一张{}",
						"和{C:attention}最后一张{}打出的卡牌"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_generator_meltdown = {
				name = "发电机熔毁",
				text = {
					{
						"当一种扑克牌型升级时，",
						"将它 {C:entr_void}25%{} 的{C:blue}筹码{}",
						"与它 {C:entr_void}25%{} 的{C:red}倍率{}互换"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_voidheart = {
				name = "虚空之心",
				text = {
					{
						"将底注中的所有盲注",
						"替换为一个单一的",
						"{C:entr_void}深渊{}盲注"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_unstable_rift = {
				name = "不稳定裂隙",
				text = {
					{
						" "
					},
					{
						"当{C:red}倍率{}或{C:blue}筹码{}",
						"发生改变时，将改变量的 {C:entr_void}20%{}",
						"添加到此小丑的",
						"{C:red}倍率{}与{C:blue}筹码{}中"
					},
					{
						"在回合的最后一手牌，",
						"使用此小丑的{C:mult}倍率{}与{C:blue}筹码{}替代计分，",
						"随后{C:red}重置{}"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_pluripotent_larvae = {
				name = "多能性幼虫",
				text = {
					{
						"出售此小丑以{C:entr_void}逆位{}",
						"所有{C:entr_void}允许被逆位{}的小丑，",
						"并用{C:entr_void}逆位{}小丑填满空余的小丑槽"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_desiderium = {
				name = "向往",
				text = {
					{
						"如果在一个底注中用光了所有的",
						"{C:blue}出牌{}与{C:red}弃牌{}次数，",
						"获得 {C:entr_void}+#1#{} 小丑槽位",
						"{C:inactive}(当前为 #2#)"
					},
					{
						"{s:0} "
					}
				}
			},
			j_entr_nadir = {
				name = "天底",
				text = {
					{
						"使用此小丑以{C:entr_void}储存{}",
						"并摧毁所有其他小丑"
					},
					{
						"当另一张小丑触发时，",
						"{C:entr_void}强制触发{}一张随机储存的小丑"
					},
					{
						"{s:0} "
					}
				}
			},
			j_entr_yaldabaoth = {
				name = "亚尔达波特",
				text = {
					{
						"每个补充包将{C:entr_void}死亡标记{}",
						"赋予一张{C:attention}随机{}卡牌"
					},
					{
						"当带有{C:entr_void}死亡标记{}的卡牌",
						"被摧毁时，获得 {C:gold}+#1#{} 晋升强度",
						"{C:inactive}(当前为 {C:gold}+#2# {C:inactive}晋升强度)"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_mutagenesis = {
				name = "突变生成",
				text = {
					{
						"{C:attention}扑克牌{}上的效果",
						"将被添加到此小丑上"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_crooked_penny = {
				name = "扭曲的便士",
				text = {
					{
						"本回合每打出一次{C:blue}手牌{}",
						"结算金钱乘以 {X:money,C:white}X#1#{}",
						"{C:inactive}(额外副本呈加法叠加)"
					},
					{
						"离开商店时",
						"将金钱设为 {C:entr_void}$0{}"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_phoenix_a = {
				name = "凤凰座A*",
				text = {
					{
						"此小丑将在出牌时作为{C:entr_void}最后一张{}",
						"卡牌被打出，并在计分前，从末尾开始",
						"摧毁每一张具有相同点数的",
						"{C:entr_void}连续{}卡牌"
					},
					{
						"每当它摧毁一张卡牌时，此小丑",
						"获得 {X:mult,C:white}X#1#{} 倍率",
						"与 {X:blue,C:white}X#2#{} 筹码",
						"{C:inactive}(当前为 {X:mult,C:white}X#3#{C:inactive} {X:blue,C:white}X#4#{C:inactive})"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_antimatter_sheath = {
				name = "反物质刀鞘",
				text = {
					{
						"回合开始时，将 {C:attention}#1#{} 张",
						"临时的{C:attention}匕首{}",
						"副本加入手中"
					},
					{
						"当{C:attention}匕首{}计分时，",
						"摧毁整副牌组中一张{C:attention}随机{}",
						"卡牌，并获得",
						"{X:mult,C:white}X#2#{} 倍率与 {X:chips,C:white}X#3#{} 筹码",
						"{C:inactive}(当前为 {X:mult,C:white}X#4#{C:inactive}, {X:chips,C:white}X#5#{C:inactive})"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_caledscratch = {
				name = "断刚剑",
				text = {
					{
						"扑克牌的重新触发会被阻挡并储存",
						"每有一份{C:entr_void}储存{}的重新触发，",
						"就将最左侧的{C:attention}小丑{}重新触发一次，",
						"随后重置次数"
					},
					{
						"{s:0} "
					},
				}
			},
			j_entr_nyx = {
				name = "尼克斯，虚空之主",
				text = {
					{
						"选择{C:attention}盲注{}时，",
						"每有一张非逆位小丑，就创造",
						"{C:attention}1{} 张 {C:dark_edition}负片{} {C:attention}临时{} 的",
						"{C:entr_void}逆位{}小丑"
					},
					{
						"花费 {X:money,C:white}X#1#{} 此小丑成本加上",
						"高亮卡牌成本的金钱来使用此小丑，",
						"移除所有选中卡牌的{C:entr_void}临时{}状态",
						"{C:inactive}(当前花费为 {C:money}$#2#{C:inactive})"
					},
					{
						"{s:0} "
					}
				}
			},

			j_lusty_joker_gfb = {
				name = "猎奇小丑",
				text= {
					"拥有 {C:hearts}#2#{} 花色的",
					"扑克牌在计分时",
					"提供 {X:entr_freaky,C:white}Xlog_#1#(Chips){} 筹码"
				}
			},
			j_space_joker_gfb = {
				name = "太空小丑",
				text = {
					"有 {C:green}#1# / #2#{} 几率",
					"为一张随机小丑添加",
					"{C:dark_edition}闪箔{}、{C:dark_edition}镭射{} 或",
					"{C:dark_edition}多彩{} 版本"
				}
			},
			j_hanging_chad_gfb = {
				name = "悬挂的查德",
				text = {
					{
						"将第一张计分牌",
						"或留在手中的卡牌",
						"额外重新触发 {C:attention}#1#{} 次"
					},
					{
						"{C:red,E:1}对这个重制满意不，",
						"{C:red,E:1}这帮菜鸡？"
					}
				}
			},
			j_smiley_gfb = {
				name = "晴朗的脸",
				text = {
					"打出的{C:attention}人头{}牌",
					"在计分时提供",
					"{C:gold}+#1#{} 晋升强度"
				}
			},
			j_blueprint_gfb = {
				name = "猩红蓝图",
				text = {
					{
						"复制左侧",
						"{C:attention}小丑{}的能力"
					},
					{
						"{C:red,E:1}反正我也没怎么",
						"{C:red,E:1}喜欢过那个蓝色的家伙{}"
					}
				}
			},
			j_brainstorm_gfb = {
				name = "头脑风暴",
				text = {
					{
						"复制最右侧",
						"{C:attention}小丑{}的能力"
					},
					{
						"{C:red,E:1}你拿起这个之前",
						"{C:red,E:1}最好先洗洗手",
						"{C:red,E:1}真的"
					}
				}
			},
			j_stone_gfb = {
				name = "石头小丑",
				text = {
					"在商店结束时",
					"将所有的扑克牌",
					"替换为{C:attention}石头牌{}"
				}
			},
			j_golden_gfb = {
				name = "迈达斯之触",
				text = {
					"所有商店与补充包里的",
					"物品全都变成{C:attention}黄金牌{}"
				}
			},
			j_joker_gfb = {
				name = "小臭",
				text = {
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率, {C:mult}-#1#{} 倍率",
					"{C:mult}+#1#{} 倍率",
				}
			},
			j_entr_searing_joke_gfb = {
				name = "负面脉冲",
				text = {
					{
						"使用此小丑将手中",
						"持有的所有卡牌的",
						"点数降低 {C:attention}2{}",
						"{C:inactive}(2和3会被摧毁)"
					},
					{
						"击败Boss盲注时，",
						"此小丑获得 {C:attention}#2#{} 次使用次数",
						"{C:inactive}(当前为 {C:attention}#1#{C:inactive} 次使用次数)"
					}
				}
			},
			j_entr_gros_michel_2 = {
				name = "大米歇尔 {s:1.5,C:red}2",
				text = {
					"{X:slib_emult,C:white}^#1#{} 倍率",
                    "在回合结束时，此牌有",
                    "{C:green}#2# / #3#{} 几率",
                    "被摧毁",
				}
			},
			j_photograph_gfb = { name = "#2#" },
			j_banner_gfb = {
				name = "旗帜",
				text = {
					{
						"每次剩余的",
						"{C:attention}弃牌{}提供",
						"{C:chips}+#1#{} 筹码",
					}, 
					{
						"当一张牌被出售时",
						"将其放逐"
					}
				}
			},
            j_chaos_gfb = {
                name = "混沌小丑",
                text = {
					"商店中每{C:attention}重掷{}一次，",
					"此小丑获得 {C:chips}+#2#{} 筹码",
					"{C:green}所有重掷免费{}",
					"{C:inactive}(当前为 {C:chips}+#1#{C:inactive} 筹码)",
                },
            },
			j_diet_cola_gfb = {
				name = "无糖可乐",
				text = {
					"当一张小丑被出售时",
					"创造一个对应的",
					"{C:entr_zenith}稀有度{}的 {C:attention}标签{}"
				}
			},
			j_credit_card_gfb = {
				name = "信用卡",
				text = {
					{
						"允许你背负",
						"高达 {C:red}-$#1#{} 的债务",
					},
					{
						"如果处于{C:red}负债{}状态",
						"在商店结束时将金钱",
						"乘以 {X:money,C:white}X1.25{}"
					}
				}
			},
			j_certificate_gfb = {
				name = "证书",
				text = {
					{
						"回合开始时，",
						"将一张带有随机{C:attention}蜡封{}的",
						"随机{C:attention}证书{}",
						"加入手中"
					},
				}
			}
		},
		Blind = {
			bl_entr_red = {
				name = "红房间",
				text = {
					"???"
				}
			},
			bl_entr_abyss = {
				name = "深渊",
				text = {
					"被击败后获得新效果并增加盲注要求",
					"失败时会增加底注",
					"连续输掉两次直接结束游戏",
				}
			},
			bl_entr_void = {
				name = "???",
				text = {
					"???"
				}
			},
			bl_entr_scarlet_sun = {
				name = "绯红之日",
				text = {
					"此盲注期间，每触发一个小丑",
					"计分后扣除 0.25 晋升强度"
				}
			},
			bl_entr_burgundy_baracuda = {
				name = "勃艮第梭鱼",
				text = {
					"打出的卡牌有二分之一几率被摧毁"
				}
			},
			bl_entr_diamond_dawn = {
				name = "钻石黎明",
				text = {
					"剥夺所有弃掉的卡牌的点数和花色"
				}
			},
			bl_entr_olive_orchard = {
				name = "橄榄果园",
				text = {
					"出牌或弃牌时，手中的卡牌变为否认牌"
				}
			},
			bl_entr_citrine_comet = {
				name = "黄水晶彗星",
				text = {
					"选定的卡牌有二分之一几率摧毁其相邻的卡牌"
				}
			},
			bl_entr_entropic_cultist = {
				name = "熵增教徒",
				text = {
					"复制 3 个随机的决战盲注",
					"击败后直接跳至底注 32"
				}
			},
			bl_entr_endless_entropy_phase_one = {
				name = "燃烧硫磺",
				text = {
					"???",
				}
			},
			bl_entr_ee_church = {
				name = "埃克莱西亚",
				text= {"???"}
			},
			bl_entr_ee_puppet = {
				name = "刺穿傀儡",
				text= {"???"}
			},
			bl_entr_ee_erebus = {
				name = "厄瑞玻斯",
				text= {"???"}
			},
			bl_entr_ee_decay = {
				name = "虚伪衰变",
				text= {"???"}
			},
			bl_entr_ee_extinction = {
				name = "艾克萨列普西",
				text= {"???"}
			},
			bl_entr_ee_nadir = {
				name = "无名天底",
				text= {"???"}
			},
			bl_entr_ee_euphoria = {
				name = "艾福莉亚",
				text= {"???"}
			},
			bl_entr_ee_fracture = {
				name = "狂热碎裂",
				text= {"???"}
			},
			bl_entr_ee_feast = {
				name = "埃奥尔蒂",
				text= {"???"}
			},
			bl_entr_ee_cleave = {
				name = "灾厄切肉刀",
				text= {"???"}
			},
			bl_entr_ee_desperation = {
				name = "无尽熵增",
				text= {"???"}
			},
			bl_entr_alabaster_anchor = {
				name = "雪花石膏锚",
				text = {
					"打出手牌、弃牌、",
					"选择/取消选择扑克牌时",
					"会使小丑的数值暂时减少 5%"
				}
			},
			--alt blinds
			bl_entr_alpha = {
				name = "阿尔法",
				text = {
					"每手牌中第一张计分卡牌被摧毁"
				}
			},
			bl_entr_beta = {
				name = "贝塔",
				text = {
					"-1 手牌上限",
					"每打出一手牌，手牌上限再 -1"
				}
			},
			bl_entr_gamma = {
				name = "伽马",
				text = {
					"根据未打出的花色数量，除以基础倍率"
				}
			},
			bl_entr_delta = {
				name = "德尔塔",
				text = {
					"根据在此盲注中打出的手牌数量，除以最终倍率"
				}
			},
			bl_entr_epsilon = {
				name = "艾普西隆",
				text = {
					"根据打出的卡牌数量，除以最终倍率"
				}
			},
			bl_entr_zeta = {
				name = "泽塔",
				text = {
					"手牌不能包含 3 张或 5 张卡牌"
				}
			},
			bl_entr_eta = {
				name = "伊塔",
				text = {
					"#1# 卡牌被削弱",
					"每次出牌后改变目标"
				}
			},
			bl_entr_theta = {
				name = "西塔",
				text = {
					"倍率运算现在改为影响筹码"
				}
			},
			bl_entr_iota = {
				name = "约塔",
				text = {
					"应用 #1# 的效果",
					"每次出牌后改变目标"
				}
			},
			bl_entr_kappa = {
				name = "卡帕",
				text = {
					"计分卡牌不计分，未计分的卡牌代为计分"
				}
			},
			bl_entr_lambda = {
				name = "拉姆达",
				text = {
					"计分的卡牌将在 5 个回合内被削弱"
				}
			},
			bl_entr_mu = {
				name = "缪",
				text = {
					"选定卡牌的点数总和不能超过 30"
				}
			},
			bl_entr_nu = {
				name = "纽",
				text = {
					"每触发一张卡牌，利息变为 0.8x"
				}
			},
			bl_entr_xi = {
				name = "克西",
				text = {
					"第一手被弃掉的卡牌变为永恒状态"
				}
			},
			bl_entr_omicron = {
				name = "奥密克戎",
				text = {
					"第一手打出的牌不提供分数"
				}
			},
			bl_entr_pi = {
				name = "派",
				text = {
					"弃掉的卡牌返回牌组"
				}
			},
			bl_entr_rho = {
				name = "柔",
				text = {
					"根据打出点数的数量，除以最终倍率"
				}
			},
			bl_entr_sigma = {
				name = "西格玛",
				text = {
					"出牌次数与弃牌次数现在共享总数"
				}
			},
			bl_entr_tau = {
				name = "陶",
				text = {
					"+1 选牌上限",
					"弃牌时 -1 选牌上限"
				}
			},
			bl_entr_upsilon = {
				name = "宇普西隆",
				text = {
					"计分卡牌提供 -0.25 晋升强度"
				}
			},
			bl_entr_phi = {
				name = "斐",
				text = {
					"非 A、3、6、8 或 9 的卡牌被削弱"
				}
			},
			bl_entr_chi = {
				name = "基",
				text = {
					"每个点数中第一张计分的卡牌被削弱"
				}
			},
			bl_entr_psi = {
				name = "普西",
				text = {
					"计分的卡牌有二分之一几率变成否认牌"
				}
			},
			bl_entr_omega = {
				name = "欧米伽",
				text = {
					"打出 #1# 时将分数要求乘以 2 倍"
				}
			},

			bl_entr_styx = {
				name = "悲苦之河",
				text = {
					"小丑与扑克牌无法被重新排列",
					"在手牌计分前自动移动 1 张小丑与 1 张扑克牌"
				}
			},
			bl_entr_choir = {
				name = "冷酷合唱团",
				text = {
					"触发过的小丑在本回合内被削弱"
				}
			},
			bl_entr_pandora = {
				name = "纯净潘多拉",
				text = {
					"抽牌时，有三分之一的几率",
					"改为抽一张随机的临时卡牌"
				}
			},
			bl_entr_cassandra = {
				name = "羁囚卡珊德拉",
				text = {
					"弃掉的卡牌返回牌组，",
					"五分之一的小丑在计分前被削弱"
				}
			},
			bl_entr_labyrinth = {
				name = "无限迷宫",
				text = {
					"+3 手牌上限，+1 选牌上限",
					"卡牌无法被取消选择",
					"当一张卡牌被选中时，随机选择另一张卡牌"
				}
			},

			bl_entr_small = {
				name = "小盲注",
				text = {
					
				}
			},
			bl_entr_big = {
				name = "大盲注",
				text = {
					
				}
			},

			bl_entr_paw = {
				name = "爪子",
				text = {
					"所有非猎奇版本的",
					"卡牌均被削弱"
				}
			}
		},
		Edition = {
			e_entr_solar = {
				name = "烈阳",
				text = {
					"{X:gold,C:white}X#1#{} 晋升强度",
				},
			},
			e_entr_fractured = {
				name = "碎裂",
				text = {
					"计分时{C:dark_edition}强制触发{}",
					"{C:attention}#1#{} 张随机卡牌"
				},
			},
			e_entr_sunny = {
				name = "晴朗",
				text = {
					"{C:gold}+#1#{} 晋升强度",
					"朋友，你听过{X:gold,C:white}飞升{}",
					"笑话吗？"
				}
			},
			e_entr_freaky = {
				name = "猎奇",
				text = {
					"{X:entr_freaky,C:white}Xlog_#1#(筹码){} 筹码"
				},
			},
			e_entr_neon = {
				name = "霓虹",
				text = {
					"被动提供",
					"{C:attention}X#1#{} 商店成本"
				},
			},
			e_entr_neon_gfb = {
				name = "霓虹",
				text = {
					"被动提供",
					"{C:attention}+1{} 商店槽位"
				},
			},
			e_entr_lowres = {
				name = "低清",
				text = {
					"{C:attention}重新触发{}此牌 {C:attention}#1#{} 次",
					"卡牌数值 {C:attention}X#2#{} {C:inactive}(如果可能的话){}"
				},
			},
			e_entr_kaleidoscopic = {
				name = "万花筒",
				text = {
					"重新触发此卡牌区域内的",
					"{C:attention}#1#{} 张随机卡牌"
				},
			},
			e_entr_gilded  = {
				name = "镀金",
				text = {
					"{C:attention}重新触发{}此牌"
				},
			},
			e_entr_gilded_consumable = {
				name = "镀金",
				text = {
					"使用时",
					"触发{C:attention}两次{}"
				},
			},
		},
		Back = {
			b_entr_twisted = {
				name = "扭曲牌组",
				text =  {
								"所有{C:red}可逆位{}的消耗牌",
								"都将自动转为{C:red}逆位{}状态",
							}
			},
			b_entr_ccd2 = {
				name = "重定义牌组",
				text =  {
								"每张牌同样也是一张随机的",
								"{C:attention}小丑{}、{C:attention}补充包{}、",
								"{C:attention}优惠券{}或{C:attention}消耗牌{}"
							}
			},
			b_entr_doc = {
				name = "收容牌组",
				text = {
					"打出版本/增强卡牌、隐藏牌型或",
					"使用消耗牌时获得 {X:dark_edition,C:white}熵{}。{C:entr_entropic}超越{}、",
					"{C:cry_exotic}真理之门{}与{C:spectral}幻灵包{}的出现频率提升",
					"筹码将根据 {X:dark_edition,C:white}熵{} 被降低"
				}
			},
			b_entr_doc_cryptidless = {
				name = "收容牌组",
				text = {
					"打出版本/增强卡牌、隐藏牌型或",
					"使用消耗牌时获得 {X:dark_edition,C:white}熵{}。{C:entr_entropic}狂热？{}、",
					"{C:cry_exotic}灵魂{}与{C:spectral}幻灵包{}的出现频率提升",
					"筹码将根据 {X:dark_edition,C:white}熵{} 被降低"
				}
			},
			b_entr_crafting = {
				name = "命运牌组",
				text =  {
					"小丑不再自然出现",
					"以一张{C:dark_edition}Aleph、负片{} {T:c_entr_destiny}命运{}开局",
					"卡牌更容易获得增强",
					"以{C:attention,T:v_magic_trick}魔术戏法{}和{C:attention,T:v_illusion}幻觉{}开局"
				}
			},
			b_entr_butterfly = {
				name = "蝴蝶牌组",
				text =  {
					"{C:attention}-2{} 小丑槽位",
					"出售的小丑有 {C:green}1 / 2{}",
					"几率仍然触发"
				}
			},
			b_entr_ambisinister = {
				name = "左右互拙牌组",
				text =  {
					"{C:attention}小丑槽位{}与",
					"{C:dark_edition}选牌上限{}",
					"现在共享额度",
					"{C:attention}+3{} 小丑槽位"
				}
			},
			b_entr_gemstone = {
				name = "宝石牌组",
				text =  {
					"非符文消耗牌有 {C:green}#1# / #2#{} 几率",
					"{C:red}失效{}，每使用 {C:attention}2{} 张非符文消耗牌，",
					"创造一张随机{C:purple}符文牌{}"
				}
			},
			b_entr_corrupted = {
				name = "腐化牌组",
				text =  {
					"{C:attention}小丑{}与{C:attention}消耗牌{}",
					"在 {C:attention}3{} 个选项之间循环变动",
					"{C:red}-1{} 商店槽位"
				}
			},
			b_entr_discordant = {
				name = "畸形牌组",
				text =  {
					"新创造的{C:attention}卡牌{}、{C:attention}优惠券{}",
					"与{C:attention}补充包{}将被随机类型替换",
					"重掷成本增速{C:red}翻倍{}"
				}
			},
		},
		Sleeve = {
			sleeve_entr_twisted = {
				name = "扭曲牌套",
				text = {
					"所有{C:red}可逆位{}的消耗牌",
					"都将自动转为{C:red}逆位{}状态",
				},
			},
			sleeve_entr_ccd2 = {
				name = "重定义牌套",
				text = {
					"每张牌同样也是一张随机的",
					"{C:attention}小丑{}、{C:attention}补充包{}、",
					"{C:attention}优惠券{}或{C:attention}消耗牌{}"
				},
			},
			sleeve_entr_doc = {
				name = "异常牌套",
				text = {
					"打出版本/增强卡牌、隐藏牌型或",
					"使用消耗牌时获得 {X:dark_edition,C:white}熵{}。{C:entr_entropic}超越{}、",
					"{C:cry_exotic}真理之门{}与{C:spectral}幻灵包{}的出现频率提升",
					"筹码将根据 {X:dark_edition,C:white}熵{} 被降低"
				}
			},
			sleeve_entr_doc_cryptidless = {
				name = "异常牌套",
				text = {
					"打出版本/增强卡牌、隐藏牌型或",
					"使用消耗牌时获得 {X:dark_edition,C:white}熵{}。{C:entr_entropic}狂热？{}、",
					"{C:cry_exotic}灵魂{}与{C:spectral}幻灵包{}的出现频率提升",
					"筹码将根据 {X:dark_edition,C:white}熵{} 被降低"
				}
			},
			sleeve_entr_ambisinister = {
				name = "左右互拙牌套",
				text = {
					"{C:attention}小丑槽位{}与",
					"{C:dark_edition}选牌上限{}",
					"现在共享额度",
					"{C:attention}+3{} 小丑槽位"
				},
			},
			sleeve_entr_crafting = {
				name = "命运牌套",
				text =  {
					"小丑不再自然出现",
					"以一张{C:dark_edition}Aleph、负片{} {T:c_entr_destiny}命运{}开局",
					"卡牌更容易获得增强",
					"以{C:attention,T:v_magic_trick}魔术戏法{}和{C:attention,T:v_illusion}幻觉{}开局"
				}
			},
			sleeve_entr_butterfly = {
				name = "蝴蝶牌套",
				text =  {
					"{C:attention}-2{} 小丑槽位",
					"出售的小丑有 {C:green}1 / 2{}",
					"几率仍然触发"
				}
			},
			sleeve_entr_gemstone  = {
				name = "宝石牌套",
				text = {
					"非符文消耗牌有 {C:green}#1# / #2#{} 几率",
					"{C:red}失效{}，每使用 {C:attention}2{} 张非符文消耗牌，",
					"创造一张随机{C:purple}符文牌{}"
				},
			},
			sleeve_entr_corrupted = {
				name = "腐化牌套",
				text =  {
					"{C:attention}小丑{}与{C:attention}消耗牌{}",
					"在 {C:attention}2{} 个选项之间循环变动",
					"{C:red}-1{} 商店槽位"
				}
			},
		},
		Fraud = {
			c_entr_master = {
				name = "大师",
				text = {
					"创造你在本局游戏",
					"中使用的最后一张",
					"{C:red}逆位{}牌",
					"{s:0.8,C:red}大师{} {s:0.8}自身除外{}"
				}
			},
			c_entr_statue = {
				name = "雕像",
				text = {
					"将整副牌组中 {C:attention}#1#{} 张随机卡牌",
					"转换为选定的 {C:attention}#2#{} 张卡牌，",
					"然后将选定的卡牌",
					"转换为一张空白的{C:attention}石头牌{}"
				}
			},
			c_entr_whetstone = {
				name = "磨刀石",
				text = {
					"有 {C:green}#1# / #2#{} 几率",
					"随机{C:attention}升级{}最多 #3# 张",
					"选定卡牌的增强效果"
				}
			},
			c_entr_feast = {
				name = "盛宴",
				text = {
					"从{C:attention}商店{}中{C:attention}出售{}并{C:attention}摧毁{}",
					"最多 {C:attention}#1#{} 张选定的卡牌、",
					"优惠券或补充包，并获得",
					"{X:attention,C:white}X#2#{} 倍的购买成本金钱"
				}
			},
			c_entr_servant = {
				name = "仆从",
				text = {
					"创造 {C:attention}#1#{} 张随机消耗牌，属于",
					"最多选定的 {C:attention}#2#{} 张消耗牌的",
					"{C:red}逆位{}变体类型",
					"{C:inactive}(必须有空间){}"
				}
			},
			c_entr_endurance = {
				name = "忍耐",
				text = {
					"将 #1# 张选定的卡牌的",
					"数值乘以 {X:attention,C:white}X#2#{}，然后",
					"使其在接下来的 {C:attention}#3#{} 回合内失去能力"
				}
			},
			c_entr_scar = {
				name = "伤痕",
				text = {
					"为最多 {C:attention}#1#{} 张选定的",
					"卡牌应用{C:dark_edition}伤痕{}贴纸"
				}
			},
			c_entr_dagger = {
				name = "匕首",
				text = {
					"摧毁 {C:attention}#1#{} 张选定的扑克牌",
					"并将所选卡牌的 {X:dark_edition,C:white}X#2#{} 倍",
					"筹码添加至你",
					"{C:attention}最常用{}牌型的筹码中"
				}
			},
			c_entr_penumbra = {
				name = "半影",
				text = {
					"放逐 {C:attention}#1#{} 张选定",
					"卡牌的增强效果，然后",
					"{C:attention}摧毁{}这些选定的卡牌"
				}
			},
			c_entr_integrity = {
				name = "完整",
				text = {
					"移除 {C:attention}#1#{} 张选定卡牌",
					"上的{C:attention}增强效果{}，然后",
					"添加一个随机{C:dark_edition}蜡封与版本{}"
				}
			},
			c_entr_forgiveness = {
				name = "宽恕",
				text = {
					"创造一张随机的{C:attention}曾出售过{}的小丑",
					"{C:inactive}(数量可以溢出){}"
				}
			},
			c_entr_feud = {
				name = "世仇",
				text = {
					"选择 {C:attentiom}#1#{} 张卡牌，",
					"将{C:attention}右侧{}卡牌 {X:chips,C:white}X#3#{} 倍的{C:blue}筹码{}",
					"添加到{C:attention}左侧{}卡牌上，然后",
					"{C:attention}摧毁{}右侧的卡牌"
				}
			},
			c_entr_advisor = {
				name = "顾问",
				text = {
					"根据你最常用牌型的{C:attention}示例{}",
					"创造其{C:attention}增强版{}卡牌的副本",
					"并将其{C:attention}抽入{}手中"
				}
			},
			c_entr_heretic = {
				name = "异教徒",
				text = {
					"将最多 {C:attention}#1#{} 张选定卡牌的",
					"某个{C:attention}特性{}或{C:attention}修改效果{}随机化"
				}
			},
			c_entr_earl = {
				name = "伯爵",
				text = {
					"在接下来的回合中",
					"剩余的{C:blue}出牌次数{}提供 {C:money}$#1#{}",
					"剩余的{C:red}弃牌次数{}提供 {C:money}$#2#{}"
				}
			},
			c_entr_mason = {
				name = "石匠",
				text = {
					"创造 {C:attention}#1# 张带有",
					"随机{C:attention}版本{}的石头牌"
				}
			},
			c_entr_princess = {
				name = "公主",
				text = {
					"在{C:attention}当前{}底注的",
					"{C:attention}剩余{}时间内，",
					"{C:planet}星球{}牌将被替换",
					"为{C:purple}恒星{}牌"
				}
			},
			c_entr_imp = {
				name = "小鬼",
				text = {
					"将 {C:attention}#1#{} 张选定的卡牌",
					"增强为{C:attention}黑暗{}牌"
				}
			},
			c_entr_oracle = {
				name = "神谕",
				text = {
					"将手中持有的 {C:attention}#1#{} 张",
					"随机卡牌增强为",
					"带有{C:attention}版本{}的{C:purple}恒星{}牌"
				}
			},
			c_entr_ocean = {
				name = "海洋",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}方块",
					"{C:blue}+#4#{} 筹码"
				}
			},
			c_entr_forest = {
				name = "森林",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}梅花",
					"{C:blue}+#4#{} 筹码"
				}
			},
			c_entr_mountain = {
				name = "高山",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}红桃",
					"{C:blue}+#4#{} 筹码"
				}
			},
			c_entr_tent = {
				name = "帐篷",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}黑桃",
					"{C:blue}+#4#{} 筹码"
				}
			},
			c_entr_companion = {
				name = "伴侣",
				text = {
					"将{C:attention}利息{}上限提高 {C:gold}#1##2#{}",
					"然后根据利息上限获得{C:gold}金钱{}"
				}
			},
			c_entr_prophecy = {
				name = "预言",
				text = {
					"接下来的 {C:attention}#1#{} 张{C:red}逆位{}牌",
					"将变成上一次使用的{C:red}欺诈{}牌"
				}
			},
			c_entr_mallet = {
				name = "木槌",
				text = {
					"摧毁手中 {C:attention}#1#{} 张随机卡牌",
					"并创造 {C:attention}#1#{} 张随机{C:red}指令{}牌",
					"{C:inactive}(必须有空间){}"
				}
			},
			c_entr_village = {
				name = "村庄",
				text = {
					"给予{C:attention}留在{}手中的卡牌",
					"{C:blue}+#1#{} 额外筹码"
				}
			},
			c_entr_frail = {
				name = "脆弱",
				text = {
					"摧毁 {C:attention}#1#{} 张选定的卡牌",
					"并将它们的修改效果{C:attention}分配{}",
					"给手中持有的{C:attention}其他{}卡牌"
				}
			},
			c_entr_disturbance = {
				name = "干扰",
				text = {
					"放逐 {C:attention}#1#{} 张选定的卡牌",
					"而无需{C:attention}摧毁{}它们"
				}
			},
			c_entr_avarice = {
				name = "贪婪",
				text = {
					"立即打开 {C:attention}#1#{} 个标准补充包"
				}
			},
			c_entr_muse = {
				name = "缪斯",
				text = {
					"将任意 #1# 张选定的",
					"卡牌{C:attention}链接在一起{}"
				}
			},
			c_entr_garden = {
				name = "花园",
				text = {
					"将 {C:attention}#1#{} 张卡牌的点数与花色{C:attention}转换{}",
					"为统一的随机点数与花色"
				}
			},
			c_entr_desert = {
				name = "沙漠",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}十字星 (Fleurons)",
					"{C:blue}+#4#{} 筹码"
				}
			},
			c_entr_wastes = {
				name = "废土",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}戟 (Halberds)",
					"{C:blue}+#4#{} 筹码"
				}
			},
			c_entr_inferno = {
				name = "炼狱",
				text = {
					"摧毁{C:attention}所有{}选定的卡牌",
					"超过 {C:attention}2{} 张后，每多一张牌",
					"就失去 {C:money}$#1#{}"
				}
			},
		},
		Planet = {
			c_entr_wormhole = {
				name = "闯入者",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} 升级",
					"{C:attention}#1#",
					"{C:mult}+#3#{} 倍率 与",
					"{C:chips}+#4#{} 筹码",
				},
			},
			c_entr_tyche = {
				name = "堤喀",
				text = {
					"提升一个{C:attention}随机{}扑克牌型",
					"每级的{C:blue}筹码{}与{C:red}倍率{}加成",
					"每级 {C:mult}+#2#{} 倍率，",
					"每级 {C:chips}+#1#{} 筹码"
				},
			},
			c_entr_theia = {
				name = "忒伊亚",
				text = {
					"提升你等级{C:attention}最高{}的扑克牌型",
					"每级的{C:blue}筹码{}与{C:red}倍率{}加成",
					"每级 {C:mult}+#2#{} 倍率，",
					"每级 {C:chips}+#1#{} 筹码"
				},
			},
			c_entr_chiron = {
				name = "喀戎",
				text = {
					"提升一个{C:attention}随机{}扑克牌型",
					"每级的{C:blue}筹码{}加成",
					"每级 {C:chips}X#1#{} 筹码"
				},
			},
			c_entr_neith = {
				name = "奈斯",
				text = {
					"提升一个{C:attention}随机{}扑克牌型",
					"每级的{C:red}倍率{}加成",
					"每级 {C:mult}X#1#{} 倍率"
				},
			},
			c_entr_sputnik = {
				name = "斯普特尼克 1 号",
				text = {
					"升级 {C:attention}#1#{} 个",
					"随机扑克牌型",
					"{C:mult}+???{} 倍率 与",
					"{C:chips}+???{} 筹码",
				},
			},
		},
		Voucher = {
			v_entr_marked = {
				name = "标记卡牌",
				text = {
					"{C:red}逆位{}消耗牌有",
					"固定的 {C:red}10%{} 几率",
					"取代其普通对应版本出现"
				},
			},
			v_entr_trump_card = {
				name = "王牌",
				text = {
					"{C:red}翻转卡{}可以出现在",
					"{C:attention}天体{}与{C:attention}秘术{}补充包中",
				},
			},
			v_entr_supersede = {
				name = "取代",
				text = {
					"{C:red}扭曲{}补充包有",
					"固定的 {C:red}20%{} 几率",
					"取代商店中的任何其他补充包"
				},
			},

			v_entr_diviner = {
				name = "占卜师",
				text = {
					"提高{C:purple}符文{}在",
					"补充包中出现的几率"
				},
			},
			v_entr_providence = {
				name = "{E:entr_shader}天命{}",
				text = {
					"符文拥有{C:purple,E:1}增强{}效果",
				},
			},
			v_entr_ascension = {
				name = "飞升",
				text = {
					"复制每回合",
					"使用的{C:attention}第一张{} {C:purple}符文{}",
				},
			},
			v_entr_starter_kit = {
				name = "新手包",
				text = {
					"{C:attention}补充包{}可以",
					"取代商店中的",
					"卡牌出现"
				},
			},
			v_entr_expansion_pack = {
				name = "扩展包",
				text = {
					"每 {C:attention}2{} 个底注，",
					"在优惠券槽位",
					"创造一套{C:attention}牌组{}",
				},
			},
		},
		Command = {
			c_entr_memory_leak = {
				name = "(~)$ memoryleak (内存泄漏)",
				text = {
					"{C:red}int *m = new int{}",
				}
			},
			c_entr_root_kit = {
				name = "(~)$ rootkit (后门)",
				text = {
					"在下一个击败的盲注中，",
					"多余的出牌次数提供 {C:red}$#1#{}",
				}
			},
			c_entr_break = {
				name = "(~)$ break; (跳出)",
				text = {
					"返回到{C:red}选择盲注{}界面，",
					"{C:red}当前的盲注{}仍处于即将到来状态",
				}
			},
			c_entr_interference = {
				name = "(~)$ interference (干扰)",
				text = {
					"{C:red}随机化{} {C:attention}打出的手牌{}、{C:attention}盲注规模{}",
					"以及{C:attention}结算资金{}，持续到",
					"{C:red}当前回合{}结束"
				}
			},
			c_entr_fork = {
				name = "(~)$ fork (分支)",
				text = {
					"创造一张选定的{C:attention}扑克牌{}的",
					"{C:red}故障{}副本，并赋予它",
					"一个新的{C:red}随机增强效果{}"
				}
			},
			c_entr_push = {
				name = "(~)$ push -f (强推)",
				text = {
					"{C:red}摧毁{}所有持有的{C:attention}小丑{}，{C:red}创造{}一张",
					"基于它们{C:red}稀有度{}生成的",
					"新{C:attention}小丑{}",
					
				}
			},
			c_entr_increment = {
				name = "(~)$ increment (自增)",
				text = {
					"{C:red}+1{} {C:attention}商店槽位{}",
					"持续到{C:attention}当前底注{}结束",
				}
			},
			c_entr_decrement = {
				name = "(~)$ decrement (自减)",
				text = {
					"将 {C:red}#1#{} 张选定的 {C:attention}小丑#<s>1#{}",
					"转换为在{C:red}收藏列表{}中",
					"位于它前面的{C:red}小丑{}",
					"{C:inactive}(当前为 #2#){}"
				}
			},
			c_entr_cookies = {
				name = "(~)$ cookies (Cookie)",
				text = {
					"创造一张{C:dark_edition}负片{}的{C:red}糖果小丑{}",
				}
			},
			c_entr_overflow = {
				name = "(~)$ overflow (溢出)",
				text = {
					"{C:red}无限{}的{C:attention}选牌上限{}",
					"直到{C:red}当前盲注{}结束",
				}
			},
			c_entr_refactor = {
				name = "(~)$ refactor (重构)",
				text = {
					"将一张选定{C:red}小丑{}的{C:attention}版本{}",
					"应用到一张随机的{C:red}小丑{}上",
				}
			},
			c_entr_ctrl_x = {
				name = "(~)$ ctrl+x (剪切)",
				text = {
					"{C:red}#1#{} #2# {C:attention}卡牌{}，",
					"{C:attention}补充包{}或{C:attention}优惠券{}",
					"{C:inactive}(当前为 #3#){}"
				}
			},
			c_entr_segfault = {
				name = "(~)$ segfault (段错误)",
				text = {
					"创造一张随机的{C:attention}扑克牌{}",
					"应用一个{C:red}随机{}的{C:attention}消耗牌{}、{C:attention}小丑{}、",
					"{C:attention}补充包{}或{C:attention}优惠券{}作为其{C:red}增强效果{}",
					"然后将其洗入{C:attention}牌组{}"
				}
			},
			c_entr_sudo = {
				name = "(~)$ sudo (提权)",
				text = {
					"{C:red}永久{}修改{C:attention}一种{}选定的",
					"{C:red}扑克牌型{}，使其计分时始终",
					"被视为{C:attention}另一种{} {C:red}扑克牌型{}"
				}
			},
			c_entr_constant = {
				name = "(~)$ constant (常量)",
				text = {
					"将所有与 {C:attention}1{} 张选定卡牌",
					"点数相同的{C:red}卡牌{}，",
					"全部转换为该{C:red}选定卡牌{}"
				}
			},
			c_entr_new = {
				name = "(~)$ new() (新建)",
				text = {
					"在下一个{C:attention}即将到来{}的盲注前，",
					"添加一个{C:attention}额外{}的{C:red}红房间{}盲注",
				}
			},
			c_entr_multithread = {
				name = "(~)$ multithread (多线程)",
				text = {
					"为{C:red}手中{}所有{C:red}选中{}的卡牌",
					"创造临时的 {C:dark_edition}负片{}副本",
				}
			},
			c_entr_invariant = {
				name = "(~)$ invariant (不可变)",
				text = {
					"将一张 {C:red}Invariant (不可变){} 贴纸",
					"应用到{C:red}商店{}中的 1 张选定卡牌上",
				}
			},
			c_entr_inherit = {
				name = "(~)$ inherit (继承)",
				text = {
					"将{C:red}所有{}与 1 张选定卡牌",
					"拥有相同{C:red}增强{}的卡牌，",
					"统一转换为一种{C:red}你选择的增强",
				}
			},
			c_entr_autostart = {
				name = "(~)$ autostart (自启)",
				text = {
					"获得 {C:red}#1#{} 个在此局游戏中",
					"{C:red}曾获得过{}的随机跳过标签",
				}
			},
			c_entr_quickload = {
				name = "(~)$ quickload (快载)",
				text = {
					"{C:red}重新触发{}结算画面",
					"但{C:red}不提供{}盲注金钱",
				}
			},
			c_entr_hotfix = {
				name = "(~)$ hotfix (热修)",
				text = {
					"将一张 {C:red}Hotfix (热修){} 贴纸",
					"应用到 1 张选定卡牌上",
				}
			},
			c_entr_pseudorandom = {
				name = "(~)$ pseudorandom (伪随机)",
				text = {
					"将一张 {C:red}Pseudorandom (伪随机){} 贴纸",
					"应用到屏幕上的{C:red}所有{}卡牌上",
				}
			},
			c_entr_bootstrap = {
				name = "(~)$ bootstrap (引导)",
				text = {
					"{C:red}此{}次出牌的最终 {C:blue}筹码{} 与 {C:red}倍率{}",
					"将应用到下一次出牌的",
					"基础 {C:blue}筹码{} 与 {C:red}倍率{}中"
				}
			},
			c_entr_local = {
				name = "(~)$ local (局部)",
				text = {
					"将 {C:red}临时{} 状态应用到",
					"#1# 张选定的扑克牌上"
				}
			},
			c_entr_transpile = {
				name = "(~)$ transpile (转译)",
				text = {
					"{C:dark_edition}#1#{} 小丑槽位",
					"{C:dark_edition}+#2#{} 消耗牌槽位",
					"{C:dark_edition}+#3#{} 手牌上限"
				}
			},
			c_entr_detour = {
				name = "(~)$ detour (绕道)",
				text = {
					"创造一张类型与你{C:attention}上一次获得{}",
					"的卡牌、补充包或优惠券{C:attention}相对应{}的",
					"{C:attention}卡牌、补充包或优惠券{}",
					"{C:inactive}(当前为 #1#){}"
				}
			},
			c_entr_mbr = {
				name = "(~)$ mbr (主引导记录)",
				text = {
					"向当前商店的补充包区",
					"添加一个{C:dark_edition}香蕉优惠券包{}",
				}
			},
			c_entr_desync = {
				name = "(~)$ desync (失步)",
				text = {
					"将一张 {C:red}Desync (失步){} 贴纸",
					"应用到 1 个选定小丑或消耗牌上",
				}
			},
			c_entr_badarg = {
				name = "(~)$ bad arg* (错误参数)",
				text = {
					"在游戏{C:attention}剩余时间{}内，{C:red}阻止{}一种",
					"{C:attention}选定{}的扑克牌型{C:red}计分{}",
					"或消耗出牌次数"
				}
			},
			c_entr_interpolate = {
				name = "(~)$ interpolate (插值)",
				text = {
					"选择并{C:red}摧毁{} #1# 张选定的{C:attention}小丑#<s>1#{}",
					"或{C:attention}消耗牌#<s>1#{}，此卡可能在未来的",
					"{C:red}扭曲{}或{C:cry_code}程序{}包中出现"
				}
			},
			c_entr_overload = {
				name = "(~)$ overload (重载)",
				text = {
					"{C:attention}下一次{}打出的手牌，",
					"将被视为包含{C:red}所有{}",
					"其他牌型"
				}
			},
			c_entr_echo = {
				name = "(~)$ echo (回显)",
				text = {
					"选择{C:attention}两张{}消耗牌",
					"当它们被使用时，将{C:dark_edition}触发{}",
					"对方的效果",
					"{C:inactive}(包含商店中的消耗牌){}"
				}
			},
		},
		Star = {
			c_entr_regulus = {
				name = "比邻星",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_hydrae = {
				name = "半人马座α",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_vega = {
				name = "北极星",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_polaris = {
				name = "阁道二",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_cassiopeiae = {
				name = "御夫座α",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_pegasi = {
				name = "特拉比斯特-1",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_persei = {
				name = "开普勒-90",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_ophiuchi = {
				name = "巨蟹座55",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_carinae = {
				name = "参宿四",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_procyon = {
				name = "南河三 B",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_tauri = {
				name = "W33A",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_sirius = {
				name = "天狼星",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_starspectrum = {
				name = "织女星",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_starstraightspectrum = {
				name = "参宿七",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_starhousespectrum = {
				name = "天棓四",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_starfivespectrum = {
				name = "HD 33579",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_multiverse = {
				name = Cryptid_config.family_mode and "多元宇宙" or "TM的整个多元宇宙",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_binarystars = {
				name = "开阳星",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_deadcore = {
				name = "死核星",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_dark_matter = {
				name = "暗物质",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_dyson_swarm = {
				name = "戴森云",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_starlua = {
				name = "Star.lua",
				text = {
					"有 {C:green}#1# / #2#{} 几率",
					"为每一种{C:legendary,E:1}扑克牌型{}",
					"升级 {C:gold}+#3#{} 晋升强度",
				}
			},
			c_entr_strange_star = {
				name = "奇异星",
				text = {
					"随机升级一个{C:legendary,E:1}扑克牌型{}",
					"本局游戏中每使用过",
					"一张{C:attention}奇异星{}",
					"{C:attention}+#2#{} {C:gold}晋升强度{}",
					"{C:inactive}(当前为{C:attention} #1#{C:inactive}){}",
				}
			},
			c_entr_nemesis = {
				name = "涅墨西斯",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){}",
					"增加{C:attention}晋升{}牌型的",
					"指数 {X:gold,C:white}+X#2#{}",
					"{C:inactive}(当前为 {X:gold,C:white}#3#{C:inactive})",
				}
			},
			c_entr_paras = {
				name = "Paras",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与 {C:attention}#3#{}",
					"{C:gold}+#7#{} 晋升强度"
				},
			},
			c_entr_jatka = {
				name = "Jatka",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与 {C:attention}#3#{}",
					"{C:gold}+#7#{} 晋升强度"
				},
			},
			c_entr_rouva = {
				name = "Rouva",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与 {C:attention}#3#{}",
					"{C:gold}+#7#{} 晋升强度"
				},
			},
			c_entr_assa = {
				name = "Assa",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与 {C:attention}#3#{}",
					"{C:gold}+#7#{} 晋升强度"
				},
			},
			c_entr_kivi = {
				name = "Kivi",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与 {C:attention}#3#{}",
					"{C:gold}+#7#{} 晋升强度"
				},
			},
			c_entr_chunk = {
				name = "Chunk",
				text = {
					"({V:1}lvl.#4#{}{C:gold}#8#{})({V:2}lvl.#5#{}{C:gold}#9#{})({V:3}lvl.#6#{}{C:gold}#10#{})",
					"升级",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"与 {C:attention}#3#{}",
					"{C:gold}+#7#{} 晋升强度"
				},
			},
			c_entr_supernova = {
				name = "坍缩",
				text = {
					"从你{X:purple,C:white}涅墨西斯{}增加最多的",
					"{C:gold}晋升强度{}中",
					"扣除 #1# {C:gold}晋升强度{}，并加给",
					"{C:legendary,E:1}指定扑克牌型{}",
				},
			},
			c_entr_pocket_dimension = {
				name = "口袋空间",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#1#{}{S:0.8,C:gold}#2#{}{S:0.8}){} 升级",
					"{C:attention}#3#",
					"{C:gold}+#4#{} 晋升强度"
				}
			},
			c_entr_black_dwarf = {
				name = "黑矮星",
				text = {
					"所有扑克牌型每有 1 级",
					"就提升其 {C:gold}晋升强度{}",
					"{C:gold}+#1#{} 晋升强度"
				}
			},
			c_entr_frozen_star = {
				name = "冰冻星",
				text = {
					"提升你等级{C:attention}最高{}的",
					"扑克牌型",
					"{C:gold}+#1#{} 晋升强度"
				}
			},
			c_entr_coatlicue = {
				name = "科亚特利库埃",
				text = {
					"随机升级一种扑克牌型的",
					"{C:gold}晋升强度{}，增加量等同于",
					"其每级提供{C:chips}筹码{}的 {C:attention}1/20{}"
				}
			},
			c_entr_threefour = {
				name = "金牛座34",
				text = {
					"随机升级一种扑克牌型的",
					"{C:gold}晋升强度{}，增加量等同于",
					"其每级提供{C:mult}倍率{}的 {C:attention}1/3{}"
				}
			},
			c_entr_fuzzball = {
				name = "绒毛球",
				text = {
					"升级 {C:attention}#1#{} 个",
					"随机扑克牌型",
					"{C:gold}+#2#{} 晋升强度",
				}
			},
		},
		Omen = {
			c_entr_rift = {
				name = "裂隙",
				text = {
					"将一种{C:attention}随机{}的{C:dark_edition}版本{}",
					"应用到 {C:attention}#1#{} 张选定卡牌上"
				}
			},
			c_entr_define = {
				name = "#define (宏定义)",
				text = {
					"将{C:entr_omen}选定卡牌{}在未来",
					"的所有实例，替换为你{C:entr_omen}指定{}的",
					"卡牌，随后{C:attention}摧毁{}该选定卡牌",
					"{C:inactive}(隐藏消耗牌及{}",
					"{C:inactive}域外及以上小丑除外){}"
				}
			},
			c_entr_beyond = {
				name = "超越",
				text = {
					"创造一张随机的",
					"{C:entr_entropic,E:1}熵增{}小丑",
					"摧毁手中所有其他小丑"
				}
			},
			c_entr_highway = {
				name = "公路",
				text = {
					"摧毁{C:red}所有{}小丑，只保留{C:attention}一{}张",
					"然后创造一张{C:entr_entropic,E:1}熵增{}小丑"
				}
			},
			c_entr_fervour={
                name="狂热",
                text={
                    "创造一张",
                    "{C:entr_reverse_legendary,E:1}传奇？ {}小丑",
                    "{C:inactive}(必须有空间)",
                },
            },
			c_entr_pulsar = {
				name = "脉冲星",
				text = {
					"将你打出次数最多的",
					"{C:legendary,E:1}扑克牌型{}的晋升强度",
					"提升其当前等级的 {X:gold,C:white}X3{} 倍",
					"{C:inactive}({C:gold}+#1#{C:inactive} 晋升强度)",

				}
			},
			c_entr_quasar = {
				name = "类星体",
				text = {
					"将所有{C:legendary,E:1}扑克牌型{}的",
					"晋升强度提升",
					"其{C:attention}当前{}等级的一半"
				}
			},

			c_entr_dispel = {
				name = "驱散",
				text = {
					"放逐 {C:attention}#1#{} 张选定的小丑",
					"{C:inactive}(无视永恒状态){}"
				}
			},
			c_entr_weld = {
				name = "焊接",
				text = {
					"将 {C:dark_edition}负片{} 与 {C:purple,E:1}Aleph (真理){}",
					"应用到 #1# 张选定小丑上"
				}
			},
			c_entr_cleanse = {
				name = "净化",
				text = {
					"{C:attention}移除{}手中{C:attention}所有{}卡牌的",
					"花色与点数",
					"每剥夺 1 筹码获得 {C:gold}$#1#{}"
				}
			},

			c_entr_insignia = {
				name = "徽记",
				text = {
					"将 {V:1}银色蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},
			c_entr_rendezvous = {
				name = "幽会",
				text = {
					"将 {V:1}猩红蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},
			c_entr_eclipse = {
				name = "帷幕",
				text = {
					"将 {V:1}蓝宝石蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},
			c_entr_calamity = {
				name = "灾厄",
				text = {
					"将 {V:1}粉色蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},
			c_entr_downpour = {
				name = "倾盆大雨",
				text = {
					"将 {V:1}天蓝蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},
			c_entr_script = {
				name = "手稿",
				text = {
					"将 {V:1}翠绿蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},
			c_entr_inscribe = {
				name = "铭刻",
				text = {
					"将手中所有数字牌的筹码",
					"乘以 {X:chips,C:white}X#1#{}",
					"然后将手中所有数字牌{C:attention}削弱{}",
					"持续 1 回合"
				}
			},
			c_entr_siphon = {
				name = "虹吸",
				text = {
					"摧毁 1 张选定的{C:attention}带版本{}",
					"小丑，然后将其{C:attention}原有的{}版本应用到",
					"手中 {C:attention}#2#{} 张随机卡牌上",
					"{C:inactive}(当前为 {C:dark_edition}#1#{C:inactive}, 排除 {C:dark_edition}负片{C:inactive})"
				}
			},
			c_entr_changeling = {
				name = "换形者",
				text = {
					"将手中 {C:attention}#1#{} 张随机卡牌",
					"转换为{C:dark_edition}带版本{}的人头牌"
				}
			},
			c_entr_ward = {
				name = "结界",
				text = {
					"削弱 {C:attention}1{} 张随机小丑",
					"持续 {C:attention}#2#{} 个回合，然后赚取",
					"其售价 {X:gold,C:white}X#1#{} 倍的金钱",
				}
			},
			c_entr_ichor = {
				name = "神血",
				text = {
					"一张{C:attention}随机{}持有的防小丑",
					"将多占用 {C:dark_edition}+1{} 个小丑槽位",
					"获得 {C:dark_edition}+#1#{} 个小丑槽位"
				}
			},
			c_entr_pact = {
				name = "束缚",
				text = {
					"{C:attention}链接{}最多 {C:attention}#1#{} 张",
					"卡牌。所有修改效果将",
					"对被链接的所有卡牌生效"
				}
			},
			c_entr_rend = {
				name = "撕裂",
				text = {
					"将最多 {C:attention}#1#{} 张",
					"选定的卡牌转换为",
					"{C:attention}血肉{}牌"
				}
			},
			c_entr_rejuvenate = {
				name = "复苏",
				text = {
					"为手中 1 张选定卡牌添加",
					"随机{C:attention}蜡封{}、{C:attention}增强{}与{C:attention}版本{}，然后",
					"将手中 {C:attention}#1#{} 张其他卡牌",
					"转换为此卡牌，{C:gold}#2#{}",
				}
			},
			c_entr_crypt = {
				name = "墓穴",
				text = {
					"选择 {C:attention}#1#{} 张小丑并",
					"削弱其中{C:attention}随机{}一张",
					"选定的小丑，然后将其变成",
					"{C:attention}另一张{}小丑的副本"
				}
			},
			c_entr_charm = {
				name = "魅惑",
				text = {
					"将一个{C:attention}随机{}的{C:dark_edition}版本{}与",
					"{C:attention}永恒{}状态应用到选定的小丑上",
				}
			},
			c_entr_entropy = {
				name = "熵",
				text = {
					"完全{C:attention}随机化{}",
					"最多 #1# 张选定卡牌",
				}
			},
			c_entr_fusion = {
				name = "融合",
				text = {
					"手中 {C:attention}#1#{} 张随机卡牌",
					"将变成 1 张选定卡牌的",
					"随机同类型卡牌"
				}
			},
			c_entr_substitute = {
				name = "替代",
				text = {
					"{C:attention}取消兑换{}一张随机优惠券",
					"及其所有前置级别，然后兑换",
					"该优惠券的下一个级别"
				}
			},
			c_entr_evocation = {
				name = "唤醒",
				text = {
					"{C:attention}升级{} #1# 张选定小丑的",
					"稀有度，然后摧毁所有其他小丑",
					"获得 {C:blue}#2#{} 次出牌次数"
				}
			},
			c_entr_mimic = {
				name = "拟态",
				text = {
					"为 #1# 张选定的卡牌",
					"创造一张带有{C:attention}香蕉{}与{C:attention}易腐{}状态的副本",
				}
			},
			c_entr_superego = {
				name = "投射",
				text = {
					"将一张 {C:attention}Projected (投射){}",
					"贴纸应用到 1 张选定的小丑上，然后",
					"将其削弱"
				}
			},
			c_entr_engulf = {
				name = "吞噬",
				text = {
					"将 {C:dark_edition}烈阳{} 效果",
					"应用到手中 {C:attention}1{} 张",
					"选定卡牌上"
				}
			},
			c_entr_offering = {
				name = "祭品",
				text = {
					"所有小丑均变为{C:attention}租赁{}状态",
					"商店价格变为 {X:gold,C:white}X#1#{}"
				}
			},
			c_entr_entomb = {
				name = "入殓",
				text = {
					"基于 #1# 张选定的消耗牌的类型，",
					"创造一个对应的{C:attention}大型补充包{}",
				}
			},
			c_entr_conduct = {
				name = "传导",
				text = {
					"将选定卡牌或消耗牌上的",
					"{C:attention}原有{}版本效果，应用到",
					"其相邻卡牌上",
					"{C:inactive}(当前为 #1#){}"
				}
			},
			c_entr_disavow = {
				name = "否认",
				text = {
					"{C:red}否认{}手中持有的 {C:attention}1{} 张",
					"选定卡牌，手中持有的{C:attention}所有其他{}卡牌",
					"将获得该卡牌的增强效果"
				}
			},
			c_entr_regenerate = {
				name = "重生",
				text = {
					"完全重置最多",
					"{C:attention}#1#{} 张选定的卡牌",
					"或小丑牌",
					"{C:inactive}(无法移除 Aleph 真理状态){}"
				}
			},
			c_entr_purity = {
				name = "纯净",
				text = {
					"将一张 {C:dark_edition}Pure (纯净){} 贴纸应用到",
					"{C:attention}#1#{} 张选定的{C:attention}小丑#<s>1#{}上"
				}
			},
			c_entr_transcend = {
				name = "超越",
				text = {
					"将 {C:attention}#1#{} 张选定的卡牌",
					"转换为一个{C:attention}随机{}的{C:red}物品{}"
				}
			},
			c_entr_malediction = {
				name = "诅咒",
				text = {
					"将一个 {V:1}琥珀蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},
			c_entr_serpents = {
				name = "巨蛇之契",
				text = {
					"创造一张随机的{C:legendary,E:1}隐藏{}消耗牌",
					"{C:inactive}(数量可以溢出){}"
				}
			},

			c_entr_splinter = {
				name = "碎片",
				text = {
					"整副牌组中 {C:attention}1{} 张随机",
					"卡牌将变成随机的{C:attention}碎裂{}小丑"
				}
			},
			c_entr_dream = {
				name = "梦境",
				text = {
					"将 {C:attention}#1#{} 张随机的",
					"{C:attention}增强版{} {C:purple}眼睛#<s>1#{}",
					"抽入手中"
				}
			},
			c_entr_void = {
				name = "虚空",
				text = {
					"将一个 {V:1}微型蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},
			c_entr_sharpen = {
				name = "锋利",
				text = {
					"将一个 {V:1}锋利蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},
			c_entr_singularity = {
				name = "奇点",
				text = {
					"将一个 {V:1}梵塔黑蜡封{}",
					"添加到 #1# 张选定卡牌上",
				}
			},

			c_entr_idyll = {
				name = "田园诗",
				text = {
					"创造一个上一次获得的{C:attention}标签{}",
					"的{C:attention}副本{}，以及其",
					"{C:entr_entropic}晋升{}变体"
				}
			},
		},
		Aesthetic = {
			c_entr_vintage = {
				name = "复古",
				text = {
					"将最多 {C:attention}#1#{} 张选定的小丑",
                	"增强为 {C:attention}#2#{}",
				}
			},
			c_entr_retro = {
				name = "怀旧",
				text = {
					"将最多 {C:attention}#1#{} 张选定的小丑",
                	"增强为 {C:attention}#2#{}",
				}
			},
			c_entr_ytp = {
				name = "鬼畜",
				text = {
					"将最多 {C:attention}#1#{} 张选定的小丑",
                	"增强为 {C:attention}#2#{}",
				}
			},
			c_entr_solarpunk = {
				name = "太阳朋克",
				text = {
					"将最多 {C:attention}#1#{} 张选定的小丑",
                	"增强为 {C:attention}#2#{}",
				}
			},
			c_entr_breakcore = {
				name = "碎核",
				text = {
					"将最多 {C:attention}#1#{} 张选定的小丑",
                	"增强为 {C:attention}#2#{}",
				}
			},
			c_entr_lewd = {
				name = "搞色色",
				text = {
					"将最多 {C:attention}#1#{} 张选定的小丑",
                	"增强为 {C:attention}#2#{}",
				}
			},
			c_entr_disco = {
				name = "迪斯科",
				text = {
					"将最多 {C:attention}#1#{} 张选定的小丑",
                	"增强为 {C:attention}#2#{}",
				}
			},
		},
		Transient = {
			c_entr_cage = {
				name = "牢笼",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们的花色变为",
					"{C:attention}最左侧{}选定卡牌的花色"
				}
			},
			c_entr_implode = {
				name = "内爆",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们变成{C:attention}无之 A{}"
				}
			},
			c_entr_meteor = {
				name = "流星",
				text = {
					"将{C:attention}临时{}状态应用到",
					"手中 {C:attention}#1#{} 张随机卡牌上，",
					"然后赋予它们{C:purple}蓝宝石{}蜡封"
				}
			},
			c_entr_concentrate = {
				name = "集中",
				text = {					"将{C:attention}临时{}状态应用到",
					"{C:attention}所有{}选定卡牌上，",
					"然后将它们复制入手中"
				}
			},
			c_entr_pyrite = {
				name = "黄铁矿",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们变成{C:attention}黄金牌{}"
				}
			},
			c_entr_set = {
				name = "设定",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们的点数变为",
					"{C:attention}最左侧{}选定卡牌的点数"
				}
			},
			c_entr_trickster = {
				name = "捣蛋鬼",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们变成一张",
					"随机的{C:red}稀有{} {C:attention}小丑{}"
				}
			},
			c_entr_sundial = {
				name = "日晷",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们变成{C:attention}玻璃牌{}"
				}
			},
			c_entr_candle = {
				name = "蜡烛",
				text = {
					"在此盲注期间，",
					"{C:attention}+#1#{} 手牌上限"
				}
			},
			c_entr_faith = {
				name = "信仰",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们变成{C:attention}幸运牌{}"
				}
			},
			c_entr_oasis = {
				name = "绿洲",
				text = {
					"将{C:attention}临时{}状态应用到",
					"一张选定卡牌上，然后",
					"复制它 {C:attention}#1#{} 次"
				}
			},
			c_entr_ragtag = {
				name = "乌合之众",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们变成一张",
					"随机的{C:blue}普通{} {C:attention}小丑{}"
				}
			},
			c_entr_burn = {
				name = "燃烧",
				text = {
					"将{C:attention}临时{}状态应用到",
					"手中 {C:attention}#1#{} 张随机卡牌上，",
					"然后赋予它们{C:purple}粉色{}蜡封"
				}
			},
			c_entr_escape = {
				name = "逃脱",
				text = {
					"将{C:attention}临时{}状态应用到",
					"手中 {C:attention}#1#{} 张随机卡牌上，",
					"然后随机化它们"
				}
			},
			c_entr_gbdecay = {
				name = "衰变",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们变成{C:attention}钢铁牌{}"
				}
			},
			c_entr_visage = {
				name = "容貌",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们变成{C:attention}石头牌{}"
				}
			},
			c_entr_nebula = {
				name = "星云",
				text = {
					"创造 {C:attention}#1#{} 个随机",
					"带有{C:attention}临时{}状态的盲注代币"
				}
			},
			c_entr_essence = {
				name = "本质",
				text = {
					"将{C:attention}临时{}状态应用到",
					"{C:attention}#1#{} 张选定卡牌上，",
					"然后将它们变成具有{C:attention}随机{}",
					"花色的 K"
				}
			},
			c_entr_manifest = {
				name = "显现",
				text = {
					"在此盲注期间，",
					"{C:attention}+#1#{} 选牌上限"
				}
			},
			c_entr_hope = {
				name = "希望",
				text = {
					"将{C:attention}临时{}状态应用到",
					"手中 {C:attention}#1#{} 张随机卡牌上，",
					"然后赋予它们{V:1}银色{}蜡封"
				}
			},
		},
		Tarot = {
			c_entr_kiln = {
				name = "窑炉",
				text = {
					"将 {C:attention}#1#{} 张选定的卡牌",
					"增强为",
					"{C:attention}陶瓷牌{}"
				}
			},
			c_entr_comet = {
				name = "彗星",
				text = {
					"将 {C:attention}#1#{} 张选定的卡牌",
					"增强为",
					"{C:attention}辉光牌{}"
				}
			},
			c_lovers_gfb = {
				name = "恋人",
				text = {
					"将{C:entr_freaky}猎奇{}版本",
					"应用到 {C:attention}#1#{} 张选定卡牌上"
				}
			},
			c_star_gfb = {
				name = "星星",
				text = {
					"将 {C:attention}#1#{} 张选定的卡牌",
					"增强为",
					"{C:attention}超新星牌{}"
				}
			},
			c_sun_gfb = {
				name = "太阳",
				text = {
					"将 {C:attention}#1#{} 张选定的卡牌",
					"增强为",
					"{C:attention}晴朗小丑牌{}"
				}
			},
			c_world_gfb = {
				name = "世界",
				text = {
					"将 {C:attention}#1#{} 张选定的卡牌",
					"增强为",
					"{C:attention}地球牌{}"
				}
			},
			c_moon_gfb = {
				name = "月亮",
				text = {
					"将 {C:attention}#1#{} 张选定的卡牌",
					"增强为",
					"{C:attention}飞向月球牌{}"
				}
			},
			c_death_gfb = {
				name = "死神",
				text = {
					"选择 {C:attention}#1#{} 张牌，",
					"将{C:attention}右侧{}的牌",
					"转换为{C:attention}左侧{}的牌",
					"{C:inactive}(拖动以重新排列位置)"
				}
			}
		},
		Spectral = {
			c_entr_flipside = {
				name = "反面",
				text = {
					"将 {C:attention}#1#{} 张选定的消耗牌",
					"转换为{C:red}逆位{}变体",
				}
			},
			c_entr_destiny = {
				name = "命运",
				text = {
					"献祭 {C:attention}5{} 张扑克牌，基于",
					"它们的增强效果合成一张小丑",
					"{C:inactive}(当前为 #1#){}"
				}
			},
			c_entr_shatter = {
				name = "粉碎",
				text = {
					"将{C:dark_edition}碎裂{}版本应用到手中",
					"{C:attention}#1#{} 张选定卡牌上",
					"{C:red}-#2#{} 选牌上限"
				}
			},
			c_entr_lust = {
				name = "色欲",
				text = {
					"将{C:dark_edition}猎奇{}版本应用到手中",
					"{C:attention}#1#{} 张随机卡牌上",
				}
			},
			c_entr_null = {
				name = "空值 (Null)",
				text = {
					"摧毁手中 {C:attention}1{} 张随机卡牌，",
					"将 {C:attention}#1#{} 张随机的",
					"{C:attention}增强版无之 Nil{} 牌",
					"加入你的手中",
				}
			},
			c_entr_antithesis = {
				name = "对立",
				text = {
					"根据{C:attention}收藏列表{}顺序，",
					"抽到的卡牌将获得{C:attention}版本{}，",
					"持续到下回合",
					"{C:inactive}(排除 {C:dark_edition}负片{C:inactive})"
				}
			},
			c_entr_oss = {
				name = "奥斯符文",
				text = {
					"下一个打开的{C:attention}补充包{}",
					"将包含一张{C:legendary,E:1}隐藏{}的消耗牌",
					"{C:inactive}(如果可能的话)"
				}
			},
			c_entr_oss_providence = {
				name = "奥斯符文{C:purple}+{}",
				text = {
					"下一个打开的{C:attention}补充包{}",
					"将包含一张{C:legendary,E:1}隐藏{}的消耗牌",
					"且当其发生时，{C:purple,E:1}生成{}一张{C:purple}符文{}牌",
					"{C:inactive}(如果可能的话)"
				}
			},
			c_entr_enchant = {
				name = "附魔",
				text = {
					"为手中 {C:attention}#1#{} 张",
					"选定卡牌添加一个",
					"{C:purple}华丽蜡封{}"
				}
			},
			c_entr_manifest = {
				name = "显现",
				text = {
					"创造出本底注内",
					"各个跳过标签的",
					"{C:entr_entropic}晋升{}变体"
				}
			},

			c_talisman_gfb = {
				name = "下载免费好用护身符 2026",
				text = {
					"为手中 {C:attention}1{} 张",
					"选定卡牌添加一个",
					"{C:attention}金色蜡封{}",
					"{C:red}警告：极其不稳定"
				}
			}
		},
		Stake = {
			stake_entr_copper = {
				name = "黄铜注",
				text = {
					"{C:attention}复制{}出来的扑克牌可能会变成{C:red}否认牌{}",
					"{s:0.8}包含所有先前底注的限制",
				},
			},
			stake_entr_platinum = {
				name = "铂金注",
				text = {
					"小丑价格增加 {C:red}20%{}",
					"{s:0.8}包含所有先前底注的限制",
				},
			},
			stake_entr_meteorite = {
				name = "陨石注",
				text = {
					"提升牌型等级可能会{C:red}失败{}",
					"{s:0.8}包含所有先前底注的限制",
				},
			},
			stake_entr_obsidian = {
				name = "黑曜石注",
				text = {
					"击败Boss盲注时",
					"必定获得一张{C:red}诅咒{}牌",
					"{s:0.8}包含所有先前底注的限制",
				},
			},
			stake_entr_iridium = {
				name = "铱金注",
				text = {
					"获胜要求达到底注 {C:red}10{}",
					"{s:0.8}包含所有先前底注的限制",
					"{C:entr_trans,s:0.7}跨性别权利",
				},
			},
			stake_entr_zenith = {
				name = "顶点注",
				text = {
					"如果 {E:1,C:entr_zenith}无尽熵增{}",
					"有 {C:green}微信{} 的话会怎样：",
					"Ruby Crimsonfang          15:23",
					"{C:inactive}我需要超级BOSS！           ",
					"Evil Ruby Crimsonfang  	15:28",
					"{C:inactive}我需要超级BOSS！           ",
					"Baron          		  14:23",
					"{C:inactive}我恨你我恨你！        ",
				},
			},
			stake_entr_gfb = {
				name =  "Ruby 'Crimsonfang' 呈现：你就是那个小丑，一出歌剧",
				text = {
					"好好享受吧。",
					"在此难度下",
					"无法获得解锁进度"
				}
			}
		},
		Tag= {
			tag_entr_dog = {
				name = "小狗标签",
				text = { "汪。", "{C:inactive}等级 {C:dark_edition}#1#" },
			},
			tag_entr_sunny = {
				name = "晴朗标签",
				text = { 
					"商店中下一个基础版小丑",
					"免费并成为{C:dark_edition}晴朗{}版本"	
				},
			},
			tag_entr_solar = {
				name = "烈阳标签",
				text = { 
					"商店中下一个基础版小丑",
					"免费并成为{C:dark_edition}烈阳{}版本"	
				},
			},
			tag_entr_fractured = {
				name = "碎裂标签",
				text = { 
					"商店中下一个基础版小丑",
					"免费并成为{C:dark_edition}碎裂{}版本"	
				},
			},
			tag_entr_freaky = {
				name = "猎奇标签",
				text = { 
					"商店中下一个基础版小丑",
					"免费并成为{C:dark_edition}猎奇{}版本"	
				},
			},

			tag_entr_neon = {
				name = "霓虹标签",
				text = { 
					"商店中下一个基础版小丑",
					"免费并成为{C:dark_edition}霓虹{}版本"	
				},
			},

			tag_entr_lowres = {
				name = "低清标签",
				text = { 
					"商店中下一个基础版小丑",
					"免费并成为{C:dark_edition}低清{}版本"	
				},
			},
			tag_entr_kaleidoscopic = {
				name = "万花筒标签",
				text = { 
					"商店中下一个基础版小丑",
					"免费并成为{C:dark_edition}万花筒{}版本"	
				},
			},
			tag_entr_gilded = {
				name = "镀金标签",
				text = { 
					"商店中下一个基础版小丑",
					"免费并成为{C:dark_edition}镀金{}版本"	
				},
			},

			tag_entr_ascendant_rare = {
				name = "{C:gold}稀有标签{}",
				text = { "商店包含一张免费的", "{C:rare}稀有小丑{}" },
			},
			tag_entr_ascendant_epic = {
				name = "{C:gold}史诗标签{}",
				text = { "商店包含一张免费的", "{C:cry_epic}史诗小丑{}" },
			},
			tag_entr_ascendant_legendary = {
				name = "{C:gold}传奇标签{}",
				text = { "商店包含一张免费的", "{C:legendary}传奇小丑{}" },
			},
			tag_entr_ascendant_exotic = {
				name = "{C:gold}域外标签{}",
				text = { "商店包含一张免费的", "{C:cry_exotic}域外小丑{}" },
			},
			tag_entr_ascendant_entropic = {
				name = "{C:gold}熵增标签{}",
				text = { "商店包含一张免费的", "{C:entr_entropic}熵增小丑{}" },
			},
			tag_entr_ascendant_copying = {
				name = "{C:gold}复制标签{}",
				text = { "获得下一个选定标签", "的 {C:attention}#1#{} 个副本", "{C:inactive}(复制类标签除外){}" },
			},
			tag_entr_ascendant_voucher = {
				name = "{C:gold}优惠券标签{}",
				text = { "在下一次商店中添加一张", " {C:attention}3{} 阶优惠券" },
			},
			tag_entr_ascendant_voucher_cryptidless = {
				name = "{C:gold}优惠券标签{}",
				text = { "在下一次商店中添加", "{C:attention}两张{}优惠券" },
			},
			tag_entr_ascendant_better_voucher = {
				name = "{C:gold}无暇优惠券标签{}",
				text = { "在下一次商店中添加", " 2 张 {C:attention}3{} 阶优惠券" },
			},
			tag_entr_ascendant_saint = {
				name = "{C:gold}圣人标签{}",
				text = { "商店包含一张免费的", "{C:attention}带版本糖果小丑{}" },
			},
			tag_entr_ascendant_negative = {
				name = "{C:gold}负片标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}负片{} 版本" },
			},
			tag_entr_ascendant_foil = {
				name = "{C:gold}闪箔标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}闪箔{} 版本" },
			},
			tag_entr_ascendant_holo = {
				name = "{C:gold}镭射标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}镭射{} 版本" },
			},
			tag_entr_ascendant_poly = {
				name = "{C:gold}多彩标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}多彩{} 版本" },
			},
			tag_entr_ascendant_glass = {
				name = "{C:gold}灰质琉璃标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}灰质琉璃{} 版本" },
			},
			tag_entr_ascendant_glitched = {
				name = "{C:gold}故障标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}故障{} 版本" },
			},
			tag_entr_ascendant_gold = {
				name = "{C:gold}鎏金标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}鎏金{} 版本" },
			},
			tag_entr_ascendant_blurry = {
				name = "{C:gold}模糊标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}模糊{} 版本" },
			},
			tag_entr_ascendant_m = {
				name = "{C:gold}M 标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}欢愉{}", "{C:inactive}M{}" },
			},
			tag_entr_ascendant_mosaic = {
				name = "{C:gold}马赛克标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}马赛克{} 版本" },
			},
			tag_entr_ascendant_astral = {
				name = "{C:gold}星界标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}星界{} 版本" },
			},
			tag_entr_ascendant_oversat = {
				name = "{C:gold}过曝标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}过曝{} 版本" },
			},
			tag_entr_ascendant_sunny = {
				name = "{C:gold}晴朗标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}晴朗{} 版本" },
			},
			tag_entr_ascendant_solar = {
				name = "{C:gold}烈阳标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}烈阳{} 版本" },
			},
			tag_entr_ascendant_fractured = {
				name = "{C:gold}碎裂标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}碎裂{} 版本" },
			},
			tag_entr_ascendant_freaky = {
				name = "{C:gold}猎奇标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}猎奇{} 版本" },
			},

			tag_entr_ascendant_neon = {
				name = "{C:gold}霓虹标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}霓虹{} 版本" },
			},
			tag_entr_ascendant_lowres = {
				name = "{C:gold}低清标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}低清{} 版本" },
			},
			tag_entr_ascendant_kaleidoscopic = {
				name = "{C:gold}万花筒标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}万花筒{} 版本" },
			},
			tag_entr_ascendant_gilded = {
				name = "{C:gold}镀金标签{}",
				text = { "商店中的{C:attention}所有{}物品均为 {C:dark_edition}镀金{} 版本" },
			},

			tag_entr_ascendant_infdiscard = {
				name = "{C:gold}弃牌标签{}",
				text = { "下回合获得", "{C:attention}+3{} 次弃牌" },
			},
			tag_entr_ascendant_cat = {
				name = "{C:gold}猫咪标签{}",
				text = { "{C:gold}喵。{}", "{C:inactive}等级 {C:dark_edition}#1#" },
			},
			tag_entr_ascendant_dog = {
				name = "{C:gold}小狗标签{}",
				text = { "{C:red}汪。{}", "{C:inactive}等级 {C:dark_edition}#1#" },
			},
			tag_entr_ascendant_canvas = {
				name = "{C:gold}画布标签{}",
				text = { "商店包含一张", "{C:attention}画布{}" },
			},
			tag_entr_ascendant_unbounded = {
				name = "{C:gold}无限标签{}",
				text = {"获得一个免费的{C:spectral}幻灵包",
				"内含{C:green,E:1}指针{}与{C:entr_entropic,E:1}超越{}", },
			},
			tag_entr_ascendant_ejoker = {
				name = "{C:gold}小丑标签{}",
				text = { "获得一个免费的带版本", "{C:attention}大型小丑包{}" },
			},
			tag_entr_ascendant_universal = {
				name = "{C:gold}泛宇宙标签{}",
				text = { "升级 {C:attention}#1#{}", "{C:gold}+3{} 晋升强度" },
			},
			tag_entr_ascendant_ebundle = {
				name = "{C:gold}组合包标签{}",
				text = {"创造一个{C:attention}控制台标签{}、{C:attention}以太标签{}、",
				"{C:attention}扭曲标签{}，以及一个{C:attention}组合包标签{}", },
			},
			tag_entr_ascendant_twisted = {
				name = "{C:gold}扭曲标签{}",
				text = {"获得一个免费的","{C:red}扭曲包{}", },
			},
			tag_entr_ascendant_stock = {
				name = "{C:gold}股票标签{}",
				text = {"将你的金钱乘以 2X", },
			},
			tag_entr_ascendant_blind = {
				name = "{C:gold}盲注标签{}",
				text = {"获得一个免费的","{C:attention}盲注代币包{}", },
			},
			tag_entr_ascendant_reference = {
				name = "{C:gold}参考标签{}",
				text = {"获得一个免费的","{C:green}参考包{}", },
			},
			tag_entr_ascendant_cavendish = {
				name = "{C:gold}卡文迪许标签{}",
				text = {"获得一张免费的","{C:attention}卡文迪许{}", },
			},
			tag_entr_ascendant_credit = {
				name = "{C:gold}信用标签{}",
				text = {"在下个商店中，初始的卡牌与", "补充包均免费", "重掷价格从 {C:gold}-$5{} 开始计算" },
			},

			tag_entr_ascendant_topup = {
				name = "{C:gold}充值标签{}",
				text = {
					"创造最多 {C:attention}3{} 张",
					"{C:green}罕见{}小丑",
					"{C:inactive}(必须有空间){}",
				},
			},
			tag_entr_ascendant_better_topup = {
				name = "{C:gold}进阶充值标签{}",
				text = {
					"创造最多 {C:attention}3{} 张",
					"{C:red}稀有{}小丑",
					"{C:inactive}(必须有空间){}",
				},
			},
			tag_entr_ascendant_booster = {
				name = "{C:gold}补充包标签{}",
				text = {
					"下一个{C:cry_code}补充包{}含有",
					"{C:attention}三倍{}卡牌数量与",
					"{C:attention}三倍{}选择次数",
				},
			},
			tag_entr_ascendant_effarcire = {
				name = "{C:gold}无穷标签{}",
				text = {
					"下回合将{C:green}整副牌组{}抽入手中"
				},
			},
			tag_entr_arcane = {
				name = "秘术标签",
				text = {
					"获得一张随机的{C:purple}符文{}"
				},
			},
			tag_entr_ascendant_arcane = {
				name = "{C:gold}秘术标签{}",
				text = {
					"获得 {C:attention}两张{}随机的{C:purple}符文{}"
				},
			},

			tag_entr_ascendant_negative_eternal = {
				name = "{C:gold}负片永恒标签{}",
				text = { "商店中的{C:attention}所有{}物品均为","{C:dark_edition}负片{}与{C:attention}永恒{}状态" },
			},
			tag_entr_ascendant_kitty = {
				name = "{C:gold}猫咪标签{}",
				text = { "拥有的每一张{C:attention}猫咪标签{}", "提供 {X:chips,C:white}X#1#{} 筹码" },
			},

			tag_entr_asc_additive = {
				name = "{C:gold}相加标签{}",
				text = { "有 {C:green}#1# / #2# 几率增强", "打出的盲注" },
			},
			tag_entr_asc_max = {
				name = "{C:gold}最大化标签{}",
				text = { "手牌计分后获得","{C:red}X2{} 倍率与", "{C:blue}X2{} 筹码" },
			},
			tag_entr_asc_symmetry = {
				name = "{C:gold}对称标签{}",
				text = { "重新触发每个计分的盲注","有 {C:green}#1# / #2# 几率", "将每个计分的盲注重新触发两次" },
			},
			tag_entr_asc_recursive = {
				name = "{C:gold}递归标签{}",
				text = { "持有的每一个标签", "提供 {X:blue,C:white}X0.1{} 筹码", "{C:inactive}(当前为 {X:blue,C:white}X#2#{C:inactive} 筹码)" },
			},
			tag_entr_asc_wave = {
				name = "{C:gold}波动标签{}",
				text = { "每一个{C:attention}打出的盲注{}", "都会参与计分" },
			},
			tag_entr_asc_prison_break = {
				name = "{C:gold}越狱标签{}",
				text = { "在当前底注期间", "禁用所有{C:attention}小丑" },
			},
			tag_entr_asc_collector = {
				name = "{C:gold}收藏家标签{}",
				text = { "下一个打开的{C:attention}符号包{}", "将包含带版本且升级过的盲注" },
			},
			tag_entr_asc_memory = {
				name = "{C:gold}追忆标签{}",
				text = { "创造一个随机的{C:bld_keepsake,E:1}带版本纪念品{}", "{C:inactive}(必须有空间)" },
			},
			tag_entr_asc_magic = {
				name = "{C:gold}魔术标签{}",
				text = { "创造一个随机的{C:attention,E:1}带版本饰品{}", "{C:inactive}(必须有空间)" },
			},
			tag_entr_asc_debuff = {
				name = "{C:gold}削弱标签{}",
				text = { "如果打出牌型是 {C:attention}#1#{}", "计分后将 {C:blue}筹码{}与{C:red}倍率{}减半" },
			},
			tag_entr_asc_joker = {
				name = "{C:gold}小丑标签{}",
				text = { "每次打出手牌后", "小丑获得 {C:red}+0.5{} 倍率" },
			},
			tag_entr_asc_mantle = {
				name = "{C:gold}披风标签{}",
				text = { "每次打出手牌时，{C:red}摧毁{}", "{C:attention}1{} 个打出的盲注" },
			},
			tag_entr_asc_awe = {
				name = "{C:gold}敬畏标签{}",
				text = { "每次出牌前，", "{C:red}削弱{}你", "{C:attention}最左侧{}或{C:attention}最右侧{}的", "饰品" },
			},
			tag_entr_asc_downpour = {
				name = "{C:gold}倾盆大雨标签{}",
				text = { "每次打出手牌后，", "每个打出的盲注有 {C:green}#1# / #2#{} 几率", "失去", "所有的{C:attention}修饰效果{}" },
			},
			tag_entr_asc_voodoo = {
				name = "{C:gold}巫毒标签{}",
				text = { "获得一个不可跳过的", "{C:attention}巫毒包{}" },
			},
			tag_entr_asc_burden = {
				name = "{C:gold}重担标签{}",
				text = { "每次打出手牌后，", "失去当前持有{C:money}金钱{}的{C:attention}三分之一{}", "向下取整" },
			},

			tag_curse_entr_blind = {
				name = "盲目诅咒",
				text = {
					"商店中的卡牌",
					"可能会被{C:red}翻转{}"
				}
			},
			tag_curse_entr_darkness = {
				name = "黑暗诅咒",
				text = {
					"补充包提供",
					"{C:red}更少{}的选项"
				}
			},
			tag_curse_entr_lost = {
				name = "迷失诅咒",
				text = {
					"没有{C:red}小盲注{}"
				}
			},
			tag_curse_entr_maze = {
				name = "迷宫诅咒",
				text = {
					"盲注的出现顺序被{C:red}随机化{}"
				}
			},
		},
		["Rune Tag"] = {
			rune_entr_fehu = {
				name = "费胡 (财富)",
				text = {
					"下一张被{C:attention}出售{}的卡牌",
					"会将其售价的{C:attention}一半{}",
					"添加到你的小丑中"
				}
			},
			rune_entr_fehu_providence = {
				name = "费胡{C:purple}+{}",
				text = {
					"下一张被{C:attention}出售{}的卡牌",
					"会将其{C:purple,E:1}全部{}售价",
					"添加到你的小丑中"
				}
			},
			rune_entr_uruz = {
				name = "乌鲁兹 (力量)",
				text = {
					"使下一次",
					"{C:attention}盲注结算金钱{}增加 {X:gold,C:white}50%{}",
					"{C:inactive}(呈加法叠加){}"
				}
			},
			rune_entr_uruz_providence = {
				name = "乌鲁兹{C:purple}+{}",
				text = {
					"使下一次",
					"{C:attention}盲注结算金钱{}增加 {X:purple,C:white,E:1}100%{}",
					"{C:inactive}(呈加法叠加){}"
				}
			},
			rune_entr_thurisaz = {
				name = "苏里萨兹 (防御)",
				text = {
					"复制下一张",
					"被{C:attention}弃掉{}的卡牌"
				}
			},
			rune_entr_thurisaz_providence = {
				name = "苏里萨兹{C:purple}+{}",
				text = {
					"将下一张",
					"被{C:attention}弃掉{}的卡牌复制 {C:purple,E:1}两遍{}"
				}
			},
			rune_entr_ansuz = {
				name = "安苏兹 (智慧)",
				text = {
					"复制下一个",
					"被{C:attention}获得{}的标签或符文"
				}
			},
			rune_entr_ansuz_providence = {
				name = "安苏兹{C:purple}+{}",
				text = {
					"将下一个",
					"被{C:attention}获得{}的标签或符文复制 {C:purple,E:1}两遍{}"
				}
			},
			rune_entr_raido = {
				name = "莱多 (旅途)",
				text = {
					"有 {C:green}#1# / #2#{} 几率",
					"阻止下一次",
					"底注的提升",
				}
			},
			rune_entr_raido_providence = {
				name = "莱多{C:purple}+{}",
				text = {
					"{C:purple,E:1}阻止{}下一次",
					"底注的提升",
				}
			},
			rune_entr_kaunan = {
				name = "科南 (火炬)",
				text = {
					"将下一次",
					"被{C:attention}打出{}的牌型升级"
				}
			},
			rune_entr_kaunan_providence = {
				name = "科南{C:purple}+{}",
				text = {
					"将下一次",
					"被{C:attention}打出{}的牌型升级",
					"{C:purple,E:1}两次{}"
				}
			},
			rune_entr_gebo = {
				name = "盖伯 (礼物)",
				text = {
					"创造一张与",
					"下一张被{C:attention}出售{}卡牌同类型",
					"的卡牌",
					"{C:inactive}(必须有空间){}"
				}
			},
			rune_entr_gebo_providence = {
				name = "盖伯{C:purple}+{}",
				text = {
					"创造一张与",
					"下一张被{C:attention}出售{}卡牌同类型",
					"的卡牌",
					"{C:purple,E:1}(数量可以溢出){}"
				}
			},

			rune_entr_wunjo = {
				name = "温乔 (喜悦)",
				text = {
					"当下一张消耗牌",
					"被使用时，创造一张",
					"{C:attention}随机{}的{C:purple}符文{}"
				}
			},
			rune_entr_wunjo_providence = {
				name = "温乔{C:purple}+{}",
				text = {
					"当下一张消耗牌",
					"被使用时，创造 {C:purple}2{} 张",
					"{C:attention}随机{}的{C:purple}符文{}"
				}
			},

			rune_entr_haglaz = {
				name = "哈格拉兹 (冰雹)",
				text = {
					"{C:red}摧毁{}下一次",
					"打出的手牌"
				}
			},
			rune_entr_haglaz_providence = {
				name = "哈格拉兹{C:purple}+{}",
				text = {
					"{C:red}摧毁{}下一次",
					"打出或{C:purple,E:1}弃掉{}的手牌"
				}
			},

			rune_entr_naudiz = {
				name = "瑙蒂兹 (需求)",
				text = {
					"下一件物品",
					"可以{C:attention}无视{}你当前的",
					"金钱余额被购买"
				}
			},
			rune_entr_naudiz_providence = {
				name = "瑙蒂兹{C:purple}+{}",
				text = {
					"下一件物品",
					"可以{C:attention}无视{}你当前的",
					"金钱余额被购买",
					"{C:purple,E:1}并且不会因此产生负债{}"
				}
			},

			rune_entr_isaz = {
				name = "伊萨兹 (冰)",
				text = {
					"在下一个商店中",
					"添加一张额外的",
					"{C:attention}优惠券{}"
				}
			},
			rune_entr_isaz_providence = {
				name = "伊萨兹{C:purple}+{}",
				text = {
					"在下一个商店中",
					"添加一张额外的",
					"{C:purple,E:1}半价{} {C:attention}优惠券{}"
				}
			},

			rune_entr_jera = {
				name = "耶拉 (丰收)",
				text = {
					"复制下一张",
					"被{C:attention}使用{}的消耗牌"
				}
			},
			rune_entr_jera_providence = {
				name = "耶拉{C:purple}+{}",
				text = {
					"将下一张",
					"被{C:attention}使用{}的消耗牌",
					"复制 {C:purple,E:1}两次{}"
				}
			},

			rune_entr_ihwaz = {
				name = "艾瓦兹 (紫杉)",
				text = {
					"随机化下一张",
					"被{C:attention}打出{}卡牌的其中一项属性"
				}
			},
			rune_entr_ihwaz_providence = {
				name = "艾瓦兹{C:purple}+{}",
				text = {
					"{C:purple,E:1}完全{}随机化",
					"下一张被{C:attention}打出{}的卡牌"
				}
			},

			rune_entr_perthro = {
				name = "佩思罗 (命运)",
				text = {
					"在下一次{C:attention}重掷{}时，",
					"重新补货{C:attention}补充包{}"
				}
			},
			rune_entr_perthro_providence = {
				name = "佩思罗{C:purple}+{}",
				text = {
					"在下一次{C:attention}重掷{}时，",
					"重新补货{C:attention}补充包{}，",
					"并提供 {C:purple,E:1}+1{} 个临时商店槽位"
				}
			},

			rune_entr_algiz = {
				name = "阿尔吉兹 (保护)",
				text = {
					"花费 {C:money}$10{} 来",
					"防止下一次{C:red}死亡{}",

				}
			},
			rune_entr_algiz_providence = {
				name = "阿尔吉兹{C:purple}+{}",
				text = {
					"花费 {C:purple,E:1}$5{} 来",
					"防止下一次{C:red}死亡{}",
				}
			},

			rune_entr_sowilo = {
				name = "索威罗 (太阳)",
				text = {
					"使下一次被{C:attention}弃掉{}的手牌",
					"获得 {C:gold}+2{} 晋升强度"

				}
			},
			rune_entr_sowilo_providence = {
				name = "索威罗{C:purple}+{}",
				text = {
					"使下一次被{C:attention}弃掉{}的手牌",
					"获得 {C:purple,E:1}+4{} 晋升强度"
				}
			},

			rune_entr_tiwaz = {
				name = "提瓦兹 (胜利)",
				text = {
					"随机{C:attention}修改{}",
					"下一张{C:attention}抽到{}的卡牌"

				}
			},
			rune_entr_tiwaz_providence = {
				name = "提瓦兹{C:purple}+{}",
				text = {
					"随机{C:attention}修改{}",
					"下一张{C:attention}抽到{}的卡牌",
					"{C:purple,E:1}两次{}"
				}
			},

			rune_entr_berkano = {
				name = "伯卡诺 (诞生)",
				text = {
					"为下一张被{C:red}摧毁{}的卡牌",
					"创造 {C:attention}两张{}副本"

				}
			},
			rune_entr_berkano_providence = {
				name = "伯卡诺{C:purple}+{}",
				text = {
					"为下一张被{C:red}摧毁{}的卡牌",
					"创造 {C:purple,E:1}三张{}副本"
				}
			},

			rune_entr_ehwaz = {
				name = "埃华兹 (马)",
				text = {
					"在下一次{C:attention}跳过{}盲注时",
					"提供一次盲注结算{C:attention}金钱{}和进入一次{C:attention}商店{}的权限"

				}
			},
			rune_entr_ehwaz_providence = {
				name = "埃华兹{C:purple}+{}",
				text = {
					"在下一次{C:attention}跳过{}盲注时",
					"提供一次盲注结算{C:attention}金钱{}和进入一次",
					"拥有 {C:purple,E:1}+1{} 槽位的{C:attention}商店{}的权限"
				}
			},

			rune_entr_mannaz = {
				name = "曼纳兹 (人类)",
				text = {
					"向下一个{C:attention}打开{}的补充包中",
					"添加一张{C:spectral}幻灵{}牌"

				}
			},
			rune_entr_mannaz_providence = {
				name = "曼纳兹{C:purple}+{}",
				text = {
					"向下一个{C:attention}打开{}的补充包中",
					"添加 {C:purple,E:1}两张{} {C:spectral}幻灵{}牌"
				}
			},

			rune_entr_laguz = {
				name = "拉古兹 (水)",
				text = {
					"返还下一次的{C:attention}弃牌{}次数"
				}
			},
			rune_entr_laguz_providence = {
				name = "拉古兹{C:purple}+{}",
				text = {
					"返还下一次的{C:attention}弃牌{}次数",
					"并临时提供 {C:purple,E:1}+1{} 次出牌"
				}
			},

			rune_entr_ingwaz = {
				name = "因格瓦兹 (种子)",
				text = {
					"下一次{C:attention}概率{}判定",
					"必定{C:green}成功{}"
				}
			},
			rune_entr_ingwaz_providence = {
				name = "因格瓦兹{C:purple}+{}",
				text = {
					"下一次{C:attention}概率{}判定",
					"必定{C:green}成功{}，且触发时",
					"有 {C:purple,E:1}33%{} 几率不消耗此符文"
				}
			},

			rune_entr_dagaz = {
				name = "达加兹 (黎明)",
				text = {
					"将下一张{C:attention}获得{}的",
					"消耗牌逆位"
				}
			},
			rune_entr_dagaz_providence = {
				name = "达加兹{C:purple}+{}",
				text = {
					"将下一张{C:attention}获得{}的",
					"消耗牌逆位",
					"并且当其发生时，{C:purple,E:1}创造{}一张",
					"随机逆位消耗牌",
					"{C:inactive}(必须有空间){}"
				}
			},

			rune_entr_othila = {
				name = "奥特拉 (遗产)",
				text = {
					"下一张被{C:attention}出售{}的卡牌提供",
					"{X:gold,C:white}X3{} 倍的金钱"
				}
			},
			rune_entr_othila_providence = {
				name = "奥特拉{C:purple}+{}",
				text = {
					"下一张被{C:attention}出售{}的卡牌提供",
					"{X:purple,C:white,E:1}X5{} 倍的金钱"
				}
			},

			rune_entr_oss = {
				name = "奥斯 (口)",
				text = {
					"下一个打开的{C:attention}补充包{}",
					"将包含一张{C:legendary,E:1}隐藏{}消耗牌",
					"{C:inactive}(如果可能的话)"
				}
			},
			rune_entr_oss_providence = {
				name = "奥斯{C:purple}+{}",
				text = {
					"下一个打开的{C:attention}补充包{}",
					"将包含一张{C:legendary,E:1}隐藏{}消耗牌",
					"当其发生时，{C:purple,E:1}生成{}一张{C:purple}符文{}牌",
					"{C:inactive}(如果可能的话)"
				}
			},
			--pacts
			rune_entr_avarice = {
				name = "贪婪印记",
				text = {
					{
						"被{C:red}贪婪{}标记"
					},
					{
						"所有出售价格",
						"乘以 {X:red,C:white}X#1#{}"
					}
				}
			},
			rune_entr_rage = {
				name = "狂怒印记",
				text = {
					"被{C:red}狂怒{}标记"
				}
			},
			rune_entr_thorns = {
				name = "荆棘印记",
				text = {
					"被{C:red}荆棘{}标记"
				}
			},
			rune_entr_denial = {
				name = "否认印记",
				text = {
					"被{C:red}否认{}标记"
				}
			},
			rune_entr_chains = {
				name = "锁链印记",
				text = {
					{
						"被{C:red}锁链{}标记"
					},
					{
						"重新触发所有{C:attention}永恒{}扑克牌",
						"每回合第一张{C:attention}抽到{}的牌变为{C:attention}永恒{}状态"
					}
				}
			},
			rune_entr_decay = {
				name = "衰变印记",
				text = {
					"被{C:red}衰变{}标记"
				}
			},
			rune_entr_envy = {
				name = "嫉妒印记",
				text = {
					{
						"被{C:red}嫉妒{}标记"
					},
					{
						"重新触发一张{C:attention}随机{}小丑，",
						"目标每回合{C:attention}改变{}"
					}
				}
			},
			rune_entr_youth = {
				name = "青春印记",
				text = {
					"被{C:red}青春{}标记"
				}
			},
			rune_entr_shards = {
				name = "碎片印记",
				text = {
					{
						"被{C:red}碎片{}标记"
					},
					{
						"扑克牌的{C:red}摧毁{}",
						"可能会{C:red}失败{}"
					}
				}
			},
			rune_entr_desire = {
				name = "欲望印记",
				text = {
					{
						"被{C:red}欲望{}标记"
					},
					{
						"{C:attention}补充包{}变得",
						"更{C:red}昂贵{}"
					}
				}
			},
			rune_entr_ice = {
				name = "坚冰印记",
				text = {
					{
						"被{C:red}坚冰{}标记"
					},
					{
						"你{C:attention}等级最高{}的牌型",
						"{C:red}无法{}再改变等级"
					}
				}
			},
			rune_entr_gluttony = {
				name = "暴食印记",
				text = {
					{
						"被{C:red}暴食{}标记"
					},
					{
						"{C:red}所有{}消耗牌变为{C:attention}永恒{}状态"
					}
				}
			},
			rune_entr_rebirth = {
				name = "重生印记",
				text = {
					{
						"被{C:red}重生{}标记"
					},
					{
						"扑克牌将被{C:attention}复制{}",
						"而不是被{C:red}摧毁{}"
					}
				}
			},
			rune_entr_despair = {
				name = "绝望印记",
				text = {
					"被{C:red}绝望{}标记"
				}
			},
			rune_entr_strength = {
				name = "力量印记",
				text = {
					"被{C:red}力量{}标记"
				}
			},			
			rune_entr_darkness = {
				name = "黑暗印记",
				text = {
					{
						"被{C:red}黑暗{}标记"
					},
					{
						"抽到的扑克牌可能是",
						"面朝{C:red}下{}的"
					}
				}
			},
			rune_entr_freedom = {
				name = "自由印记",
				text = {
					"被{C:red}自由{}标记"
				}
			},
			rune_entr_eternity = {
				name = "永恒印记",
				text = {
					"被{C:red}永恒{}标记"
				}
			},
			rune_entr_loyalty = {
				name = "忠诚印记",
				text = {
					{
						"被{C:red}忠诚{}标记"
					},
					{
						"利息现在每 {C:money}$#1#{} 计算一次",
						"每隔一次出牌提供 {X:mult,C:white}X#2#{} 倍率"
					}
				}
			},
			rune_entr_brimstone = {
				name = "硫磺印记",
				text = {
					{
						"被{C:red}硫磺{}标记"
					},
					{
						"在回合的{C:attention}最后一手牌{}打出后",
						"提供 {X:mult,C:white}X#1#{} 倍率"
					}
				}
			},
			rune_entr_dreams = {
				name = "梦境印记",
				text = {
					{
						"被{C:red}梦境{}标记"
					},
					{
						"小盲注不提供{C:attention}奖励{}"
					}
				}
			},
			rune_entr_energy = {
				name = "能量印记",
				text = {
					"被{C:red}能量{}标记"
				}
			},
			rune_entr_blood = {
				name = "鲜血印记",
				text = {
					"被{C:red}鲜血{}标记"
				}
			},
			rune_entr_awakening = {
				name = "觉醒印记",
				text = {
					"被{C:red}觉醒{}标记"
				}
			},
			rune_entr_serpents = {
				name = "巨蛇印记",
				text = {
					"被{C:red}巨蛇{}标记",
					"{C:red,E:1,s:0.8}你的命运已成定局{}"
				}
			},
		},
		Rune = {
			c_entr_fehu = {
				name = "费胡符文",
				text = {
					"下一张被{C:attention}出售{}的卡牌",
					"会将其售价的{C:attention}一半{}",
					"添加到你的小丑中"
				}
			},
			c_entr_fehu_providence = {
				name = "费胡符文{C:purple}+{}",
				text = {
					"下一张被{C:attention}出售{}的卡牌",
					"会将其{C:purple,E:1}全部{}售价",
					"添加到你的小丑中"
				}
			},
			c_entr_uruz = {
				name = "乌鲁兹符文",
				text = {
					"使下一次",
					"{C:attention}盲注结算金钱{}增加 {X:gold,C:white}50%{}",
					"{C:inactive}(呈加法叠加){}"
				}
			},
			c_entr_uruz_providence = {
				name = "乌鲁兹符文{C:purple}+{}",
				text = {
					"使下一次",
					"{C:attention}盲注结算金钱{}增加 {X:purple,C:white,E:1}100%{}",
					"{C:inactive}(呈加法叠加){}"
				}
			},
			c_entr_thurisaz = {
				name = "苏里萨兹符文",
				text = {
					"创造一张",
					"下一张被{C:attention}弃掉{}卡牌的{C:attention}副本{}",
					"并将其抽入{C:attention}手中{}"
				}
			},
			c_entr_thurisaz_providence = {
				name = "苏里萨兹符文{C:purple}+{}",
				text = {
					"创造 {C:purple,E:1}两张{}",
					"下一张被{C:attention}弃掉{}卡牌的{C:attention}副本{}",
					"并将其抽入{C:attention}手中{}"
				}
			},
			c_entr_ansuz = {
				name = "安苏兹符文",
				text = {
					"创造一张",
					"下一个被{C:attention}获得{}的标签或符文的{C:attention}副本{}",
				}
			},
			c_entr_ansuz_providence = {
				name = "安苏兹符文{C:purple}+{}",
				text = {
					"创造 {C:purple,E:1}两张{}",
					"下一个被{C:attention}获得{}的标签或符文的{C:attention}副本{}",
				}
			},
			c_entr_raido = {
				name = "莱多符文",
				text = {
					"有 {C:green}#1# / #2#{} 几率",
					"阻止下一次",
					"底注的{C:attention}提升{}"
				}
			},
			c_entr_raido_providence = {
				name = "莱多符文{C:purple}+{}",
				text = {
					"{C:purple,E:1}阻止{}下一次",
					"底注的{C:attention}提升{}"
				}
			},
			c_entr_kaunan = {
				name = "科南符文",
				text = {
					"升级",
					"下一次被{C:attention}打出{}的牌型"
				}
			},
			c_entr_kaunan_providence = {
				name = "科南符文{C:purple}+{}",
				text = {
					"将下一次",
					"被{C:attention}打出{}的牌型升级",
					"{C:purple,E:1}两次{}"
				}
			},

			c_entr_gebo = {
				name = "盖伯符文",
				text = {
					"创造一张与",
					"下一张被{C:attention}出售{}卡牌同类型",
					"的卡牌",
					"{C:inactive}(必须有空间){}"
				}
			},
			c_entr_gebo_providence = {
				name = "盖伯符文{C:purple}+{}",
				text = {
					"创造一张与",
					"下一张被{C:attention}出售{}卡牌同类型",
					"的卡牌",
					"{C:purple,E:1}(数量可以溢出){}"
				}
			},

			c_entr_wunjo = {
				name = "温乔符文",
				text = {
					"当下一张消耗牌",
					"被使用时，创造一张",
					"{C:attention}随机{}的{C:purple}符文{}"
				}
			},
			c_entr_wunjo_providence = {
				name = "温乔符文{C:purple}+{}",
				text = {
					"当下一张消耗牌",
					"被使用时，创造 {C:purple}2{} 张",
					"{C:attention}随机{}的{C:purple}符文{}"
				}
			},

			c_entr_haglaz = {
				name = "哈格拉兹符文",
				text = {
					"{C:red}摧毁{}下一次",
					"打出的手牌"
				}
			},
			c_entr_haglaz_providence = {
				name = "哈格拉兹符文{C:purple}+{}",
				text = {
					"{C:red}摧毁{}下一次",
					"打出或{C:purple,E:1}弃掉{}的手牌"
				}
			},

			c_entr_naudiz = {
				name = "瑙蒂兹符文",
				text = {
					"下一张{C:attention}购买{}的商店卡牌",
					"可以{C:attention}无视{}你当前的",
					"金钱余额被购买，如果需要的话",
					"会让你陷入{C:attention}负债{}"
				}
			},
			c_entr_naudiz_providence = {
				name = "瑙蒂兹符文{C:purple}+{}",
				text = {
					"下一张{C:attention}购买{}的商店卡牌",
					"可以{C:attention}无视{}你当前的",
					"金钱余额被购买",
					"{C:purple,E:1}且不会产生任何债务{}"
				}
			},

			c_entr_isaz = {
				name = "伊萨兹符文",
				text = {
					"在下一个{C:attention}商店{}中",
					"包含一张额外的{C:attention}优惠券{}"
				}
			},
			c_entr_isaz_providence = {
				name = "伊萨兹符文{C:purple}+{}",
				text = {
					"在下一个{C:attention}商店{}中",
					"包含一张额外的{C:attention}优惠券{}",
					"且价格为{C:purple,E:1}半价{}"
				}
			},

			c_entr_jera = {
				name = "耶拉符文",
				text = {
					"创造一张",
					"下一张被{C:attention}使用{}消耗牌的",
					"{C:attention}副本{}",
					"{C:inactive}(隐藏的消耗牌除外)"
				}
			},
			c_entr_jera_providence = {
				name = "耶拉符文{C:purple}+{}",
				text = {
					"创造 {C:purple,E:1}两张{}",
					"下一张被{C:attention}使用{}消耗牌的",
					"{C:attention}副本{}"
				}
			},
			c_entr_ihwaz = {
				name = "艾瓦兹符文",
				text = {
					"随机化下一张",
					"被{C:attention}打出{}卡牌的其中一项属性"
				}
			},
			c_entr_ihwaz_providence = {
				name = "艾瓦兹符文{C:purple}+{}",
				text = {
					"{C:purple,E:1}完全{}随机化",
					"下一张被{C:attention}打出{}的卡牌"
				}
			},

			c_entr_perthro = {
				name = "佩思罗符文",
				text = {
					"在下一次{C:attention}重掷{}时，",
					"重新补货{C:attention}补充包{}"
				}
			},
			c_entr_perthro_providence = {
				name = "佩思罗符文{C:purple}+{}",
				text = {
					"在下一次{C:attention}重掷{}时，",
					"重新补货{C:attention}补充包{}，",
					"并{C:attention}临时{}提供",
					"{C:purple,E:1}+1{} 个商店槽位"
				}
			},

			c_entr_algiz = {
				name = "阿尔吉兹符文",
				text = {
					"花费 {C:money}$10{} 来",
					"防止下一次{C:red}死亡{}",
				}
			},
			c_entr_algiz_providence = {
				name = "阿尔吉兹符文{C:purple}+{}",
				text = {
					"花费 {C:purple,E:1}$5{} 来",
					"防止下一次{C:red}死亡{}",
				}
			},

			c_entr_sowilo = {
				name = "索威罗符文",
				text = {
					"使下一次被{C:attention}弃掉{}的手牌",
					"获得 {C:gold}+2{} 晋升强度"
				}
			},
			c_entr_sowilo_providence = {
				name = "索威罗符文{C:purple}+{}",
				text = {
					"使下一次被{C:attention}弃掉{}的手牌",
					"获得 {C:purple,E:1}+4{} 晋升强度"
				}
			},

			c_entr_tiwaz = {
				name = "提瓦兹符文",
				text = {
					"下一张{C:attention}抽到{}的卡牌",
					"将获得一项{C:attention}随机{}修改"
				}
			},
			c_entr_tiwaz_providence = {
				name = "提瓦兹符文{C:purple}+{}",
				text = {
					"下一张{C:attention}抽到{}的卡牌",
					"将获得 {C:purple,E:1}两项{} {C:attention}随机{}修改"
				}
			},

			c_entr_berkano = {
				name = "伯卡诺符文",
				text = {
					"为下一张被{C:red}摧毁{}的卡牌",
					"创造 {C:attention}两张{}副本"
				}
			},
			c_entr_berkano_providence = {
				name = "伯卡诺符文{C:purple}+{}",
				text = {
					"为下一张被{C:red}摧毁{}的卡牌",
					"创造 {C:purple,E:1}三张{}副本"
				}
			},

			c_entr_ehwaz = {
				name = "埃华兹符文",
				text = {
					"在下一次{C:attention}跳过{}盲注时",
					"提供一次盲注结算{C:attention}金钱{}和进入一次{C:attention}商店{}的权限"
				}
			},
			c_entr_ehwaz_providence = {
				name = "埃华兹符文{C:purple}+{}",
				text = {
					"在下一次{C:attention}跳过{}盲注时",
					"提供一次盲注结算{C:attention}金钱{}和进入一次",
					"拥有 {C:purple,E:1}+1 商店槽位{}的{C:attention}商店{}的权限"
				}
			},

			c_entr_mannaz = {
				name = "曼纳兹符文",
				text = {
					"下一个{C:attention}打开{}的补充包",
					"将包含一张{C:spectral}幻灵{}牌"
				}
			},
			c_entr_mannaz_providence = {
				name = "曼纳兹符文{C:purple}+{}",
				text = {
					"下一个{C:attention}打开{}的补充包",
					"将包含 {C:purple,E:1}两张{} {C:spectral}幻灵{}牌"
				}
			},

			c_entr_laguz = {
				name = "拉古兹符文",
				text = {
					"返还下一次",
					"{C:attention}弃牌{}次数"
				}
			},
			c_entr_laguz_providence = {
				name = "拉古兹符文{C:purple}+{}",
				text = {
					"返还下一次的{C:attention}弃牌{}次数",
					"并临时提供 {C:purple,E:1}+1{} 次出牌"
				}
			},

			c_entr_ingwaz = {
				name = "因格瓦兹符文",
				text = {
					"下一次{C:attention}概率{}判定",
					"必定{C:green}成功{}"
				}
			},
			c_entr_ingwaz_providence = {
				name = "因格瓦兹符文{C:purple}+{}",
				text = {
					"下一次{C:attention}概率{}判定",
					"必定{C:green}成功{}，且触发时",
					"有 {C:purple,E:1}33%{} 几率不消耗此符文"
				}
			},

			c_entr_dagaz = {
				name = "达加兹符文",
				text = {
					"将下一张{C:attention}获得{}的",
					"消耗牌逆位"
				}
			},
			c_entr_dagaz_providence = {
				name = "达加兹符文{C:purple}+{}",
				text = {
					"将下一张{C:attention}获得{}的",
					"消耗牌逆位，",
					"并且当其发生时，{C:purple,E:1}创造{}一张",
					"随机逆位消耗牌",
					"{C:inactive}(必须有空间){}"
				}
			},
			c_entr_othila = {
				name = "奥特拉符文",
				text = {
					"下一张被{C:attention}出售{}的卡牌提供",
					"{X:gold,C:white}X3{} 倍的金钱"
				}
			},
			c_entr_othila_providence = {
				name = "奥特拉符文{C:purple}+{}",
				text = {
					"下一张被{C:attention}出售{}的卡牌提供",
					"{X:purple,C:white,E:1}X5{} 倍的金钱"
				}
			},
		},
		Pact = {
			c_entr_avarice = {
				name = "贪婪契约",
				text = {
					"复制你{C:attention}售价{}最高的",
					"小丑，然后将所有{C:attention}当前{}与{C:attention}未来{}",
					"卡牌的售价乘以 {X:red,C:white}X0.25{}",
					"{C:inactive}(必须有空间，剥夺负片状态)"
				}
			},
			c_entr_rage = {
				name = "狂怒契约",
				text = {
					"随机{C:red}摧毁{}你{C:attention}整副{}牌组中",
					"{C:attention}20%{} 的卡牌",
					"{C:inactive}(最少 5 张，当前为 #1#)"
				}
			},
			c_entr_thorns = {
				name = "荆棘契约",
				text = {
					"将{C:attention}租赁{}状态应用到 {C:attention}#1#{} 张随机小丑上，",
					"然后赋予它们{C:attention}随机{}版本"
				}
			},
			c_entr_denial = {
				name = "否认契约",
				text = {
					"创造一张上一次{C:attention}出售{}卡牌的{C:attention}副本{}",
					"然后将该卡牌{C:red}放逐{}",
					"{C:inactive}(当前为 {C:attention}#1#{C:inactive}，必须有空间){}"
				}
			},
			c_entr_chains = {
				name = "锁链契约",
				text = {
					"重新触发所有{C:attention}永恒{}",
					"扑克牌，每回合第一张{C:attention}抽到{}的牌",
					"将变为{C:attention}永恒{}状态"
				}
			},
			c_entr_decay = {
				name = "衰变契约",
				text = {
					"从 {C:attention}#2#{} 种随机牌型中{C:red}扣除{} {C:attention}#1#{} 个等级",
					"为你打出次数最多的牌型增加 {C:attention}#3#{} 级"
				}
			},
			c_entr_envy = {
				name = "嫉妒契约",
				text = {
					"{C:red}摧毁{}一张{C:attention}随机{}小丑",
					"重新触发一张{C:attention}随机{}小丑，",
					"目标每回合改变"
				}
			},
			c_entr_youth = {
				name = "青春契约",
				text = {
					"{C:attention}摧毁{}一张随机小丑",
					"{C:attention}-#1#{} 底注",
				}
			},
			c_entr_shards = {
				name = "碎片契约",
				text = {
					"将{C:dark_edition}碎裂{}状态应用到一张",
					"随机小丑上，{C:attention}未来{}的扑克牌",
					"摧毁效果可能会{C:red}失败{}"
				}
			},
			c_entr_desire = {
				name = "欲望契约",
				text = {
					"创造 {C:attention}#1#{} 张随机",
					"{C:spectral}幻灵{}或{C:red}预兆{}牌",
					"{C:attention}补充包{}的价格变得 {C:money}50%{} 更贵",
					"{C:inactive}(必须有空间){}"
				}
			},
			c_entr_ice = {
				name = "坚冰契约",
				text = {
					"兑换 {C:attention}#1#{} 张随机{C:attention}优惠券{}",
					"你{C:attention}等级最高{}的牌型",
					"{C:red}无法{}再改变等级"
				}
			},
			c_entr_gluttony = {
				name = "暴食契约",
				text = {
					"{C:attention}+#1#{} 消耗牌槽位",
					"{C:red}所有{}消耗牌变为{C:attention}永恒{}状态"
				}
			},
			c_entr_rebirth = {
				name = "重生契约",
				text = {
					"扑克牌将被{C:attention}复制{}",
					"而不是被{C:red}摧毁{}",
					"{C:blue}-#1#{} 手牌上限"
				}
			},
			c_entr_despair = {
				name = "绝望契约",
				text = {
					"将{C:attention}整副牌组{}中的 {C:attention}#1#{} 张随机",
					"卡牌#<s>1#进行增强，并在 {C:attention}#3#{} 回合内削弱",
					"{C:attention}整副牌组{}中 {C:attention}#2#%{} 的卡牌"
				}
			},	
			c_entr_strength = {
				name = "力量契约",
				text = {
					"将你{C:attention}打出次数最多{}的牌复制 {C:attention}#1#{} 次",
					"将{C:attention}租赁{}状态应用到一张随机小丑上"
				}
			},	
			c_entr_darkness = {
				name = "黑暗契约",
				text = {
					"将{C:dark_edition}负片{}状态应用到一张随机小丑上",
					"扑克牌可能会被面朝{C:red}下{}抽到"
				}
			},	
			c_entr_freedom = {
				name = "自由契约",
				text = {
					"{C:attention}+#1#{} 选牌上限",
					"{C:attention}-#2#{} 手牌上限"
				}
			},	
			c_entr_eternity = {
				name = "永恒契约",
				text = {
					"为你{C:attention}打出次数最多{}的牌型",
					"提供 {C:gold}+#1#{} 晋升强度，",
					"一张随机小丑变为{C:attention}永恒{}状态"
				}
			},	
			c_entr_loyalty = {
				name = "忠诚契约",
				text = {
					"利息现在每 {C:money}$4{} 计算一次",
					"每隔一次出牌提供 {X:mult,C:white}X0.5{} 倍率"
				}
			},
			c_entr_brimstone = {
				name = "硫磺契约",
				text = {
					"在回合的{C:attention}最后一手牌{}打出后",
					"提供 {X:mult,C:white}X3.6{} 倍率",
					"{C:blue}-#1#{} 次出牌"
				}
			},
			c_entr_dreams = {
				name = "梦境契约",
				text = {
					"获得 {C:attention}#1#{} 个随机标签",
					"小盲注不提供{C:attention}奖励{}"
				}
			},
			c_entr_energy = {
				name = "能量契约",
				text = {
					"为上一次弃掉的手牌",
					"应用随机{C:dark_edition}版本{}",
					"{C:red}-#1#{} 次弃牌"
				}
			},	
			c_entr_blood = {
				name = "鲜血契约",
				text = {
					"将{C:attention}整副牌组{}中",
					"{C:attention}#1#{} 张随机",
					"扑克牌链接在一起"
				}
			},		
			c_entr_awakening = {
				name = "觉醒契约",
				text = {
					"创造一张随机的{C:dark_edition}负片{}优惠券",
					"{C:attention}-#1#{} 补充包槽位"
				}
			},
		},
		mtx = {
			c_entr_extrajoker = {
				name = "额外小丑槽",
				text = {
					"{C:attention}+#1# 小丑槽位{}",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_unstick = {
				name = "除胶剂",
				text = {
					"移除你的{C:attention}小丑{}上的",
					"所有{C:attention}贴纸{}",
					"{C:purple}-c.#1#{}"
				}
			},
			c_entr_extrahands = {
				name = "额外出牌",
				text = {
					"{C:blue}+#1# 次出牌{}",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_moneybundle = {
				name = "成捆美元",
				text = {
					"{C:money}+$#1#{}",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_biggerpockets = {
				name = "更大口袋",
				text = {
					"{C:attention}+#1# 消耗牌槽位{}",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_deckfix = {
				name = "卡组修复",
				text = {
					"摧毁最多 {C:attention}#1#{} 张",
					"选定卡牌",
					"{C:purple}-c.#2#{}"
				}
			},
			c_entr_generousdonation = {
				name = "慷慨捐赠",
				text = {
					"{C:purple}-c.#1#{}"
				}
			},
		},
		Other = {
			asc_power_tutorial = {
				name = "晋升强度说明",
				text = {
					"晋升强度会将",
					"{C:blue}筹码{}与{C:mult}倍率{}乘以",
					"{X:gold,C:white}X(1.25 ^ 强度)",
					"{C:inactive,s:0.8}例如：+0.5 晋升强度 -> X1.11 筹码/倍率",
					"{C:inactive,s:0.6}此提示框可以在设置中禁用"
				}
			},
			antipattern_pair = {
				name = "反面模式",
				text = {
					"在 #1# 之后打出的手牌：",
					"#2# #3# #4# #5# #6# #7#",
					"#8# #9# #10# #11# #12#",
				}
			},
			cry_multiuse = {
				name = "m",
				text = {
					"{C:inactive}可使用次数: ({V:1}#1#{C:inactive} 次剩余)",
				},
			},
			cry_banana_booster = {
				name = "香蕉",
				text = {
					"包中的所有卡牌",
					"均带有{C:attention}香蕉{}状态",
				},
			},
			cry_banana_voucher = {
				name = "香蕉",
				text = {
					"每回合有 {C:green}#1# / #2#{} 几率",
					"被取消兑换",
				},
			},
			cry_banana_consumeable = {
				name = "香蕉",
				text = {
					"使用时有 {C:green}#1# / #2#{} 几率",
					"不发生任何事",
				},
			},
			banana = {
				name = "香蕉",
				text = {
					"每回合有 {C:green}#1# / #2#{} 几率",
					"被摧毁",
				},
			},
			echo_tooltip = {
				name = "(~)$ echo (回显)",
				text = {
					"当此卡被使用时，",
					"同时触发 {C:attention}#1#{}"
				}
			},
			temporary_debuff_tooltip = {
				name = "临时削弱",
				text = {
					"在接下来的 {C:attention}#1#{} 回合内",
					"处于被削弱状态"
				}
			},
			inversion_allowed = {
				name = "逆位许可",
				text = {
					"可以被{C:red}逆位{}",
					"为 {C:red}#1#{}"
				}
			},
			no_downside = {
				name = "负面效果已消除",
				text = {
					"负面效果已被移除",
				}
			},
			no_downside_cond = {
				name = "负面效果已消除",
				text = {
					"当 {X:dark_edition,C:white}熵{}",
					"高于 {C:attention}100{} 时",
					"负面效果将被移除"
				}
			},
			p_entr_twisted_pack_normal = { 
				name = "扭曲包",
				group_name = "逆位卡牌",
				text={
					"从最多 {C:attention}#2#{} 张{C:red}逆位{}卡牌中",
					"选择 {C:attention}#1#{} 张，",
					"立即使用或带走",
				}
			},
			p_entr_twisted_pack_jumbo = { 
				name = "巨型扭曲包",
				group_name = "逆位卡牌",
				text={
					"从最多 {C:attention}#2#{} 张{C:red}逆位{}卡牌中",
					"选择 {C:attention}#1#{} 张，",
					"立即使用或带走",
				},
			},
			p_entr_twisted_pack_mega = { 
				name = "超级扭曲包",
				group_name = "逆位卡牌",
				text={
					"从最多 {C:attention}#2#{} 张{C:red}逆位{}卡牌中",
					"选择 {C:attention}#1#{} 张，",
					"立即使用或带走",
				},
			},
			p_entr_twisted_pack_normal_2 = { 
				name = "扭曲包",
				group_name = "逆位卡牌",
				text={
					"从最多 {C:attention}#2#{} 张{C:red}逆位{}卡牌中",
					"选择 {C:attention}#1#{} 张，",
					"立即使用或带走",
				}
			},
			p_entr_twisted_pack_jumbo_2 = { 
				name = "巨型扭曲包",
				group_name = "逆位卡牌",
				text={
					"从最多 {C:attention}#2#{} 张{C:red}逆位{}卡牌中",
					"选择 {C:attention}#1#{} 张，",
					"立即使用或带走",
				},
			},
			p_entr_twisted_pack_mega_2 = { 
				name = "超级扭曲包",
				group_name = "逆位卡牌",
				text={
					"从最多 {C:attention}#2#{} 张{C:red}逆位{}卡牌中",
					"选择 {C:attention}#1#{} 张，",
					"立即使用或带走",
				},
			},
			p_entr_blind = { 
				name = "盲注包",
				group_name = "盲注",
				text={
					"从最多 {C:attention}#2#{} 张{C:attention}盲注代币{}中",
					"选择 {C:attention}#1#{} 张，",
					"立即使用或带走",
				}
			},
			p_entr_unbounded = {
				name = "无限包",
				text = {
					"从最多 {C:attention}#2#{} 张{C:spectral}幻灵{}牌中",
					"选择 {C:attention}#1#{} 张",
					"{s:0.8,C:inactive}(由无限标签生成)",
				},
			},
			p_entr_reference_pack = { 
				name = "参考包",
				group_name = "逆位卡牌",
				text={
					"从最多 {C:attention}#2#{} 张{C:attention}参考小丑{}中",
					"选择 {C:attention}#1#{} 张",
				}
			},
			p_entr_voucher_pack = {
				name = "优惠券包",
				group_name = "优惠券",
				text={
					"从最多 {C:attention}#2#{} 张{C:attention}优惠券{}中",
					"选择 {C:attention}#1#{} 张",
				}
			},
			undiscovered_rune = {
				name = "未发现",
				text = {
					"在未设定种子的对局中",
					"购买或使用此卡",
					"以了解其作用",
				},
			},
			undiscovered_pact = {
				name = "未发现",
				text = {
					"在未设定种子的对局中",
					"购买或使用此卡",
					"以了解其作用",
				},
			},
			undiscovered_fraud = {
				name = "未发现",
				text = {
					"在未设定种子的对局中",
					"购买或使用此卡",
					"以了解其作用",
				},
			},
			undiscovered_omen = {
				name = "未发现",
				text = {
					"在未设定种子的对局中",
					"购买或使用此卡",
					"以了解其作用",
				},
			},
			undiscovered_star = {
				name = "未发现",
				text = {
					"在未设定种子的对局中",
					"购买或使用此卡",
					"以了解其作用",
				},
			},
			undiscovered_command = {
				name = "未发现",
				text = {
					"在未设定种子的对局中",
					"购买或使用此卡",
					"以了解其作用",
				},
			},
			undiscovered_cblind = {
				name = "未发现",
				text = {
					"在未设定种子的对局中",
					"购买或使用此卡",
					"以了解其作用",
				},
			},
			undiscovered_transient = {
				name = "未发现",
				text = {
					"在未设定种子的对局中",
					"购买或使用此卡",
					"以了解其作用",
				},
			},
			entr_pinned = {
				name = "不可变",
				text = {
					"{C:attention}无法{}被重掷",
					"在下一回合的商店中",
					"会{C:attention}重新出现{}"
				}
			},
			entr_hotfix = {
				name = "热修",
				text = {
					"{C:attention}无法{}被削弱",
				}
			},
			entr_pseudorandom = {
				name = "伪随机",
				text = {
					"所有的{C:red}概率事件{}都将",
					"{C:red}必定成功{}，直到",
					"下一回合开始"
				}
			},
			temporary = {
				name = "临时",
				text = {
					"在回合结束时",
					"被{C:red}摧毁{}"
				}
			},
			superego = {
				name = "投射",
				text = {
					"出售时，创造 {C:attention}#1#{} 张",
					"此卡牌的副本",
					"每过 2 回合数量增加"
				}
			},
			desync = {
				name = "失步",
				text = {
					"在 {C:attention}#1#{} 期间",
					"{C:dark_edition}强制触发{}",
					"打出手牌时随机决定时机"
				}
			},
			entr_aleph = {
				name = "Aleph (真理)",
				text = {
					"{C:red}永远{}无法被{C:attention}移除{}"
				}
			},
			entr_copper_sticker = {
                name = '黄铜贴纸',
                text = {
                    "曾在{C:attention}黄铜注",
					"难度下",
					"使用此小丑赢得游戏"
                }
            },
			entr_platinum_sticker = {
                name = '铂金贴纸',
                text = {
                    "曾在{C:attention}铂金注",
					"难度下",
					"使用此小丑赢得游戏"
                }
            },
			entr_meteorite_sticker = {
                name = '陨石贴纸',
                text = {
                    "曾在{C:attention}陨石注",
					"难度下",
					"使用此小丑赢得游戏"
                }
            },
			entr_obsidian_sticker = {
                name = '黑曜石贴纸',
                text = {
                    "曾在{C:attention}黑曜石注",
					"难度下",
					"使用此小丑赢得游戏"
                }
            },
			entr_iridium_sticker = {
                name = '铱金贴纸',
                text = {
                    "曾在{C:attention}铱金注",
					"难度下",
					"使用此小丑赢得游戏"
                }
            },
			entr_zenith_sticker = {
                name = '顶点贴纸',
                text = {
                    "曾在{C:entr_zenith}顶点注",
					"难度下",
					"使用此小丑赢得游戏"
                }
            },
			entr_marked = {
				name = "标记",
				text = {
					"本回合内，始终",
					"加入到每一手",
					"打出的牌中"
				}
			},
			entr_death_mark = {
				name = "死亡标记",
				text = {
					"触发时被{C:red}摧毁{}"
				}
			},
			void_temporary = {
				name = "临时",
				text  = {
					"在回合结束时",
					"被{C:red}摧毁{}"
				}
			},
			entr_death_mark_consumeable = {
				name = "死亡标记",
				text = {
					"使用时不会生效，",
					"而是直接被{C:red}摧毁{}"
				}
			},
			entr_crimson_seal = {
				name = "猩红蜡封",
				text = {
					"重新触发{C:attention}相邻{}的卡牌"
				}
			},
			entr_sapphire_seal = {
				name = "蓝宝石蜡封",
				text = {
					"如果在回合结束时",
					"被{C:attention}持有{}在手中，",
					"为打出的牌型提供",
					"{C:attention}+0.25{} 晋升强度"
        		}
			},
			entr_silver_seal = {
				name = "银色蜡封",
				text = {
					"计分时，每有一张卡牌",
					"留在{C:attention}手中{}，提供 {C:gold}$1{}"
        		}
			},
			entr_pink_seal = {
				name = "粉色蜡封",
				text = {
					"弃掉时，创造一张",
					"{C:red}逆位{}牌，",
					"然后被{C:attention}摧毁{}",
					"{C:inactive}(必须有空间){}"
				}
			},
			entr_verdant_seal = {
				name = "翠绿蜡封",
				text = {
					"打出且是{C:attention}唯一{}一张",
					"计分的卡牌时，",
					"创造一张{C:red}指令{}牌"
				}
			},
			entr_cerulean_seal = {
				name = "天蓝蜡封",
				text = {
					"如果此卡是打出扑克牌型的",
					"{C:attention}一部分{}，",
					"为该牌型创造 3 张{C:dark_edition}负片{}的{C:purple}恒星{}牌",
					"然后{C:attention}摧毁{}打出的手牌"
				}
			},
			entr_ornate_seal = {
				name = "华丽蜡封",
				text = {
					"被{C:red}摧毁{}时，",
					"创造一张{C:purple}符文{}牌",
					"{C:inactive}(必须有空间){}"
				}
			},
			entr_amber_seal = {
				name = "琥珀蜡封",
				text = {
					"当被{C:attention}复制{}或{C:attention}复印{}时，",
					"创造一张{C:red}契约{}牌，",
					"然后{C:red}摧毁{}自身",
					"{C:inactive}(必须有空间){}"
				}
			},
			entr_mini_seal = {
				name = "微型蜡封",
				text = {
					"计分后，有 {C:green}#1# / #2#{} 几率",
					"{C:red}摧毁{} {C:attention}相邻{}的卡牌"
				}
			},
			entr_sharp_seal = {
				name = "锋利蜡封",
				text = {
					"计分前，有 {C:green}#1# / #2#{} 几率",
					"升级此卡的{C:attention}增强效果{}"
				}
			},
			entr_vantablack_seal = {
				name = "梵塔黑蜡封",
				text = {
					"当被选中时，",
					"{C:attention}+1{} 选牌上限"
				}
			},
			link = {
				name = "链接",
				text = {
					"与其他共享相同",
					"链接的卡牌，",
					"同步所有的修改效果",
					"{C:inactive}(#1#){}"
				}
			},
			xmult_bonus = {
				name = "额外倍率",
				text = {
					"{X:red,C:white}X#1#{} 额外",
					"倍率"
				}
			},
			entr_yellow_sign = {
				name = "黄印",
				text = {
					"{C:attention}临时{}被视为",
					"{C:diamonds}方块{}"
				}
			},
			scarred = {
				name = "伤痕",
				text = {
					"弃牌时{C:attention}不会{}从",
					"手中移除，但",
					"{C:attention}仍会{}抽取新牌补位"
				}
			},
			tmtrainer_dummy = {
				name = "故障效果",
				text = {
					"#1#",
					"#2#"
				}
			},
			entr_pure = {
				name = "纯净",
				text = {
					"此小丑的数值",
					"无法改变"
				}
			},
			entr_card_suit_level = {
				text = {
					"--------------",
					"{S:0.8,V:1}#1#{} {S:0.8}({S:0.8,V:2}lvl.#3#{})",
					"{C:blue}+#2#{} 筹码"
				}
			}
		},
		Partner = {
			pnr_entr_parakmi = {
				name = "蒂奥伊斯",
				text = {
					"补充包可能会",
					"被随机替换为",
					"另一种随机",
					"补充包"
				}
			}
		},
		TheFamily_Tab = {
            entr_rune_tags = {
                name = "符文标签",
                text = {
                    "隐藏或显示符文标签"
                }
            }
        },
		TheFamily_Group = {
            entr_misc_group = {
                name = "杂项设置 (Entropy)",
                text = {
                    "切换 Entropy 添加的各种 UI 元素的显示"
                }
            }
        },
		Mod = {
            entr = {
				name = "Entropy (熵)",
				text = {
					"{s:1.2}一个非常{C:red,s:1.2}混乱{s:1.2}的 Balatro 模组，灵感",
					"{s:1.2}主要来源于{C:red,s:1.2}以撒的结合：忏悔{s:1.2}等作品，",
					"{s:1.2}核心机制围绕{C:red,s:1.2}逆位{s:1.2}消耗牌展开，",
					"{s:1.2}并在多个维度扩展了原版的机制玩法。",
					"{s:1.2}整体体验贴近原版，但又不完全是原版{C:purple,s:1.2}+{}"
				}
			}
		}
	},
	misc = {
		tutorial = {
			cry_intro_1 = {
				"你好，我是{C:attention}约瑟夫·J·小丑{}！",
				"欢迎来到{C:entr_entropic,E:1}Entropy{}的世界！",
			},
			cry_intro_2 = {
				"看起来你在当前存档中",
				"还从未游玩过{C:entr_entropic,E:1}Entropy{}。",
				"让我来为你展示一下它的奇妙之处吧！",
			},
			cry_intro_3 = {
				"*长出双手*",
			},
			cry_intro_4 = {
				"很难用三言两语来概括",
				"这个模组的魅力，但我能告诉你的是，",
				"你即将迎来一段{C:entr_entropic,E:1}更为疯狂{}的旅程！",
				"这绝对不是你之前玩过的那个{C:attention}Cryptid{}...",
			},
			cry_intro_5 = {
				"你可能从这些{C:entr_entropic}游戏设置集{}的名字中看出来了，我很喜欢字母 {C:attention}E{}。",
				"选择一个游戏设置集，让我为你详细解释...",
				"{s:0.8}注意：游戏集的平衡性仍在积极调整中。",
				"{s:0.8}请做好内容会频繁变动的准备！",
			},
			cry_modest_1 = {
				"想要寻找贴近原版的游戏体验？",
				"那么{C:entr_entropic}Ethereal (空灵){} 设置集绝对是你的不二之选！",
			},
			cry_modest_2 = {
				"不过，还是要小心那些隐藏在",
				"Entropy 各处的诡计！你永远无法预料",
				"下一个回合会碰到什么...",
			},
			cry_mainline_1 = {
				"想要{E:1,C:attention}打破{}游戏的常规？好消息，",
				"你可以做到，而且不需要走极端！",
			},
			cry_mainline_2 = {
				"这里的内容依旧疯狂，但你将有机会",
				"体验{C:entr_entropic}循序渐进{}的成长系统。",
				"只是千万别掉以轻心...",
			},
			cry_mainline_3 = {
				"因为虽然你会变得更强，但我精心设计了一些",
				"{E:1,C:dark_edition}Boss{}，它们有可能会让你",
				"后悔选择了这个{C:entr_entropic}设置集{}...",
			},
			cry_madness_1 = {
				"你想让你的硬盘彻底{C:red,E:1}湮灭{}吗？",
				"哦，那可太有趣了！{C:entr_entropic}Exalted (狂热){} 设置集的座右铭就是：",
				"'平衡？{E:1,C:red}那是什么鬼东西！？{}'",
			},
			cry_madness_2 = {
				"我熬了无数个通宵，灌下了无数瓶{C:green}魔爪能量饮料{}，",
				"才确保这个设置集达到了",
				"{C:entr_entropic}绝对的完美平衡{}，这一切都是为了你！",
			},
			cry_madness_3 = {
				"你将以解锁所有内容的状态开局，",
				"尽情释放 Entropy 的{C:red,E:1}全部力量{}吧！",
				"只是要小心别让游戏{C:attention,E:1}崩溃{}了，",
				"因为这很可能会在你输掉对局之前发生...",
			},

			entr_tut_intro_1 = {
				"你好！我叫 {C:red}Ruby{}，我来这里",
				"是为了帮助你了解 {C:entr_entropic}Entropy{} 的基础玩法。"
			},
			entr_tut_intro_2 = {
				"这个模组的核心机制",
				"与原版游戏相比并没有太大区别。"
			},
			entr_tut_intro_3 = {
				"不过，还是有一些全新的内容",
				"我需要向你详细介绍。"
			},
			entr_tut_intro_4 = {
				"那么，我们一会儿商店见。",
			},

			entr_ap_1 = {
				"干得漂亮，现在你可以看看",
				"{C:entr_entropic}Entropy{} 的商店都提供了些什么好东西。"
			},
			entr_ap_2 = {
				"试着买下这张 {C:gold}晴朗{} 小恶魔吧。"
			},
			entr_ap_3 = {
				"这是本模组添加的 {C:attention}#1#{} 张小丑之一。"
			},
			entr_ap_4 = {
				"这张小丑能提供 {C:gold}+2{} 晋升强度，",
				"你可能很好奇这有什么用。"
			},
			entr_ap_5 = {
				"是这样的，每 {C:gold}+1{} 晋升强度",
				"都会将 {C:blue}筹码{} 与 {C:red}倍率{} 同时乘以 {X:purple,C:white}X1.25{}。"
			},
			entr_ap_6 = {
				"所以 {C:gold}+2{} 就相当于将两者分别",
				"触发两次 {X:purple,C:white}X1.25{}，也就是大约乘以 {X:purple,C:white}X1.56{}。"
			},
			entr_ap_7 = {
				"如果你想知道精确的",
				"计算公式，那就是 {X:gold,C:white}X(1.25 ^ 晋升强度)。"
			},
			entr_ap_8 = {
				"让我们在下一回合试试这张 {C:attention}小丑{} 吧。"
			},

			entr_alt_1 = {
				"欢迎来到击败Boss盲注后的商店。",
				"这里的大部分内容还是老样子，",
				"但有一个明显的区别。"
			},
			entr_alt_2 = {
				"你可能已经注意到了这个新出现的",
				"{C:purple}紫色{}商店按钮。"
			},
			entr_alt_3 = {
				"在 {C:entr_entropic}Entropy{} 中，你的对局分为",
				"两条截然不同的路线，这会直接影响你的",
				"{C:red}难度{}与{C:entr_void}奖励{}。"
			},
			entr_alt_4 = {
				"主路线包含了常规的盲注，",
				"包括 {C:attention}原版{} 以及一些",
				"由 {C:entr_entropic}Entropy{} 新增的盲注。"
			},
			entr_alt_5 = {
				"另一条路线被称为 {C:purple}反面路线 (The Flipside){}，",
				"这里有着专属的全新盲注，",
				"挑战难度通常也更高。"
			},
			entr_alt_6 = {
				"在这里，出现 {C:red}扭曲补充包{} 的几率也会更高，",
				"并且你还有机会遇到全新的 {C:entr_void}虚空小丑{}。所以，擦亮眼睛！"
			},
			entr_alt_7 = {
				"每次在击败Boss盲注后的商店中，",
				"你都可以切换一次路线。"
			},
			entr_alt_8 = {
				"现在，让我们切换到 {C:purple}另一条路线{}，",
				"我们下一个商店再见。"
			},

			entr_packs_1 = {
				"现在让我们来看看",
				"商店里的补充包。"
			},
			entr_packs_2 = {
				"试着买下这个由",
				"{C:entr_entropic}Entropy{} 新增的",
				"{C:red}扭曲补充包{} 吧。"
			},
			entr_packs_3 = {
				"扭曲补充包是一种",
				"仅包含逆位消耗牌的补充包。"
			},
			entr_packs_4 = {
				"{C:red}逆位{}消耗牌是基于",
				"现有的 {C:spectral}消耗牌{} 设计的，",
				"但它们的效果发生了某种扭曲。"
			},
			entr_packs_5 = {
				"举个例子，这张牌是 {C:entr_omen}魅惑{}，",
				"它是原版《小丑牌》中 {C:spectral}邪咒{} 的",
				"对应逆位版本。"
			},
			entr_packs_6 = {
				"这些消耗牌也可以通过",
				"其他途径获得，比如使用",
				"{C:spectral}反面{} 或 {C:purple}达加兹{} 符文。"
			},
			entr_packs_7 = {
				"补充包中必定能够",
				"选择逆位消耗牌。"
			},
			entr_packs_8 = {
				"让我们试着使用一下 {C:entr_omen}魅惑{} 吧。"
			},
			entr_packs_9 = {
				"接下来是现有",
				"补充包的改动。试着买下",
				"这个 {C:attention}天体包{}。"
			},
			entr_packs_10 = {
				"你可能已经在这个补充包中",
				"发现了一种新的 {C:purple}消耗牌类型{}。"
			},
			entr_packs_11 = {
				"这就是符文，它们有很小的几率",
				"取代秘术包中的 {C:purple}塔罗牌{}",
				"或天体包中的 {C:blue}星球牌{}。"
			},
			entr_packs_12 = {
				"符文没有专属的",
				"补充包，所以这种替代机制",
				"是获取它们的主要方式。"
			},
			entr_packs_13 = {
				"让我们试着使用这枚符文，",
				"看看它能带来什么神奇的效果。"
			},
			entr_packs_14 = {
				"好了，接下来就全看你的了。"
			}

		},
		achievement_names = {
			ach_entr_event_horizon = "事件视界",
			ach_entr_here_comes_the_sun = "太阳出来了",
			ach_entr_megalyteri = "Megalyteri",
			ach_entr_acheros = "阿刻戎",
			ach_entr_rift = "裂隙",
			ach_entr_katevaino = "Katevaino",
			ach_entr_joy_to_the_world = "普天同庆",
			ach_entr_suburban_jungle = "郊区丛林",
			ach_entr_f_x = "f(x)",
			ach_entr_c_sharp = "完美主义#"
		},
		achievement_descriptions = {
			ach_entr_event_horizon = "使用 #define 宏定义将方尖碑转换为啜泣",
			ach_entr_here_comes_the_sun = "获得一张晴朗小丑",
			ach_entr_acheros = "在底注 32 击败 Boss 盲注：无尽熵增",
			ach_entr_rift = "在反面路线中击败底注 8",
			ach_entr_katevaino = "在帕拉科米上使用超越",
			ach_entr_joy_to_the_world = "让温乔符文创造出另一个温乔符文",
			ach_entr_suburban_jungle = "在持有一张 Entropy 传奇小丑的情况下打出葫芦",
			ach_entr_f_x= "在持有反导数的情况下打出衍生物",
			ach_entr_c_sharp = "发现并解锁所有的原版与 Entropy 收藏条目"
		},
		suits_plural = {
			entr_nilsuit = "无",
		},
		suits_singular = {
			entr_nilsuit = "无",
		},
		ranks = {
			entr_nilrank = "无"
		},
		dictionary = {
			k_corrupted_ex = "已腐化！",
			k_recovered_ex = "已恢复！",
			cry_demicolon = "半分号触发！",
			k_ee_hand_1 = "当打出手牌时，一张随机卡牌变为晴朗版本",
			k_ee_hand_2 = "卡牌无法被削弱",
			k_ee_hand_3 = "当打出手牌时，所有小丑数值 X1.666",
			k_ee_hand_4 = "强制触发一张随机小丑",

			k_ee_discard_1 = "如果仅弃掉1张卡牌，扩散其版本效果",
			k_ee_discard_2 = "创造打出卡牌的负片香蕉副本",
			k_ee_discard_3 = "每弃掉一张卡牌，获得一个晋升标签",
			k_ee_discard_4 = "^3 倍率",


			k_before = "在计分之前：",
			k_pre_joker = "在小丑计分之前：",
			k_joker_main = "在主计分期间：",
			k_individual = "当此卡触发时：",
			k_pre_discard = "当弃牌时：",
			k_remove_playing_cards = "当扑克牌被摧毁时：",
			k_setting_blind = "当进入盲注时：",
			k_ending_shop = "当离开商店时：",
			k_reroll_shop = "当重掷时：",
			k_selling_card = "当一张卡被出售时：",
			k_using_consumeable = "当消耗牌被使用时：",
			k_playing_card_added = "当扑克牌被添加时：",

			k_tmtmult = "+??? 倍率",
			k_tmtchips = "+??? 筹码",

			k_tmtxmult = "X??? 倍率",
			k_tmtxchips = "X??? 筹码",

			k_tmtemult = "^??? 倍率",
			k_tmtechips = "^??? 筹码",

			k_tmtdollars = "+??? 美元",
			k_tmtjoker_random = "创造一张随机小丑",
			k_tmtjoker_choose_rarity = "创造一张随机稀有度的小丑",
			k_tmtedition = "将一种随机版本应用到随机小丑上",
			k_tmtante = "-??? 底注",
			k_tmtconsumable = "创造一张随机消耗牌",
			k_tmtenhancement_play = "一张打出的牌获得新的增强效果",
			k_tmtenhancement_hand = "一张持有的牌获得新的增强效果",
			k_tmtrandom = "触发 3 种随机效果",

			k_entr_entropic = "熵增",
			k_entr_reverse_legendary = "传奇？",
			k_entr_void = "虚空",
			k_entr_zenith = "顶点",
			k_entr_reverse_zenith = "顶点？",
			k_fraud = "欺诈",
			b_fraud_cards = "欺诈牌",

			k_command = "指令",
			b_command_cards = "指令牌",

			k_omen = "预兆",
			b_omen_cards = "预兆牌",

			k_transient = "瞬态",
			b_transient_cards = "瞬态牌",

			k_mtx = "内购",
			b_mtx_cards = "内购牌",

			k_inverted = "逆位",
			k_inverted_pack = "扭曲补充包",
			k_voucher_pack = "优惠券包",
			b_inverted_cards = "逆位牌",

			entr_code_sudo = "覆盖",
			entr_code_sudo_previous = "覆盖为先前的牌型",
			k_cooked_ex = "大势已去！",
			k_entr_asc_tutorial = "启用晋升强度说明提示框",
			k_entr_faster_ante_scaling = "如果你拥有熵增小丑，盲注分数规模加速增长",
			k_entr_entropic_music = "熵增小丑专属BGM (Joker in Greek by gemstonez)",
			k_entr_blind_tokens = "启用盲注代币",
			k_entr_profile_prefix = "为 Entropy 启用自定义存档预设",
			k_credits = "制作人员",
			k_code = "代码",
			k_idea = "创意提供",
			k_art = "美术设计",
			k_music = "音乐",
			k_music_sound = "音乐 / 音效",
			k_forcetrigger_ex = "强制触发！",
			k_spoiled_ex = "已腐坏！",
			k_downgrade_ex = "已降级！",
			k_backfired_ex = "适得其反！",
			k_skipped_q = "已跳过？",
			k_star = "恒星",
			b_star_cards = "恒星牌",	
			k_planet_multiverse = Cryptid_config.family_mode and "多元宇宙" or "TM的整个多元宇宙",
			k_planet_binary_star = "双星系统",
			k_planet_dyson_swarm = "戴森球巨构",

			k_entropy = "熵",

			k_cblind = "盲注代币",
			b_cblind_cards = "盲注代币",
			k_entr_base = "基础",

			k_blind_pack = "盲注包",
			b_blind_cards = "盲注",

			k_reference_pack = "参考包",
			b_reference_cards = "参考小丑",
			b_buy_slot = "+小丑槽",
			b_sell_slot = "-小丑槽",
			b_transition = "切换路线",
			
			b_cant_reroll="想都别想。",

			ph_blind_score_less_than="得分低于",
			entr_nadir_placeholder = "3X 基础值",

			ph_no_decks = "本局未购买任何牌组",
			ph_decks_bought = "本局已购买的牌组",

			ph_cards_defined = "本局中的宏定义",
			ph_definitions = "本局没有宏定义", 
			ph_leftright = "左侧的卡牌将始终转换为右侧的卡牌",
			b_definitions = "宏定义列表",
			entr_ascended = "已晋升！",
			k_entr_freebird = "反现实小丑专属BGM (Freebird by Lynyrd Skynyrd - 受版权保护)",

			entr_gameset_modest = "Ethereal (空灵)",
			entr_gameset_mainline = "Elysian (极乐)",
			entr_gameset_madness = "Exalted (狂热)",
			entr_gameset_custom = "Emergent (涌现)",

			entr_b_reset_gameset_modest = "重置游戏设置集 (空灵)",
			entr_b_reset_gameset_mainline = "重置游戏设置集 (极乐)",
			entr_b_reset_gameset_madness = "重置游戏设置集 (狂热)",

			entr_opened = "已打开！",
			entr_kiy_banished = "已放逐",

			k_saved_heroic = "不够英勇！",
			k_saved_just = "不够正义！",
			b_on = "启用",
			b_off = "禁用",
			b_enabled = "已启用",
			b_disabled = "已禁用",
			b_cycle = "循环",
			b_true_endless = "真无尽模式",
			k_entr_glitched = "使用全新的故障着色器效果 (by cassknows)",
			ph_hand_notreal = "调用扑克牌型函数时传入了无效参数",


			cry_notif_antireal_1 = "反现实小丑",
			cry_notif_antireal_2 = "版权声明",
			cry_notif_antireal_d1 = '反现实小丑播放的歌曲 "Freebird"，',
			cry_notif_antireal_d2 = "受到版权保护，不得被用于",
			cry_notif_antireal_d3 = "直播和视频中。",

			k_entr_omega_aleph = "Aleph（真理）贴纸将阻止自毁 (存在不稳定风险，生效需重启游戏)",
			k_entr_corrupted_speed = "腐化牌组的循环速度 (%)",

			k_saved_skullcry = "顶点注的力量拯救了你",

			b_change_path_1 = "进入",
			b_change_path_2 = "反面路线",
			b_change_path_3 = "返回",
			b_infinity = "无尽",

			b_daily_challenge = "每日挑战",

			flipside_none = '无',
			flipside_minimal = '极简',
			flipside_full = '完整',
			
			flipside_info = '手持“反面”消耗牌时的逆位展示信息',
			curses_enabled = "允许诅咒牌在黑曜石注之外出现",

			b_stat_CBlind = "盲注代币",
			b_stat_Fraud = "欺诈",
			b_stat_Star = "恒星",
			b_stat_Omen = "预兆",
			b_stat_Command = "指令",
			k_upgrade_atomikos = "已摧毁！",
			k_destroyed_ex = "已摧毁！",
			k_new = "new();",
			k_ascended_ex = "已晋升",

			k_rune = "符文",
			k_rune_pack = "符文包",
			b_rune_cards = "符文",
			k_pact = "契约",
			k_pact_pack = "魔鬼交易",
			b_pact_cards = "契约",

			cry_set_music = "音乐",

			k_inactive = "未激活",
			k_inactive_ex = "未激活！",
			k_randomised = "已随机化！",
			k_saved_algiz = "被阿尔吉兹符文救下一命",
			k_undebuffed_ex = "已解除削弱！",
			k_spatial_anomaly = "空间异常",

			k_curse_blind = "盲目诅咒",
			k_curse_blind_desc = "商店里的卡牌可能会被隐藏",

			k_curse_darkness = "黑暗诅咒",
			k_curse_darkness_desc = "补充包提供的选择更少",

			k_curse_lost = "迷失诅咒",
			k_curse_lost_desc = "没有小盲注",

			k_curse_maze = "迷宫诅咒",
			k_curse_maze_desc = "盲注出现的顺序被随机化",
			k_level_chips = "每级筹码",
			k_level_mult = "每级倍率",
			k_level_asc = "每级晋升强度",
			k_star_q = "恒星？",
			k_moon = "月球",
			k_satellite = "卫星",

			k_joker_in_greek = "Jokers in Greek (希腊小丑)",
			k_mirrored_in_crimson = "Mirrored in Crimson (猩红倒影)",
			k_freebird = "Freebird (自由之鸟)",
			k_ruby_reference = "Mors Caloris (热寂)",
			k_entropy_is_endless = "Entropy Is Endless (熵增无尽)",
			k_snd_ominous = "snd_ominous (不祥之音)",
			k_ee_goodmusic = "A Fervent Dreamers Lovesong (狂热梦想家的情歌)",
			k_ee_badmusic = "Utmost Devotion (极致奉献)",

			k_plus_rune = "+1 符文",
			k_plus_star = "+1 恒星",
			k_plus_pact = "+1 契约",
			k_plus_omen = "+1 预兆",
			k_plus_tag = "+1 标签",
			k_plus_inverted = "+1 逆位卡牌",
			k_plus_discard = "+1 次弃牌",

			k_switch_ex = "切换！",
			k_bounce_ex = "反弹！",
			b_challenge_me = "挑战",

			ph_red_1 = "???",
			ph_red_2 = "???",
		},
		v_dictionary = {
			card_art = "卡牌美术: #1#",
			shader = "着色器: #1#",
			wish = "愿望: #1#",
			cry_art = { "美术设计: #1#" },
			cry_code = { "程序代码: #1#" },
			cry_idea = { "创意提供: #1#" },
			a_eqmult = { "倍率 = #1#" },
			a_twisted = {"+#1# 逆位"},

            entr_void_desc = {
                "永久{C:entr_void}逆位{}所有未来",
                "出现的列在下方的小丑",
                "将其变为 {C:entr_void}#1#{}:",
                "{s:0.1} "
            }
		},
		gfb_quips = {
			{"32 个底注", "你拿什么", "来证明你的实力"},
			{"MATHISFUN", "认证的", "盖章认可"},
			{"现在附赠", "20% 额外的", "[服务器封禁]"},
			{"难道你", "不想知道吗", "气象男孩"},
			{"明天", "会有更多", "神级代金券"},
			{"汪汪汪", "嗷嗷嗷"},
			{"喂，我的", "优惠券在", "这里啊老兄"},
			{"6", "", "7"},
			{"你已经", "买了一个了", "你这个贪婪的混蛋"},
			{"优惠券？", "我根本不认识她"},
			{"", ":sun_with_face:"},
			{"我手里", "没有优惠券", "但我好想尖叫"},
			{"这玩意", "可真是", "太折磨我了"},
			{"我们的", "优惠券", "用光了"},
			{"向", "Balatro 的", "优惠券们致敬"},
			{"量子等级", "的 PR 合并", "就在明天"},
			{"让我们", "来一探", "究竟"},
			{"尝试索引", "全局变量 'VOUCHER'", "(一个 NIL 空值)"},
			{"", "本节目由突袭", "暗影传说赞助播出"},
			{"世界上", "根本没什么事", "发生过"},
			{"在这破商店里", "我要的优惠券呢", "我想兑换 想要蹦蹦跳跳"},
			{"", "=0 张优惠券", ""},
			{"愚蠢的", "啊啊啊", "凭证机制"},
			{"|   | |", "------", "| |   | _"},
			{"抱歉 吉姆波，我不允许赊账，", "或许你可以等你再", "MMMMMMMMMM有钱点再来"},
			{"我很惊讶", "你居然读完了", "所有的烂梗嘲讽"},
			{"你大可以说", "这游戏实在是", "太有“熵”了"},
			{"", "这TM简直是在熵我"},
			{"我能", "硬抗下来"},
			{"火辣的单身", "Boss盲注", "就在你附近"},
			{"无尽熵增", "想和你聊聊"},
			{"干嘛", "这么", "严肃？"},
			{"灰飞烟灭", "化作", "虚无的原子"},
			{"VOUCHER（优惠券）？", "不如叫", "VOUCHEEKS（屁股券）"},
			{"下个底注", "保证出", "魔术戏法"},
			{"", "BOO", ""},
			{"相信我兄弟", "下个底注", "必出反物质"},
			{"绝不放弃你", "绝不让你失望", "绝不抛弃你并对你置之不理"},
			{"别给我", "玩什么", "切线套路"},
			{":chud:"},
			{"今天", "我们", "享受盛宴"},
			{ "你", "这下恐怕是", "大势已去了" },
			{ "面包", ">", "钥匙" },
			{ "大笑", "笑死我了，", "真的" },
			{ "你本来", "应该拿", "那个跳过标签的" },
			{ "TMD", "什么是", "公里" },
			{ "500 个", "消耗牌", "槽位" },
			{ "2036年", "8月", "12日" },
			{ "版主，", "给他们上", "大记忆恢复术" },
			{ "DEEZ", "NUTS", "哈哈骗到你了" },
			{ "LOREM", "IPSUM", "DOLOR SIT" },
			{ "没有优惠券？", ":megamind:", "" },
			{ "求求你快点", "我真的需要", "这个" },
			{ "可怕的", "儿童搅拌机", "都市传说" }, -- 这是一个群内好友的梗
			{ "", "RE R", "" }, -- 另一个同样性质的梗
			{ "", "开始工作", "" },
			{ "", "IMG_4750.png", "" },
			{ "这简直是", "一坨优惠券大便", "" },
			{ "1.1 更新", "就在明天", "(相信我)" },
			{"TODO:", "编写更多烂梗语录"},
			{"哟 优惠券", "优惠券: 哟"},
			{"一坨大便优惠券"},
			{"SMODS.JimboQuip"},
			{"VOUCHER", "I HARDLY", "KNOW HER"},
			{"RUBY", "'ENTROPY'", "CRIMSONFANG"}
		},
		labels = {
			banana = "香蕉",
			entr_pinned = "不可变",
			entr_marked = "标记",
			entr_death_mark = "死亡标记",
			void_temporary = "临时",
			entr_hotfix = "热修",
			temporary = "临时",
			entr_pseudorandom = "伪随机",
			link = "已链接",
			superego = "投射",
			entr_sunny = "晴朗",
			entr_solar = "烈阳",
			entr_neon = "霓虹",
			entr_lowres = "低清",
			entr_kaleidoscopic = "万花筒",
			entr_gilded = "镀金",
			entr_fractured = "碎裂",
			entr_freaky = "猎奇",
			entr_yellow_sign = "黄印",
			scarred = "伤痕",
			desync = "失步",
			entr_aleph = "Aleph",
			entr_pure = "纯净",
			entr_crimson_seal = "猩红蜡封",
			entr_sapphire_seal = "蓝宝石蜡封",
			entr_silver_seal = "银色蜡封",
			entr_pink_seal = "粉色蜡封",
			entr_verdant_seal = "翠绿蜡封",
			entr_cerulean_seal = "天蓝蜡封",
			entr_ornate_seal = "华丽蜡封",
			entr_amber_seal = "琥珀蜡封",
			entr_mini_seal = "微型蜡封",
			entr_sharp_seal = "锋利蜡封",
			entr_vantablack_seal = "梵塔黑蜡封",
		},
		poker_hands = {
			["entr_All"] = Cryptid_config.family_mode and "全卡" or "TM的所有牌",
			["entr-Flesh"] = "血肉",
			["entr-Straight_Flesh"] = "血肉顺",
			["entr-Flesh_House"] = "血肉葫芦",
			["entr-Flesh_Five"] = "血肉五条",
			["entr_derivative"] = "衍生物"
		},
		poker_hand_descriptions = {
			entr_All = {
				"一手包含了标准52张扑克牌中",
				"每一张牌的牌型，外加",
				"一整套完整的光学牌和无之牌",
				"且每个花色都有一个无之牌",
				Cryptid_config.family_mode and "上帝已死" or "去你的，上帝已死",
			},
			entr_derivative = {
				"5 张包含非标准点数或花色的牌"
			}
		},
		challenge_names = {
			c_entr_lifelight = "生命之光 (Lifelight)",
			c_entr_vesuvius = "维苏威火山 (Vesuvius)",
			c_entr_hyperaccelerated_bongcloud_opening = "超加速老头推车开局 (Hyperaccelerated Bongcloud)",
			c_entr_hyperbolic_chamber = "精神时光地狱 (Hyperbolic Hell-Tier Chamber)",
			c_entr_daily = "每日挑战 (Daily Challenge)",
			c_entr_paycheck_to_paycheck = "月光族 (Paycheck to Paycheck)",
			c_entr_riffle_shuffle = "鸽尾洗牌 (Riffle Shuffle)",
			c_entr_variety_content = "多样性内容 (Variety Content)",
			c_entr_phantom_hand_syndrome = "幻影手综合征 (Phantom Hand Syndrome)",
			c_entr_eco_friendly = "环保主义 (Eco-Friendly)",
		},
		v_text = {
			ch_c_entr_no_planets = { "商店中不再出现星球牌" },
			ch_c_entr_starting_ante_mten = { "从底注 -10 开始游戏" },
			ch_c_entr_reverse_redeo = { "逆转“减税 (Redeo)”小丑改变底注的效果" },
			ch_c_entr_set_seed = {"设定种子为: #1#"}
		},
		quips={
			entr_lq_ee_1={
                "纯属技术问题"
            },
            entr_lq_ee_2={
                "如果你想",
				"打败我，",
				"你至少得去",
				"再练个一千年！"
            },
            entr_lq_ee_3={
                "你早就该",
				"按住 R 键重开了！"
            },
            entr_lq_ee_4={
                "在终点，",
				"世间万物终将",
				"屈服于熵增.."
            },
            entr_lq_ee_5={
                "看来你的",
				"“熵”",
				"还不够高啊！"
            },
            entr_lq_ee_6={
                "或许你应该",
				"再去多找几次",
				"重新触发的机会！"
            },
            entr_lq_ee_7={
                "也许你可以尝试",
				"再多装几个",
				"其他 Mod！"
            },
            entr_lq_ee_8={
                "别哭，这",
				"只是一场游戏...",
            },
            entr_lq_ee_9={
                "你真的",
				"有在用心玩吗？"
            },
			entr_lq_ee_10={
                "也许你应该",
				"彻底放弃",
				"打败我的念头！"
            },
			entr_lq_ee_revived = {
				"你真的",
				"以为那会有",
				"用吗？"
			},
			entr_tq_ee_half = {
				"这就是",
				"你的全部实力吗？"
			},
			entr_wq_ee_1={
                "啊？",
            },
            entr_wq_ee_2={
                "什么！？"
            },
            entr_wq_ee_3={
                "这怎么可能..."
            },
            entr_wq_ee_4={
                "展示出",
				"你的秘密！"
            },
            entr_wq_ee_5={
                "那可真是",
				"太有熵增感了！"
            },

			entr_lq_1 = {
				"看来命运",
				"终于追上了你。"
			},
			entr_lq_2 = {
				"一种无法避免的结局。"
			},
			entr_lq_3 = {
				"要不",
				"再来一局？"
			},
			entr_lq_4 = {
				"祝你下次",
				"好运..."
			},

			entr_wq_1 = {
				"你还真是",
				"有点东西，对吧？"
			},
			entr_wq_2 = {
				"熵增的力量",
				"在你体内闪耀！"
			},
			entr_wq_3 = {
				"我没看错你！"
			},
			entr_wq_4 = {
				"干得好... 现在去挑战",
				"铱金注吧！"
			},
		}
	},
}
local CBlind = {}
for i, v in pairs(decs.descriptions.Blind) do 
	local text = {}
	for i2, v2 in pairs(v.text or {}) do text[#text+1]=v2 end
	CBlind["c_entr_"..i] = {
		name=(v.name or "盲注").."代币",
		text={
			"使用后可改变",
			"当前或即将到来的",
			"盲注"
		}
	}
end
for i, v in pairs(G.localization.descriptions.Blind) do 
	local text = {}
	for i2, v2 in pairs(v.text or {}) do text[#text+1]=v2 end
	CBlind["c_entr_"..i] = {
		name=(type(v.name) ~= "table" and v.name or "盲注").."代币",
		text={
			"使用后可改变",
			"当前或即将到来的",
			"盲注"
		}
	}
end
decs.descriptions.CBlind = CBlind
return decs