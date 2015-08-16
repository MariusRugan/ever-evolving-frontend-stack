describe 'Article Store', ->

  before ->
    @Constants = require 'constants/main'
    @AppDispatcher = require 'dispatcher'

    # Some trickery to get spy the dispatcher before the store registers with it
    registerSpy = sinon.spy(@AppDispatcher, 'register')
    @store = require 'stores/article'
    @dispatch = registerSpy.getCalls(0)[0].args[0]

  beforeEach ->
    # reset store with fixtures before each run
    @dispatch
      actionType: @Constants.ARTICLE_LOADED
      payload:
        id: 'foo'
        liked: false


  describe 'liking an article', ->


    describe 'default state', ->

      it 'is unliked by default', ->
        expect(@store.getCurrent().get('liked')).to.be.false


    describe 'when liking an article', ->

      beforeEach ->
        @dispatch
          actionType: @Constants.LIKE_ARTICLE
          id: 'foo'

      it 'like the track', ->
        expect(@store.getCurrent().get('liked')).to.be.true
