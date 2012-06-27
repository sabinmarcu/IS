Modules = {}
obs = require "Modules/Observer"
# The mediator class acts as an airport to data streams.
# @concern Modules.Observer
class Modules.Mediator
	@::[key] = value for key, value of obs
	installTo = (object)	->
		@delegate "publish", object
		@delegate "subscribe", object
	included = ->
		@::queue = {}
		@::_delegates =
			publish: true
			subscribe: true
	extended = ->
		@queue = {}
		@_delegates =
			publish: true
			subscribe: true

module.exports = Modules.Mediator::