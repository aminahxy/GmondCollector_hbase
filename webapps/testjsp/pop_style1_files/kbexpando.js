/****************************************************************************************
KB Expando documentation
*****************************************************************************************
Example of a KB expando:

<a href="javascript:" class="kbexpandolink">Add description of the link here</a>
<div class="kbexpandoContent">Add Content of the expando here</div>

You can add any additional styling to it or wrap in a div to apply the blueLink styleguide style:

<div class="blueLink">//it can be any other class of your choice if you want a different look. See a developer for custom styling
<a href="javascript:" class="kbexpandolink">Add description of the link here</a>
<div class="kbexpandoContent">Add Content of the expando here</div>
</div>

it is possible to nest an expando within another, here is an example:

<div class="blueLink">
<a href="javascript:" class="kbexpandolink">Add description of the link here</a>
<div class="kbexpandoContent">
Add Content of the expando here
<a href="javascript:" class="kbexpandolink">here</a>
<div class="kbexpandoContent">
content of the inner expando here
</div>
</div>
</div>

PS: You can nest indefinitely     */

$(document).ready(function ()
{
    InitializeExpandos();
});

function InitializeExpandos()
{
    $(".kbexpandolink").click(function ()
    {
        var next = $(this).next(".kbexpandoContent");
        next.slideToggle("fast");
        if ($(this).hasClass("open"))
        {
            $(this).removeClass("open");
        }
        else
            $(this).addClass("open");
    });
    $('.kbexpandolink font').css("color", "#365ebf").css("font-weight", "bold");
}
function ExpandoCollapseAll()
{
    var expandoLink = $(".kbexpandolink");

    if (expandoLink.hasClass("open"))
    {
        expandoLink.removeClass("open");
        $(".kbexpandoContent").hide();
    }
}
function ExpandoExpandAll()
{
    ExpandoCollapseAll();
    var expandoLink = $(".kbexpandolink");

    if (!expandoLink.hasClass("open"))
        expandoLink.addClass("open");

    $(".kbexpandoContent").slideDown();
}

function GetAjaxArticle(url, targetDestinationID)
{
    var resource = url.toLowerCase();
    var isKbArticle = resource.match("pages") || resource.match("articles");

    var content = $("#" + targetDestinationID);
    content.html("<div style=\"text-align: center;\"><img src=\"\/Support\/images\/ajax-loader.gif\" /><p>Loading the article, please wait ...</p></div>");
    content.load(url + " " + "#KBArticleContent", function ()
    {
        if (isKbArticle)
            InitializeExpandos();
        else
            InitializeIPHexpandos();
    });
}

function GetIframeArticle(url, targetDestinationID, wizardName, resource, steps)
{
    $("#GuidedWorkFlowArticleContent").show();
    $("#" + targetDestinationID).html("<div style=\"text-align: center;\"><img src=\"\/Support\/images\/ajax-loader.gif\" /><p>Loading the article, please wait ...</p></div>");
    var iframeID = "wizardiframe";
    var IFRAME_WIDTH = "850";
    var IFRAME_HEIGHT = "700";
    var track = "wizard=" + wizardName + ":art[" + resource + "]:" + steps;
    var iframeSource = url + "?QBSRequestNoNav=true";
    var iframe = "";
    iframe = "<iframe style=\"overflow-x: hidden;\" scrolling=\"yes\" horizontalscrolling=\"no\" verticalscrolling=\"yes\" src=\"" + iframeSource + "\" frameborder=\"0\" id=\"" + iframeID + "\" width=\"" + IFRAME_WIDTH + "\" height=\"" + IFRAME_HEIGHT + "\"/>";
    SC_MakeRequest(track);

    setTimeout(function ()
    {
        $("#" + targetDestinationID).html(iframe);
    }, 1000);
}

function GetIframeArticleTall(url, targetDestinationID, wizardName, resource, steps, height)
{
    $("#GuidedWorkFlowArticleContent").show();
    $("#" + targetDestinationID).html("<div style=\"text-align: center;\"><img src=\"\/Support\/images\/ajax-loader.gif\" /><p>Loading the article, please wait ...</p></div>");
    var iframeID = "wizardiframe";
    var IFRAME_WIDTH = "850";
    var IFRAME_HEIGHT = height;
    var track = "wizard=" + wizardName + ":art[" + resource + "]:" + steps;
    var iframeSource = url + "?QBSRequestNoNav=true";
    var iframe = "";
    iframe = "<iframe style=\"overflow-x: hidden;\" scrolling=\"no\" horizontalscrolling=\"no\" verticalscrolling=\"yes\" src=\"" + iframeSource + "\" frameborder=\"0\" id=\"" + iframeID + "\" width=\"" + IFRAME_WIDTH + "\" height=\"" + IFRAME_HEIGHT + "\"/>";
    SC_MakeRequest(track);

    setTimeout(function () {
        $("#" + targetDestinationID).html(iframe);
    }, 1000);
}