
$(function(){
 	homePageMouse();
 }

function homePageMouse(){
	$(".homelink1").mouseover(function(){
	  $(this).css("border", "green 2px solid");
	});
	$(".circle").mouseout(function(){
	  $(this).css("border", "white 2px solid");
	});
});

-


