$(function () {
   if($("#isLike").val()==1)
       $("#like").css('color','#dc3545');
   $("#like_btn").click(function () {
       var blogId =$("#blogId").val();
       var usrId =$("#usrId").val();
       var data = {'blogId':blogId,'usrId':usrId,'pageNo':1};
       ajax(data,'like',function () {
            if($("#isLike").val()==1)
                $("#isLike").val(0);
            else
                $("#isLike").val(1);
            var val = parseInt($("#likeCount").val());
           if($("#isLike").val()==0) {
               $("#like").css('color', '#fff');
               val-=1;
               $("#likeCount").val(val);
               $("#like").text(val);
           }
           else {
               $("#like").css('color', '#dc3545');
               val+=1;
               $("#likeCount").val(val);
               $("#like").text(val);
           }
       })

   });

    if($("#isStar").val()==1)
        $("#star").css('color','#dc3545');
    $("#star_btn").click(function () {
        var blogId =$("#blogId").val();
        var usrId =$("#usrId").val();
        var data = {'blogId':blogId,'usrId':usrId,'pageNo':1};
        ajax(data,'star',function () {
            if($("#isStar").val()==1)
                $("#isStar").val(0);
            else
                $("#isStar").val(1);
            var val = parseInt($("#starCount").val());
            if($("#isStar").val()==0) {
                $("#star").css('color', '#fff');
                val-=1;
                $("#starCount").val(val);
                $("#star").text(val);
            }
            else {
                $("#star").css('color', '#dc3545');
                val+=1;
                $("#starCount").val(val);
                $("#star").text(val);
            }
        })

    })
});