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
	$("#team_search_btn").click(function() {
		pro_name = $("#team_search").val();
		window.location.href = "/admin?name="+pro_name;
	});
  
	$("#team_clear_btn").click(function() {
		$("#team_search").val("");
		window.location.href = "/admin";
	});

	$("#add_team").click(function() {
		pro = $("#pro").val();
    amateur_1 = $("#amateur_1").val();
    amateur_2 = $("#amateur_2").val();
    amateur_3 = $("#amateur_3").val();
    if (pro != "") {
  		$.post("/admin/add_team", {pro:pro,amateur_1:amateur_1,amateur_2:amateur_2,amateur_3:amateur_3}, function(data) {
  			if ( data.success ) {
  				$("#team_table").html(data.view);
  				$(".clear").val("");
  			} else {
  				$(".error-message").show().delay(1500).fadeOut(500);
  			}
  		});
    }
  });
});

function updatePro(el) {
	pro_id = $(el).siblings("input").attr("data-id");
	score = $(el).siblings("input").val();
	
	$.post("/admin/update_pro_score", {pro_id:pro_id,score:score}, function(data) {
		if (data.success) {
			$(".thank-message").show().delay(1500).fadeOut(500);
		} else {
			$(".error-message.score").show().delay(1500).fadeOut(500);
		}
	});
}

function updateTeam(el) {
	team_id = $(el).siblings("input").attr("data-id");
	score = $(el).siblings("input").val();
	
	$.post("/admin/update_amateur_score", {team_id:team_id,score:score}, function(data) {
		if (data.success) {
			$(".thank-message").show().delay(1500).fadeOut(500);
		} else {
			$(".error-message.score").show().delay(1500).fadeOut(500);
		}	
	});
}

function deleteTeam(id) {
	if (confirm("Are you sure you want to delete this team?")) {
		$.post("/admin/delete_team", {id:id}, function(data) {
			if (data.success) {
				$("#team_"+data.team_id).remove();
			}
		});
	}
}

function deleteImage(id) {
  if (confirm("Are you sure you want to delete this image?")) {
		$.post("/admin/delete_image", {id:id}, function(data) {
			if (data.success) {
				window.location.reload();
			}
		});
  }
}

function checkFile(el,allowed) {
	var suffix = $(el).val().split(".")[$(el).val().split(".").length-1].toUpperCase();
	if (!(allowed.indexOf(suffix) !== -1)) {
		alert("File type not allowed,\nAllowed files: *."+allowed.join(",*."));
		$(el).val("");
	}
}
