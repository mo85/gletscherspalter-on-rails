Glacier.Selector = Class.create({
	initialize: function() {
		new Ajax.Autocompleter('user_name', 'user_choices', '/users.ajax', { 
		method: 'get', 
		updateElement: Glacier.Selector.selectEntry });
	},

	selectEntry: function(element) {
		var node = element.cloneNode(true);
		$('users_list').insert({
			bottom: node
		});
	}
});