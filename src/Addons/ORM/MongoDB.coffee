class MongoDBConnector
	_identifier: "Mongo"
	
	create: -> @super.create.apply @, arguments

	extended: ->


module.exports = MongoDBConnector::

