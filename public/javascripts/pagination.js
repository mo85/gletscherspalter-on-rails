Glacier.Paginator = {
	
	addAjaxPagination: function(containerId) {
		var elems = $$("div.pagination a");

		elems.each(function(elem) {
			elem.onclick = function() { return false; }
			elem.observe("click", function() {
				$$("div.pagination")[0].update("Seite wird geladen...");
				new Ajax.Updater(containerId, elem.href, { method: 'get', evalScripts: true});
			});
		});
	}
		
};
