AppDispatcher = require 'dispatcher'
Constants = require 'constants/main'


###
# Article actions
###
module.exports =
  ###
  # Loads the article JSON asynchronously, fires ARTICLE_LOADED when done
  ###
  loadArticleData: ->
    AppDispatcher.dispatch
      actionType: Constants.LOAD_ARTICLE

    #TODO: move to API utility
    superagent = require('superagent')
    superagent
      .get('/article.json')
      .set('Content-Type', 'application/json')
      .end (err, response) ->
        # Dispatch loaded action so we can keep actions synchronous fire&forget
        AppDispatcher.dispatch
          actionType: Constants.ARTICLE_LOADED
          payload: response.body

  ###
  # @param {string} id
  ###
  likeArticle: (id) ->
    AppDispatcher.dispatch
      actionType: Constants.LIKE_ARTICLE
      id: id

  ###
  # @param {string} id
  ###
  unlikeArticle: (id) ->
    AppDispatcher.dispatch
      actionType: Constants.UNLIKE_ARTICLE
      id: id
