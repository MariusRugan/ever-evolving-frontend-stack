React = require 'react'
Article = require 'components/article'

# For production and server side rendered pages it's better to serve CSS from 
# the HEAD section of the page itself. However this allows hot-reloading during
# development
css = require('main.sass')


React.render <Article/>, document.getElementById 'article'
