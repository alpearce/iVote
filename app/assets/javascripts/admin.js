// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


	var HIDDEN = true;
	$(".result_container").hide();

$(".toggle").click(function(){
	if (HIDDEN)
	{
	$(".result_container").show();
	 HIDDEN = false;
}
else
{
	$(".result_container").hide();
	 HIDDEN = true;
}	
	
});




