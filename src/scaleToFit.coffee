
$ = jQuery

class ScaleToFit
  defaults:
    scaleTo: $('body')
    crop: false
  constructor:(element, options)->
    _this = this
    @$window = $(window)
    @$element = $(element)
    @aspectRatioW = @$element.width() / @$element.outerHeight(true)
    @aspectRatioH = @$element.outerHeight(true) / @$element.width()
    @options = $.extend {}, @defaults, @$element.data(), options
    @$window.bind 'resize', ()->
      _this.resize()
    @$window.trigger 'resize'
    @$element.css
      'overflow': 'hidden'
      # 'position': 'fixed'
    return
  resize: ()->
    if ((@$window.width() / @$window.outerHeight(true)) < @aspectRatioW)
      console.log 'do height'

      if (!@options.crop)
        topPos = @$window.height()/2 - @$element.outerHeight(true)/2
        @$element.css
          'top': topPos
          'position': 'relative'
          'width': 'auto'

      # @$element.width(@$window.width() * @aspectRatioW)
      # @$element.height(@$window.outerHeight(true))
    else
      console.log 'do width'
      if (!@options.crop)
        maxWidth = @$window.height()*@aspectRatioW
        @$element.css
          'width': maxWidth
          'margin': '0 auto'
          'top': 'auto'

      # @$element.width(@$window.width())
      # @$element.height(@$window.outerHeight(true) * @aspectRatioH)
    return

$.fn.scaleToFit = (option) ->
  return @each ()->
    options = typeof option == 'object' && option
    new ScaleToFit this, options
    return

$.fn.scaleToFit.Constructor = ScaleToFit

