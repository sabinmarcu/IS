IS = require "./IS"
obj = IS.Object

describe "Barebone Object", ->

	it "Should clone properly", ->

		newobj = obj.clone()

		(expect newobj::).toEqual obj::

		newobj.extend
			"Chestie": "Naspa"
		newobj.include 
			potato: [
				{ "chestie": "naspa" }
				"barabula"
				"cartof"
			]
		inst = new newobj

		(expect newobj.Chestie).toBe "Naspa"
		(expect inst.potato).toBeDefined()
		(expect newobj.potato).not.toBeDefined()
		(expect inst.potato).toContain "barabula"
		(expect inst.potato).not.toNotContain "cartof"
		(expect inst.potato).toContain "chestie": "naspa"
		(expect obj.Chestie).not.toBeDefined()
		(expect (new obj).potato).not.toBeDefined()