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
      $(this).parents('li.phone-number').remove();
    }
    return false;
  });

  // Add a phone number
  $('fieldset.phone .add').click(function(event) {
    $(this).parents('li').before('                                  \
      <li id="phone-number-0" class="phone-number">                 \
        <select name="client[phone_numbers][0][type]"               \
            id="client_phone_numbers_0_type">                       \
          <option selected="selected" value="Home">Home</option>    \
          <option value="Cell">Cell</option>                        \
        </select>                                                   \
        <input type="text" value="" size="30"                       \
            name="client[phone_numbers][0][number]"                 \
            id="client_phone_numbers_0_number" autocomplete="off">  \
        <a title="Delete this number" href="#" class="delete">      \
          <img src="/images/delete.png?1295921241" alt="Delete">    \
        </a>                                                        \
      </li>                                                         \
    ')
  });

  return false;
});
