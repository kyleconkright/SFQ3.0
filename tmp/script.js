(function() {
  $(function() {
    var $form, baseURL, btns, menus;
    baseURL = 'http://www.soundfreaq-theme.myshopify.com/';
    $.getJSON('http://freegeoip.net/json/', function(location) {
      if (location.country_code === 'US') {
        $('a.buy-btn.intl').css('display', 'inline-block');
        return $('a.where-to-buy-btn.intl').attr('href', baseURL + 'pages/where-to-buy');
      } else {
        $('a.buy-btn.intl').text('Where to Buy').attr('href', baseURL + 'pages/where-to-buy-intl').css('display', 'inline-block');
        return $('a.where-to-buy-btn.intl, a.price.intl').remove();
      }
    });
    $.ajax({
      url: 'http://cdn.soundfreaq.com/data/data.json?callback=?',
      type: 'GET',
      dataType: 'json',
      success: function(results) {
        return $.each(results.pressReleases, function() {
          return console.log(this.title);
        });
      },
      error: function() {
        return console.log('major fail');
      }
    });
    $('div#header').scrollToFixed();
    menus = $('div#header #search, div#header #menu');
    btns = $('div#header .menubtn, div#header .searchbtn');
    $('div#header .nav').on('click', '.menubtn, .searchbtn', function(e) {
      var id;
      e.preventDefault();
      id = $(this).data('name');
      if ($(this).hasClass('on')) {
        $('#' + id).hide();
        return $(this).removeClass('on');
      } else {
        menus.hide();
        btns.removeClass('on');
        $('#' + id).slideDown(250);
        return $(this).addClass('on');
      }
    });
    $form = $('#newsletter form');
    $form.submit(function(e) {
      var $this;
      e.preventDefault();
      $this = $(this);
      return $.ajax({
        type: "GET",
        url: 'http://soundfreaq.us7.list-manage.com/subscribe/post-json?u=1a463054a5823c402f5c28c6c&amp;id=fd0c707a7d&c=?',
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
    $('#product-compare ul.holder > li:odd').css({
      'background-color': '#eee'
    });
    $('#product-compare ul.holder > li:even').css({
      'background-color': '#dfdfdf'
    });
    $('.quote-slider').responsiveSlides({
      namespace: "slides",
      nav: true,
      pause: true,
      nextText: '<i class="fa fa-chevron-right"></i>',
      prevText: '<i class="fa fa-chevron-left"></i>',
      navContainer: '#quote-slider'
    });
    return $('.product-slider').responsiveSlides({
      namespace: "slides",
      nav: true,
      pause: true,
      nextText: '<i class="fa fa-chevron-right"></i>',
      prevText: '<i class="fa fa-chevron-left"></i>'
    });
  });

}).call(this);
