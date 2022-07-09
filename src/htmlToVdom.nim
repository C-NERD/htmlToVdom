from karax / vdom import add, newVNode, text, setAttr, VNodeKind, VNode
from strtabs import pairs
from strutils import parseEnum, strip, isEmptyOrWhitespace
from htmlparser import parseHtml
from xmltree import `[]`, items, attrs, text, kind, len, tag, XmlNode, XmlNodeKind, `$`

#[method getText(node : XmlNode) : string {.base.} =

    if node.kind == xnText:

        if not ($node).isEmptyOrWhitespace():

            return $node

    elif node.kind == xnElement:

        for child in node:

            if child.kind == xnText:
                
                if not ($child).isEmptyOrWhitespace():

                    result.add($child)]#

converter xmlToVNode(node : XmlNode) : VNode =
    ## Converts XmlNode to VNode
    
    let attributes = node.attrs()
    result = newVNode(parseEnum[VNodeKind](node.tag()))
    if attributes != nil:
    
        for key, value in attributes.pairs():

            result.setAttr(key, value)

proc getText(node : XmlNode) : string =

    if node.kind == xnText:

        if not ($node).isEmptyOrWhitespace():

            return $node

    elif node.kind == xnElement:

        for child in node:

            if child.kind == xnText:
                
                if not ($child).isEmptyOrWhitespace():

                    result.add($child)

proc children(parent : XmlNode) : seq[VNode] =
    ## Gets children of xmlnode in VNode

    for pos in 0..<parent.len:
      
        if parent[pos].kind == xnElement:

            let vnode = parent[pos].xmlToVNode()
            for kid in children(parent[pos]):

                vnode.add(kid)

            result.add(vnode)

        elif parent[pos].kind == xnText:

            let nodetext = parent[pos].getText()
            if not nodetext.isEmptyOrWhitespace():

                result.add(text(nodetext))
        
        else:

            discard

proc toVdom*(node : XmlNode) : seq[VNode] {.deprecated.} =
    ## Gets all children of node in VNode
    
    result = children(node)

    ## Fixes the bug that occures with a single node in the dom
    if result == @[] and node != nil:
    
        result.add(node.xmlToVNode())

proc toVdom*(html : string) : seq[VNode] {.deprecated.} =
    ## Gets all children of html in VNode
    
    let tree = parseHtml(html)
    result = children(tree)

    ## Fixes the bug that occures with a single node in the dom
    if result == @[] and tree != nil:
        
        result.add(tree.xmlToVNode())

proc toVNode*(node : XmlNode) : VNode =
    ## Builds a new karax vnode object recursively
    
    result = node.xmlToVNode()
    for child in node.children():

        result.add(child)

proc toVNode*(html : string) : VNode =
    
    let node = html.parseHtml()
    return node.toVNode()

