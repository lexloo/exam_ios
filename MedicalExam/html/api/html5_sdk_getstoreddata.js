(function() {
    // 已废弃
    if (typeof iTek == 'undefined') {
        iTek = {};
    }
    iTek.workflow = iTek.workflow || {};
    var workflow = iTek.workflow;

    workflow.getApprovalMenu = function(cbSucc) {
        iTek.local.getStoredData('getApprovalMenu',cbSucc);
    };

    workflow.getFormInfo = function(id,cbSucc,cbErr) {
        var param = {};
        param.arg_0 = id;
        iTek.local.getStoredData('getFormInfo',cbSucc,cbErr,param);
    };

})();
