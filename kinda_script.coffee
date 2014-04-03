window._c =
  makeElement: (element, text) ->

    # Get element type to create
    # Regex: /^\w+/
    #
    # Example: a.class
    # Returns: 'a'

    e = element.match(/^\w+/)


    # Fetch attributes into an array whether they are
    # just the attribute name or the name and value
    # Regex: /\[[\w-]+]|\[[\w-]+=['"][\s\.\w-]*['"]\]/g
    #
    # Example: a[data-test1][data-test2='asdf']
    # Returns: ["[data-test1]', '[data-test2="asdf"]"]

    #attrs = element.match(/\[[\w-]+]|\[[\w-]+=['"][\s\.\w-]*['"]\]/g)
    attrs = element.match(/\[[\w\-='"\.]*\]/g)
    element = element.replace(/\[[\w\-='"\.]*\]/g, '')

    # Fetch classes into an array
    # Regex: /\.[\w-]+(?!['"=\s-])/g
    #
    # Example: a.class.test
    # Returns: ['class', 'test']

    # @cole BUG: _c.makeElement('option[data-vin="U.V.G"]')
    #   will make an element with a class of "V", it shouldn't
    #   because it's clearly within the data-vin
    classes = element.match(/\.[\w-]+(?!['"=\s-])/g)


    # Fetch id into an array
    # Regex: /#[\w-]+/
    #
    # Example: a.class#test
    # Returns: ['test']

    ids = element.match(/#[\w-]+/)


    # Fetch attributes into an array whether they are
    # just the attribute name or the name and value
    # Regex: /\[[\w-]+]|\[[\w-]+=['"][\s\.\w-]*['"]\]/g
    #
    # Example: a[data-test1][data-test2='asdf']
    # Returns: ["[data-test1]', '[data-test2="asdf"]"]

    #attrs = element.match(/\[[\w-]+]|\[[\w-]+=['"][\s\.\w-]*['"]\]/g)


    # Create element based on e.
    # If no e then create div element.
    #
    # Returns: <a></a> || <div></div>

    el = if e then document.createElement(e[0]) else document.createElement('div')

    # Add classes in classes array to el
    #
    # Returns: <a class="example"></a>

    if classes
      for cls in classes
        el.className += " #{cls.substring(1)}"
        el.className = el.className.replace(/^\s*/, '')


    # Add id in id array to el
    #
    # Returns: <a id="example"></a>

    if ids
      for id in ids
        el.id = id.substring(1)


    # Add attributes in attrs array
    # If the attribute has a value its given a value in the element
    # If it doesn't it's given a value of ""
    #
    # Returns: <a data-test1 data-test2="example"></a>

    if attrs
      for attr in attrs
        if /\=/.test(attr)
          attrName = attr.match(/[\w-]+/)[0]
          attrValue = attr.match(/["'][\s\w\.-]*['"]/)
          attrValue = attrValue[0].substring(1, attrValue[0].length - 1)
          el.setAttribute(attrName, attrValue)
        else
          attr = attr.replace(/[\[\]]/g, "")
          el.setAttribute(attr, "")

    if text
      el.innerHTML = text

    el
