IS = require "../../lib/isf.js"
chai = require "chai"
obj = IS.Object.clone()

do chai.should

describe "Function Overwrite Module", ->

	it "Should overwrite properly", ->

        class baseclass extends obj
            @m1: -> return "foo"
            @m2: -> return 'bar'

        (baseclass.m1() ).should.equal "foo"
        (baseclass.m2() ).should.equal "bar"

        class object extends baseclass

            @extend IS.Modules.Overwrite._extend_

            IS.Modules.Overwrite "m1", (-> "bar"), @
            @_overwrite_ "m2", ( -> "baz" ), @

        (object.m1()).should.equal "bar"
        (object.m2()).should.equal "baz"

	it "Should overwrite properly with the instances", ->

        class baseclass extends obj
            m1: -> return "foo"
            m2: -> return 'bar'

        bc = new baseclass()
        (bc.m1() ).should.equal "foo"
        (bc.m2() ).should.equal "bar"

        class object extends baseclass

            @extend IS.Modules.Overwrite._extend_

            IS.Modules.Overwrite "m1", (-> "bar"), @::
            @_overwrite_ "m2", ( -> "baz" )

        o= new object()
        (o.m1()).should.equal "bar"
        (o.m2()).should.equal "baz"

	it "Should overwrite properly with the instances and super", ->

        class baseclass extends obj
            m1: -> return "foo"
            m2: -> return 'bar'

        bc = new baseclass()
        (bc.m1() ).should.equal "foo"
        (bc.m2() ).should.equal "bar"

        class object extends baseclass

            @extend IS.Modules.Overwrite._extend_

            IS.Modules.Overwrite "m1", (-> @_super_() + "bar"), @::
            @_overwrite_ "m2", ( -> @_super_() + "baz" )

        o = new object()
        (o.m1()).should.equal "foobar"
        (o.m2()).should.equal "barbaz"
