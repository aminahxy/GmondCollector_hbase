function SubmitRecord() {
    var ExitOfFailedValidation = false;
    if (!AllFieldsValidatedCheck()) {
        return ExitOfFailedValidation;
    }
    var qbapi = new QuickBaseAPI("bgtvmymbq", null);
    qbapi.setField("First Name", $("#firstname").val());
    qbapi.setField("Last Name", $("#lastname").val());
    qbapi.setField("E-Mail", $("#email").val());

    var recordId = qbapi.AddRecord();
    if (recordId > 0) {
        $("#thankyouMsg").show();
        $("#customerinfo").hide();
    }
    else {
        $("#errorMsg").show();
        $("#customerinfo").hide();
    }
}
function AllFieldsValidatedCheck() {
    var hasNoErros = true;
    if ($("#firstname").val() == "") {
        $("#firstname_error").show();
        hasNoErros = false;
    }
    else {
        $("#firstname_error").hide();
    }
    if ($("#lastname").val() == "") {
        hasNoErros = false;
        $("#lastname_error").show();
    }
    else {
        $("#lastname_error").hide();
    }
    if (!IsValidEmailFormat($("#email").val())) {
        hasNoErros = false;
        $("#email_error").show();
    }
    else {
        $("#email_error").hide();
    }
    return hasNoErros;
}
function IsValidEmailFormat(email) {
    var status = false;
    var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
    if (email.search(emailRegEx) != -1) {
        status = true;
    }
    return status;
}