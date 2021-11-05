import ../src/htmlToVdom
import karax / [karaxdsl, vdom, karax]
#from strutils import strip

let 
    html = """
      <nav id = "navbar" style = "background: blue;">Hello This is a navbar</nav>
      <section id = "mainsection">
        <pre>
            <code>
import htmToVdom, htmlstr
echo htmlstr.str.toVdom()
            </code>
        </pre>
        <p>Just some incorrect nim code</p>
      </section>
      <footer>
        <div id = "legalsection">
            <a href = "https://someurl">some text</a>
            <a href = "https://someurl">some text</a>
            <a href = "https://someurl">some text</a>
        <div>
      </footer>
    """

proc main() : VNode =
    result = buildHtml(main(id = "ROOT")):

        for dom in toVdom(html):
            dom
        
        #text("<strong>Hello boyz</strong>")

when isMainModule:
    setRenderer main