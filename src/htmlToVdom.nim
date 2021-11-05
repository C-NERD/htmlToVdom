from karax/vdom import add, newVNode, text, setAttr, VNodeKind, VNode
from strtabs import pairs
from strutils import isEmptyOrWhitespace 
from htmlparser import parseHtml, htmlTag, HtmlTag
from xmltree import `[]`, items, attrs, text, kind, len, XmlNode, XmlNodeKind

when not defined(js):
  {.error: "This module only works on the JavaScript platform".}

## Converts HtmlTag to VNodeKind
func tagtoKTag(tag : HtmlTag) : VNodeKind =

  case tag:

  of tagHtml : return html
  of tagA : return a
  of tagAbbr : return abbr
  #of tagAcronym : return 
  of tagAddress : return address
  #of tagApplet : return 
  of tagArea : return area
  of tagArticle : return article
  of tagAside : return aside
  of tagAudio : return audio
  #of tagB : return b
  of tagBase : return base
  of tagBdi : return bdi
  #of tagBdo : return 
  #of tagBasefont : return 
  #of tagBig : return 
  of tagBlockquote : return blockquote
  of tagBody : return body
  of tagBr : return br
  of tagButton : return button
  of tagCanvas : return canvas
  of tagCaption : return caption
  #of tagCenter : return 
  of tagCite : return cite
  of tagCode : return code
  of tagCol : return col
  of tagColgroup : return colgroup
  of tagCommand : return command
  of tagDatalist : return datalist
  of tagDd : return dd
  #of tagDel : return del
  of tagDetails : return details
  of tagDfn : return dfn
  #of tagDialog : return 
  of tagDiv : return tdiv
  #of tagDir : return 
  of tagDl : return dl
  of tagDt : return dt
  of tagEm : return em
  of tagEmbed : return embed
  #of tagFieldset : return 
  of tagFigcaption : return figcaption
  of tagFigure : return figure
  #of tagFont : return 
  of tagFooter : return footer
  of tagForm : return form
  #of tagFrame : return 
  #of tagFrameset : return 
  of tagH1 : return h1
  of tagH2 : return h2
  of tagH3 : return h3
  of tagH4 : return h4
  of tagH5 : return h5
  of tagH6 : return h6
  of tagHead : return head
  of tagHeader : return header
  #of tagHgroup : return 
  of tagHr : return hr
  #of tagI : return i
  of tagIframe : return iframe
  of tagImg : return img
  of tagInput : return input
  of tagIns : return ins
  #of tagIsindex : return 
  #of tagKbd ; return 
  of tagKeygen : return keygen
  of tagLabel : return label
  of tagLegend : return legend
  of tagLi : return li
  of tagLink : return link
  of tagMap : return map
  of tagMark : return mark
  of tagMenu : return menu
  of tagMeta : return meta
  of tagMeter : return meter
  of tagNav : return nav
  #of tagNobr : return 
  #of tagNoframes : return 
  of tagNoscript : return noscript
  of tagObject : return `object`
  of tagOl : return ol
  of tagOptgroup : return optgroup
  of tagOption : return option
  of tagOutput : return output
  of tagP : return p
  of tagParam : return param
  of tagPre : return pre
  of tagProgress : return progress
  #of tagQ : return 
  of tagRp : return rp
  of tagRt : return rt
  of tagRuby : return ruby
  #of tagS : return s
  of tagSamp : return samp
  of tagScript : return script
  of tagSection : return section
  of tagSelect : return select
  of tagSmall : return small
  of tagSource : return source
  of tagSpan : return span
  #of tagStrike : return 
  of tagStrong : return strong
  of tagStyle : return style
  of tagSub : return sub
  of tagSummary : return summary
  of tagSup : return sup
  of tagTable : return table
  of tagTbody : return tbody
  of tagTd : return td
  of tagTextarea : return textarea
  of tagTfoot : return tfoot
  of tagTh : return th
  #of tagThead : return 
  of tagTime : return time
  of tagTitle : return title
  of tagTr : return tr
  of tagTrack : return track
  #of tagTt : return 
  #of tagU : return u
  of tagUl : return ul
  of tagVar : return `var`
  of tagVideo : return video
  of tagWbr : return wbr
  else : discard

## Converts XmlNode to VNode
proc toVNode(node : XmlNode) : VNode =

  let attributes = node.attrs()
  result = newVNode(tagtoKtag(node.htmlTag))
  if attributes != nil:
  
    for key, value in attributes.pairs():

      result.setAttr(key, value)

  for pos in 0..<node.len:

    if node[pos].kind == xnText:

      let nodetext = node[pos].text
      if not nodetext.isEmptyOrWhitespace:

        result.add(text(nodetext))

## Create a VNode tree recursively
proc rVdomTree(rootnode : XmlNode) : seq[VNode] =

  for pos1 in 0..<rootnode.len:
    
    if rootnode[pos1].kind == xnElement:

      let 
        vnode = rootnode[pos1].toVNode()
        lenght = rootnode[pos1].len
      
      #if lenght > 1:

      for kid in rVdomTree(rootnode[pos1]):
        vnode.add(kid)

      result.add(vnode)
    else:

      discard

## Convert html string to Vdom
proc toVdom*(html : string) : seq[VNode] =

  let tree = parseHtml(html)
  result = rVdomTree(tree)

## Convert html string to Vdom
proc toVdom*(html : XmlNode) : seq[VNode] =
  result = rVdomTree(html)