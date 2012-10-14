Addons = { "ORM": {} }
class Addons.ORM.MongoDBConnector
	_identifier: "Mongo"

	create: -> @super.create.apply @, arguments

	extended: ->


module.exports = Addons.ORM.MongoDBConnector::

