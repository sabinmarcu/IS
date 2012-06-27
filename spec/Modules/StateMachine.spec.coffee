IS = require "../IS"
obj = IS.Object.clone()
obj.extend IS.Modules.StateMachine

describe "StateMachine Module", ->

	beforeEach ->
		@addMatchers 
			toHaveProperty: (prop) ->
			  	return true for k, v of @actual when k == prop
			  	return false

	it "Should have the properties when extended", ->
		o = obj.clone()

		(expect o).toHaveProperty 'delegateContext'
		(expect o).toHaveProperty 'activateContext'
		(expect o).toHaveProperty 'deactivateContext'
		(expect o).toHaveProperty '_contexts'
		(expect o).toHaveProperty 'switchContext'
					  
	it "Should delegate contexts right", ->

		a = 
			name: "barabula"
		o = obj.clone()
		o.delegateContext a

		(expect a).toHaveProperty "activate"
		(expect a).toHaveProperty "deactivate"
		(expect typeof a.activate).toBe 'function'
		(expect typeof a.deactivate).toBe 'function'

	it "Should find contexts appropriately", ->

		a = 
			name: "barabula"
		b = 
			name: "cartof"
		o = obj.clone()
		o.delegateContext a
		o.delegateContext b

		(expect o._find a).not.toBe null
		(expect o._find b).not.toBe null


	it "Should trigger functions accordingly",  ->
		
		a = 
			name: "barabula"
			activate: -> @name
			deactivate: -> "booger"
		o = obj.clone()
		o.delegateContext a

		(expect do a.activate).toBe a.name
		(expect do a.deactivate).toBe "booger"

		(expect o._activeContext).toBe null

		(expect o.activateContext a).toBe a.name
		(expect o.deactivateContext a).toBe "booger"

	it "Should switch contexts accordingly", ->

		a = 
			name: "barabula"
		b = 
			name: "cartof"
		c = 
			name: "potato"
		d = 
			name: "tato"

		o = obj.clone()
		o.delegateContext a
		o.delegateContext b
		o.delegateContext c
		o.delegateContext d
		o.activateContext a

		(expect do o.switchContext).toEqual b
		(expect o.switchContext d).toEqual d
		(expect do o.switchContext).toEqual a

