React = require 'react'
Redux = require 'redux'
thunkMiddleware = require 'redux-thunk'
Provider = require('react-redux').Provider

Article = require 'components/article'
articleReducers = require 'reducers/article'
require 'main.sass'


createStoreWithMiddleWare = Redux.applyMiddleware(
  thunkMiddleware
)(Redux.createStore)

store = createStoreWithMiddleWare(articleReducers)

React.render(
  <Provider store={store}>
    {() -> <Article/>}
  </Provider>,
  document.getElementById 'article'
)
