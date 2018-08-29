var testEditor;
var area=0;
var format=0;
$(function() {
    $("#switch").click(function () {
        if(area===0){
            $("#editortxt").fadeOut();
            $("#image").fadeOut();
            $("#txtitle").fadeOut();
            $("#mdtitle").fadeIn();
            $("#editormd").fadeIn();
            $("#mdcontent");
            $("#title").val("");
            $("#content").val("");
            if(format===0) {
                testEditor = editormd("editormd", {
                    width: "98%",
                    height: 900,
                    syncScrolling: "single",
                    path: "../lib/",
                    saveHTMLToTextarea : true
                });
                format=1;
            }
            area=1;
        }else{
            $("#mdcontent").val("");
            $("#mdtitle").val("").fadeOut();
            $("#editormd").fadeOut();
            $("#editortxt").fadeIn();
            $("#image").fadeIn();
            $("#txtitle").fadeIn();
            $("#title");
            $("#content");
            area=0;
        }
    });
});