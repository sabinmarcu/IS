IS = require "../IS"
obj = IS.Object
obj.extend IS.Modules.ORM()

_count = (json) ->
	nr = 0
	nr++ for key, value of json
	nr

describe "ORM Testing", ->

	beforeEach ->
		@addMatchers 
			toHaveProperty: (prop) ->
			  	return true for k, v of @actual when k == prop
			  	return false

	it "Should create the right reccords", ->
		o = obj.clone()

		o.create()
		(expect _count o._reccords).toEqual 1
		n = o.create("with-id")
		(expect _count o._reccords).toEqual 2
		(expect _count o._symlinks)
		(expect n).toEqual o.get("with-id")

	it "Should create base props properly", ->
		o = obj.clone()

		o.addProp "baseProp"
		(expect o._props).toContain "baseProp"

		x = o.reuse()
		(expect x).toHaveProperty "baseProp"

	it "Should update props on the fly", ->
		o = obj.clone()

		o.addProp "baseProp"

		a = o.reuse()
		b = o.reuse()
		(expect a).toHaveProperty "baseProp"
		(expect b).toHaveProperty "baseProp"

		o.addProp "afterProp"

		(expect a).toHaveProperty "afterProp"
		(expect b).toHaveProperty "afterProp"


	it "Should reuse properly", ->
		o = obj.clone()

		o.reuse()
		(expect _count o._reccords).toEqual 1

		x = o.reuse "with-id" 
		(expect x).toEqual o.get "with-id"
		(expect x).toEqual o.reuse "with-id"
		(expect x._id).toBe "with-id"

		y = o.reuse "with-data", {"data": "new"} 
		(expect y::).toEqual x::
		(expect y._id).toBe "with-data"
		(expect y.data).toBe "new"

	it "Should get by object query properly", ->
		o = obj.clone()

		o.addProp("queryprop1")
		o.addProp("queryprop2")

		a = o.reuse();
		a.queryprop1.set "app"
		a.queryprop2.set "app2"
		b = o.reuse();
		b.queryprop1.set "progr"
		b.queryprop2.set "stuff2"

		(expect o.get { queryprop1: "app"}).toBe a

	it "Should retrieve multiple objects on object query", ->
		o = obj.clone()

		o.addProp("prop")

		a = o.reuse()
		b = o.reuse()
		c = o.reuse()

		a.prop.set true
		b.prop.set false
		c.prop.set true

		(expect (o.get prop:true).length).toBe 2
		(expect o.get prop:true).toContain a
		(expect o.get prop:true).not.toContain b
		(expect o.get prop:true).toContain c

	it "Should retrieve an object on object query with multiple ", ->
		o = obj.clone()

		o.addProp("prop")
		o.addProp("prop2")

		a = o.reuse()
		b = o.reuse()
		c = o.reuse()

		a.prop.set true
		b.prop.set false
		c.prop.set true
		a.prop2.set 2
		b.prop2.set 2
		c.prop2.set 3

		results = o.get prop: true, prop2: 2
		(expect results).toBe a

	it "Should retrieve objects with modifier matchers", ->
		o = obj.clone()

		o.addProp("prop")
		o.addProp("prop2")

		a = o.reuse()
		b = o.reuse()
		c = o.reuse()

		a.prop.set 3
		b.prop.set 5
		c.prop.set 8

		(expect o.get prop: {"$gt": 5}).toBe c
		(expect o.get prop: {"$lt": 5}).toBe a
		(expect o.get prop: {"$gte": 5}).toContain c
		(expect o.get prop: {"$gte": 5}).toContain b		
		(expect o.get prop: {"$gt": 3, "$lt": 8}).toBe b

		a.prop2.add 1
		a.prop2.add 4
		a.prop2.add 5
		
		b.prop2.add 6
		b.prop2.add 7
		b.prop2.add 8

		c.prop2.add 1
		c.prop2.add 2
		c.prop2.add 3

		results = o.get prop2: {"$contains": 1}
		(expect results).toContain a
		(expect results).toContain c

	it "Should retrieve items between two delimiters", ->
		o = obj.clone()

		o.addProp("prop")

		a = o.reuse()
		b = o.reuse()
		c = o.reuse()
		d = o.reuse()


		a.prop.set 1
		b.prop.set 2
		c.prop.set 3
		d.prop.set 4

		(expect _count o.get prop: {"$gt": 1, "$lt": 4}).toBe 2
		(expect o.get prop: {"$gt": 2, "$lt": 4}).toBe c
