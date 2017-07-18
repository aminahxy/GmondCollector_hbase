/*
    jQuery.fixedIE plugin to emulate position:fixed in Internet Explorer 6
    Copyright (C) 2010 Tim Branyen

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
(function(window, document, $) {

    // Cache variables for better compression
    var win = $(window),
        doc = $(document),

        // Function calls
        eE = "executeExpression",
        
        // Units
        p = "px",
        pc = "%";
        
    // Offset should always be top of page on load
    win.scrollTop(0);

    // If any hash is provided, make sure to scroll to the corresponding element
    var hash = window.location.hash;
    if(hash.length) {
        var anchor = $(hash).length ? $(hash) : $("a[name~='"+ hash.slice(1) +"']");
        window.setTimeout(function() {
            anchor.length && win.scrollTop(anchor.offset().top);
        }, 0);
    } 

    // Adapted position: fixed Modernizr test by Colin Snover & Paul Irish
    function testFixedSupport() {
        var test = $("<div/>"),
            control = test.clone(false),
            root = $(document.body || document.documentElement),
            rootStyle = root[0].style;

        root.data('orig', rootStyle.cssText);
        rootStyle.cssText = "padding:0;margin:0";
        test[0].style.cssText = "position:fixed;top:42px";
        root.append(test).append(control);
        
        var ret = test.offset().top !== control.offset().top;
        test.remove();
        control.remove();
        rootStyle.cssText = root.data('orig');
        root.removeData('orig');

        return ret;
    };

    // Testing out global function call instead of nested expression
    window.executeExpression = function(that, position, initial) {
        var data = $.data(that),
            dir = data["fixedie.dir"],
            val = 0,
            offset = 0;

        // TLBR = 1234
        if(position === 1) {
            offset = initial ? $.data(that)["fixedie.offset"] : win.height();
            return dir.top.unit === p
                ? (doc.scrollTop() + $.data(that)["fixedie.offset"]) +p
                : (doc.scrollTop() + offset * dir.top.val) +p;
        }
        else if(position === 3) {
            return dir.bottom.unit === p
                ? (win.height() + doc.scrollTop() - $(that).outerHeight() - dir.bottom.val) +p
                : (win.height() + doc.scrollTop() * dir.bottom.val) +p;
        }
        else if(position === 2) {
            offset = initial ? $.data(that)["fixedie.offset"] : win.width();
            return dir.left.unit === "px"
                ? (doc.scrollLeft() + $.data(that)["fixedie.offset"]) +"px"
                : (offset * dir.left.val + win.scrollLeft()) +p;
        }
        else {
            return dir.right.unit === p
                ? (win.width() + doc.scrollLeft() - $(that).outerWidth() - dir.right.val) +p
                : "0px";//(win.width() + 
        }
    };

    $.fixedIE = $.fn.fixedIE = function(options) {
        // Run feature detection test
        var isFixed = testFixedSupport();

        // Set the customization options here
        options = $.extend({
            selector: "",
            _elements: new $.fn.init
        }, options);

        // Operate on the correct subset based off the documentation
        if(options.selector.length) {
            // Only operate on specific subset that has been requested, probably did $(document).fixIE({ selector: "#something" });
            options._elements = options._elements.add(options.selector);
        }
        else if(typeof this === "object") {
            // Seek out subset based off of the object passed, probably did $("#something").fixedIE();
            this.css("position") === "fixed" && (options._elements = options._elements.add(this[0]));
        }
        else {
            // Seek out all the fixed elements on the page
            $.each($.makeArray(document.styleSheets), function() {
                $.each(this.cssRules || this.rules, function() {
                    $(this.selectorText).css("position") === "fixed" && (options._elements = options._elements.add(this.selectorText));
                });
            });
        }

        // Make sure there is a position fixed element on the page or bail out now
        // Also make sure we are working with something that is truely not position fixed
        if(isFixed || options._elements.length <= 0) { return $.isFunction(this) ? $("<div/>") : this; }

        // IE 6 hack to get smooth scrolling, no flicker.  Improved from Eric Watson's hack to not trigger an actual request.
        $("html").css("background-image", "url(.)");

        // This is what we're returning
        return options._elements.each(function() {
            // Going to need to pull each one of these elements out of the DOM, its okay since their fixed and not positioned relative to anything anyways
            var elem = $(this).css("position", "absolute").appendTo("body"),
                convert = function(any) {
                    var div = $("<div/>"),
                        val = div.css({ height: any, visibility: "hidden", position: "absolute" }).appendTo("body").height();
                    
                    div.remove();
                    return val;
                };

            // If neither top or bottom are specified default to top:0px
            elem.css("top") === "auto" && elem.css("bottom") === "auto" && elem.css("top", "0px");

            var offset = elem.offset(),
                dir = function(dir) {
                    var obj = {},
                        iestyle = elem[0].currentStyle[dir];

                    if(iestyle.slice(-1) === pc) {
                        obj.unit = pc;
                        obj.val = window.parseFloat(iestyle) / 100;
                    }
                    else if (iestyle.slice(-2) === p) {
                        obj.unit = p;
                        obj.val = window.parseFloat(iestyle) || 0;
                    }
                    else {
                        obj.unit = p;
                        obj.val = window.parseFloat(convert(iestyle)) || 0;
                    }

                    return obj;
                };

            // Must resize the elements and overflow the contents if exceeded past viewport
            (offset.top + elem.outerHeight()) > win.height() && elem.css({ 'overflow-y': "hidden", height: win.height() +p }).data("fixedie.fill", "height");
            (offset.left + elem.outerWidth()) > win.width() && elem.css({ 'overflow-x': "hidden", width: win.width() +p }).data("fixedie.fill", "width");
            
            // Only if in IE 5.5 or 6 browser
            var setExpr = elem[0].style.setExpression,
                removeExpr = elem[0].style.removeExpression;

            if(setExpr) {
                var top = dir("top"), left = dir("left"), right = dir("right"), bottom = dir("bottom");
                elem.data("fixedie.dir", { top: top, left: left, right: right, bottom: bottom });

                if(elem.css("bottom") !== "auto") {
                    elem.data("fixedie.vertical", "bottom");
                    setExpr("top", eE +"(this,3,true)");
                }
                else {
                    elem.data("fixedie.vertical", "top")
                        .data("fixedie.offset", elem.offset().top);
                    setExpr("top", eE +"(this,1,true)");
                }

                if(elem.css("right") !== "auto") {
                    elem.data("fixedie.horizontal", "right");
                    setExpr("left", eE +"(this,4,true)");
                }
                else {
                    elem.data("fixedie.horizontal", "left")
                        .data("fixedie.offset", elem.offset().left);
                    setExpr("left", "executeExpression(this,2,true)");
                }

                win.bind("resize scroll", function() {
                    elem.width(elem.width());
                    // Only need to modify top and left for % units
                    elem.data("fixedie.horizontal") === "left" && left.unit === pc && removeExpr("left") && setExpr("left", eE +"(this,2)");
                    elem.data("fixedie.vertical") === "top" && top.unit === pc && removeExpr("top") && setExpr("top", eE +"(this,1)");

                    elem.data("fixedie.vertical") === "bottom" && setExpr("top", eE +"(this,3)");
                    elem.data("fixedie.horizontal") === "right" && setExpr("left", eE +"(this,4)");

                    // Handle 100% elements
                    var fill = elem.data("fixedie.fill");
                    fill && fill === "height" && elem.css("height", win.height() +p);
                    fill && fill === "width" && elem.css("width", win.width() +p);
                });
            }
        });
    };

})(this, this.document, this.jQuery);
