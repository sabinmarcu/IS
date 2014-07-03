IS   = require "./../lib/isf.js"
chai = require "chai"
DefineProperty = IS.DefineProperty
Object = IS.Object.clone()
do chai.should

describe "DefineProperty", ->

	it "should have the proper properties", ->
		(typeof DefineProperty).should.not.equal "undefined"
		(typeof DefineProperty).should.equal "function"
		(typeof DefineProperty.extend).should.equal "object"
		(typeof DefineProperty.extend).should.not.equal "undefined"

	it "should have the proper extend functions", ->
		(typeof DefineProperty.extend.define).should.not.equal "undefined"
		(typeof DefineProperty.extend.define).should.equal "function"
		(typeof DefineProperty.extend.defineSetter).should.not.equal "undefined"
		(typeof DefineProperty.extend.defineSetter).should.equal "function"
		(typeof DefineProperty.extend.defineGetter).should.not.equal "undefined"
		(typeof DefineProperty.extend.defineGetter).should.equal "function"

	it "should do basic getter", ->

		o = {}
		DefineProperty "name", (-> "My Name"), null, o

		(typeof o.name).should.equal "string"
		o.name.should.equal "My Name"

	it "should do basic setter", ->
		o = { _name: "John"}
		DefineProperty "name", (-> o._name), ((name) -> o._name = name), o

		o.name.should.equal "John"

		o.name = "Matt"

		(typeof o.name).should.equal "string"
		o.name.should.equal "Matt"

	it "should work while including", ->

		class NEW_OBJECT extends Object
			@extend DefineProperty.extend

			constructor: ->  
				@_name = "John"
				@_surname = "Malcom"

			@defineGetter "name", -> @_name
			@defineSetter "name", (name) -> @_name = name

			@defineGetter "surname", -> @_surname
			@defineSetter "surname", (name) -> @_surname = name

			@define "fullname", (-> "#{@_name} #{@_surname}"), ((name) -> [@_name, @_surname] = name.split " ")

		obj = new NEW_OBJECT()

		(typeof obj.name).should.not.equal "undefined"
		(typeof obj.name).should.equal "string"
		(typeof obj.surname).should.not.equal "undefined"
		(typeof obj.surname).should.equal "string"
		(typeof obj.fullname).should.not.equal "undefined"
		(typeof obj.fullname).should.equal "string"

		obj.name.should.equal "John"
		obj.surname.should.equal "Malcom"
		obj.fullname.should.equal "John Malcom"

		obj.name = "Matt"
		obj.name.should.equal "Matt"

		obj.surname = "Someone"
		obj.surname.should.equal "Someone"

		obj.fullname = "John Malcom"
		obj.name.should.equal "John"
		obj.surname.should.equal "Malcom"
		obj.fullname.should.equal "John Malcom"

	it "should work while extending", ->

		class NEW_NEW_OBJECT extends Object
			@extend DefineProperty.extend

			@_name = "John"
			@defineGetter "sname", (-> @_name), @
			@defineSetter "sname", ((name) -> @_name = name), @

		(typeof NEW_NEW_OBJECT.sname).should.not.equal "undefined"
		(typeof NEW_NEW_OBJECT.sname).should.equal "string"

		NEW_NEW_OBJECT.sname.should.equal "John"

		NEW_NEW_OBJECT.sname = "Matt"

		NEW_NEW_OBJECT.sname.should.equal "Matt"
