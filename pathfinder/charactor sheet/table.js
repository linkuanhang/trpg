$(document).ready(function(){
	$(".value[id], table[id]").each(function(){$(this).attr("title",$(this).prop("id"));});
	$(".value").not("input").each(function(){observe.observe(this,config);});
	$("table").each(function(){observe.observe(this,config);});
	$("input,select").change(function(){input_change(this);});
	$("*[data-eval]").each(calculate);
	$("table.sortable").sortable({
		containerSelector:'table',itemPath:'tbody',itemSelector:'tr.sortable',handle:'td.移動',
		placeholder:'<tr style="height:1em;" />'});
	test("#test-text");
	$("div .loader").hide();
	$("div.tabs-container").show();
	$(".tabs-container .tabbar button.tablink").get(0).click();
});

// Model
//	Variable
//		Calculated variable
var staVar='<span clsss="value"></span>';
var dynVar='<input class="value w3-border-0 w3-center" type="number" style="width:3em" />';
var selVar='<select class="value w3-border-0 w3-center" style="background:rgba(0, 0, 0, 0);"></selection>';
//		Read variable
var selOpt='<option></option>';
var boxTitle='<strong class="title"></strong>';
var reagionTitle='<h2></h2>';
var blockTitle='<h3 class="title"></h3>';
var textTitle='<h3></h3>';
var paragraph='<p></p>';
var tabLink='<button class="tablink w3-bar-item w3-button"></button>'

//	Container
var block='<div class="block w3-panel w3-border"></div>';
var boxes='<p class="boxes w3-container"></p>';
var box='<span class="box w3-tag w3-border w3-theme-light"></span>';
var table='<table class="w3-table-all w3-centered w3-panel"><thead></thead><tbody></tbody><tfoot></tfoot></table>';
var tableTitle='<th></th>';
var tableRow='<tr></tr>';
var tableCol='<td></td>';
var section='<section></section>';
var article='<article></article>';
var tab='<div class="tab w3-container w3-border" hidden="hidden">';


function eval_set(str){return eval(str);}
function eval_with_this(node,str){return eval_set.call(node,str);}
//function eval_with_this(node,str){return Function("return "+str).call(node);}

function get_one(jid){
	var jnode=$(jid);
	if(!jnode.hasClass("value")){jnode=jnode.find(".value");}
	return jnode;
}

function get(jsel,node){
	var seljnode=$();
	
	if(!node){
		$(jsel).each(function(){seljnode=seljnode.add(get_one(this));});
		return seljnode;
	}else{
		var jnode=$(node);
		if(jnode.closest("tr").length>0){
			jnode=jnode.closest("tr").find(jsel).each(function(){seljnode=seljnode.add(get_one(this));});
			return seljnode;
		}else if(jnode.closest(".block")){
			var titles=jnode.closest(".block").find(".title");
			$.each(jsel.split(","),function(idx,val){
				seljnode=seljnode.add(titles.filter(function(){return $(this).text().trim()==val.trim();}).siblings(".value"));
			});
			return seljnode;
		}else{return $(jsel);}
	}
}

function copy_one(jid,totext){
	var jnode=get_one(jid);
	var text;
	
	if(jnode.prop("tagName").toLowerCase()=="input"){
		if(jnode.attr("type")=="checkbox"){return jnode.prop("checked");}
		else if(jnode.attr("type")=="number"){return parseFloat(jnode.val());}
		else if(jnode.attr("type")=="text"){text=jnode.val();}
	}
	else if(jnode.prop("tagName").toLowerCase()=="select"){text=jnode.val();}
	else{text=jnode.text();}
	
	if(!totext){return parseFloat(text);}
	else{return text;}
}

function write_one(jid,value){
	var jnode=$(jid);
	
	if(jnode.prop("tagName").toLowerCase()=="input"){
		if(jnode.hasClass("store")){
			jnode.attr("value",value);
		}
		else{
			jnode.val(value);
		}
		jnode.change(function(){input_change(this)});
	}
	else{
		if(jnode.text()!=value.toString()){
			jnode.text(value);
		}
	}
}

function add_row(inTableNode){
	var jnode=$(inTableNode);
	var jTable=jnode.closest("table");
	var jHeads=jTable.find("thead th");
	var jCols=jTable.find("tfoot tr:first-child td");
	var jNewRow=jTable.find("tfoot tr.template td").clone();
	var jNewCol;
	var i;
	
	for(i=0;i<jHeads.length;i++){
		jNewCol=$(jNewRow.get(i));
		jNewCol.addClass($(jHeads.get(i)).text());
		write_one(get_one(jNewRow.get(i)),copy_one(jCols.get(i),true));
		
		if(get_one(jNewRow.get(i)).prop("tagName").toLowerCase()=="input"){
			get_one(jNewRow.get(i)).change();
		}
	}
	
	jTable.find("tbody").append($(tableRow).addClass("sortable").append(jNewRow));
}


// View
function show_tab(node,id){
	$(".tabs .tab").hide();
	$("#"+id).show();
	$(node).siblings(".w3-theme-dark").removeClass("w3-theme-dark");
	$(node).addClass("w3-theme-dark");
}

function add_sign(numText,mode){
	var number=parseFloat(numText);
	if(number>0){return "+"+number.toString();}
	else if(number==0){return mode.toString()+number.toString();}
	else{return numText;}
}

function calculate(idx,node){
	var jnode=$(node);
	var res=eval_with_this(jnode,jnode.data("eval"));
	
	write_one(jnode,res);
}

