# htmlToVdom

Karax extension to convert html in string form to embeddable Karax vdom

## Install with nimble

```bash
nimble install htmlToVdom
```

## Code example

```Nim
import htmlToVdom
from htmlparser import parseHtml
from xmltree import `[]`, XmlNode, XmlNodeKind, kind, items

let 
    html = "<h2>Header2 <em>emphasis</em></h2>"
    svg = """
        <svg width="297mm" height="210mm" version="1.1" viewBox="0 0 297 210" xmlns="http://www.w3.org/2000/svg">
            <g font-weight="bold">
                <g font-family="'Noto Sans Adlam Unjoined'">
                    <text transform="scale(1.0824 .9239)" x="-2.8955693" y="210.04376" fill="#000000" font-size="267.27px" stroke-width="1.392" style="line-height:1.25" xml:space="preserve"><tspan x="-2.8955693" y="210.04376" fill="#000000" font-family="'Noto Sans Adlam Unjoined'" font-weight="bold" stroke-width="1.392"/></text>
                    <text x="195.88306" y="193.94878" font-size="143.59px" stroke-width=".74786" style="line-height:1.25" xml:space="preserve"><tspan x="195.88306" y="193.94878" font-family="'Noto Sans Adlam Unjoined'" font-weight="bold" stroke-width=".74786"/></text>
                    <text x="61.365891" y="196.07318" font-size="267.32px" stroke-width="1.3923" style="line-height:1.25" xml:space="preserve"><tspan x="61.365891" y="196.07318" font-family="'Standard Symbols PS'" font-weight="bold" stroke-width="1.3923">B</tspan></text>
                </g>
                <text x="63.8148" y="33.334621" font-family="sans-serif" font-size="50.8px" stroke-width=".26458" style="line-height:1.25" xml:space="preserve"><tspan x="63.8148" y="33.334621" font-family="sans-serif" font-weight="bold" stroke-width=".26458"/></text>
            </g>
        </svg>"""

## convert html to vnode
let html_vnode = html.toVNode()

## convert svg to vnode
## Note this library uses the parseHtml() proc from the htmlparser library from the nim standard library, this 
## proc for some reason adds a document tag as parent when converting svg to vnode which will lead to errors.
## Hence you should manually parse your svg with the parseHtml proc and then extract your svg from the returned
## XmlNode

let 
    node : XmlNode = block:

        var node : XmlNode
        for child in svg.parseHtml():

            if child.kind() == xnElement:

                node = child
                break
            
        node
  
    vnode = node.toVNode()

```
