
_excludes = ["included", "extended"]

clone = (obj) ->
	o = if obj instanceof Array then [] else {}
	for k, v of obj
		if v? and typeof v is "object" then o[k] = clone v
		else o[k] = v
	return o

# Barebone Object that is to be augmented with modules 
# @author Sabin Marcu
# @version v0.1
class Obiect

	@clone: () -> (@proxy @include, (@proxy @extend, ->)(@))(@::)

	@extend: (obj) ->
		obj = clone obj
		@[k] = value for k, value of obj when not ((k in _excludes) or (obj._excludes? and k in obj._excludes))
		obj.extended?.call(@)
		this

	@include: (obj) ->
		obj = clone obj
		@::[key] = value for key, value of obj
		obj.included?.call(@)
		this

	@proxy: () ->
		what = arguments[0]
		to = arguments[1]
		if typeof what == "function" 
			return (args...) => 
				what.apply to, args
		else return @[what]

	@delegate: (property, context) ->
		if (@_delegates?[property]? is false and @_deleagates[property] isnt false) then trigger "Cannot delegate member #{property} to #{context}"
		context[property] = @proxy(->
			@[property] arguments
		, @)

	extended = ->
	included = ->

	@include 
		proxy: @proxy

module.exports = Obiect
