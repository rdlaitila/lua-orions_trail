local lecs = {}

lecs.REQUIRE_PATH = (...):match("(.-)[^%.]+$")

lecs.Component  = require(lecs.REQUIRE_PATH .. "component")
lecs.Entity     = require(lecs.REQUIRE_PATH .. "entity")
lecs.System     = require(lecs.REQUIRE_PATH .. "system")
lecs.Manager    = require(lecs.REQUIRE_PATH .. "manager")
lecs.uuid       = require(lecs.REQUIRE_PATH .. "uuid")

return lecs