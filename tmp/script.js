(function() {
  $(function() {
    var $form, btns, dropdown, galleryImg, imageRoll, insta_url, menus, pinDescrip, rightDiv, thisUrl;
    $.getJSON('http://ipinfo.io/json/', function(location) {
      if (location.country === 'US') {
        $('a.buy-btn.intl, .price.intl').css('display', 'inline-block');
        $('a.where-to-buy-btn.intl').attr('href', '../pages/where-to-buy');
        return $('#buckets div.intl, #sub-buckets a.intl').remove();
      } else {
        $('a.where-to-buy-btn.intl').attr('href', '../pages/where-to-buy-intl');
        $('a.buy-btn.intl, a.price.intl').remove();
        $('#buckets div.us, #subbuckets a.us').remove();
        return $('.us').remove();
      }
    });
    $('div.support a[href^="http"]').not('div.support a[href^="{{ shop.url }}"]').attr('target', '_blank');
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
    dropdown = $('#product-select');
    $('.popup').on('change', dropdown, function() {
      var new_src, sku;
      sku = $(this).find(':selected').data('sku');
      new_src = $('.popup #quick-preview-image #preload li img[src*=' + sku + ']').attr('src');
      return $(this).find('.main-image').attr('src', new_src);
    });
    $('.add-to-cart').on('click', function(event) {
      var cartCount, hasHave, id, name, optionCopy, plural, quantity;
      event.preventDefault();
      quantity = parseInt($(this).parent().find('#quantity').val());
      id = $(this).parent().find('#product-select').val();
      name = $(this).parent().find(':selected').data('name');
      if (name == null) {
        name = $(this).parent().find('#product-name').data('name');
      }
      if (quantity > 1) {
        plural = 's';
        hasHave = 'have';
      } else {
        plural = '';
        hasHave = 'has';
      }
      cartCount = parseInt($('.cart-count').text());
      optionCopy = '<p><a href="../cart">Checkout</a> | <a class="close" href="#">Continue Shopping</a></p>';
      return $.ajax({
        type: 'POST',
        url: '/cart/add.js',
        data: 'quantity=' + quantity + '&id=' + id,
        dataType: 'json',
        success: function() {
          $('.cart-count, .quick-cart-count').text(cartCount += quantity).removeClass('hide');
          $('.quick-look-options').html(optionCopy);
          return $('<div id="modal">' + quantity + ' ' + name + '' + plural + ' <span>' + hasHave + ' been added to your cart</span></div>').stop().prependTo('body').delay(2000).fadeOut();
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
      auto: false,
      namespace: "slides",
      pager: true
    });
    $('ul.slides_tabs.slides2_tabs li a').html('<i class="fa fa-circle"></i>');
    $("#product-image-gallery #images").justifiedGallery({
      'rowHeight': 360,
      'captions': true
    });
    imageRoll = $('.image-roll');
    imageRoll.remove();
    galleryImg = $('#product-image-gallery #images a img');
    pinDescrip = $('.product-headline h1').text();
    thisUrl = $(location).attr('href');
    $(galleryImg).hover(function() {
      var imgSrc;
      $(this).parent().append(imageRoll);
      imgSrc = $(this).attr('src');
      return $('.image-roll a').hover(function() {
        switch ($(this).data('name')) {
          case 'image':
            $(this).attr('href', imgSrc).addClass('image');
            break;
          case 'pinterest':
            $(this).attr('href', 'http://pinterest.com/pin/create/link/?media=' + imgSrc + '&description=' + pinDescrip);
            break;
          case 'facebook':
            $(this).attr('href', 'http://www.facebook.com/sharer/sharer.php?u=' + thisUrl + '&picture' + imgSrc);
        }
        return $('#images .image-roll a.image').magnificPopup({
          type: 'image',
          midClick: true
        });
      });
    });
    $('.video-link').magnificPopup({
      type: 'iframe',
      midClick: true
    });
    rightDiv = $('#main-features div.bit-2 div');
    rightDiv.has('img').css({
      'width': '100%'
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
