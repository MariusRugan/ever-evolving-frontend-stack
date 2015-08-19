React = require 'react/addons'

require 'components/imagegallery.sass'


module.exports = React.createClass
  render: ->
    images = @props.images?.map (image) ->
      <div 
        className="ImageGallery-image"
        key={image}
        style={{backgroundImage: "url(#{image})"}}
        />

    <div className="ImageGallery">
      {images}
    </div>
