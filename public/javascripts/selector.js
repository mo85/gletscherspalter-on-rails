Glacier.Selector = Class.create({
	initialize: function(name) {
		this.name = name;
		
		new Ajax.Autocompleter(this.name + '_name', this.name + '_choices', '/users.ajax', { 
		method: 'get', 
		updateElement: this.selectEntry.bind(this) });
	},

	selectEntry: function(element) {
		var node = element.cloneNode(true);
		node.id = 'user_' + node.title;

		$(this.name + 's_list').insert({
			bottom: node
		});
		
		node.insert({
			bottom: " <a onclick='Glacier.Selector.removeUser(this); return false;' href='#'><img src='/images/icons/cross.png' alt='delete' border='0' /></a>"
		});
		
		$(this.name + '_name').value = '';
	}
});

Glacier.Selector.addUserIds = function() {
	var users = $('usrs_list').childElements();
	$('users').value = users.pluck('title');
}

Glacier.Selector.removeUser = function(element) {
	element.parentNode.remove();
}
