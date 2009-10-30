Glacier.Selector = Class.create({
	initialize: function(name) {
		this.name = name;
		
		new Ajax.Autocompleter(this.name + '_name', this.name + '_choices', '/users.ajax', { 
		method: 'get', 
		updateElement: this.selectEntry.bind(this) });
	},

	selectEntry: function(element) {
		var node = element.cloneNode(true);
		$(this.name + 's_list').insert({
			bottom: node
		});
		
		// adding ids to hidden input
		var input = $(this.name + 's');
	}
});