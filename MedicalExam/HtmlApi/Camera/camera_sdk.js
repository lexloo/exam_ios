// 已废弃
function CameraOperate(){

    this.id;
    this.useFront = false;

    var images;
    var finalCbSucc;

    this.captureImage = function(cbSucc,cbErr){
        finalCbSucc = cbSucc;
        var option = {};
        option.useFront = this.useFront;
        iTek.camera.captureImage(option,afterImageSucc,cbErr);
    };

    this.getImages = function(){
        return images;
    };

    var afterImageSucc = function(data){
        var imageName = data["imgName"];
        if(images){
            images = images+","+imageName;
        }else{
            images = imageName;
        }
        var imageData = data["imgBase64Data"];
        if(typeof finalCbSucc == 'function'){
            finalCbSucc(imageName,"data:image/jpg;base64,"+imageData);
        }else{
            alert("cbSucc is not a function.");
        }
    };

};