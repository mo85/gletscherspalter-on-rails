document.observe('dom:loaded', function() {
	new Ajax.Autocompleter('user_name', 'user_choices', '/news/completions', {
		method: 'get'
	});
});