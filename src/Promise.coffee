class Promise 
	constructor: (promise) ->
		if promise instanceof Promise then return promise
		@callbacks = []
	then: (ok, err, progr) ->
		@callbacks.push
			ok: ok
			error: err
			progress: progr
		@
	resolve: (args...) ->
		callback = @callbacks.shift()
		if callback and callback.ok then callback.ok.apply @, args
		@
	reject: (args...) ->
		callback = @callbacks.shift()
		if callback and callback.error then callback.error.apply @, args
		@
	progress: (args...) ->
		callback = @callbacks[0]
		if callback and callback.progress then callback.progress.apply @, args
		@

module.exports = Promise
