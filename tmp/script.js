(function() {
  $(function() {
    var $form, baseURL, btns, dropdown, imageRoll, insta_url, menus, productName;
    baseURL = 'http://www.soundfreaq-theme.myshopify.com/';
    $.getJSON('http://freegeoip.net/json/', function(location) {
      if (location.country_code === 'US') {
        $('a.buy-btn.intl, .price.intl').css('display', 'inline-block');
        return $('a.where-to-buy-btn.intl').attr('href', baseURL + 'pages/where-to-buy');
      } else {
        $('a.buy-btn.intl').text('Where to Buy').attr('href', baseURL + 'pages/where-to-buy-intl').css('display', 'inline-block');
        return $('a.where-to-buy-btn.intl, a.price.intl').remove();
      }
    });
    $('.open-quick-look').magnificPopup({
      type: 'inline',
      midClick: true
    });
    $('.open-quick-look').on('click', function() {
      return $('.quick-look-options').html('');
    });
    $('a.close').on('click', function(event) {
      event.preventDefault();
      return $.magnificPopup.close();
    });
    $('.add-to-cart').on('click', function(event) {
      var cartCount, id, optionCopy, quantity;
      event.preventDefault();
      quantity = parseInt($(this).parent().find('#quantity').val());
      id = $(this).parent().find('#product-select').val();
      cartCount = parseInt($('.cart-count').text());
      optionCopy = '<p><a href="../cart">Checkout</a> | <a class="close" href="#">Continue Shopping</a></p>';
      return $.ajax({
        type: 'POST',
        url: '/cart/add.js',
        data: 'quantity=' + quantity + '&id=' + id,
        dataType: 'json',
        success: function() {
          $('.cart-count, .quick-cart-count').text(cartCount += quantity).removeClass('hide');
          return $('.quick-look-options').html(optionCopy);
        },
        error: function(error) {
          console.log(error.status);
          switch (error.status) {
            case 404:
              optionCopy = 'Please select an Option';
              break;
            case 422:
              optionCopy = 'Sorry, we are out of that item';
          }
          return $('.quick-look-options').html(optionCopy);
        }
      });
    });
    dropdown = $('#product-select');
    $('.popup').on('change', dropdown, function() {
      var new_src, sku;
      sku = $(this).find(':selected').data('sku');
      new_src = $('.popup #quick-preview-image #preload li img[src*=' + sku + ']').attr('src');
      return $(this).find('.main-image').attr('src', new_src);
    });
    $('.video-link').magnificPopup({
      type: 'iframe',
      midClick: true
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
    $('.product-slider').responsiveSlides({
      namespace: "slides",
      nav: true,
      pause: true,
      nextText: '<i class="fa fa-chevron-right"></i>',
      prevText: '<i class="fa fa-chevron-left"></i>'
    });
    $("#product-image-gallery").justifiedGallery({
      'rowHeight': 360,
      'captions': true
    });
    productName = $('span.product-name h2').text().toLowerCase().replace(/\s+/g, '');
    imageRoll = $('<div class="image-roll"><a href="' + productName + '"><i class="fa fa-pinterest"></i></a><a href="#"><i class="fa fa-picture-o"></i></a><a href="http://facebook.com/"><i class="fa fa-facebook-square"></i></a></div>');
    $("#product-image-gallery a").hover(function() {
      return imageRoll.appendTo(this);
    }, function() {
      return $(this).find(imageRoll).remove();
    });
    imageRoll.on('click', 'a', function(event) {
      event.preventDefault();
      return alert($(this).parents('#product-image-gallery').find('img').attr('src'));
    });
    insta_url = 'https://api.instagram.com/v1/users/239381321/media/recent/?client_id=b64a4afe94a34684bcb7f61c86bc6c4a&count=9&callback=?';
    return $.ajax({
      type: 'GET',
      url: insta_url,
      dataType: 'jsonp',
      success: function(results) {
        return $.each(results.data, function() {
          return $('<li class="bit-3"><a target="_blank" href="' + this.link + '"><img src="' + this.images.low_resolution.url + '"></a></li>').appendTo('ul#insta');
        });
      },
      error: function() {
        return console.log('insta fail');
      }
    });
  });

}).call(this);
