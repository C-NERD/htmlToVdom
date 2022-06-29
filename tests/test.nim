import unittest, ../src/htmlToVdom, karax / [vdom]
from htmlparser import parseHtml
from xmltree import `[]`, XmlNode, XmlNodeKind, kind, items

suite "htmlToVdom test":
  
    const
        html = "<div>Hello world</div>"
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
        </svg>
        """
  
    test "Single node rendering test":

        let vnode = html.toVNode()
        
        assert(vnode.kind == tdiv)
        assert(vnode[0].text == "Hello world")
    
    test "Svg rendering test":

        let 
            node : XmlNode = block : ## For some reason the htmlparse adds document tag as the parent tag

                var node : XmlNode
                for child in svg.parseHtml():

                    if child.kind() == xnElement:

                        node = child
                        break
                
                node

            vnode = node.toVNode()  

        assert(vnode.kind == VNodeKind.svg)
        assert(vnode[0].kind == g)
        assert(vnode[0][0].kind == g)
        assert(vnode[0][0].len == 3)
