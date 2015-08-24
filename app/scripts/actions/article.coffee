Constants = require 'constants/main'


###
# Article actions
###
module.exports =
  fetchArticleData: ->
    (dispatch) ->
      dispatch
        type: Constants.LOAD_ARTICLE

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
