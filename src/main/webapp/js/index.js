/**
 * Created by sccy on 2018/4/3/0003.
 */
window.onload = function () {
    function nav() {
        var As = document.getElementById('tonal').getElementsByTagName('a');
        var obj = As[0];
        for (var i = 1; i < As.length; i++) {
            if (window.location.href.indexOf(As[i].id) >= 0)
                obj = As[i];
        }
        obj.id='tonal_current';
    }
    function order() {
        var A = document.getElementById('order').getElementsByTagName('a');
        var obj = A[0];
        for (var i = 1; i < A.length; i++) {
            if (window.location.href.indexOf(A[i].id) >= 0)
                obj = A[i];
        }
        obj.id='order_current';
    }
    nav();
    order();
};