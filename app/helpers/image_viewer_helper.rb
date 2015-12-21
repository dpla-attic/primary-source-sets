module ImageViewerHelper
  ##
  # Return the HTML necessary to instantiate the OpenSeadragon viewer.
  #
  # Give it the `id' of the parent div, the image URL, and other options.
  #
  # We specify multiple U.I. icons instead of a base path with OpenSeadragon's
  # `prefixUrl' parameter because this appears to be the best way of working
  # with the Rails asset pipeline's different URLs between development and
  # production.
  #
  def image_viewer(url)
    opts = {
      id: 'osd-viewer',
      tileSources: {
        type: 'image',
        url: url
      },
      prefixUrl: '',
      navImages: {
        zoomIn: {
          REST:     path_to_image('openseadragon/zoomin_rest.png'),
          GROUP:    path_to_image('openseadragon/zoomin_grouphover.png'),
          HOVER:    path_to_image('openseadragon/zoomin_hover.png'),
          DOWN:     path_to_image('openseadragon/zoomin_pressed.png')
        },
        zoomOut: {
          REST:   path_to_image('openseadragon/zoomout_rest.png'),
          GROUP:  path_to_image('openseadragon/zoomout_grouphover.png'),
          HOVER:  path_to_image('openseadragon/zoomout_hover.png'),
          DOWN:   path_to_image('openseadragon/zoomout_pressed.png')
        },
        home: {
          REST:   path_to_image('openseadragon/home_rest.png'),
          GROUP:  path_to_image('openseadragon/home_grouphover.png'),
          HOVER:  path_to_image('openseadragon/home_hover.png'),
          DOWN:   path_to_image('openseadragon/home_pressed.png')
        },
        fullpage: {
          REST:   path_to_image('openseadragon/fullpage_rest.png'),
          GROUP:  path_to_image('openseadragon/fullpage_grouphover.png'),
          HOVER:  path_to_image('openseadragon/fullpage_hover.png'),
          DOWN:   path_to_image('openseadragon/fullpage_pressed.png')
        }
      }
    }
    # Can't use "defer" attribute of <script> here.  Must use jQuery.
    # This will run after openseadragon.js is loaded, as long as that is
    # included with `defer'.
    "<script>" \
    "  $(function() { " \
    "    var viewer = OpenSeadragon(#{opts.to_json}); " \
    "  });" \
    "</script>"
  end
end
