{CompositeDisposable} = require 'atom'

class ConfigPlus
  disposables: null

  constructor: (@scope, @config) ->

  get: (param) ->
    atom.config.get("#{@scope}.#{param}")

  set: (param, value) ->
    atom.config.set("#{@scope}.#{param}", value)

  toggle: (param, options={}) ->
    @set param, !@get(param)
    @log param if options.log?

  log: (param) ->
    console.log "#{@scope}.#{param}: #{@get(param)}"

  onDidChange: (param, callback) ->
    @disposables ?= new CompositeDisposable
    @disposables.add atom.config.onDidChange "#{@scope}.#{param}", callback

  dispose: ->
    @disposables?.dispose()

module.exports = ConfigPlus
