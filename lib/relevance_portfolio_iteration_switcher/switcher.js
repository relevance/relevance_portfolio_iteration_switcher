var Switcher = {
  init: function() {
    Switcher.wrapper = $('#relevance-switcher-wrapper');
    Switcher.bar = Switcher.wrapper.find('#relevance-switcher-bar')
    Switcher.hideButton = Switcher.wrapper.find('#relevance-switcher-hide-button');
    Switcher.showButton = Switcher.wrapper.find('#relevance-switcher-show-button');
    Switcher.iterationButton = Switcher.wrapper.find('#relevance-switcher-iteration-button');
    Switcher.iterationList = Switcher.wrapper.find('#relevance-switcher-iteration-list');

    Switcher.hideButton.click(function() { Switcher.hideBar(400)});
    Switcher.showButton.click(function() { Switcher.showBar(400)});
    Switcher.wireSwitcher();

    Switcher.hideIfPreviouslyHidden();
  },

  hideIfPreviouslyHidden: function() {
    if ($.cookie('relevance-switcher-hidden') == 'true') {
      Switcher.hideBar(0);
    }
  },

  hideBar: function(speed) {
    if (Switcher.bar.is(':animated')) return;

    $.cookie('relevance-switcher-hidden', 'true', { path: "/" });
    Switcher.bar.animate({"margin-top": "0px", "margin-top": "-52px"}, speed, function(){
      Switcher.showButton.animate({"margin-top": "-100px", "margin-top": "-8px"}, speed);
    });
  },

  showBar: function(speed) {
    if (Switcher.bar.is(':animated')) return;

    $.cookie('relevance-switcher-hidden', null, { path: "/" });
    Switcher.showButton.animate({"margin-top": "-8px", "margin-top": "-100px"}, speed, function() {
      Switcher.bar.animate({"margin-top": "0px", "margin-top": "0px"}, speed);
    });
  },

  wireSwitcher: function() {
    this.iterationButton.click(function() {
      if (Switcher.iterationList.is(":animated")) return;

      if (Switcher.iterationButton.hasClass('relevance-switcher-active')) {
        Switcher.iterationButton.removeClass('relevance-switcher-active');
        Switcher.iterationList.animate({"top": "-10px", "opacity": 0}, 400, function() {
          Switcher.iterationList.hide();
        });
      } else {
        Switcher.iterationButton.addClass('relevance-switcher-active');
        Switcher.iterationList.show().animate({"top": "0px", "opacity": 1}, 400);
      }
    });
  }
};

/*!
 * jQuery Cookie Plugin
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2011, Klaus Hartl
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.opensource.org/licenses/GPL-2.0
*/
(function($) {
  $.cookie = function(key, value, options) {

    // key and at least value given, set cookie...
    if (arguments.length > 1 && (!/Object/.test(Object.prototype.toString.call(value)) || value === null || value === undefined)) {
      options = $.extend({}, options);

      if (value === null || value === undefined) {
        options.expires = -1;
      }

      if (typeof options.expires === 'number') {
        var days = options.expires, t = options.expires = new Date();
        t.setDate(t.getDate() + days);
      }

      value = String(value);

      return (document.cookie = [
              encodeURIComponent(key), '=', options.raw ? value : encodeURIComponent(value),
              options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
              options.path    ? '; path=' + options.path : '',
              options.domain  ? '; domain=' + options.domain : '',
              options.secure  ? '; secure' : ''
      ].join(''));
    }

    // key and possibly options given, get cookie...
    options = value || {};
    var decode = options.raw ? function(s) { return s; } : decodeURIComponent;

    var pairs = document.cookie.split('; ');
    for (var i = 0, pair; pair = pairs[i] && pairs[i].split('='); i++) {
      if (decode(pair[0]) === key) return decode(pair[1] || ''); // IE saves cookies with empty string as "c; ", e.g. without "=" as opposed to EOMB, thus pair[1] may be undefined
    }
    return null;
  };
})(jQuery);

$(Switcher.init);
