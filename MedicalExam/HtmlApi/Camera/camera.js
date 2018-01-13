// 已废弃
 function Camera(){
 	/**
 	 * 最多拍摄照片数量
 	 */
 	var maxSize=99;
 	/**
 	 * 是否开启水印
 	 */
 	var isOpenWatermark=false; 
 	var id;
 	var viewid;
 }
 Camera.prototype={
 	/**
 	 * 相机的初始化方法
 	 * viewid 是承载相机控件的div id 
 	 * id 唯一值
 	 * maxSize 最大拍摄数量
 	 */
 	init:function(viewid,id,maxSize){
 		var $this=this;
 		this.viewid=viewid;
 	    this.id=viewid;
 	    this.pics=[];
 		if(maxSize!=null&&maxSize>0){
 			$this.maxSize=maxSize;
 		}
 		var tpl='<div class="row  image-list none activi-img" id="imgitem_'+viewid+'" style="width: 100%;align: center;margin-top: 10px;">'
 		    +'<div id="startCamera_'+viewid+'" class="image-item add" ></div>'
			+'<div id="del_'+viewid+'" class="image-item del"></div></div>';
		var cameraDiv=document.getElementById(viewid);
		cameraDiv.innerHTML=tpl;
		/**
		 * 添加图片监听
		 */
		$("#startCamera_"+viewid).click(function(){
			$this.startCarmera(viewid,$this.maxSize);
			event.stopPropagation();
		});
		/**
		 * 删除图片监听
		 */
		$("#del_"+viewid).click(function(){
			$this.showDel(viewid);
			event.stopPropagation();
		});
 	},
 	/**
 	 * 相机考试初始化方法
 	 * viewid 是承载相机控件的div id 
 	 * id 唯一值
 	 * maxSize 最大拍摄数量
 	 */
 	initExam:function(view,viewid,id){
 		var $this=this;
 		this.viewid=viewid;
 	    this.id=viewid;
 		$this.maxSize=99;
 		this.pics=[];
 		var tpl=$('<div class="row  image-list none activi-img" id="imgitem_'+viewid+'" style="width: 100%;align: center;margin-top: 10px;">').appendTo(view);
		var add=$('<div id="startCamera_'+viewid+'" class="image-item add" ></div>').appendTo(tpl);
		var del=$('<div id="del_'+viewid+'" class="image-item del"></div></div>').appendTo(tpl);
		/**
		 * 添加图片监听
		 */
		add.on('click',function(event){
			$this.startCarmera(viewid,$this.maxSize);
			event.stopPropagation();
		});
		/**
		 * 删除图片监听
		 */
		del.on('click',function(event){
			$this.showDel(viewid);
			event.stopPropagation();
		});
 	},
   startCarmera:function (viewid,maxSize){
   			var $this=this;
  			var domList=$("#imgitem_"+viewid).find("*[id^=Img_]");
  			if(domList!=null&&domList.length>=maxSize){
  				mui.toast('图片最多为'+maxSize+"张!",{ duration:'long', type:'div' }) 
  				return;
  			}
 			var params={};
 			params.viewId=$this.id;
 			iTek.camera.startCamera(params,function(result){
 				if(result!=null){
 					var name=result.name;
 					var path=result.path;
 					$this.saveImg(name,path);
 				}
 			},function(result){
 				
 			});
 	},
 	saveImg :function (name,path){
 			var $this=this;
 			var html = "";  
            	html +='<div  id="Img_'+name+'" class="image-item">';  
            	html +='    <img id="picBig_'+name+'" src="'+path+'">';  
                html +='    <span id="del_img_'+name+'" class="orp">';         
           		html +='        <div class="orp-bg"></div>';      
            	html +='    </span>';  
           	 	html +='</div>';
           	 $("#del_"+$this.viewid).before(html);  
           	 $this.pics.push(name);
           	 $("#del_img_"+name).click(function(){
           	 	if(path.indexOf("http")>=0){
           	 		$("#Img_"+name).remove();
 					$this.pics.splice($.inArray(name,$this.pics),1);
 					$("#del_"+$this.viewid).show();
 					$("#imgitem_"+$this.viewid).addClass("none");
           	 		return;
           	 	}
           	 	$this.delImg(name);
           	 });
           	 $("#picBig_"+name).click(function(){
           	 		T.showBigImg(path);
           	 });
 	},
 	 showDel:function (viewId){
 		var domList=$("#imgitem_"+viewId).find("*[id^=Img_]");
 		if(domList!=null&&domList.length>0){
 			$("#del_"+viewId).hide();
 			$("#imgitem_"+viewId).removeClass("none");
 		}else{
 			 mui.toast('没有图片无法删除',{ duration:'long', type:'div' }) 
 		}
 	},
 	 /**
 	 * 刪除照片
 	 */
 	delImg :function (name,path){
 		var pics=this.pics;
 		var $this=this;
 		var parmas={};
 		parmas.viewid=$this.viewid;
 		parmas.name=name;
 		iTek.camera.delImg(parmas,function(result){
 			if(result!=null){
 				var name=result.name;
 				$("#Img_"+name).remove();
 				pics.splice($.inArray(name,pics),1);
 			}
 			$("#del_"+$this.viewid).show();
 			$("#imgitem_"+$this.viewid).addClass("none");
 		},function(result){
 			if(result!=null){
 				mui.toast('删除失败！',{ duration:'long', type:'div' }) 
 			}
 			$("#del_"+$this.viewid).show();
 			$("#imgitem_"+$this.viewid).addClass("none");
 		});
 	},
 	/*
 	 *删除指定控件的所以图片 
 	 */
 	delAll:function(){
 		var parmas={};
 		parmas.id=this.id;
 		iTek.camera.delImg(parmas);
 	},
	getPics:function(){
		return this.pics.join(",");
	},setPics:function(pics){
		$that=this;
		if(!pics||pics==""){
			return;
		}
		var strs=pics.split(",");
		$.each(strs,function(){
				var strs=this.replace(",","");
//				var basePath="http://121.199.44.59:8088/datacache/imgcache/"+strs+".jpg";
				var basePath="http://sfa.itfsm.com/datacache/imgcache/"+strs+".jpg";
				$that.saveImg(strs,basePath);
		});
	},
	getCameraId:function(){
		return this.id;
	},
	validate:function(){
		if(this.pics.length>0){
			return true;
		}else{
			mui.toast("请拍摄照片!",{ duration:'long', type:'div' });
			return false;
		}
	}
 }

 	

 
