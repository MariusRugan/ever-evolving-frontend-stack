React = require 'react'


module.exports = React.createClass
  render: ->
    <div className="ArticleExcerpt">{@props.excerpt}</div>
