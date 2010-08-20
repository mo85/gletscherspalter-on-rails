Glacier.CommentHandler = Class.create({
	
	initialize: function(hideComments, notificationURL) {
		this.notificationURL = notificationURL;
		this.inputForm = $("new-comment-input");
		this.toggler = $("toggle-comments-link");
		this.comments = $$('div.comment');
		this.comments.each(function(e, i) {
			if (i < 3 || hideComments == "0") {
				e.toggle();
			}
		});
		if (this.comments.size() <= 3 || hideComments == "0") {
			this.inputForm.toggle();
		}

		this.toggledComments = [];
		for (i = 3; i <= this.comments.size(); i++) {
			if (this.comments.size() > i) {
				this.toggledComments[i-3] = this.comments[i];
			}
		}
		
		if (hideComments == "0") {
			this.toggler.update("Kommentare verstecken...");
		}
		
		this.toggler.observe("click", this.toggleComments.bind(this));
	},

	notifyServer: function() {
		new Ajax.Request(this.notificationURL, {
			parameters: {
				resource_type: "Event",
				setting: "comments_expanded"
			}
		});
	},

	toggleComments: function() {
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
		
		this.notifyServer();
		
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