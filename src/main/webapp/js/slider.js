/**
 * Created by sccy on 2018/3/28/0028.
 */
window.onload=function(){
    var As = document.getElementById('tonal').getElementsByTagName('a');
    var obj = As[0];
    for (var i = 1; i < As.length; i++) {
        if (window.location.href.indexOf(As[i].id) >= 0)
            obj = As[i];
    }
    obj.id='tonal_current';
};

function ajax(data,url,callback) {
    $.ajax({
        type:"POST",
        dataType:"json",
        data:data,
        url:url,
        success:function (result) {
            callback(result);
        },
        error:function (err) {
            alert("操作出现错误!");
            console.log(err);
        }
    })
}
