
function doStartup() {
    InitializeIPHexpandos();
}

// ============================================================ \\
// =====           Wrapper functions of JS CALLABLE LIBRARY   == \\
// ============================================================ \\

function ShowTopic(helpItemID) {

    if (helpItemID.length <= 0)
        return;

    window.external.ShowTopic(helpItemID);
}

function ShowFederatedTopic(link, hapId, helpItemId) {

    if (helpItemId.length <= 0)
        return;

    window.external.ShowFederatedTopic(link, hapId, helpItemId);
}


function SearchTopics(searchQuery) {
    if (searchQuery.length <= 0)
        return;

    window.external.SearchTopics(searchQuery);
}

function qbcommand(command) {
    if (command.length <= 0)
        return;

    window.external.RunQBCommand(command);
}

function QBURL(url) {
    if (url.length <= 0)
        return;

    window.external.QBURL(url);
}

function GetQBValue(key) {
    if (key.length <= 0)
        return;

    var ret = window.external.GetStringValue(key);
    return ret;
}


//Added by the QuickBooks Web Team 11/30/2011
//**************************************************
function InitializeIPHexpandos() {

    //select all expando links currently displayed
    var IPHexpandoLinks = $('a[expando=""]');
    IPHexpandoLinks.addClass("IPHexpando");
    IPHexpandoLinks = $(".IPHexpando");

    //Add click event to all expando links selected
    IPHexpandoLinks.bind('click', function () {

        //look for the expando content among siblings
        nextexpando = $(this).next(".expando");

        //if the expando content is not a sibbling, check at the parent level
        if (nextexpando.length <= 0) {
            var currentparent = $(this).parent();
            nextexpando = currentparent.next(".expando");

            if (nextexpando.length <= 0) {
                nextexpando = currentparent.children(".expando").first();
            }

            //if the expando content is not found, check ancestors until found
            if (nextexpando.length <= 0) {
                while (nextexpando.length <= 0) {

                    currentparent = currentparent.parent();

                    if (currentparent.length <= 0) {
                        break;
                    }

                    else {
                        nextexpando = currentparent.next(".expando");

                        if (nextexpando.length <= 0) {
                            nextexpando = currentparent.children(".expando").first();
                        }
                    }
                }
            }
        }

        //collapse expando 
        if ($(this).hasClass("open")) {

            $(this).removeClass("open");
            nextexpando.slideUp("fast");
        }

        //expand expando
        else {
            $(this).addClass("open");
            nextexpando.css("border", "solid 1px #EFEFEF").css("position", "relative").css("width", "95%"); //the 95% is necessary to avoid content to disappear in expandos
            nextexpando.slideDown("fast");
        }
    });
} 

