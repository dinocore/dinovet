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
    event.stopPropagation()
  });

  // Delete a phone number
  $('fieldset.phone .delete').live('click', function(event) {
    if(confirm("Are you sure you want to delete this phone number?")) {
      var entry = $(this).parents('li.phone-number');
      entry.children('input._destroy').val(1);
      entry.hide();
    }
    return false;
  });

  // Add a phone number
  $('fieldset.phone .add').click(function(event) {
    var last_entry = $(this).parents('li').siblings('li').last('li')
    var last_count = parseInt(
      last_entry.children('select').attr('id').match(/\d/))

    var new_entry = last_entry.clone();
    var count = last_count + 1;

    var fields = new_entry.children('select, input');
    fields.each(function() {
      $(this).attr('id', $(this).attr('id').replace(/\d/, count));
      $(this).attr('name', $(this).attr('name').replace(/\d/, count));
      $(this).val('');
    });

    new_entry.insertAfter(last_entry);

    return false;
  });
});
