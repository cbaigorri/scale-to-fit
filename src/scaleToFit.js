(function() {
  var $, ScaleToFit;

  $ = jQuery;

  ScaleToFit = (function() {
    ScaleToFit.prototype.defaults = {
      scaleTo: $('body'),
      crop: false
    };

    function ScaleToFit(element, options) {
      var _this;
      _this = this;
      this.$window = $(window);
      this.$element = $(element);
      this.aspectRatioW = this.$element.width() / this.$element.outerHeight(true);
      this.aspectRatioH = this.$element.outerHeight(true) / this.$element.width();
      this.options = $.extend({}, this.defaults, this.$element.data(), options);
      this.$window.bind('resize', function() {
        return _this.resize();
      });
      this.$window.trigger('resize');
      this.$element.css({
        'overflow': 'hidden'
      });
      return;
    }

    ScaleToFit.prototype.resize = function() {
      var maxWidth, topPos;
      if ((this.$window.width() / this.$window.outerHeight(true)) < this.aspectRatioW) {
        console.log('do height');
        if (!this.options.crop) {
          topPos = this.$window.height() / 2 - this.$element.outerHeight(true) / 2;
          this.$element.css({
            'top': topPos,
            'position': 'relative',
            'width': 'auto'
          });
        }
      } else {
        console.log('do width');
        if (!this.options.crop) {
          maxWidth = this.$window.height() * this.aspectRatioW;
          this.$element.css({
            'width': maxWidth,
            'margin': '0 auto',
            'top': 'auto'
          });
        }
      }
    };

    return ScaleToFit;

  })();

  $.fn.scaleToFit = function(option) {
    return this.each(function() {
      var options;
      options = typeof option === 'object' && option;
      new ScaleToFit(this, options);
    });
  };

  $.fn.scaleToFit.Constructor = ScaleToFit;

}).call(this);
