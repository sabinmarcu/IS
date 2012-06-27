IS = require "./IS"
obj = IS.Variable

_count = (json) ->
	nr = 0
	nr++ for key, value of json
	nr

describe "Variable Object", ->

	it "Should spawn properly", ->
		n = obj.clone()
		(expect n).toEqual n
		
		x = n.spawn()
		(expect x).toEqual n.spawn()

	it "Should have different values for different variables",  ->
		n = obj.clone()
		z = n.spawn()
		y = n.spawn()

		y.set true
		z.set false
		(expect do y.get).not.toEqual do z.get
		(expect do y.get).toBe true
		(expect do z.get).toBe false