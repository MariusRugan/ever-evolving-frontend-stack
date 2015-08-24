describe 'Article Reducers', ->

  before ->
    @Constants = require 'constants/main'
    @reducers = require 'reducers/article'

  beforeEach ->
    Immutable = require 'immutable'

    @state = Immutable.Map
      article: Immutable.Map
        id: 'foo'
        liked: false


  describe 'returning default state', ->

    beforeEach ->
      @state = @reducers @state,
        type: 'nonexistent'

    it 'returns default state with non-matching action types', ->
      expect(@state.getIn(['article', 'id'])).to.be.equal 'foo'


  describe 'liking an article', ->

    beforeEach ->
      @state = @reducers @state,
        type: @Constants.LIKE_ARTICLE
        id: 'foo'

    it 'like the article', ->
      expect(@state.getIn(['article', 'liked'])).to.be.true
