if TheFamily then
    TheFamily.create_tab_group({
        key = "entr_misc_group",
        order = 0,
        center = "c_entr_ingwaz",
        can_be_disabled = true,
    })
    
    TheFamily.create_tab({
        key = "entr_rune_tags",
        center = "c_entr_ingwaz",
        can_be_disabled = true,
        group_key = "entr_misc_group",
        click = function(self, card)
            G.runes_visible = not G.runes_visible
            for i, v in pairs(G.HUD_runes or {}) do
                v.states.visible = not G.runes_visible
            end
            play_sound('cardSlide1')
            if self.card.children.popup then
                self.card.children.popup:remove()
                self.card.children.popup = nil
                self.card.thefamily_popup_checked = nil
                self:render_popup()
            end
        end,
        can_highlight = function(self, card)
            return false
        end,
        front_label = function(self, card)
            return {
                text = localize("b_rune_cards"),
            }
        end,
        popup = function(self, card)
            return {
                name = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Toggle Rune Tag Display",
                                    colour = G.C.WHITE,
                                    scale = 0.4,
                                },
                            },
                        },
                    },
                },
                description = {
                    {
                        {
                            n = G.UIT.R,
                            config = { align = "cm" },
                            nodes = TheFamily.UI.localize_text({
                                "Toggles the display of {C:purple}Rune Tags{}",
                                "Currently {V:1}#1#{}"
                            }, {
                                align = "cm",
                                vars = {
                                    G.runes_visible and localize("b_disabled") or localize("b_enabled"),
                                    colours = {
                                        G.runes_visible and G.C.MULT or G.C.GREEN
                                    }
                                }
                            }),
                        },
                    },
                },
            }
        end,
    })
end