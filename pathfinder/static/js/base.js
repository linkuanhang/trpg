$(document).ready(function(){
	$("#header").load("/trpg/pathfinder/navbar.html");
	
	$("*").contents().filter(function() {
		return this.nodeType==3;
	}).each(function(){
		this.textContent=this.textContent.replace(/(\n|\t|\r)/gm,"");
	});
	
	var request=new XMLHttpRequest();
	request.onreadystatechange=function(){
		if (request.readyState==4 && request.status==200){
			loadXML(request);
		}
	};
	
	$(".toggle").hide();
	$("main [lang]").hide();
	$("main [lang='"+$("#languages [checked='checked']").attr("id")+"']").show();
});

function show(node)
{
	$(node).parent().next().toggle();
}

function show2(node)
{
	$(node).next().children().toggle();
}

function nav_toggle(){
	$("main").css("margin-left",(parseInt($("main").css("margin-left"))+200)%400);
	$("#sidenav").toggle();
}

function sidenav_toggle(node){
	if (node.hasClass('w3-hide')){
		node.removeClass('w3-hide');
	}
	else{
		node.addClass('w3-hide');
	}
}

function toggle_lang(node){
	var language=node.attr("id");
	
	if (node.is(":checked")){
		$("main [lang='"+language+"']").show();
	}
	else{
		$("main [lang='"+language+"']").hide();
	}
}
