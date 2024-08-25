--delay7 by @cfd90
--modified and ported to fx mod for norns by @imminent gloom

local fx = require("fx/lib/fx")
local mod = require 'core/mods'

local FxDelay7 = fx:new{
    subpath = "/fx_delay7"
}

function FxDelay7:add_params()
	params:add_separator("fx_delay7", "fx delay7")
	FxDelay7:add_slot("fx_delay7_slot", "slot")
	FxDelay7:add_control("fx_delay7_time", "time", "time", controlspec.new(0.0001, 2, "exp", 0, 0.3, "s"))
	FxDelay7:add_control("fx_delay7_feedback", "feedback", "feedback", controlspec.new(0, 1, "lin", 0.01, 0, ""))
	FxDelay7:add_control("fx_delay7_sep", "sep", "sep", controlspec.new(0, 1, "lin", 0.01, 0, ""))
	FxDelay7:add_control("fx_delay7_mix", "mix", "mix", controlspec.new(0, 1, "lin", 0.01, 0, ""))
	FxDelay7:add_control("fx_delay7_send", "send", "send", controlspec.new(0, 1, "lin", 0.01, 0, ""))
	FxDelay7:add_control("fx_delay7_hp", "hp", "hp", controlspec.new(20, 10000, "exp", 0, 20, "Hz"))
	FxDelay7:add_control("fx_delay7_lp", "lp", "lp", controlspec.new(20, 10000, "exp", 0, 5000, "Hz"))
end

mod.hook.register("script_post_init", "fx delay7 mod post init", function()
    FxDelay7:add_params()
end)

mod.hook.register("script_post_cleanup", "delay7 mod post cleanup", function()
end)

return FxDelay7
