IS = require "../../IS"
mongo = IS.Object.clone()
mongo.extend IS.Modules.ORM "MongoDB"

describe "ORM Mongo", ->

	it "Should get the object Properly", ->
		
		inst = IS.Object.clone()
		inst.extend IS.Modules.ORM "MongoDB"

		(expect inst._identifier).toBe "Mongo"


