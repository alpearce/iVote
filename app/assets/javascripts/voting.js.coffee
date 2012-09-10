# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
drop  = {
	drop : (event, ui) ->
		dropped = $(this).data('dropped')
		$(this).data('dropped', dropped + 1)
		$(this).height(ui.draggable.height() * (dropped + 1))
		return
	out : (event, ui) ->
		dropped = $(this).data('dropped')
		$(this).data('dropped', dropped - 1) 
		$(this).height(ui.draggable.height() * (dropped - 1))
		return
}



$ ->
	$(".candidate").draggable()
	$(".landing").droppable(drop)
	$(".landing").data('dropped', 0)
		
	return