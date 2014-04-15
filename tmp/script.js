(function() {
  $(function() {
    var $form;
    console.log('scripts are working');
    $.getJSON('http://freegeoip.net/json/', function(location) {
      if (location.country_code !== 'US') {
        $('.intl').css({
          'display': 'none'
        });
        return console.log('You are outside of the US');
      } else {
        return console.log('You are inside of the US');
      }
    });
    $('div#header').scrollToFixed();
    $form = $('#newsletter form');
    $form.submit(function(e) {
      var $this;
      e.preventDefault();
      $this = $(this);
      return $.ajax({
        type: "GET",
        url: 'http://erichutchinson.us7.list-manage.com/subscribe/post-json?u=1a463054a5823c402f5c28c6c&amp;id=fd0c707a7d&c=?',
        data: $this.serialize(),
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        error: function(err) {
          return alert('no');
        },
        success: function(data) {
          if ($('input[name=EMAIL]').val().indexOf('@') !== -1 && $('input[name=EMAIL]').val().indexOf('.') !== -1) {
            return $('label').text('Thanks! Check your inbox to confirm.');
          } else {
            return alert('not valid email');
          }
        }
      });
    });
    return $('.product-slider').slick({
      'dots': true,
      'arrows': false,
      'centerPadding': 0,
      'draggable': false
    });
  });

}).call(this);
