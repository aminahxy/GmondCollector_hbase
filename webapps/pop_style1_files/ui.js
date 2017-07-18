///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ui.js -- core ui javascript //
/////////////////////////////////
//////////////////////////
// The EventSink Object //
//////////////////////////////////////////////////////////////////////////////
var EventSink = function () {
    this.events = Array();
}
// Method for subscribing to events
EventSink.prototype.SubscribeTo = function (EventName, Callback, OptionalTag) {
    var newEventSubs = { "EventName": EventName, "Callback": Callback, "OptionalTag": OptionalTag }
    this.events[this.events.length] = newEventSubs;
    return newEventSubs;
}

// Method for raising events
EventSink.prototype.RaiseEvent = function (EventName, Sender, Args, Callback) {
    // Iterate through the events and find the matching items
    for (i = 0; i < this.events.length; i++) {

        if (EventName == this.events[i].EventName) {
            // consumers can provide either raw JS code or functions
            // as callbacks -- we check to see which we have and
            // call as appropriate       
            if (typeof this.events[i].Callback == 'function') {
                this.events[i].Callback(Sender, EventName, Args);
            }
            else {
                eval(this.events[i].Callback);
            }
        }
    }
    if (typeof Callback == "function") {
        Callback(Args);
    }

}


/////////////////////////
// IntuitUICOre object //
//////////////////////////////////////////////////////////////////////////////////

/*** DEFINITIONS ***/
var ESC_KEY = 27;
var ARROW_DN_KEY = 40;
var ARROW_UP_KEY = 38;
var ENTER_KEY = 13;

var IntuitUICore = function () {
    this.__initcore();
    return this;
}

IntuitUICore.AjaxHistoryCookieName = 'ajaxHistory';
IntuitUICore.redirectHintString = '#ps';
// bool for whether we've already initialized
IntuitUICore.prototype.__initialized = false;
// holds the core container -- the top window preferably
IntuitUICore.prototype.coreContainer = Object();

// Initializes the core
IntuitUICore.prototype.__initcore = function () {
    if (!this.__initialized) {
        this.coreContainer = this.GetTopWindow();
        this.__initialized = true;
        this.PerformHintRedirect();
        this.ApplicationRoot = "/support";
        // ----- DEPRECATED ------        
        //        $(document).ready(function() 
        //        { 
        //            Intuit.ReplayAjaxHistory();
        //        });
    }
}

// for relative pathing, allows the app to store the application root
IntuitUICore.prototype.SetApplicationRoot = function (ApplicationRoot) {
    ApplicationRoot = ApplicationRoot.toString();
    if (ApplicationRoot.length >= 1 &&
        ApplicationRoot.indexOf('/', 1) == ApplicationRoot.length - 1) {
        ApplicationRoot = ApplicationRoot.substr(0, ApplicationRoot.length - 1);
    }
    this.ApplicationRoot = ApplicationRoot;
}

// Helper -- gets the top window, and we are making sure that 
// it is possible to call a page within an iframe from a different domain
IntuitUICore.prototype.GetTopWindow = function () {
    var wnd = window;
    var startDomain = wnd.document.domain;
    var parrentDomain = "";

    while (wnd.parent != wnd) {
        try {
            parrentDomain = wnd.parent.document.domain;

            if (parrentDomain == startDomain)
                wnd = window.parent;
        }
        catch (e) {
            return wnd;
        }
    }

    return wnd;
}


//////////////////////////
// Event Sink Functions //
//////////////////////////////////////////////////////////////////////////////
// Set the EventSink on the core 
IntuitUICore.prototype.EventSink = new EventSink();
// Helper method pointing to the EventSink for convenience
IntuitUICore.prototype.SubscribeTo = function (EventName, Callback, OptionalTag) {
    return this.EventSink.SubscribeTo(EventName, Callback, OptionalTag);
}
// Helper method pointing to the EventSink for convenience
IntuitUICore.prototype.RaiseEvent = function (EventName, Sender, Args, Callback) {
    return this.EventSink.RaiseEvent(EventName, Sender, Args, Callback);
}


//////////////////
// UI Functions //
//////////////////////////////////////////////////////////////////////////////

