-- Removed optional worlds must not appear as Journal goals.
package.path = "./?.lua;./?/init.lua;" .. package.path

local defs = require("scripts.journal.data")
local state = require("scripts.journal.journal")
local force = {technologies = {}}
local quest = defs.by_id.pelagos

if quest then
	assert(state.state(force, quest) == "unavailable", "Pelagos must be unavailable when its mod is absent")
	assert(not state.journal_visible(force, quest), "Pelagos must not appear in the Journal when absent")
end

print("test_removed_optional_content: ok")
