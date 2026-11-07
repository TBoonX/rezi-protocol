---@diagnostic disable: need-check-nil
-- The Journal and the projects it reports, on the real player of the scenario and the real GUI. The player has no
-- character yet (the freeplay intro runs), which does not matter for a window.
local journal = require("__razi-protocol__.scripts.journal.journal")
local window = require("__razi-protocol__.scripts.journal.window")
-- project_state adds status_for to the table that project_api returns
require("__razi-protocol__.scripts.journal.project_state")
local projects = require("__razi-protocol__.scripts.journal.project_api")
local great_projects = require("__razi-protocol__.scripts.projects.great_projects")
local story = require("__razi-protocol__.lib.story")

return function(runner)
	-- A mock accepts any caption, style or sprite; the game refuses a wrong one.
	for _, view in ipairs({"quests", "projects", "systems", "archive"}) do
		runner.test("the Journal opens its " .. view .. " view", function()
			local player = game.players[1]
			journal.preferences(player.index).view = view
			window.open(player)
			local frame = player.gui.screen[journal.FRAME]
			if not (frame and frame.valid) then
				runner.assert(false, "no Journal window")
				return
			end
			runner.assert(#frame.children > 0, "the Journal window is empty")
			window.close(player)
		end)
	end

	-- Counting a missing prototype is an engine error, so cover both startup modes.
	runner.test("the Archive Array project reports zero before relay construction", function()
		local force = game.players[1].force
		local enabled = story.enabled()
		runner.assert((prototypes.entity["razi-archive-relay"] ~= nil) == enabled,
			"the relay prototype does not match the story mode")
		local count_ok, count = pcall(function() return force.get_entity_count("razi-archive-relay") end)
		if enabled then
			runner.assert(count_ok and count == 0, "the story-enabled relay count should start at zero")
		else
			runner.assert(not count_ok, "the game accepts a count of an unknown entity; the guard is not needed")
		end
		local built, wanted, sites = projects.status_for(force, "array")
		runner.assert(built == 0 and wanted == 3, "array reports " .. tostring(built) .. " of " .. tostring(wanted))
		runner.assert(type(sites) == "table" and #sites == 0, "array reports sites")
		built, wanted = great_projects.array(force)
		runner.assert(built == 0 and wanted == 3, "great_projects.array reports " .. tostring(built) .. " of " .. tostring(wanted))
	end)
end
