$(document).ready(function() {

  $('.panel .header').click(function(event) {
    self = arguments.callee
    if(self.busy) { return false; }
    self.busy = true;
    view  = $(this).siblings('.view');
    tabs  = $(this).find('.tab-navigation ul li');
    title = $(this).children('h2');

    if(view.css('display') == 'none') {
      $(title).removeClass('closed');
      $(tabs).fadeIn();
      $(view).slideToggle(null, function() { self.busy = false });
    } else {
      $(title).addClass('closed');
      $(tabs).fadeOut();
      $(view).slideToggle(null, function() { self.busy = false });
    }

  });

  $('.tab-navigation ul li a').click(function(event) {
    return false;
  });
});
