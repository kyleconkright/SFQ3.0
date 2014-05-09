$ ->

	baseURL = 'http://www.soundfreaq-theme.myshopify.com/'

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


	# CUSTOM DATA
	$.ajax
		# url: 'http://cdn.shopify.com/s/files/1/0436/0145/t/1/assets/data2.json'
		url: 'http://cdn.soundfreaq.com/data/data.json?callback=?'
		type: 'GET'
		dataType: 'json'
		success: (results) ->
			$.each results.pressReleases, ->
				console.log this.title
		error: ->
			console.log 'major fail'	


	$('div#header').scrollToFixed()

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


	$('#product-compare ul.holder > li:odd').css 'background-color':'#eee'
	$('#product-compare ul.holder > li:even').css 'background-color':'#dfdfdf'			
						

	$('.quote-slider').responsiveSlides({
		namespace: "slides",
		nav: true,          
		pause: true,
		nextText: '<i class="fa fa-chevron-right"></i>',
		prevText: '<i class="fa fa-chevron-left"></i>',
		navContainer: '#quote-slider',
		})

	$('.product-slider').responsiveSlides({
		namespace: "slides",
		nav: true,          
		pause: true,
		nextText: '<i class="fa fa-chevron-right"></i>',
		prevText: '<i class="fa fa-chevron-left"></i>'
		})

	$("#product-image-gallery").justifiedGallery({
		'rowHeight':360
		});

	# INSTAGRAM

	insta_url = 'https://api.instagram.com/v1/users/239381321/media/recent/?client_id=b64a4afe94a34684bcb7f61c86bc6c4a&count=9&callback=?'

	$.ajax
		type: 'GET'
		url: insta_url
		dataType: 'jsonp'
		success: (results) ->
			$.each results.data, ->
				console.log this.link
				$('<li class="bit-3"><a target="_blank" href="' + this.link + '"><img src="' + this.images.low_resolution.url + '"></a></li>').appendTo('ul#insta')
		error: ->
			console.log 'insta fail'
