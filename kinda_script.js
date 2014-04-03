// Generated by CoffeeScript 1.7.1
(function() {
  window._c = {
    makeElement: function(element, text) {
      var attr, attrName, attrValue, attrs, classes, cls, e, el, id, ids, _i, _j, _k, _len, _len1, _len2;
      e = element.match(/^\w+/);
      attrs = element.match(/\[[\w\-='"\.]*\]/g);
      element = element.replace(/\[[\w\-='"\.]*\]/g, '');
      classes = element.match(/\.[\w-]+(?!['"=\s-])/g);
      ids = element.match(/#[\w-]+/);
      el = e ? document.createElement(e[0]) : document.createElement('div');
      if (classes) {
        for (_i = 0, _len = classes.length; _i < _len; _i++) {
          cls = classes[_i];
          el.className += " " + (cls.substring(1));
          el.className = el.className.replace(/^\s*/, '');
        }
      }
      if (ids) {
        for (_j = 0, _len1 = ids.length; _j < _len1; _j++) {
          id = ids[_j];
          el.id = id.substring(1);
        }
      }
      if (attrs) {
        for (_k = 0, _len2 = attrs.length; _k < _len2; _k++) {
          attr = attrs[_k];
          if (/\=/.test(attr)) {
            attrName = attr.match(/[\w-]+/)[0];
            attrValue = attr.match(/["'][\s\w\.-]*['"]/);
            attrValue = attrValue[0].substring(1, attrValue[0].length - 1);
            el.setAttribute(attrName, attrValue);
          } else {
            attr = attr.replace(/[\[\]]/g, "");
            el.setAttribute(attr, "");
          }
        }
      }
      if (text) {
        el.innerHTML = text;
      }
      return el;
    }
  };

}).call(this);