function sum_node(jnodes){
	var s=0;
	jnodes.each(function(){
		s=s+copy_one(this);
	});
	
	return s;
}

function make_value(node){
	var jnode=$(node);
	var jblock=jnode.closest(".block");
	var nodes=$();
	
	jblock.find(".indvars .box").find(".value[type='checkbox']:checked").siblings(".value[data-mod]").each(function(){
		if(eval_with_this($(this),$(this).data("mod")).index(jnode)>=0){nodes=nodes.add($(this));}
	});
		
	jblock.find(".depvars .box input.value[data-mod]").not("*[readonly]").each(function(){
		nodes=nodes.add($(this));
	});
	
	return sum_node(nodes);
}

function carrying_capacity(num){
	if(num<=10){return 10*num}
	else{
		switch(num%10){
			case 0:
				return 25*Math.pow(4,Math.floor(num/10));
			case 1:
				return 28.75*Math.pow(4,Math.floor(num/10));
			case 2:
				return 32.5*Math.pow(4,Math.floor(num/10));
			case 3:
				return 37.5*Math.pow(4,Math.floor(num/10));
			case 4:
				return 43.75*Math.pow(4,Math.floor(num/10));
			case 5:
				return 50*Math.pow(4,Math.floor(num/10));
			case 6:
				return 57.5*Math.pow(4,Math.floor(num/10));
			case 7:
				return 65*Math.pow(4,Math.floor(num/10));
			case 8:
				return 75*Math.pow(4,Math.floor(num/10));
			case 9:
				return 87.5*Math.pow(4,Math.floor(num/10));
		}
		return "**"
	}
}

function state(num,values,maps,other){
	var i;
	
	for(i=0;i<values.length;i++){
		if(num<=values[i]){
			return maps[i];
		}
	}
	
	return other;
}

function sum_product(ja1,ja2){
	var s=0,i;
	for(i=0;i<Math.min(ja1.length,ja2.length);i++){
		s=s+(copy_one(ja1.get(i))*copy_one(ja2.get(i)));
	}
	
	return s;
}


// Controller
var MutationObserver = window.MutationObserver || window.WebKitMutationObserver || window.MozMutationObserver;
var config={characterData:true,childList:true,subtree:true};
var observe=new MutationObserver(function(mutations){
	mutations.forEach(function(item){
		var jnode=$(item.target);
		
		input_mod_data(jnode);
		input_ref_data(jnode);
		
		if(item.type=="attributes"){alert(item.attributeName);}
	});
});

function input_change(node){
	var jnode=$(node);
	
	if(jnode.hasClass("store")){
		write_one(jnode,copy_one(jnode));
	}
	
	input_mod_data(jnode);
	input_ref_data(jnode);
}

function input_mod_data(jnode){
	if(jnode.data("mod")){
		eval_with_this(jnode,jnode.data("mod")).each(calculate);
	}
}

function input_ref_data(jnode){
	var id;
	
	if(jnode.closest("table").length>0){
		id=jnode.closest("table").prop("id");
	}else{
		id=jnode.prop("id");
	}
	
	$("*[data-ref~='"+id+"']").each(calculate);
}

// Old
function edit_content(){
	alert("Edit Context.");
}

function edit_HTML(){
	jnode=$(".edit[data-stat='act']");
	jnode.data({"method":"HTML"});
	var input=jnode.html();
	jnode.empty();
	var textarea=$("<textarea contextmenu=\"write-menu\" style=\"width: 100%; resize: vertical\" />").text(input);
	jnode.append(textarea);
}

function write_edit(){
	jnode=$(".edit[data-stat='act']");
	if(jnode.data("method")=="HTML"){
		var input=jnode.children("textarea").val();
		jnode.html(input);
		jnode.removeData("method");
	}
	jnode.attr("data-stat","inact");
}

function test(node){
	/*
	var jbox=$(box);
	var jtitle=$(title);
	var jvalue1=$(tempVal),jvalue2=$(value),jvalue3=$(value);
	
	jtitle.text("測試值");
	jvalue1.attr("value",5);
	jvalue2.text("/");
	jvalue3.text(8);
	jbox.append(jtitle,jvalue1,jvalue2,jvalue3);
	
	$(node).append(jbox);
	*/
	/*
	var IDs=[],out=[],oldDepth=2,newDepth,diffDepth,tempText;
	$("*[id]").each(function(){
		//if(/\w/.test(this.id) || this.id.endsWith('區')){}
		//else{IDs.push(this.id);}
		
		if($.inArray(this.id,IDs)>-1){tempText="<span class=\"w3-tag w3-border w3-theme-heavy\" style=\"color:red;\">"+this.id+"</span>";}
		else{tempText="<span class=\"w3-tag w3-border w3-theme-light\" style=\"color:red;\">"+this.id+"</span>";}
		
		newDepth=$(this).parents().length;
		diffDepth=newDepth-oldDepth;
		
		if(diffDepth<0){tempText="</div>".repeat(Math.abs(diffDepth))+tempText;}
		else if(diffDepth>0){tempText="<div style=\"margin-left:1em;\">".repeat(Math.abs(diffDepth))+tempText;}
		
		IDs.push(this.id);
		out.push(tempText);
		oldDepth=newDepth;
	});
	
	IDs.push("</div>".repeat(oldDepth-2));
	
	$(node).html(out.join(" "));
	*/
}
