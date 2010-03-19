$(function() {
	$('.pagination a').live("click", function() {
		$(".pagination").html("Seite wird geladen...");
		$.get(this.href, null, null, "script");
		return false;
	});
});