React = require 'react/addons'


module.exports = React.createClass
  render: ->
    getRichContent = =>
      __html:
        @props.content

    <article 
      className="ArticleContent"
      dangerouslySetInnerHTML={getRichContent()}>
    </article>
