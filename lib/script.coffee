$ ->

	# baseURL = 'http://www.soundfreaq-theme.myshopify.com/'

	#FREE IP LOOKUP
	# $.getJSON 'http://ipinfo.io/json/', (location) ->
	# 	if location.country is 'US'
	# $.getJSON 'http://freegeoip.net/json/', (location) ->
	# 	if location.country_code is 'US'
		# 	$('a.buy-btn.intl, .price.intl')
		# 		.css 'display','inline-block'
		# 	$('a.where-to-buy-btn.intl')
		# 		.attr 'href', '../pages/where-to-buy'
		# 	$('#buckets div.intl, #sub-buckets a.intl').remove()
		# else
		# 	$('a.where-to-buy-btn.intl')
		# 		.attr 'href', '../pages/where-to-buy-intl'
		# 	$('a.buy-btn.intl, a.price.intl').remove()
		# 	$('#buckets div.us, #subbuckets a.us').remove()
		# 	$('.us').remove()
		# 	$('.store.intl').remove()
		# 	$('#store').remove()


	#PAID IP LOOKUP - MAXMIND
	onSuccess = (location) ->
		console.log JSON.stringify(location.country.iso_code)
		if location.country.iso_code is 'US'
			$('a.buy-btn.intl, .price.intl')
				.css 'display','inline-block'
			$('a.where-to-buy-btn.intl')
				.attr 'href', '../pages/where-to-buy'
			$('#buckets div.intl, #sub-buckets a.intl').remove()
		else
			$('a.where-to-buy-btn.intl')
				.attr 'href', '../pages/where-to-buy-intl'
			$('a.buy-btn.intl, a.price.intl').remove()
			$('#buckets div.us, #subbuckets a.us').remove()
			$('.us').remove()
			$('.store.intl').remove()
			$('#store').remove()

	geoip2.country(onSuccess)



	#OPEN LINKS IN NEW WINDOW
	# $('div.support a[href^="http"]').not('div.support a[href^="{{ shop.url }}"]').attr('target', '_blank')
	# $('div.support a[href^="http"]').not('div.support a[href^="soundfreaq.com"]').attr('target', '_blank')


	#BUY BUTTON
	$('.open-quick-look').magnificPopup
		type:'inline'
		midClick: true

	$('.open-quick-look').on 'click', ->
		$('.quick-look-options').html('')

	$('.close').on 'click', (event) ->
		event.preventDefault()
		# $.magnificPopup.close()
		alert 'hello'



	#PREVIEW IMAGE QUICK LOOK
	dropdown = $('#product-select')

	$('.popup').on 'change', dropdown, ->
		sku = $(@).find(':selected').data('sku')
		new_src = $('.popup #quick-preview-image #preload li img[src*=' + sku + ']').attr('src')
		$(@).find('.main-image').attr('src', new_src)


	#CUSTOM ADD TO CART LOGIC
	$('.add-to-cart').on 'click', (event) ->
		event.preventDefault()
		quantity = parseInt($(@).parent().find('#quantity').val())
		id = $(@).parent().find('#product-select').val()
		name = $(@).parent().find(':selected').data('name')
		if not name?
			name = $(@).parent().find('#product-name').data('name')
		if quantity > 1
			plural = 's'
			hasHave = 'have'
		else
			plural = ''
			hasHave = 'has'
		cartCount = parseInt($('.cart-count').text())
		optionCopy = '<p><a href="../cart">Checkout</a> | <a class="close" href="#">Continue Shopping</a></p>'
		$.ajax
			type: 'POST'
			url: '/cart/add.js'
			data: 'quantity='+quantity+'&id='+id
			dataType: 'json'
			success: ->
				$('.cart-count, .quick-cart-count').text(cartCount +=quantity).removeClass 'hide'
				$('.quick-look-options').html(optionCopy)
				$('<div id="modal">' + quantity + ' ' + name + '' + plural + ' <span>' + hasHave + ' been added to your cart</span></div>').stop().prependTo('body').delay(2000).fadeOut()
				$('.close').on 'click', (event) ->
					event.preventDefault()
					$.magnificPopup.close()
			error: (error) ->
				console.log error.status
				switch error.status
					when 404 then optionCopy = 'Please select an Option'
					when 422 then optionCopy = 'Sorry, we are out of that item'

				$('.quick-look-options').html(optionCopy)

	$('#soldout').on 'click', (e)->
		e.preventDefault()







	#CART LOGIC OLD
	# $('.add-to-cart').on 'click', (event) ->
	# 	cartCount = parseInt($('.cart-count').text())
	# 	quantity = parseInt($(@).parent().find('#quantity').val())
	# 	cartUpdate = () -> $('.cart-count, .quick-cart-count').text(cartCount +=quantity).removeClass 'hide'
	# 	event.preventDefault()
	# 	Shopify.addItem(
	# 		$(@).parent().find('#product-select').val()
	# 		$(@).parent().find('#quantity').val(),
	# 		cartUpdate()
	# 		options.show()
	# 		)
	# 	Shopify.onItemAdded(
	# 		alert 'hi'
	# 		)



	#FIXED HEADER
	$('div#header').scrollToFixed()
	$('.product-name').scrollToFixed(
		marginTop: 60
	)


	#MENU + SEARCH
	menus = $('div#header #search, div#header #menu')
	btns = $('div#header .menubtn, div#header .searchbtn')

	$('div#header .nav').on 'click','.menubtn, .searchbtn', (e) ->
		e.preventDefault()
		id = $(@).data('name')
		if $(@).hasClass 'on'
			$('#' + id).hide()
			$(@).removeClass 'on'
		else
			menus.hide()
			btns.removeClass 'on'
			$('#' + id).slideDown(250)
			$(@).addClass 'on'


	#NEWSLETTER
	$form = $('#newsletter form')

	$form.submit (e)->
		e.preventDefault()
		$this = $(@)
		$.ajax
			type: "GET"
			url: 'http://soundfreaq.us7.list-manage.com/subscribe/post-json?u=1a463054a5823c402f5c28c6c&amp;id=fd0c707a7d&c=?'
			data: $this.serialize()
			dataType: 'json'
			contentType: "application/json; charset=utf-8"
			error: (err) ->
				alert 'no'
			success: (data) ->
				if ($('input[name=EMAIL]').val().indexOf('@') != -1 and $('input[name=EMAIL]').val().indexOf('.') != -1)
					$('label').text('Thanks! Check your inbox to confirm.')
				else
					alert 'not valid email'


	#PRODUCT COMPARE EVEN/ODD STYLING
	$('#product-compare ul.holder > li:odd').css 'background-color':'#eee'
	$('#product-compare ul.holder > li:even').css 'background-color':'#dfdfdf'



	#QUOTE SLIDER
	$('.quote-slider').responsiveSlides({
		namespace: "slides",
		nav: true,
		pause: true,
		nextText: '<i class="fa fa-chevron-right"></i>',
		prevText: '<i class="fa fa-chevron-left"></i>',
		navContainer: '#quote-slider',
		})


	#PRODUCT IMAGE SLIDER
	$('.product-slider').responsiveSlides
		auto: false
		namespace: "slides"
		pager: true

	$('ul.slides_tabs.slides2_tabs li a').html('<i class="fa fa-circle"></i>')


	#PRODUCT IMAGE GALLERY
	$("#product-image-gallery #images").justifiedGallery
		'rowHeight':360
		'captions': true


	#PRODUCT IMAGE GALLERY ROLLOVERS
	imageRoll = $('.image-roll')
	imageRoll.remove()
	galleryImg = $('#product-image-gallery #images a img')
	pinDescrip = $('.product-name h2').text()
	thisUrl = $(location).attr('href')
	$(galleryImg).hover(
		->
			$(@).parent().append(imageRoll)
			imgSrc = $(@).attr('src')
			$('.image-roll a').hover(
				->
					switch $(@).data('name')
						when 'image' then $(@).attr('href', imgSrc).addClass 'image'
						when 'pinterest' then $(@).attr('href', 'http://pinterest.com/pin/create/link/?media=' + imgSrc + '&description=Soundfreaq ' + pinDescrip)
						when 'facebook' then $(@).attr('href', 'http://www.facebook.com/sharer/sharer.php?u=' + thisUrl + '&picture' + imgSrc)

					$('#images .image-roll a.image').magnificPopup
						type:'image'
						midClick: true
				)
		)


	#PRODUCT VIDEO POPUP
	$('.video-link').magnificPopup
		type:'iframe'
		midClick: true

	#PRODUCT FEATURE RIGHT WIDTH FIX
	rightDiv = $('#main-features div.bit-2 div')

	rightDiv.has('img').css 'width':'100%'




	#INSTAGRAM
	insta_url = 'https://api.instagram.com/v1/users/239381321/media/recent/?client_id=b64a4afe94a34684bcb7f61c86bc6c4a&count=9&callback=?'

	$.ajax
		type: 'GET'
		url: insta_url
		dataType: 'jsonp'
		success: (results) ->
			$.each results.data, ->
				$('<li class="bit-3"><a target="_blank" href="' + this.link + '"><img src="' + this.images.low_resolution.url + '"></a></li>').appendTo('ul#insta')
			$('<a href="http://www.instagram.com/soundfreaq" target="_blank">follow on instagram</a>').insertAfter('ul#insta h2')
		error: ->
			console.log 'insta fail'
