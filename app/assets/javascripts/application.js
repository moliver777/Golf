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
		search = $("#team_search").val();
		window.location.href = "/admin?name="+search;
	});
  
	$("#team_clear_btn").click(function() {
		$("#team_search").val("");
		window.location.href = "/admin";
	});

	$("#add_team").click(function() {
		name = $("#name").val();
    pro1 = $("#pro1").val();
    pro2 = $("#pro2").val();
    pro3 = $("#pro3").val();
		pro4 = $("#pro4").val();
    tee_hour = $("select#tee_hour").val();
    tee_mins = $("select#tee_mins").val();
		$.post("/admin/add_team", {name:name,pro1:pro1,pro2:pro2,pro3:pro3,pro4:pro4,tee_hour:tee_hour,tee_mins:tee_mins}, function(data) {
			if ( data.success ) {
				$("#team_table").html(data.view);
				$(".clear").val("");
        $("select#tee_hour").val("00");
        $("select#tee_mins").val("00");
			} else {
				$(".error-message").show().delay(1500).fadeOut(500);
			}
		});
  });
});

function updatePro(el) {
	pro_id = $(el).attr("data-id");
	score = $(el).val();
	
	$.post("/admin/update_pro_score", {pro_id:pro_id,score:score}, function(data) {
		if (data.success) {
			$(".thank-message").show().delay(1500).fadeOut(500);
      $(el).parents(".team_row").find(".team_score").html(data.score);
		} else {
			$(".error-message.score").show().delay(1500).fadeOut(500);
		}
	});
}

function updateTeam(el) {
	team_id = $(el).attr("data-id");
	score = $(el).val();
	
	$.post("/admin/update_team_score", {team_id:team_id,score:score}, function(data) {
		if (data.success) {
			$(".thank-message").show().delay(1500).fadeOut(500);
		} else {
			$(".error-message.score").show().delay(1500).fadeOut(500);
		}
	});
}

function editTeam(id) {
	if (confirm("Are you sure you want to update this team?")) {
    var params = {
      id: id,
      tee_hour: $("select#tee_hour").val(),
      tee_mins: $("select#tee_mins").val(),
      name: $("input#name").val(),
      pro1: $("input#pro1").val(),
      pro2: $("input#pro2").val(),
      pro3: $("input#pro3").val(),
			pro4: $("input#pro4").val()
    }
		$.post("/admin/update_team", params, function(data) {
			if (data.success) {
        window.location.href = "/admin"
			}
		});
	}
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
