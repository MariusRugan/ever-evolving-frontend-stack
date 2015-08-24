React = require 'react'
ActionCreators = require 'actions/article'

require 'components/likebutton.sass'


module.exports = React.createClass
  _handleClick: ->
    if @props.liked
      action = ActionCreators.unlikeArticle
    else
      action = ActionCreators.likeArticle

    # Sending ID so this component can be used in places where there are 
    # multiple articles.
    #
    # @FIXME: use bindActionCreators or callback patterns? Passing dispatch
    # gets tiresome, yet passing callbacks seems like it won't scale either.
    @props.dispatch action.call(null, @props.id)


  render: ->
    text = if @props.liked then '★' else '☆'
    <a 
      className="ArticleLikeButton"
      onClick={@_handleClick}
      title="Like this article"
      >
        {text}
    </a>
