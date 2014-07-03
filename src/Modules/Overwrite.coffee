Modules = {}

random = ->
    if Math.uuid? then return Math.uuid().replace(/-/g, "")
    else return new parseInt Date().getTime()
class Modules.Overwrite

    overwrite: (method, replacement, parent) ->
        prev = parent[method]
        do (prev, parent, replacement, method) -> 
            parent[method] = ->
                this._super_ = prev
                replacement.apply this, arguments


ow = new Modules.Overwrite()
module.exports = Modules.Overwrite::overwrite
module.exports._extend_ = 
    _overwrite_: (method, replacement, parent = @::) -> ow.overwrite.call(@, method, replacement, parent)
