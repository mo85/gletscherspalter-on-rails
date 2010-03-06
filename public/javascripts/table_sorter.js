var TableSorter = Class.create({
	initialize: function(element) {
		this.element = element;
		this.sortIndex = -1;
		this.sortOrder = 'asc'
		this.initDOMReferences();
		this.initEventHandlers();
	},

	initDOMReferences: function() {
		var head = this.element.down('thead');
		var body = this.element.down('tbody');
		if (!body || !head) { throw 'Table must have a head and a body to be sortable.'; }
		this.headers = head.down('tr').childElements();
		this.headers.each(function(e, i) {
			e._colIndex = i;
		});
		this.body = body;
	},

	initEventHandlers: function() {
		this.handler = this.handleHeaderClick.bind(this);
		this.element.observe('click', this.handler);
	},

	handleHeaderClick: function(e) {
		var element = e.element();
		if (!('_colIndex' in element)) {
			element = element.ancestors().find(function(elt) {
				return '_colIndex' in elt;
			});
			if (!((element) && '_colIndex' in element)) return;
		}
		this.sort(element._colIndex);
	},

	adjustSortMarkers: function(index) {
		if (this.sortIndex != -1) {
			this.headers[this.sortIndex].removeClassName('sort-' + this.sortOrder);
		}
		if (this.sortIndex != index) {
			this.sortOrder = 'asc';
			this.sortIndex = index;
		} else {
			this.sortOrder = ('asc' == this.sortOrder ? 'desc' : 'asc');
		}
		this.headers[index].addClassName('sort-' + this.sortOrder);
	},

	sort: function(index) {
		this.adjustSortMarkers(index);
		var rows = this.body.childElements();
		rows = rows.sortBy(function(row) {
			return row.childElements()[this.sortIndex].collectTextNodesIgnoreClass();
		}.bind(this));

		if ('asc' == this.sortOrder) {
			rows.reverse();
		}
		rows.reverse().each(function(row, index) {
			if (index > 0) {
				this.body.insertBefore(row, rows[index - 1]);
			}
		}.bind(this));
		rows.reverse().each(function(row, index) {
			row[(1 == index % 2 ? 'add' : 'remove') + 'ClassName']('alternate');
		});
	}
});
