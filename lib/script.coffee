$ ->

	baseURL = 'http://www.soundfreaq-theme.myshopify.com/'
		

	#INTERNATIONAL HANDLING
	$.getJSON 'http://freegeoip.net/json/', (location) ->
		if location.country_code is 'US'
			$('a.buy-btn.intl, .price.intl').css 'display','inline-block'
			$('a.where-to-buy-btn.intl').attr 'href', baseURL + 'pages/where-to-buy'
		else
			$('a.buy-btn.intl')
				.text 'Where to Buy'
				.attr 'href', baseURL + 'pages/where-to-buy-intl'
				.css 'display','inline-block'
			$('a.where-to-buy-btn.intl, a.price.intl').remove()

	#BUY BUTTON
	$('.open-quick-look').magnificPopup
		type:'inline'
		midClick: true

	$('a.close').on 'click', (event) ->
		event.preventDefault()
		$.magnificPopup.close()

	#CART LOGIC

	$('.add-to-cart').on 'click', (event) ->
		cartCount = parseInt($('.cart-count').text())
		quantity = parseInt($(@).parent().find('#quantity').val())
		cartUpdate = () -> $('.cart-count, .quick-cart-count').text(cartCount +=quantity).removeClass 'hide'
		event.preventDefault()
		Shopify.addItem(
			$(@).parent().find('#product-select').val()
			$(@).parent().find('#quantity').val()
			cartUpdate()
			)

	#CUSTOM VERSION - WORK IN PROGRESS
	# $('.add-to-cart').on 'click', (event) ->
	# 	cartCount = parseInt($('.cart-count').text())
	# 	cartUpdate = () -> $('.cart-count, .quick-cart-count').text(cartCount +=quantity).removeClass 'hide'
	# 	event.preventDefault()
	# 	quantity = parseInt($(@).parent().find('#quantity').val())
	# 	id = $(@).parent().find('#product-select').val()
	# 	console.log id
	# 	$.ajax
	# 		type: 'POST'
	# 		url: '/cart/add.js'
	# 		data: 'quantity='+quantity+'&id='+id
	# 		dataType: 'json'
	# 		success: ->
	# 			cartUpdate()
	# 		error: (XMLHttpRequest, textStatus) ->
	# 			if id is 'null'
	# 				alert 'whoops'
	# 			else 
	# 	  			Shopify.onError(XMLHttpRequest, textStatus)



	#PREVIEW IMAGE QUICK LOOK
	dropdown = $('#product-select')

	$('.popup').on 'change', dropdown, ->
		sku = $(@).find(':selected').data('sku')
		new_src = $('.popup #quick-preview-image #preload li img[src*=' + sku + ']').attr('src')
		$(@).find('.main-image').attr('src', new_src)




	#PRODUCT VIDEO POPUP
	$('.video-link').magnificPopup
		type:'iframe'
		midClick: true

	# CUSTOM DATA
	# $.ajax
	# 	# url: 'http://cdn.shopify.com/s/files/1/0436/0145/t/1/assets/data2.json'
	# 	url: 'http://cdn.soundfreaq.com/data/data.json?callback=?'
	# 	type: 'GET'
	# 	dataType: 'json'
	# 	success: (results) ->
	# 		$.each results.pressReleases, ->
	# 			console.log this.title
	# 	error: ->
	# 		console.log 'major fail'	


	#FIXED HEADER
	$('div#header').scrollToFixed()



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
	$('.product-slider').responsiveSlides({
		namespace: "slides",
		nav: true,          
		pause: true,
		nextText: '<i class="fa fa-chevron-right"></i>',
		prevText: '<i class="fa fa-chevron-left"></i>'
		})

	#PRODUCT IMAGE GALLERY
	$("#product-image-gallery").justifiedGallery({
		'rowHeight':360
		});

	#INSTAGRAM
	insta_url = 'https://api.instagram.com/v1/users/239381321/media/recent/?client_id=b64a4afe94a34684bcb7f61c86bc6c4a&count=9&callback=?'

	$.ajax
		type: 'GET'
		url: insta_url
		dataType: 'jsonp'
		success: (results) ->
			$.each results.data, ->
				$('<li class="bit-3"><a target="_blank" href="' + this.link + '"><img src="' + this.images.low_resolution.url + '"></a></li>').appendTo('ul#insta')
		error: ->
			console.log 'insta fail'
