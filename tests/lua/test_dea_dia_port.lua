-- The Dea Dia 2.1 fork receives its intended Nyxaris placement and routes.
package.path = "./?.lua;./?/init.lua;" .. package.path

local function check(ok, message)
	if not ok then
		error(message, 2)
	end
end

local function run(active_mods, include_lemures)
	local raw = {
		planet = {moshine = {}},
		["space-location"] = {["apia-carnova-orbit"] = {}, ["star-dea-dia"] = {}, ["dea-dia-system-edge"] = {}},
		["space-connection"] = {}
	}
	if include_lemures then
		raw.planet.lemures = {}
	end

	rawset(_G, "mods", active_mods)
	rawset(_G, "data", {raw = raw, extend = function(_, entries)
		for _, entry in ipairs(entries) do
			raw[entry.type][entry.name] = entry
		end
	end})
	local updates = {}
	rawset(_G, "PlanetsLib", {
		extend = function(_, entries)
			for _, entry in ipairs(entries) do
				raw[entry.type][entry.name] = entry
			end
		end,
		update = function(_, entries)
			for _, entry in ipairs(entries) do
				updates[entry.name] = entry
			end
		end
	})
	rawset(_G, "deleteRoute", function(name)
		raw["space-connection"][name] = nil
	end)
	package.loaded["util"] = true
	package.loaded["__space-age__.prototypes.planet.asteroid-spawn-definitions"] = {
		nauvis_fulgora = {}, spawn_definitions = function() return {} end
	}
	package.loaded["prototypes.world.systems.nyxaris"] = nil
	require("prototypes.world.systems.nyxaris")
	return updates, raw["space-connection"]
end

local updates, routes = run({["dea-dia-system-beomyo"] = "0.37.1"}, true)
check(updates["star-dea-dia"] and updates["star-dea-dia"].orbit.parent.name == "nyxaris",
	"the 2.1 fork's star must orbit Nyxaris")
check(updates["dea-dia-system-edge"], "the 2.1 fork's system edge must be positioned")
check(routes["sye-nyxaris-dea-dia-system-edge"] and routes["dea-dia-system-edge-lemures"],
	"the 2.1 fork's Nyxaris and Lemures routes must be created")

updates, routes = run({}, true)
check(not updates["star-dea-dia"] and not updates["dea-dia-system-edge"],
	"Dea Dia locations must not be moved when the fork is absent")
check(not routes["sye-nyxaris-dea-dia-system-edge"] and not routes["dea-dia-system-edge-lemures"],
	"Dea Dia routes must not be created when the fork is absent")

updates, routes = run({["dea-dia-system-beomyo"] = "0.37.1"}, false)
check(routes["sye-nyxaris-dea-dia-system-edge"] and not routes["dea-dia-system-edge-lemures"],
	"the fork must not create a route to a missing location")

print("test_dea_dia_port: ok")
