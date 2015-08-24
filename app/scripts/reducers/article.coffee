Immutable = require 'immutable'
Constants = require 'constants/main'


articleReducers = (state = new Immutable.Map(), action) ->
  changeLikeStatus = (id, liked) ->
    state.setIn(['article', 'liked'], liked)

  switch action.type
    when Constants.ARTICLE_LOADED
      state = state.set('article', Immutable.Map(action.payload))
    when Constants.LIKE_ARTICLE
      state = changeLikeStatus action.id, true
    when Constants.UNLIKE_ARTICLE
      state = changeLikeStatus action.id, false


  return state


module.exports = articleReducers