// Renders an item "disabled" by graying it out
IntuitUICore.prototype.RenderDisabled = function (ContainerID, _color) {
    //alert("render Disable");
    var isFullPage = false;
    if (null != ContainerID && ContainerID == "fullpage") {
        var BodyID = $("body").attr("id");
        if (null == BodyID || BodyID == "") {
            BodyID = "IntuitBody";
            $("body").attr("id", BodyID);
        }
        ContainerID = BodyID;
        isFullPage = true;
    }
    if (null != ContainerID) {
        var obj = document.getElementById(ContainerID);
        if (obj) {
            var h1 = document.getElementById(ContainerID).offsetHeight;
            var w1 = document.getElementById(ContainerID).offsetWidth;
            var newDivId = this.InsertGrayDiv(ContainerID);
            if (newDivId) {
                var gs = document.getElementById(newDivId);

                if (null != _color) {
                    switch (_color) {
                        case "white": gs.className = "darkClassWhite"; break;
                        case "black": gs.className = "darkClassBlack"; break;
                        case "red": gs.className = "darkClassRed"; break;
                        case "green": gs.className = "darkClassGreen"; break;
                        case "blue": gs.className = "darkClassBlue"; break;
                        default: break;
                    }
                }
                else
                    gs.className = "darkClassWhite";

                if (isFullPage) {
                    var CurrentPageHeight = $(document).height() + "px";
                    var CurrentPageWidth = $(document).width() + "px";

                    gs.style.height = CurrentPageHeight;
                    //gs.style.height = "100%";
                    //gs.style.width = "100%";
                    gs.style.width = CurrentPageWidth;
                    gs.style.position = "fixed";
                }
                else {
                    gs.style.height = h1 + 10 + "px";
                    gs.style.width = w1 + "px";
                }
            }
        }
    }
}

// enables a previously disabled element
IntuitUICore.prototype.RenderEnabled = function (ContainerID) {
    //alert("render Enable");
    if (null != ContainerID && ContainerID == "fullpage") {
        var BodyID = $("body").attr("id");
        if (null == BodyID || BodyID == "") {
            BodyID = "IntuitBody";
            $("body").attr("id", BodyID);
        }
        ContainerID = BodyID;
    }
    if (null != ContainerID) {
        var divId = ContainerID + 'grayed';
        while (rdiv = document.getElementById(divId)) {
            var parentdiv = document.getElementById(ContainerID);
            if (parentdiv) {
                try {

                    parentdiv.removeChild(rdiv);
                }
                catch (err)
                { }
            }
        }
    }
}

IntuitUICore.prototype.InsertGrayDiv = function (divid) {
    var newdiv = document.createElement("div");
    if (newdiv) {
        var parentdiv = document.getElementById(divid);
        if (parentdiv) {
            var GrayDivID = divid + 'grayed';

            newdiv.setAttribute('id', GrayDivID);
            if (parentdiv.childNodes.length > 0) {
                parentdiv.insertBefore(newdiv, parentdiv.childNodes[0]);
            }
            else {
                parentdiv.appendChild(newdiv);
            }
        }
    }
    return GrayDivID;
}

////////////////////////////////
// Product Selection Functions //
////////////////////////////////////////////////////////////////////////////////
// Set our default productId
IntuitUICore.prototype.ProductId = -1;
IntuitUICore.prototype.SetProductSelectionAndRedirect = function (ProductId, Url) {
    this.SetProductSelection(ProductId, function () { location.href = Url; });
}

// Sets the Selected Product, Server side, then calls the supplied callback
IntuitUICore.prototype.SetProductSelection = function (ProductId, callback) {
    //    this.AddHistoryItem("Intuit.RaiseEvent('ProductSelectionChanging');"+
    //    "Intuit.SetProductSelection("+ProductId+",function() { Intuit.RaiseEvent('ProductSelectionChanged'); });");
    this.Load(this.ApplicationRoot + "/ajaxReceivers/ProductSelectionController.aspx?ProductID=" + ProductId, function (data) {
        if (data == "OK") {
            this.ProductId = ProductId;
        }
        if (callback) {
            if (typeof callback == 'function') {
                callback(data, ProductId);
            }
            else {
                eval(callback);
            }
        }
    });
    this.AddRedirectHint();
}

// This function is used to prevent clicking the back button after changing the product.
// When the product selector finishes, it sends the user to whatever page he or she was on followed by the
// hash of "#ps" (represented here by IntuitUICore.redirectHintString). This function looks at the current document
// location  to determine if the URL contains the #ps, and redirects it to the same URL without the #ps.
IntuitUICore.prototype.PerformHintRedirect = function () {
    if (document.location.hash && document.location.hash.indexOf(IntuitUICore.redirectHintString) != -1) {
        location.replace(location.href.substr(0, document.location.href.indexOf(IntuitUICore.redirectHintString)));
    }
}

