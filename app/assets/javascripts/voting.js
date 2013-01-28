$(document).ready(function(){
	
	var YES = $(".remaining").attr("data-remaining");
	var MAX = YES;
	var ballot = {};
	$(".btn-group").button();
	$(".btn-success").click(function(e){
		var source = e.target;
		var form = $(this).siblings("#candidate_vote");
		if(form.attr('value') != 0)
		{
		
		YES -= 1;
		if(YES >= 0)
		{
		$(".remaining").html(YES + " YES votes remain.");
		}
	}
	if (YES >= 0)
	{
	$(this).closest(".candidate").removeClass("yes no abstain");
	$(this).closest(".candidate").addClass("yes");
	form.attr("value", 0);
	}
	else
	{
		alert("Sorry, you cannot have more than " + MAX + " votes.")
		YES = 0;
	}
	});
	$(".btn-info").click(function(e){
		var source = e.target;
		var form = $(this).siblings("#candidate_vote");
		
		if(form.attr('value') == 0)
		{
		
		YES += 1;
		$(".remaining").html(YES + " YES votes remain.");
	}	
	form.attr("value", 1);
	$(this).closest(".candidate").removeClass("yes no abstain");
	$(this).closest(".candidate").addClass("abstain");
	});
	$(".btn-danger").click(function(e){
			var source = e.target;
			var form = $(this).siblings("#candidate_vote");
			if(form.attr('value') == 0)
			{
			
			YES += 1;
			$(".remaining").html(YES + " YES votes remain.");
		}
		form.attr("value", 2);
		$(this).closest(".candidate").removeClass("yes no abstain");
		$(this).closest(".candidate").addClass("no");
	});
	
	$(".rotate_button").click(function(eventOject){
		var image = $(this).parent().siblings(".candidate_image");
		image.rotate((image.getRotateAngle()[0]) + 90);
		
		
	});

	$("#submit_ballot").click(function(){
		$("#submit_ballot").attr("disabled", "disabled")
		var candidate_votes = {};
		$(".candidate_vote").each(function(index, element){
			var candidate_id = $(element).attr("data-candidate-id");
			var vote = $(element).val();
			candidate_votes[candidate_id] = vote;
			
			
		});
		var ballot = {};
		var user = $("#user_id").val();
		ballot["ballot"] = candidate_votes;
		ballot["user_id"] = user;
		$.ajax({
			url : "/voting/vote",
			data : ballot,
			type : "POST",
			success : function (a, b, c)
			{
				$("#submit_ballot").attr("disabled", "");
			},
			error : function (a, b, c)
			{
				$("#submit_ballot").attr("disabled", "");
			alert(a.responseText);	
			}
		});
		
		
	});	
	
	
	$("#quick_submit_ballot").click(function(){
		$("#submit_ballot").attr("disabled", "disabled")
		var candidate_votes = {};
		$(".candidate_vote").each(function(index, element){
			var candidate_id = $(element).attr("data-candidate-id");
			var vote = $(element).val();
			candidate_votes[candidate_id] = vote;
			
			
		});
		var ballot = {};
		var user = $("#user_id").val();
		ballot["ballot"] = candidate_votes;
		ballot["user_id"] = user;
		$.ajax({
			url : "/voting/quickvote",
			data : ballot,
			type : "POST",
			success : function (a, b, c)
			{
				$("#submit_ballot").attr("disabled", "");
			},
			error : function (a, b, c)
			{
				$("#submit_ballot").attr("disabled", "");
			alert(a.responseText);	
			}
		});
		
		
	});
		
		
	});