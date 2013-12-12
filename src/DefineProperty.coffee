_root = null
if root? then _root = root
else if window? then _root = window
else _root = {}

# A class that handles the creation of properties (getters / setters) for any other given class
class DefineProperty
	define: (property, getter, setter, parent = _root) ->
		@defineSetter property, setter, parent
		@defineGetter property, getter, parent
	defineSetter: (property, setter, parent = _root) ->
		if property? and setter? and parent? then parent.__defineSetter__ property, setter
	defineGetter: (property, getter, parent = _root) ->
		if property? and getter? and parent? then parent.__defineGetter__ property, getter

dp = new DefineProperty()
module.exports = (args...) -> dp.define.apply dp, args 
module.exports.extend = 
		define: (prop, getter, setter, parent = @::) -> dp.define.apply @, [prop, getter, setter, parent]
		defineSetter: (prop, setter, parent = @::) -> dp.defineSetter.apply @, [prop, setter, parent]
		defineGetter: (prop, getter, parent = @::) -> dp.defineGetter.apply @, [prop, getter, parent]