IntuitUICore.prototype.AddRedirectHint = function () {
    if (!document.location.hash || document.location.hash.indexOf(IntuitUICore.redirectHintString) == -1) {
        document.location.hash += IntuitUICore.redirectHintString.substr(1);
    }
}



//////////////////////
// COOKIE Functions //
////////////////////////////////////////////////////////////////////////////////
IntuitUICore.prototype.SetCookie = function (name, value, expiredays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + expiredays);
    document.cookie = name + "=" + escape(value) + ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString());

}

IntuitUICore.prototype.GetCookie = function (name) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(name + "=");
        if (c_start != -1) {
            c_start = c_start + name.length + 1;
            c_end = document.cookie.indexOf(";", c_start);
            if (c_end == -1) c_end = document.cookie.length;
            return unescape(document.cookie.substring(c_start, c_end));
        }
    }
    return "";
}

//SEARCH WAS HERE


////////////////////
// AJAX Functions //
////////////////////////////////////////////////////////////////////////////////


IntuitUICore.prototype.ReloadPartial = function (targetId, callback) {
    this.LoadPartial(window.location, targetId, callback);
}

IntuitUICore.prototype.LoadPartial = function (Url, targetId, callback) {
    var loc = Url.toString();
    var strtot = "";
    var qsa = "&intupartial=true&partialid=" + targetId;
    if (this.ProductId != 0) {
        qsa + "&ProductId=" + this.ProductId;
    }
    var rand_no = Math.random();
    qsa += "&" + rand_no;
    var idx = loc.length;
    if (loc.indexOf("#") != -1) {
        idx = loc.indexOf("#");
    }

    if (loc.indexOf("?") == -1) {
        loc = loc.insert("?", idx);
        idx++;
    }
    loc = loc.insert(qsa, idx);
    var _this = this;

    this.Load(loc, function (data) {
        _this.ReplaceContentWith(targetId, data);
        //$("#"+targetId).replaceWith(data);
        if (callback) callback(data);
    });

}

IntuitUICore.prototype.ReplaceContentWith = function (targetId, data) {
    //    if (document.location.href.toString().indexOf('?')==-1)
    //        document.location.href+="?";
    //    var hash = document.location.hash;
    //    document.location.hash = hash+targetId+",";
    //    location.replace(location);

    $("#" + targetId).replaceWith(data);
}

IntuitUICore.prototype.Load = function (Url, callback) {
    //alert("loading "+Url);
    $.get(Url, function (data) {
        if (callback) callback(data);
    });
}

IntuitUICore.prototype.AddHistoryItem = function (jsToExecute) {
    var cookie = this.GetCookie(IntuitUICore.AjaxHistoryCookieName);
    cookie += jsToExecute;
    this.SetCookie(IntuitUICore.AjaxHistoryCookieName, cookie, 1);
}

IntuitUICore.prototype.ReplayAjaxHistory = function () {
    var cookie = this.GetCookie(IntuitUICore.AjaxHistoryCookieName);
    if (cookie && cookie.length > 0) {
        this.SetCookie(IntuitUICore.AjaxHistoryCookieName, "", 1);
        eval(cookie);
    }
}


/////////////////////////////
// Initialization/Creation //
////////////////////////////////////////////////////////////////////////////////
// Factory for creating only 1 core object
IntuitUICore.Create = function () {
    // Gets the IntuitUICore object stored at the top window
    var singleton = new IntuitUICore().GetTopWindow().intuitcore;
    // if not found, we'll created it
    if (null == singleton) {
        var core = new IntuitUICore();
        core.GetTopWindow().intuitcore = new IntuitUICore();
        singleton = core;
    }
    return singleton;
}

// Globally available Core object
var Intuit = IntuitUICore.Create();





