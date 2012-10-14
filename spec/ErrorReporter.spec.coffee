IS = require "./IS"
obj = IS.Object.clone()

describe "Error Reporter", ->

	it "Should extend right", ->
		class item extends obj
			@extend IS.ErrorReporter

		(expect typeof item.generate).toBe "function"

	it "Should get the properties right", ->
		class item2 extends obj

			@errorGroupMap : [5, 6, 7]
			@errorGroups   : ["Chestie", "Naspa"]
			@errorMessages : ["There is no space", "No more jizz", "Need more potassium", "Need Viagra"]

			@extend IS.ErrorReporter


		(expect item2._errorMessages).toContain "There is no space"
		(expect item2._errorMessages).toContain "No more jizz"
		(expect item2._errorMessages).toContain "Need more potassium"
		(expect item2._errorMessages).toContain "Need Viagra"

		(expect item2._errorGroupMap).toContain 5
		(expect item2._errorGroupMap).toContain 6
		(expect item2._errorGroupMap).toContain 7

		(expect item2._errorGroups).toContain "Chestie"
		(expect item2._errorGroups).toContain "Naspa"

	it "Should generate errors properly", ->
		class item2 extends obj

			@errorGroupMap : [1, 1, 1, 2, 2]
			@errorGroups   : [ "Penis", "Vagina" ]
			@errorMessages : [ "No more Viagra", "Need potassium", "No banana for you", "Need a dildo", "No more wine" ]

			@extend IS.ErrorReporter

			error0 = item2.generate 0
			error1 = item2.generate 1
			error2 = item2.generate 2
			error3 = item2.generate 3
			error4 = item2.generate 4
			error5 = item2.generate 5

			(expect error0.name).toBe "Unknown Error"
			(expect error1.name).toBe "Penis"
			(expect error2.name).toBe "Penis"
			(expect error3.name).toBe "Penis"
			(expect error4.name).toBe "Vagina"
			(expect error5.name).toBe "Vagina"

			(expect error0.message).toBe "An unknown error has occurred"
			(expect error1.message).toBe "No more Viagra"
			(expect error2.message).toBe "Need potassium"
			(expect error3.message).toBe "No banana for you"
			(expect error4.message).toBe "Need a dildo"
			(expect error5.message).toBe "No more wine"

			(expect ( item2.generate 3, "Stuff is fucked up!" ).message).toBe "No banana for you - Extra Data : Stuff is fucked up!"

