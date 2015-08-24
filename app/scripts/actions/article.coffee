AppDispatcher = require 'dispatcher'
Constants = require 'constants/main'


requestArticleData = ->
  type: Constants.LOAD_ARTICLE


###
# Article actions
###
module.exports =
  fetchArticleData: ->
    (dispatch) ->
      dispatch(requestArticleData)

      #TODO: move to API utility
      superagent = require('superagent')
      superagent
        .get('/article.json')
        .set('Content-Type', 'application/json')
        .end (err, response) ->

          dispatch
            type: Constants.ARTICLE_LOADED
            payload: response.body

  ###
  # @param {string} id
  ###
  likeArticle: (id) ->
    type: Constants.LIKE_ARTICLE
    id: id

  ###
  # @param {string} id
  ###
  unlikeArticle: (id) ->
    type: Constants.UNLIKE_ARTICLE
    id: id
