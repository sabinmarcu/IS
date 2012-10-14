
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

	@clone: (obj = @)-> debugger ;(Obiect.proxy Obiect.include, (Obiect.proxy Obiect.extend, ->)(obj))(obj::)

	@extend: (obj, into = @) ->
		obj = clone obj
		for k, value of obj
			if not ((k in _excludes) or (obj._excludes? and k in obj._excludes))
				if into[k]?
					into.super ?= {}
					into.super[k] = into[k]
				into[k] = value
		obj.extended?.call(into)
		this

	@include: (obj, into = @) ->
		obj = clone obj
		into::[key] = value for key, value of obj
		obj.included?.call(into)
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
