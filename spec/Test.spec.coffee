describe "Spec testing", ->
	it "Should get negated false to be true", ->
		(expect !false).toBe true
	it "Should get operations done right", ->
		(expect	2*2).toBe 4
		(expect 4/2*3).toBe 6
	it "Should get awkward stuff right", ->
		(expect 5 + + "6").toBe 11
		(expect 5 + "6").toBe "56"
		(expect 6 + + + "7").toBe 13