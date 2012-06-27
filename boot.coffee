stitch = require "stitchw"
program = require "commander"
CoffeeScript = require "coffee-script"

pak = stitch.createPackage
	paths: [
		__dirname + "/src"
	]
	dependencies: [
		__dirname + "/bootstraps/uuid.js"
	]


class Bootstrap
	@compile: (location = __dirname + "/lib/application.js", watch = null, callback = null) -> 
		watch = program.watch or watch
		action = () ->
			pak.compile (err, data) ->
				if err then console.log "Error encountered at compiling : " + err.message
				else 
					fs = require "fs"
					location = program.compile or location
					content = CoffeeScript.compile fs.readFileSync __dirname + "/bootstraps/constructor.coffee", 'utf8'
					back = process.env.PWD + "/src/"
					content = "(function(module){ #{data} \n var require = this.require; \n\n;#{content} \n\n }).call({}, typeof(module) == \"undefined\" ? (typeof(window) == \"undefined\" ? root : window) : module);"
					fs.writeFile location, content, (err) ->
						if err then console.log "Error encountered at writing compiled file (location : #{location}: #{err.message}"
						else console.log "Compiled to #{location}"
					callback(content) if callback?
		if not watch?	then action() 
		else
			action() 
			setInterval action, watch * 1000

	@server: (server, port) ->
		express = require "express"
		app = express.createServer()		
		c = @compile	
		app.configure ->
			app.use app.router
			app.use express.static(__dirname + (if program.documentation then "/docs" else ""))
			app.get "/lib/application.js", (req, res) ->
				c(null, null, (ct) ->
					res.send ct, { 'Content-Type': 'text/javascript' }, 201
				)
		port = program.port or port
		address = program.address or address
		app.listen port, address 
		console.log "Start listening at #{address}:#{port}"
		if program.documentation
			codo = require "codo"

program.version('0.0.1').usage('[options] <file...>').option("-p, --port <number>", "The port on which to start server", parseInt, 9323).option("-a, --address <string>", "The address on which to start the server", ((val) -> val), "127.0.0.1").option("-c, --compile <string>", "Compile the application", ((val) -> val)).option("-w, --watch <number>", "Recompile every n seconds", parseFloat).option("-d, --documentation", "Serve documentation files with a standalone web server").option("-s, --specs", "Run specs instead").parse(process.argv)

if program.compile then	Bootstrap.compile()
else if program.specs then Bootstrap.specs()
else Bootstrap.server()