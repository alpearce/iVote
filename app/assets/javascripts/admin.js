// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


	var HIDDEN = true;
	$(".results").hide();

$(".toggle").click(function(){
	if (HIDDEN)
	{
	$(".results").show();
	 HIDDEN = false;
}
else
{
	$(".results").hide();
	 HIDDEN = true;
}	
	
});


