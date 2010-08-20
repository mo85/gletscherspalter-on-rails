Glacier.CommentHandler = Class.create({
	
	initialize: function(toggleLinkID, formID) {
		this.inputForm = $(formID);
		this.toggler = $(toggleLinkID);
		this.comments = $$('div.comment');
		this.comments.each(function(e, i){
			if (i < 3) {
				e.toggle();
			}
		});
		if (this.comments.size() <= 3) {
			this.toggleCommentsForm();
		}

		this.toggledComments = this.comments.findAll(
			function(c){ return c.getStyle("display") == "none" });
		this.toggler.observe("click", this.toggleInvisibleComments.bind(this));
	},

	toggleInvisibleComments: function() {
		var toggler = this.toggler
		this.toggleCommentsForm();
		this.toggledComments.each(function(e) {
			if (e.getStyle("display") == "none") {
				e.appear();
				toggler.update("Kommentare verstecken...");
			} else {
				e.hide();
				toggler.update("Alle Kommentare anzeigen...");
			}
		});
		return false;
	},
	
	toggleCommentsForm: function() {
		if (this.inputForm.getStyle("display") == "none") {
			this.inputForm.appear();
		} else {
			this.inputForm.hide();
		}
	}
	
});