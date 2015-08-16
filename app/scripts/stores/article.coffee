Immutable = require 'immutable'
EventEmitter = require('events').EventEmitter
AppDispatcher = require 'dispatcher'
Constants = require 'constants/main'


# Actual data store, could be a Record but we don't need the validation for now
data = new Immutable.Map()


###
# Main Article Store, listens to Dispatcher to update itself, emits change when
# updated
###
class ArticleStore extends EventEmitter
  CHANGE_EVENT: 'change'

  constructor: ->
    @dispatchToken = AppDispatcher.register (action) =>
      handler = @[action.actionType]
      handler.call(@, action) if handler

  ###
  # @param {function} callback
  ###
  addChangeListener: (callback) ->
    @on @CHANGE_EVENT, callback

  ###
  # @param {function} callback
  ###
  removeChangeListener: (callback) ->
    @removeListener @CHANGE_EVENT, callback

  ###
  # @param {Object} action
  # @param {Object} action.payload
  ###
  "#{Constants.ARTICLE_LOADED}": (action) ->
    data = Immutable.Map(action.payload)
    @emit @CHANGE_EVENT

  ###
  # @param {Object} action
  # @param {string} id
  ###
  "#{Constants.LIKE_ARTICLE}": (action) ->
    @_changeLikeStatus action.id, true

  ###
  # @param {Object} action
  # @param {string} id
  ###
  "#{Constants.UNLIKE_ARTICLE}": (action) ->
    @_changeLikeStatus action.id, false

  getCurrent: ->
    return data

  ###
  # @param {string} id
  # @param {boolean} liked
  ###
  _changeLikeStatus: (id, liked) ->
    data = data.set('liked', liked)
    @emit @CHANGE_EVENT


# FIXME: re-evaluate singleton pattern for unit testing purposes, perhaps
# going fully functional programming could be better to avoid side-effects
module.exports = new ArticleStore
