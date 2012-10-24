# An ErrorReporter base factory. It is the starting point for creating custom error reporters (throw error generators)
class ErrorReporter

	# A few base variables
	@_errorGroupMap		: [ 0 ]
	@_errorGroups       : [ "Unknown Error" ]
	@_errorMessages     : [	"An unknown error has occurred" ]

	# Initializing the future arrays with blank arrays for lazy adding.
	@errorGroupMap : []
	@errorGroups   : []
	@errorMessages : []

	# A function that would format the message of a previous error that needs to be included into the current one :)
	# @param [Error] error The error to be formatted
	# @return [String] The error string of the converted error object
	@wrapCustomError : (error) -> "[#{error.name}] #{error.message}"

	# A function to generate and link the error
	# @param [Number] errorCode The errorCode of the error to be generated
	# @param [String] extra Extra information to be included within the error
	# @return [ErrorReporter] A new ErrorReporter instance initialized with the data sent.
	# @example How to generate an error and throw it
	#   throw ErrorReporter.generate(errCode) // WARNING : Do not add "new" after throw.
	@generate : (errorCode, extra = null) -> return (new @).generate errorCode, @, extra

	# This function will be called when extending the item. This way, we can compile the list of errors on site.
	# @private
	@extended : ->
		@_errorGroupMap.push item for item in @super.errorGroupMap if @super? and @super.errorGroupMap?
		@_errorGroups.push item for item in @super.errorGroups if @super? and @super.errorGroups?
		@_errorMessages.push item for item in @super.errorMessages if @super? and @super.errorMessages?
		@include ErrorReporter::

	# Generates the error based on factory items
	generate: (errCode, ER, extra = null) ->
		if not ER._errorGroupMap[errCode]? then @name = ER._errorGroups[0]; @message = ER._errorMessages[0]
		else @name = ER._errorGroups[ER._errorGroupMap[errCode]]; @message = ER._errorMessages[errCode]
		if extra? and extra then @message += (" - Extra Data : #{extra}" if extra? and extra)
		@errCode = errCode
		@
		
	# Transforms the error message into a pretty text
	# @return [String] The error string required.
	# @example Test a string
	#   ErrorReporter.generate(0).toString() // => [Unknown Error] An unknown error has occurred |0|
	toString: => "[#{@name}] #{@message} |#{@errCode}|"


# And finally, exporting the commonjs module.
module.exports = ErrorReporter
