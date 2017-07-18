//rnc 02-16-2010 - created new metric - Propensity to Contact
//This metric counts the number of clicks when a customer goes to Contact Support from a KB (event12 = yes)
//and the number of clicks when a customer goes someplace else which is not Contact Support (event13 = no).
//The Events can be found in Omniture's Site Catalyst Site Metrics menu -> Custom Events -> Custom Events 1-20.
//This function is called from Base.master

function SC_propensityToContact(type, page) {
    //Event 12 Name = P2C “Yes” (counts the number of times they go to an article = Y)
    //Event 13 Name = P2C “No” (counts the number of time they go somewhere else = n)
    //alert("Inside Propensity");
    var str = "";
    if (s == null || typeof s == 'undefined') {
        s = s_gi(s_account);
    }
    //SC: Propensity to Contact
    s.linkTrackVars = "prop37,eVar37,events";
    if (page) {
        s.linkTrackEvents = "event12";
        s.events = "event12";
    }
    else {
        s.linkTrackEvents = "event13";
        s.events = "event13";
    }
    // send values
    s.tl(true, 'o', 'P2C');
    // clear values
    s.events = "";
    return true;
}