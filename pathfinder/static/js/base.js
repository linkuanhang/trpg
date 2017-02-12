$(document).ready(function(){
	$("body").css("padding-top","70px");
	$("#header").load("/pathfinder/navbar.html");
	
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
	
	$(".toggle").hide()
});

function show(node)
{
	$(node).parent().next().toggle();
}

function show2(node)
{
	$(node).next().children().toggle();
}

function nav_show(node){
	$(node).next().toggle();
	
	var span_node=$(node).children("span");
	if($(span_node).text()=="expand_more"){$(span_node).text("expand_less");}
	else{$(span_node).text("expand_more");}
}
