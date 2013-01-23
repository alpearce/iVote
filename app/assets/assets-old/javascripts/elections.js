$(document).ready(function(){
	
	//var YES = $(".remaining").attr("data-remaining");
	//var MAX = YES;
	var ballot = {};
	$(".btn-group").button();
	$(".success").click(function(e){
		var source = e.target;
		var form = $(this).siblings("#candidate_vote");
	$(this).closest(".candidate").removeClass("yes no abstain");
	//$(this).closest(".candidate").addClass("yes");
	form.attr("value", 0);
	
	});
	$(".info").click(function(e){
		var source = e.target;
		var form = $(this).siblings("#candidate_vote");
		
		if(form.attr('value') == 0)
		{
		
		YES += 1;
		$(".remaining").html(YES + " YES votes remain.");
	}	
	form.attr("value", 1);
	});
	$(".danger").click(function(e){
			var source = e.target;
			var form = $(this).siblings("#candidate_vote");
			if(form.attr('value') == 0)
			{
			
			YES += 1;
			$(".remaining").html(YES + " YES votes remain.");
		}
		form.attr("value", 2);
	});

	$("#elect_ballot").click(function(){
		$("#elect_ballot").attr("disabled", "disabled")
		var candidate_votes = {};
		$(".candidate_vote").each(function(index, element){
			var candidate_id = $(element).attr("data-candidate-id");
			var vote = $(element).val();
			candidate_votes[candidate_id] = vote;
			
			
		});
		var ballot = {};
		var y = 0;
		var n = 0;
		var a = 0;
		Object.keys(candidate_votes).forEach(function(val, index, array){
			if (candidate_votes[val] == 0)
			{
				y += 1;
			}
			if (candidate_votes[val] == 1)
			{
				a += 1;
			}
			if (candidate_votes[val] == 2)
			{
				n += 1;
			}
			
			
		});
		if (y !== 1 ||  n >= 2 || a !== 1)
		{
			alert("Invalid Data");
			return;
		}
		
		var user = $("#user_id").val();
		ballot["ballot"] = candidate_votes;
		ballot["user_id"] = user;
		$.ajax({
			url : "/elections/vote",
			data : ballot,
			type : "POST",
			success : function (a, b, c)
			{
				$("#elect_ballot").attr("disabled", "");
			},
			error : function (a, b, c)
			{
				$("#elect_ballot").attr("disabled", "");
			alert(a.responseText);	
			}
		});
		
		
	});	
			
		
	});