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
        props =
          liked: false
          id: @id

        renderLikeButton.call(@, props)


      it 'is show as unliked', ->
        expect(@domElement.getDOMNode().textContent).to.equal '☆'


      describe 'Clicking like', ->
        beforeEach ->
          TestUtils.Simulate.click @domElement

        it 'fires an likeArticle action', ->
          expect(@ActionCreators.likeArticle).to.have.been.calledWith @id


    describe 'When liked', ->

      beforeEach ->
        props =
          liked: true
          id: @id

        renderLikeButton.call(@, props)


      it 'is show as liked', ->
        expect(@domElement.getDOMNode().textContent).to.equal '★'


      describe 'Clicking like', ->
        beforeEach ->
          TestUtils.Simulate.click @domElement

        it 'fires an unlikeArticle action', ->
          expect(@ActionCreators.unlikeArticle).to.have.been.calledWith @id
