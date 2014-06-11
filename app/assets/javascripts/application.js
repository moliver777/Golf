// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready(function() {
	$("#add_pro").click(function(e) {
		pro_name = $("#pro_name").val()
		pro_image = $("#pro_image").val()
		if (pro_image == "") {
			e.preventDefault();
			if (pro_name != "") {
				$.post("/admin/add_pro", {pro_name:pro_name}, function(data) {
					if ( data.success ) {
						$("tr#new_pro").before("<tr id='pro_"+data.pro.id+"'><td>"+data.pro.name+" <a onclick='deletePro("+data.pro.id+")'>X</a> </td><td><input data-id='"+data.pro.id+"' value='0' 'type='text'> <a  class='update_pro' onclick='updatePro(this)'>Update Score</a></td></tr>")
						$("#pro_name").val("")
					} else {
						$(".error-message").show().delay(1500).fadeOut(500);
					}
				
				})
			}
		}

	});
	
	$("#pro_search_btn").click(function() {
		pro_name = $("#pro_search").val();
		window.location.href = "/admin/pros?name="+pro_name
	})
	
	$("#team_search_btn").click(function() {
		pro_name = $("#team_search").val();
		window.location.href = "/admin/teams?name="+pro_name
	})
	

	$("#add_team").click(function() {
		team_name = $("#team_name").val()
		team_image = $("#pro_image").val()
		if (team_image == "") {
			e.preventDefault();
			if (team_name != "") {
				$.post("/admin/add_team", {team_name:team_name}, function(data) {
					if ( data.success ) {
						$("tr#new_team").before("<tr id='team_"+data.team.id+"'><td>"+data.team.name+"  <a onclick='deleteTeam("+data.team.id+")'>X</a> </td><td><input  data-id='"+data.team.id+"' value='0' 'type='text'> <a class='update_team' onclick='updateTeam(this)'>Update Score</a></td></tr>")
						$("#team_name").val("")
					} else {
						$(".error-message").show().delay(1500).fadeOut(500);
					}
					
				})
			}
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

function deletePro(id) {
	if (confirm("Are you sure you want to delete this pro?") ) {
		$.post("/admin/delete_pro", {id:id}, function(data) {
			if ( data.success ) {
				$("#pro_"+data.pro_id).remove()
			}
		})
	}

}

function deleteTeam(id) {
	if (confirm("Are you sure you want to delete this team?") ) {
		$.post("/admin/delete_team", {id:id}, function(data) {
			if ( data.success ) {
				$("#team_"+data.team_id).remove()
			}
		})
	}

}

function deleteTeamImage(id) {
	if (confirm("Are you sure you want to delete this teams image?") ) {
		$.post("/admin/delete_team_image", {id:id}, function(data) {
			if ( data.success ) {
				$("#team_image_"+data.team_id).html('<form accept-charset="UTF-8" action="/admin/update_team_image" enctype="multipart/form-data" id="proForm" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="✓"><input name="authenticity_token" type="hidden" value="Ty6R1Wtkmm0syBqvu1Zbo3G4Wy+xu0ZdoRzl37EyHrE="></div><input id="team_image" name="image_form[image]" type="file"><input id="image_form_id" name="image_form[id]" type="hidden" value="'+data.team_id+'"><input id="add_team" name="commit" type="submit" value="Add Image"></form>')
			}
		})
	}

}

function deleteProImage(id) {
	if (confirm("Are you sure you want to delete this pro image?") ) {
		$.post("/admin/delete_pro_image", {id:id}, function(data) {
			if ( data.success ) {
				$("#pro_image_"+data.pro_id).html('<form accept-charset="UTF-8" action="/admin/update_pro_image" enctype="multipart/form-data" id="proForm" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="✓"><input name="authenticity_token" type="hidden" value="Ty6R1Wtkmm0syBqvu1Zbo3G4Wy+xu0ZdoRzl37EyHrE="></div><input id="pro_image" name="image_form[image]" type="file"><input id="image_form_id" name="image_form[id]" type="hidden" value="'+data.pro_id+'"><input id="add_pro" name="commit" type="submit" value="Add Image"></form>')
			}
		})
	}

}


