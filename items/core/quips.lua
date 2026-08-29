for i=1,10 do
    SMODS.JimboQuip{
        key = "lq_ee_"..tostring(i),
        type = 'ee_loss',
        extra = {center = "j_entr_eecc"},
        filter = function(quip, type) 
            if type == "ee_loss" then return true, {override_base_checks = true} end
        end
    }
end

for i=1,7 do
    SMODS.JimboQuip{
        key = "wq_ee_"..tostring(i),
        type = 'ee_win',
        extra = {center = "j_entr_eecc"},
        filter = function(quip, type) 
            if type == "ee_win" then return true, {override_base_checks = true} end
        end
    }
end

SMODS.JimboQuip{
    key = "lq_ee_revived",
    type = 'ee_revived',
    extra = {center = "j_entr_eecc"},
    filter = function(quip, type) 
        if type == "ee_revived" then return true, {override_base_checks = true} end
    end
}

for i=1,4 do
    SMODS.JimboQuip{
        key = "lq_"..tostring(i),
        type = 'loss',
        extra = {center = "j_entr_surreal_joker"},
    }
end
for i=1,4 do
    SMODS.JimboQuip{
        key = "wq_"..tostring(i),
        type = 'win',
        extra = {center = "j_entr_surreal_joker"},
    }
end


SMODS.JimboQuip{
    key = "tq_ee_half",
    type = 'ee_taunt',
    extra = {center = "j_entr_eecc"},
}