//////////////////
// String Proto //
////////////////////////////////////////////////////////////////////////////////
String.prototype.insert = function (str, at) {
    if (at > this.length)
        throw "Index is greater than length";
    return this.substr(0, at) + str + this.substr(at);
}
String.prototype.trim = function () {
    return (this.replace(new RegExp("^([\\s]+)|([\\s]+)$", "gm"), ""));
}
// Give string object the left trim method.
String.prototype.leftTrim = function () {
    return (this.replace(new RegExp("^[\\s]+", "gm"), ""));
}
// Give string object the right trim method.
String.prototype.rightTrim = function () {
    return (this.replace(new RegExp("[\\s]+$", "gm"), ""));
}
/*Build Ethnio script*/
function BuildEthnio() {
    var target = $("#Ethnio_Campaign").attr("rel");
    if (null != target && target != "") {
        var EthnioString = '<script language="javascript" src=parent.location.protocol + "//ethnio.com/remotes/' + target + '" type="text/javascript"></script>';

        $("body").append(EthnioString);
    }
}
/*Closed Loop Feedback Tagging*/
var closedloopEmail = "";
var ClosedLoopTargetKB = "";
var closedLoopTitle = "";
var CustomerName = "";
function BuildClosedLoopFeedback() {
    var Tag = $("#ClosedLoopFeedback");
    if (Tag.length > 0) {
        var ajaxLoaderImg = "<div style=\"width: 100%;\"><center><img src=\"/Support/images/AjaxLoaders/ajax-loader.gif\"/></center></div>";
        var TargetKB = Tag.attr("rel");
        ClosedLoopTargetKB = TargetKB;
        var Title = $("title").html();
        Title = Title.replace("QuickBooks Support -", "");
        Title = Title.trim();
        Title = $.URLEncode(Title);
        closedLoopTitle = Title;

        var ProxyUrl = "/Support/MyAccount/proxy/ClosedLoopFeedback.aspx?kb=" + TargetKB + "&action=check&title=" + Title + "&email=" + closedloopEmail;

        if (null != $.cookie("Intuit.QuickBooks.Support.KBContainment")) {

            var emailArticleComboString = $.cookie("Intuit.QuickBooks.Support.KBContainment");
            //alert("String: " + emailArticleComboString + " - Current Article: " + TargetKB);

            var emailArticleComboList = emailArticleComboString.split(":");
            var cookieEmail = emailArticleComboList[0];
            CustomerName = emailArticleComboList[1];
            closedloopEmail = cookieEmail;
            var articleList = emailArticleComboList[2].split(",");

            //alert(articleList.length + ", " + articleList[0]);

            if (TargetKB != "") {

                var currentArticleIsPresent = false;

                for (i = 0; i < articleList.length; i++) {
                    if (TargetKB == articleList[i]) {
                        currentArticleIsPresent = true;
                    }
                }

                if (currentArticleIsPresent) {
                    ProxyUrl = "/Support/MyAccount/proxy/ClosedLoopFeedback.aspx?kb=" + TargetKB + "&action=isSubscribed&title=" + Title + "&email=" + closedloopEmail;
                }
            }
        }

        //alert("Proxy URL: " + ProxyUrl);

        Tag.html(ajaxLoaderImg);
        Tag.load(ProxyUrl + " #ClosedLoopFeedbackContent");
    }
}
/*Closed Loop Feedback ajax calls for proxy postbacks*/
function PostClosedLoopFeedback(TargetKB, Action, Email) {
    //alert(Email);
    var Tag = $("#ClosedLoopFeedback");
    if (Tag.length > 0) {
        var ajaxLoaderImg = "<div style=\"width: 100%;\"><center><img src=\"/Support/images/AjaxLoaders/ajax-loader.gif\"/></center></div>";
        var Title = $("title").html();
        Title = Title.replace("QuickBooks Support -", "");
        Title = Title.trim();
        Title = $.URLEncode(Title);

        var ProxyUrl = "/Support/MyAccount/proxy/ClosedLoopFeedback.aspx?kb=" + TargetKB + "&action=" + Action + "&title=" + Title + "&email=" + Email;

        var emailArticleComboString = $.cookie("Intuit.QuickBooks.Support.KBContainment");
        //alert(emailArticleComboString);
        var articleString = "";

        if (Action == "subscribe") {

            if (null != emailArticleComboString) {
                var emailArticleCombo = emailArticleComboString.split(":");
                //alert(emailArticleComboString);
                var cookieEmail = emailArticleCombo[0];
                closedloopEmail = Email;

                CustomerName = emailArticleCombo[1];

                articleString = emailArticleCombo[2];

                var articleList = articleString.split(",");

                if (articleList.length > 0 && TargetKB != "" && null != TargetKB) {

                    var currentArticleIsPresent = false;

                    for (i = 0; i < articleList.length; i++) {
                        if (TargetKB == articleList[i]) {
                            currentArticleIsPresent = true;
                        }
                    }

                    if (!currentArticleIsPresent) {
                        articleList.push(TargetKB);
                        articleString = "";

                        for (i = 0; i < articleList.length; i++) {
                            if (i < eval(articleList.length - 1)) {
                                articleString += articleList[i] + ",";
                            }
                            else {
                                articleString += articleList[i];
                            }
                        }

                        emailArticleComboString = Email + ":" + CustomerName + ":" + articleString;
                    }

                    //update cookie
                    if (articleString != "") {
                        $.cookie("Intuit.QuickBooks.Support.KBContainment", null);
                        $.cookie("Intuit.QuickBooks.Support.KBContainment", emailArticleComboString, { expires: 365 });
                    }
                }
            }

            else {
                //create cookie
                $.cookie("Intuit.QuickBooks.Support.KBContainment", Email + ":" + CustomerName + ":" + TargetKB, { expires: 365 });
            }
        }

        if (Action == "unsubscribe") {
            var emailArticleCombo = emailArticleComboString.split(":");

            var cookieEmail = emailArticleCombo[0];
            CustomerName = emailArticleCombo[1];
            articleString = emailArticleCombo[2];

            var articleList = articleString.split(",");
            var newArticleList = new Array();

            if (articleList.length > 0 && TargetKB != "" && null != TargetKB) {

                var currentArticleIsPresent = false;

                for (i = 0; i < articleList.length; i++) {
                    if (TargetKB == articleList[i]) {
                        currentArticleIsPresent = true;
                    }
                }

                if (currentArticleIsPresent) {
                    articleString = "";
                    var indexofTargetKb = 0;

                    for (i = 0; i < articleList.length; i++) {
                        if (articleList[i] != TargetKB) {
                            newArticleList.push(articleList[i]);
                        }
                    }

                    for (i = 0; i < newArticleList.length; i++) {
                        if (i < eval(newArticleList.length - 1)) {
                            articleString += newArticleList[i] + ",";
                        }
                        else {
                            articleString += newArticleList[i];
                        }
                    }

                    emailArticleComboString = cookieEmail + ":" + CustomerName + ":" + articleString;
                }

                //update cookie
                if (articleString != "") {
                    $.cookie("Intuit.QuickBooks.Support.KBContainment", null);
                    $.cookie("Intuit.QuickBooks.Support.KBContainment", emailArticleComboString, { expires: 365 });
                }
                else {
                    $.cookie("Intuit.QuickBooks.Support.KBContainment", null);
                }
            }

        }
        Tag.html(ajaxLoaderImg);
        Tag.load(ProxyUrl + " #ClosedLoopFeedbackContent");
    }
}
/*closedLoop Feedback button/login*/
function CLFSubscribeButton() {
    //create the modal popup
    $("#PagesContainer").append('<div id="ContingencyEmailBox" class="ModalPopup Modal_disablePage" rel="#iframe?url=/Support/Login/ContainmentEmailLightbox.aspx&scrolling=no&width=520&height=200&id=ContingencyEmailBoxIframe&param1=ContingencyEmailBoxIframe&param2=ContingencyEmailBox&param3=' + closedloopEmail + '&param4=' + ClosedLoopTargetKB + '&param5=' + closedLoopTitle + '&param6=' + CustomerName + '"></div>');
    var test = $("#ContingencyEmailBox").attr("rel");
    Intuit.CreateModal("hiddensignIn", "ContingencyEmailBox", true);

    Intuit.Modal.showModal("ContingencyEmailBox", function () { });

}
/*MyAccount Overview Widgets*/
function BuildOverviewWidget(TabId, DestinationContainerId) {
    var ContentPlaceHolder = $("#" + DestinationContainerId);
    var CurrentTabContentID = TabId + "Content";
    var buildDiv = "<div id=\"" + CurrentTabContentID + "\"></div>";

    ContentPlaceHolder.html("");
    ContentPlaceHolder.append(buildDiv);
    //BuildIndividualWidget(CurrentTabContentID, "Alert");
    BuildIndividualWidget(CurrentTabContentID, "Orders", "to view all your orders, order histories and statuses or to inquire about an order.");
    BuildIndividualWidget(CurrentTabContentID, "Articles", "to view all favorite articles, view all subscribed articles and updates, unsubscribe to articles and search favorites.");
    //BuildIndividualWidget(CurrentTabContentID, "Profile", "to view and edit your personal information, shipping informa&shy;tion, contact information and change your password.");
}
/*MyAccount individual widget*/
function BuildIndividualWidget(currentTabContentID, widgetName, purpose) {
    var widgetContainerId = widgetName + "Container";
    var widgetDivGenerate = "<div id=\"" + widgetContainerId + "\" style=\"width: 100%;\"><center><img src=\"/Support/images/AjaxLoaders/ajax-loader.gif\"/></center></div><br />";
    if (purpose != undefined) {
        widgetDivGenerate += "<div class='WidgetOverviewSummary'><div class='WidgetOverviewSummaryTopcap'><div class='WidgetOverviewSummaryTopLeft'/><div class='WidgetOverviewSummaryTopLine'/><div class='WidgetOverviewSummaryTopRight'/></div><div style='clear:both;'></div><div class='WidgetOverviewSummaryMainContentContainer'><div class='WidgetOverviewSummaryMainContent'>Go to \"<a href='javascript:void(0);' onclick=\"parent.BuildMyAccountTabContent('"
      + widgetName + "', 'MainContent', '/Support/MyAccount/proxy/" + widgetName + ".aspx', 490);SwitchTabsAndSelect($('#My" + widgetName + "'));\">My " + widgetName + "</a>\" " + purpose
      + "</div></div><div class='WidgetOverviewSummaryBottomcap'><div class='WidgetOverviewSummaryBottomLeft'/><div class='WidgetOverviewSummaryBottomLine'/><div class='WidgetOverviewSummaryBottomRight'/></div></div><div style='clear:both;'/>";
    }
    $("#" + currentTabContentID).append(widgetDivGenerate);

    WidgetAjaxCall(widgetName, widgetContainerId);
}
/*set the ajax call for Overview Widgets*/
function WidgetAjaxCall(widgetId, _destinationId) {
    var destination = $("#" + _destinationId);
    switch (widgetId) {
        case "Alert": destination.load("/Support/MyAccount/proxy/Alerts.aspx #AlertContent", function (responseText, textStatus) { ajaxCallComplete(responseText, textStatus, destination); }); break;
        case "Orders": destination.load("/Support/MyAccount/proxy/OrdersOverView.aspx #OrdersOverviewContent", function (responseText, textStatus) { ajaxCallComplete(responseText, textStatus, destination, "Orders"); }); break;
        case "Articles": destination.load("/Support/MyAccount/proxy/ArticlesOverView.aspx #ArticlesOverviewContent", function (responseText, textStatus) { ajaxCallComplete(responseText, textStatus, destination, "Articles"); }); break;
        case "Profile": destination.load("/Support/MyAccount/proxy/ProfileOverView.aspx #ProfileOverviewContent", function (responseText, textStatus) { ajaxCallComplete(responseText, textStatus, destination); }); break;
        default: alert("No Proper ID was inputed for the Widget");
    }
}
/*Activate the tabs and insert the content in an iframe*/
function BuildMyAccountTabContent(TabId, displayDestinationID, url, _width) {
    var iframeID = "";
    var iframeSource = "";
    var iframe = "";
    var AjaxSnakeGraphic = "<div id=\"AjaxSnakeGraphic\" style=\"width: 490px; position: absolute; z-index: 100;\"><center><img src=\"/Support/images/AjaxLoaders/ajax-loader.gif\"/></center></div>";
    var displayTarget = $("#" + displayDestinationID);
    var IFRAME_WIDTH = "";

    displayTarget.html("");
    displayTarget.html(AjaxSnakeGraphic);
    IFRAME_WIDTH = _width;

    if (null != TabId && TabId != "")
        iframeID = TabId + "Iframe";

    if (null != url && url != "")
        iframeSource = url;

    if (iframeSource != "" && iframeID != "") {
        //alert(displayTarget.attr("id"));
        iframe = "<iframe src=\"" + iframeSource + "\" frameborder=\"0\" id=\"" + iframeID + "\" enableviewstate=\"true\" scrolling=\"no\" width=\"" + IFRAME_WIDTH + "\"/>";
        displayTarget.append(iframe);
    }

}
/*Resize an Iframe to adjust the height according to the content*/
function ResizeContentIframe(frameId, newHeight) {
    $("#" + frameId).css("height", newHeight);
}

