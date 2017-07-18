/* 
 * Baynote Observer for intuit-quickbooks
 * Last updated: October 14th, 2009 
 */
 
function bn_getMeta(name) {
	var metas=document.getElementsByTagName("meta");
	
	if (!metas) return;
	
	for (var i=0; i < metas.length; i++) {
		if (!metas[i]) return;
		if (metas[i].name == name) {
        	return metas[i].content;    	
    	}
	}
}
 
function bn_isNotEmpty(name) {
	return (name != null) && (name != "");
}
function bn_getOrderInfo() {
	if (typeof(bnOrderId) != "undefined" && bn_isNotEmpty(bnOrderId))
		baynote_tag.attrs.purchaseId = bnOrderId;
	if (typeof(bnOrderTotal) != "undefined" && bn_isNotEmpty(bnOrderTotal))
		baynote_tag.attrs.totalPurchases = parseFloat(bnOrderTotal);
	if (typeof(bnOrderDetails) != "undefined" && bn_isNotEmpty(bnOrderDetails))
		baynote_tag.attrs.purchaseDetails = bnOrderDetails;
}
function bn_getMediaInfo() {
	if (typeof(bnMediaDuration) != "undefined" && bn_isNotEmpty(bnMediaDuration)) {
		baynote_tag.attrs.expectedDuration = bnMediaDuration;
	}	
}
function bn_showObserver() {
	/* 1. set customer id */
	bn_customerId = "intuit";
	/* 2. set customer code */
	bn_code = "quickbooks";
	var bn_locHref = window.location.href;
	if (bn_locHref.indexOf("https://") == 0) {
		baynote_tag.server = "https://" + bn_customerId + "-" + bn_code + ".baynote.net";
	} else {
		baynote_tag.server = "http://" + bn_customerId + "-" + bn_code + ".baynote.net";
	}
	baynote_tag.customerId = bn_customerId;
	baynote_tag.code = bn_code;
	baynote_tag.type = "baynoteObserver";
	
	baynote_tag.summary = bn_getMeta("Description");
	
	/* 3. set customer domain (optional) */
	baynote_globals.cookieDomain = "support.quickbooks.intuit.com";
	/* 4. collect purchase info (optional) */ 
	bn_getOrderInfo();
	bn_getMediaInfo();
	baynote_tag.show();
}
if (typeof(baynote_tag)!="undefined") {
	bn_showObserver();
}

