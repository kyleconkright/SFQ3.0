$ ->
	console.log 'scripts are working'

	$('div#header').scrollToFixed()

	$form = $('#newsletter form')

	$form.submit (e)->
		e.preventDefault()
		$this = $(@)
		$.ajax
			type: "GET"
			url: 'http://erichutchinson.us7.list-manage.com/subscribe/post-json?u=c8c95e39b427209a753338e7a&amp;id=3e4a2c0d22&c=?'
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