//URL Encode/Decode
$.extend({ URLEncode: function (c) {
    var o = ''; var x = 0; c = c.toString(); var r = /(^[a-zA-Z0-9_.]*)/;
    while (x < c.length) {
        var m = r.exec(c.substr(x));
        if (m != null && m.length > 1 && m[1] != '') {
            o += m[1]; x += m[1].length;
        } else {
            if (c[x] == ' ') o += '+'; else {
                var d = c.charCodeAt(x); var h = d.toString(16);
                o += '%' + (h.length < 2 ? '0' : '') + h.toUpperCase();
            } x++;
        }
    } return o;
},
    URLDecode: function (s) {
        var o = s; var binVal, t; var r = /(%[^%]{2})/;
        while ((m = r.exec(o)) != null && m.length > 1 && m[1] != '') {
            b = parseInt(m[1].substr(1), 16);
            t = String.fromCharCode(b); o = o.replace(m[1], t);
        } return o;
    }
});
//Tag Kb for 800#
function TagKb800() {
    var TagKb800 = $("#TagKb800");
    if (TagKb800.length > 0 && null != TagKb800) {
        //alert("hi");
        var TagKb800Rel = TagKb800.attr("rel");
        //alert(TagKb800Rel);
        if (null != TagKb800Rel && TagKb800Rel.toLowerCase() == "on") {
            $("#kb800Shell").fadeIn();
        }
    }
}

