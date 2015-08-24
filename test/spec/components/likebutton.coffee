React = require 'react/addons'
TestUtils = React.addons.TestUtils

shallowRenderer = TestUtils.createRenderer()


describe 'Article Like Button', ->

  before ->
    @ActionCreators = require 'actions/article'
    @LikeButton = React.createFactory(require 'components/likebutton')

    sinon.spy @ActionCreators, 'likeArticle'
    sinon.spy @ActionCreators, 'unlikeArticle'


  describe 'Toggling Like Actions', ->
    before ->
      @id = 'foo'

    renderLikeButton = (props) ->
      # I'd prefer to use shallowRenderer but it doesn't seem to work with
      # events yet: https://github.com/facebook/react/issues/1445
      #shallowRenderer.render @LikeButton(props)
      #@element = shallowRenderer.getRenderOutput()

      @element = TestUtils.renderIntoDocument @LikeButton(props)
      @domElement = TestUtils.findRenderedDOMComponentWithTag @element, 'a'


    describe 'When not liked', ->

      beforeEach ->
        @dispatcher = sinon.spy()

        props =
          liked: false
          id: @id
          dispatch: @dispatcher

        renderLikeButton.call(@, props)


      it 'is show as unliked', ->
        expect(@domElement.getDOMNode().textContent).to.equal '☆'


      describe 'Clicking like', ->
        beforeEach ->
          TestUtils.Simulate.click @domElement

        it 'fires an likeArticle action', ->
          # FIXME: the arguments to the action aren't asserted
          expect(@dispatcher).to.have.been.calledWith \
            @ActionCreators.likeArticle(@id)


    describe 'When liked', ->

      beforeEach ->
        @dispatcher = sinon.spy()

        props =
          liked: true
          id: @id
          dispatch: @dispatcher

        renderLikeButton.call(@, props)


      it 'is show as liked', ->
        expect(@domElement.getDOMNode().textContent).to.equal '★'


      describe 'Clicking like', ->
        beforeEach ->
          TestUtils.Simulate.click @domElement

        it 'fires an unlikeArticle action', ->
          # FIXME: the arguments to the action aren't asserted
          expect(@dispatcher).to.have.been.calledWith \
            @ActionCreators.unlikeArticle(@id)
