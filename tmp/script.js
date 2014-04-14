(function() {
  $(function() {
    var $form;
    console.log('scripts are working');
    $('div#header').scrollToFixed();
    $form = $('#newsletter form');
    return $form.submit(function(e) {
      var $this;
      e.preventDefault();
      $this = $(this);
      return $.ajax({
        type: "GET",
        url: 'http://erichutchinson.us7.list-manage.com/subscribe/post-json?u=c8c95e39b427209a753338e7a&amp;id=3e4a2c0d22&c=?',
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
  });

}).call(this);