//Tag Kb chat
function chatTagKb() {
    var chatkbtag = $("#chatkbtag");

    if (chatkbtag.length > 0 && null != chatkbtag) {
        var chatkbtagRel = chatkbtag.attr("rel");
        if (null != chatkbtagRel && chatkbtagRel.toLowerCase() == "on") {
            $("#chatkbtagShell").fadeIn();
        }
    }
}

// Change function of enter key to the same behaviour as clicking on the passed in button.
function interceptEnterKey(event, button) {
    if (event.which == 13 && $("#" + button).length > 0) {
        $('#' + button).click();
        //document.getElementById('' + button).click();
        return false;
    }
    else {
        return true;
    }
}

jQuery.fn.nocomplete = function () {
    i = 0;
    d = new Date;
    time = d.getTime();
    return this.each(function () {
        newName = time + '' + i;
        oldName = this.name;
        this.name = newName;
        jQuery(this).keyup(function (e) {
            jQuery(this).next()[0].value = jQuery(this).attr('value');
        }).after('<input type="hidden" name="' + oldName + '" value="' + this.value + '" />');
        i++;
    });
};

$.fn.absolutePosition = function () {
    var output = new Object();
    var mytop = 0, myleft = 0;
    var obj = $(this).get(0);
    while (obj) {
        mytop += obj.offsetTop;
        myleft += obj.offsetLeft;
        obj = obj.offsetParent;

    }
    output.top = mytop;
    output.left = myleft;
    return output;
}

