React = require 'react/addons'
ReactRedux = require 'react-redux'
Constants = require 'constants/main'
ActionCreators = require 'actions/article'
ArticleHeader = require './header'
ImageGallery = require './imagegallery'
ArticleExcerpt = require './excerpt'
ArticleContent = require './content'


require 'components/article.sass'



###
# Represents Article Detail Page or View
#
# @class
# @todo: implement shouldComponentUpdate with Immutable object
###
ArticleDetail = React.createClass

  ###
  # Sets the initial state before data is loaded
  ###
  #getInitialState: ->
  #  state =
  #    article: null

  ###
  # Registers callback with the article store and requests initial data
  ###
  componentDidMount: ->
    @props.dispatch(ActionCreators.fetchArticleData())

  #componentWillUnmount: ->
    # clean up...

  ###
  # Renders Article page or a loading message in case no data is present yet
  ###
  render: ->
    # shorthand for @state.article.get
    context = @props.article?.get.bind(@props.article)

    # Ideally the initial state would be rendered from the server of course
    unless context
      <div>Loading...</div>
    else
      <article className="Article" data-id={context('id')}>
        {# FIXME: consider passing full article object?}
        <ArticleHeader
          id={context('id')}
          title={context('title')}
          liked={context('liked')} 
          />
        <ArticleExcerpt excerpt={context('excerpt')} />
        <ImageGallery images={context('images')} />
        <ArticleContent content={context('content')} />
      </article>



stateToProps = (state) ->
  article: state.get('article')

module.exports = ReactRedux.connect(stateToProps)(ArticleDetail)
