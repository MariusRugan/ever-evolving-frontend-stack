Immutable = require 'immutable'
Constants = require 'constants/main'


articleReducers = (state = new Immutable.Map(), action) ->
  switch action.type
    when Constants.ARTICLE_LOADED
      state = state.set('article', Immutable.Map(action.payload))

  return state


module.exports = articleReducers