//*******************************************************************************
// POP-Under Window

function PopUnder(_url) {
    var currentwindow = this.window;
    var PopupOptions = "width=800,height=510,scrollbars=1,resizable=1,toolbar=1,location=1,menubar=1,status=1,directories=0";
    var PopupWindow = window.open(_url, "", PopupOptions);
    PopupWindow.blur();
    //setTimeout("function(){PopupWindow.blur();}", 5000);
    currentwindow.focus();
}
function CheckForSiteSurveyPopup(_modaltype, PageViews) {
    if (BrowserDetect.browser != "unknown_browser" && BrowserDetect.browser != "Firefox") {
        var _cookieValue = $.cookie("Intuit.QuickBooks.Support.SiteSurvey");
        var _PageTrackingCookie = $.cookie("Intuit.QuickBooks.PageCountTracker");

        if (null != _PageTrackingCookie && _PageTrackingCookie != "undefined") { //increment page views in session cookie
            var PageNumber = parseInt(_PageTrackingCookie) + 1;
            writeSessionCookie("Intuit.QuickBooks.PageCountTracker", PageNumber);
        }
        else { //create cookie and increment
            writeSessionCookie("Intuit.QuickBooks.PageCountTracker", 1);
        }

        if (null != _cookieValue && _cookieValue != "undefined") {
            return;
        }
        else {
            if (parseInt($.cookie("Intuit.QuickBooks.PageCountTracker")) == PageViews) {
                writePersistentCookie("Intuit.QuickBooks.Support.SiteSurvey", "1", "days", 7);
                _cookieValue = $.cookie("Intuit.QuickBooks.Support.SiteSurvey");

                //Pop the modal here
                if (_modaltype == "popunder") {
                    Intuit.CreateModal("hiddensignIn", "PopUnderModal", true);

                    var optinParam = $.getUrlVar('optin');

                    if (optinParam != "popunder") {
                        Intuit.Modal.showModal("PopUnderModal");
                    }
                }
            }
        }
    }
}
//****************************************************************************************
// Browser Detection algorithm 

