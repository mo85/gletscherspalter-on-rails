document.observe('dom:loaded', function() {
 	Glacier.Selector.addAutocompletion();
});


Glacier.Selector.addAutocompletion = function() {
	return new Ajax.Autocompleter('user_name', 'user_choices', '/users.ajax', { 
	method: 'get', 
	updateElement: Glacier.Selector.selectEntry });
}

Glacier.Selector.selectEntry = function(element) {
	var node = element.cloneNode(true);
	$('users_list').insert({
		bottom: node
	});
}