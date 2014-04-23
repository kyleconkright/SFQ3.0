$ ->
	console.log 'scripts are working'

	$.getJSON 'http://freegeoip.net/json/', (location) -> 
	    if location.country_code isnt 'US' 
	        $('.intl').css 'display':'none' 
	        console.log 'You are outside of the US' 
	    else
	        console.log 'You are inside of the US'


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

			
						

	$('.product-slider').slick(
		'dots': true
		'arrows': false
		'centerPadding': 0
		'draggable': false
		)