//Browser name: BrowserDetect.browser
//Browser version: BrowserDetect.version
//OS name: BrowserDetect.OS

var BrowserDetect = {
    init: function () {
        this.browser = this.searchString(this.dataBrowser) || "unknown_browser";
        this.version = this.searchVersion(navigator.userAgent)
			|| this.searchVersion(navigator.appVersion)
			|| "unknown_version";
        this.OS = this.searchString(this.dataOS) || "unknown_OS";
    },
    searchString: function (data) {
        for (var i = 0; i < data.length; i++) {
            var dataString = data[i].string;
            var dataProp = data[i].prop;
            this.versionSearchString = data[i].versionSearch || data[i].identity;
            if (dataString) {
                if (dataString.indexOf(data[i].subString) != -1)
                    return data[i].identity;
            }
            else if (dataProp)
                return data[i].identity;
        }
    },
    searchVersion: function (dataString) {
        var index = dataString.indexOf(this.versionSearchString);
        if (index == -1) return;
        return parseFloat(dataString.substring(index + this.versionSearchString.length + 1));
    },
    dataBrowser: [
		{
		    string: navigator.userAgent,
		    subString: "Chrome",
		    identity: "Chrome"
		},
		{ string: navigator.userAgent,
		    subString: "OmniWeb",
		    versionSearch: "OmniWeb/",
		    identity: "OmniWeb"
		},
		{
		    string: navigator.vendor,
		    subString: "Apple",
		    identity: "Safari",
		    versionSearch: "Version"
		},
		{
		    prop: window.opera,
		    identity: "Opera",
		    versionSearch: "Version"
		},
		{
		    string: navigator.vendor,
		    subString: "iCab",
		    identity: "iCab"
		},
		{
		    string: navigator.vendor,
		    subString: "KDE",
		    identity: "Konqueror"
		},
		{
		    string: navigator.userAgent,
		    subString: "Firefox",
		    identity: "Firefox"
		},
		{
		    string: navigator.vendor,
		    subString: "Camino",
		    identity: "Camino"
		},
		{		// for newer Netscapes (6+)
		    string: navigator.userAgent,
		    subString: "Netscape",
		    identity: "Netscape"
		},
		{
		    string: navigator.userAgent,
		    subString: "MSIE",
		    identity: "Explorer",
		    versionSearch: "MSIE"
		},
		{
		    string: navigator.userAgent,
		    subString: "Gecko",
		    identity: "Mozilla",
		    versionSearch: "rv"
		},
		{ 		// for older Netscapes (4-)
		    string: navigator.userAgent,
		    subString: "Mozilla",
		    identity: "Netscape",
		    versionSearch: "Mozilla"
		}
	],
    dataOS: [
		{
		    string: navigator.platform,
		    subString: "Win",
		    identity: "Windows"
		},
		{
		    string: navigator.platform,
		    subString: "Mac",
		    identity: "Mac"
		},
		{
		    string: navigator.userAgent,
		    subString: "iPhone",
		    identity: "iPhone"
		},
        {
            string: navigator.userAgent,
            subString: "iPad",
            identity: "iPad"
        },
        {
            string: navigator.userAgent,
            subString: "iPod",
            identity: "iPod"
        },
        {
            string: navigator.userAgent,
            subString: "Android",
            identity: "Android"
        },
        {
            string: navigator.userAgent,
            subString: "BlackBerry",
            identity: "BlackBerry"
        },
		{
		    string: navigator.platform,
		    subString: "Linux",
		    identity: "Linux"
		}
	]

};

//Epsilon-Greedy Success Event Notifier
function AsyncEpsilonGreedy(CampaignKey, Recipe, RecMode) { //RecMode: success, positive, or negative
    var EpsilonProxyUrl = "/Support/Epsilon_greedy/RecordEvent.aspx" + "?cmpkey=" + CampaignKey + "&recipe=" + Recipe + "&recmode=" + RecMode;
    $.ajax({ url: EpsilonProxyUrl });
}

BrowserDetect.init();
//On document Ready
$(document).ready(function () {
    BuildEthnio();
    BuildClosedLoopFeedback();
});
