import ../src/htmlToVdom
import karax / [karaxdsl, vdom, karax]

let html = "<p>Like always this answer will be vague because it's a test. Simple circular motion is the motion of an object in a parabolic path around another object. There are to forces that acts on this object and they are :</p><p><br></p><ol><li>Centripetal Force</li><li>And, Centrifugal Force</li></ol><p><br></p>"
proc main() : VNode =

  result = buildHtml(main(id = "ROOT")):

    for dom in toVdom(html):
      dom

when isMainModule:
  setRenderer main