(function($) {
  var methods = {
    init : function(options) {
      return this.each(function() {
        $(this).find('li').not('.category').find('a').bind(
                              'click.column_select', methods.toggle_select)
      });
    },

    select : function() {
    },

    deselect : function() {
    },

    toggle_select : function() {
      if($(this).hasClass('selected')) {
        $(this).removeClass('selected');
        $(this).css('background-color', '');
      } else {
        $(this).addClass('selected');
        $(this).css('background-color', 'red');
      }
      return false;
    }
  };

  $.fn.column_select = function(method) {
    if(methods[method]) {
      return methods[method].apply(this,
                                   Array.prototype.slice.call(arguments, 1));
    } else if(typeof method === 'object' || ! method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' +  method + ' does not exist on jQuery.column_select');
    }
  };
})(jQuery);
