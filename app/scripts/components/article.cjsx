React = require 'react/addons'
Constants = require 'constants/main'
ActionCreators = require 'actions/article'
ArticleHeader = require './header'
ImageGallery = require './imagegallery'
ArticleExcerpt = require './excerpt'
ArticleContent = require './content'


require 'components/article.sass'

articleStore = require 'stores/article'


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
  getInitialState: ->
    state =
      article: null

  ###
  # Retrieves data from relevant store(s)
  ###
  _getDataFromStore: ->
    state =
      article: articleStore.getCurrent()

  ###
  # Registers callback with the article store and requests initial data
  ###
  componentDidMount: ->
    articleStore.addChangeListener @_handleChange
    ActionCreators.loadArticleData()


  ###
  # Handler called when the store is updated, updates the state which 
  # kicks off re-rendering process of the relevant components if anything 
  # changed
  ###
  _handleChange: ->
    @setState @_getDataFromStore()

  #componentWillUnmount: ->
    # clean up...

  ###
  # Renders Article page or a loading message in case no data is present yet
  ###
  render: ->
    # shorthand for @state.article.get
    context = @state.article?.get.bind(@state.article)

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



module.exports = ArticleDetail
