$(document).ready(function() {
	$("#add_pro").click(function() {
		pro_name = $("#pro_name").val()
		if (pro_name != "") {
			$.post("/admin/add_pro", {pro_name:pro_name}, function(data) {
				if ( data.success ) {
					$("tr#new_pro").before("<tr><td>"+data.pro.name+"</td><td><input data-id='"+data.pro.id+"' value='0' 'type='text'> <a  class='update_pro' onclick='updatePro(this)'>Update Score</a></td></tr>")
					$("#pro_name").val("")
				} else {
					$(".error-message").show().delay(1500).fadeOut(500);
				}
					
			})
		}
	})
	

	$("#add_team").click(function() {
		team_name = $("#team_name").val()
		if (team_name != "") {
			$.post("/admin/add_team", {team_name:team_name}, function(data) {
				if ( data.success ) {
					$("tr#new_team").before("<tr><td>"+data.team.name+"</td><td><input  data-id='"+data.team.id+"' value='0' 'type='text'> <a class='update_team' onclick='updateTeam(this)'>Update Score</a></td></tr>")
					$("#team_name").val("")
				} else {
					$(".error-message").show().delay(1500).fadeOut(500);
				}
					
			})
		}
	})
})

function updatePro(el) {
	pro_id = $(el).siblings("input").attr("data-id")
	score = $(el).siblings("input").val()
	
	$.post("/admin/update_score", {pro_id:pro_id, score:score}, function(data) {
		if ( data.success ) {
			$(".thank-message").show().delay(1500).fadeOut(500);
		} else {
			$(".error-message.score").show().delay(1500).fadeOut(500);
		}
			
	})
}

function updateTeam(el) {
	team_id = $(el).siblings("input").attr("data-id")
	score = $(el).siblings("input").val()
	
	$.post("/admin/update_team_score", {team_id:team_id, score:score}, function(data) {
		if ( data.success ) {
			$(".thank-message").show().delay(1500).fadeOut(500);
		} else {
			$(".error-message.score").show().delay(1500).fadeOut(500);
		}
			
	})
}