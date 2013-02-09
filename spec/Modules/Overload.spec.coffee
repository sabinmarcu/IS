IS = require "../IS"
chai = require "chai"
obj = IS.Object

do chai.should

describe "Function Overload Module", ->

	it "Should overload properly", ->

		class object extends obj

			@include IS.Modules.Overload
			@extend IS.Modules.Overload

			@uname: "Sabin"
			@username: "sabinmarcu"
			@get: @overload
				single:
					if:
						args: 1
					then: -> @uname
				multiple:
					then: (args...) -> @[arg] or null for arg in args

		( object.get "me" ).should.equal "Sabin"
		( object.get "username", "uname" ).should.contain "Sabin"
		( object.get "username", "uname" ).should.contain "sabinmarcu"

	it "Should handle more complex overloads", ->

		class object extends obj

			@include IS.Modules.Overload
			@extend IS.Modules.Overload

			@get: @overload
				string:
					if: "arg1": (arg) -> arg.substr?
					then: -> "string"
				object:
					if: "arg1": (arg) -> arg.username?
					then: (arg) -> arg.username
				object_plus:
					if:
						args: 2
						"arg1": (arg) -> arg.username?
					then: (arg, many) -> Array(many + 1).join arg.username
				array:
					if:	"arg1": (arg) -> typeof arg is "array"
					then: -> "array"

			( object.get "some string" ).should.equal "string"
			( object.get ["Some", "Array", "Elements"] ).should.equal "array"
			( object.get {"username": "Bula"} ).should.equal "Bula"
			( object.get {"username": "Bula"}, 3).should.equal "BulaBulaBula"

