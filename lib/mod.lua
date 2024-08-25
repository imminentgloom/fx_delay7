--delayyyyyyyy by @cfd90
--modified and ported to fx mod for norns by @imminent gloom

local fx = require("fx/lib/fx")
local mod = require 'core/mods'
local hook = require 'core/hook'
local tab = require 'tabutil'
-- Begin post-init hack block
if hook.script_post_init == nil and mod.hook.patched == nil then
    mod.hook.patched = true
    local old_register = mod.hook.register
    local post_init_hooks = {}
    mod.hook.register = function(h, name, f)
        if h == "script_post_init" then
            post_init_hooks[name] = f
        else
            old_register(h, name, f)
        end
    end
    mod.hook.register('script_pre_init', '!replace init for fake post init', function()
        local old_init = init
        init = function()
            old_init()
            for i, k in ipairs(tab.sort(post_init_hooks)) do
                local cb = post_init_hooks[k]
                print('calling: ', k)
                local ok, error = pcall(cb)
                if not ok then
                    print('hook: ' .. k .. ' failed, error: ' .. error)
                end
            end
        end
    end)
end
-- end post-init hack block


local FxDelayyyyyyyy = fx:new{
    subpath = "/fx_delayyyyyyyy"
}

function FxDelayyyyyyyy:add_params()
    params:add_separator("fx_delayyyyyyyy", "fx delayyyyyyyy")
	
	FxDelayyyyyyyy:add_slot("fx_delayyyyyyyy_slot", "slot")
	FxDelayyyyyyyy:add_control("fx_delayyyyyyyy_time", "time", "time", controlspec.new(0.0001, 2, "exp", 0, 0.3, "s"))
	FxDelayyyyyyyy:add_control("fx_delayyyyyyyy_feedback", "feedback", "feedback", controlspec.new(0, 1, "lin", 0.01, 0, ""))
	FxDelayyyyyyyy:add_control("fx_delayyyyyyyy_sep", "sep", "<->", controlspec.new(0, 1, "lin", 0.01, 0, ""))
	FxDelayyyyyyyy:add_control("fx_delayyyyyyyy_mix", "mix", "mix", controlspec.new(0, 1, "lin", 0.01, 0, ""))
	FxDelayyyyyyyy:add_control("fx_delayyyyyyyy_send", "send", "send", controlspec.new(0, 1, "lin", 0.01, 0, ""))
	FxDelayyyyyyyy:add_control("fx_delayyyyyyyy_hp", "hp", "hp", controlspec.new(20, 10000, "exp", 0, 20, "Hz"))
	FxDelayyyyyyyy:add_control("fx_delayyyyyyyy_lp", "lp", "lp", controlspec.new(20, 10000, "exp", 0, 5000, "Hz"))
end

mod.hook.register("script_post_init", "fx delayyyyyyyy mod post init", function()
    FxDelayyyyyyyy:add_params()
end)

mod.hook.register("script_post_cleanup", "delayyyyyyyy mod post cleanup", function()
end)

return FxDelayyyyyyyy