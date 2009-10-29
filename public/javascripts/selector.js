/*Glacier.Selector = Class.create({
	initialize: function(id) {
		this.id = id;
		this.addAutocompletion();
		alert("Test");
	},
	
	addAutocompletion: function() {
		new Ajax.Autocompleter(this.id, 'user_choices', '/users.ajax', { method: 'get' });
	}
});*/

document.observe('dom:loaded', function() {
	new Ajax.Autocompleter('user_name', 'user_choices', '/users.ajax', {
		method: 'get'
	});
});
