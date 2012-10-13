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

	it "Should clone other objects properly", ->

		class object
			@prop: "Sabin"

		newobject = obj.clone object
		newobject.prop = "Irina"

		(expect object.prop).toBe "Sabin"
		(expect newobject.prop).toBe "Irina"
		(expect object.prop).not.toEqual newobject.prop

	it "Should Extend and Include properly", ->

		class Primitive extends IS.Object
			@classprop1: "Class Prop Primitive"
			@classprop2: -> "Primitive"
			instprop1: "Instance Prop Primitive"
			instprop2: -> "Instance Primitive"

		class Mixin
			@classprop1: "Mixin Object"
			instprop2: -> "Mixin Instance"

		(expect Primitive.classprop1).toBe "Class Prop Primitive"
		(expect Primitive.prototype.instprop2()).toBe "Instance Primitive"

		(expect Mixin.classprop1).toBe "Mixin Object"
		(expect Mixin::instprop2()).toBe "Mixin Instance"
	
	it "Should Extend and Include properly", ->

		class Primitive extends IS.Object
			@classprop1: "Class Prop Primitive"
			@classprop2: -> "Primitive"
			instprop1: "Instance Prop Primitive"
			instprop2: -> "Instance Primitive"

		class Mixin
			@classprop1: "Mixin Object"
			instprop2: -> "Mixin Instance"

		Primitive.extend Mixin
		Primitive.include Mixin::

		(expect Primitive.classprop1).toBe "Mixin Object"
		(expect Primitive::instprop2()).toBe "Mixin Instance"

		Primitive.classprop2 = -> @::instprop1

		(expect Primitive.classprop2()).toBe "Instance Prop Primitive"

		Primitive.classprop2 = -> @super

		(expect Primitive.classprop2().classprop1).toBe "Class Prop Primitive"

