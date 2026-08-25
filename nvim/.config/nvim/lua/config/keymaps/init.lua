require("config.keymaps.base")

local leader = require("config.keymaps.leader")
require("config.keymaps.apply").apply(leader)

return {
	leader = leader,
}
