(function(){function a(a,b,c){if(!b.is||!b.getCustomData("block_processed"))b.is&&CKEDITOR.dom.element.setMarker(c,b,"block_processed",!0),a.push(b)}function b(b,c){function d(){this.foreach(function(a){/^(?!vbox|hbox)/.test(a.type)&&(a.setup||(a.setup=function(b){a.setValue(b.getAttribute(a.id)||"",1)}),!a.commit)&&(a.commit=function(b){var c=this.getValue();"dir"==a.id&&b.getComputedStyle("direction")==c||(c?b.setAttribute(a.id,c):b.removeAttribute(a.id))})})}var e=function(){var a=CKEDITOR.tools.extend({},CKEDITOR.dtd.$blockLimit);return b.config.div_wrapTable&&(delete a.td,delete a.th),a}(),f=CKEDITOR.dtd.div,g={},h=[];return{title:b.lang.div.title,minWidth:400,minHeight:165,contents:[{id:"info",label:b.lang.common.generalTab,title:b.lang.common.generalTab,elements:[{type:"hbox",widths:["50%","50%"],children:[{id:"elementStyle",type:"select",style:"width: 100%;",label:b.lang.div.styleSelectLabel,"default":"",items:[[b.lang.common.notSet,""]],onChange:function(){var a=["info:elementStyle","info:class","advanced:dir","advanced:style"],c=this.getDialog(),d=c._element&&c._element.clone()||new CKEDITOR.dom.element("div",b.document);this.commit(d,!0);for(var a=[].concat(a),e=a.length,f,g=0;g<e;g++)(f=c.getContentElement.apply(c,a[g].split(":")))&&f.setup&&f.setup(d,!0)},setup:function(a){for(var b in g)g[b].checkElementRemovable(a,!0)&&this.setValue(b,1)},commit:function(a){var b;(b=this.getValue())?g[b].applyToObject(a):a.removeAttribute("style")}},{id:"class",type:"text",requiredContent:"div(cke-xyz)",label:b.lang.common.cssClass,"default":""}]}]},{id:"advanced",label:b.lang.common.advancedTab,title:b.lang.common.advancedTab,elements:[{type:"vbox",padding:1,children:[{type:"hbox",widths:["50%","50%"],children:[{type:"text",id:"id",requiredContent:"div[id]",label:b.lang.common.id,"default":""},{type:"text",id:"lang",requiredContent:"div[lang]",label:b.lang.common.langCode,"default":""}]},{type:"hbox",children:[{type:"text",id:"style",requiredContent:"div{cke-xyz}",style:"width: 100%;",label:b.lang.common.cssStyle,"default":"",commit:function(a){a.setAttribute("style",this.getValue())}}]},{type:"hbox",children:[{type:"text",id:"title",requiredContent:"div[title]",style:"width: 100%;",label:b.lang.common.advisoryTitle,"default":""}]},{type:"select",id:"dir",requiredContent:"div[dir]",style:"width: 100%;",label:b.lang.common.langDir,"default":"",items:[[b.lang.common.notSet,""],[b.lang.common.langDirLtr,"ltr"],[b.lang.common.langDirRtl,"rtl"]]}]}]}],onLoad:function(){d.call(this);var a=this,c=this.getContentElement("info","elementStyle");b.getStylesSet(function(d){var e,f;if(d)for(var h=0;h<d.length;h++)f=d[h],f.element&&"div"==f.element&&(e=f.name,g[e]=f=new CKEDITOR.style(f),b.filter.check(f)&&(c.items.push([e,e]),c.add(e,e)));c[1<c.items.length?"enable":"disable"](),setTimeout(function(){a._element&&c.setup(a._element)},0)})},onShow:function(){"editdiv"==c&&this.setupContent(this._element=CKEDITOR.plugins.div.getSurroundDiv(b))},onOk:function(){if("editdiv"==c)h=[this._element];else{var d=[],g={},i=[],j,l=b.getSelection(),o=l.getRanges(),r=l.createBookmarks(),s,t;for(s=0;s<o.length;s++)for(t=o[s].createIterator();j=t.getNextParagraph();)if(j.getName()in e&&!j.isReadOnly()){var u=j.getChildren();for(j=0;j<u.count();j++)a(i,u.getItem(j),g)}else{for(;!f[j.getName()]&&!j.equals(o[s].root);)j=j.getParent();a(i,j,g)}CKEDITOR.dom.element.clearAllMarkers(g),o=[],s=null;for(t=0;t<i.length;t++)j=i[t],u=b.elementPath(j).blockLimit,u.isReadOnly()&&(u=u.getParent()),b.config.div_wrapTable&&u.is(["td","th"])&&(u=b.elementPath(u.getParent()).blockLimit),u.equals(s)||(s=u,o.push([])),o[o.length-1].push(j);for(s=0;s<o.length;s++){u=o[s][0],i=u.getParent();for(j=1;j<o[s].length;j++)i=i.getCommonAncestor(o[s][j]);t=new CKEDITOR.dom.element("div",b.document);for(j=0;j<o[s].length;j++){for(u=o[s][j];!u.getParent().equals(i);)u=u.getParent();o[s][j]=u}for(j=0;j<o[s].length;j++)if(u=o[s][j],!u.getCustomData||!u.getCustomData("block_processed"))u.is&&CKEDITOR.dom.element.setMarker(g,u,"block_processed",!0),j||t.insertBefore(u),t.append(u);CKEDITOR.dom.element.clearAllMarkers(g),d.push(t)}l.selectBookmarks(r),h=d}d=h.length;for(g=0;g<d;g++)this.commitContent(h[g]),!h[g].getAttribute("style")&&h[g].removeAttribute("style");this.hide()},onHide:function(){"editdiv"==c&&this._element.removeCustomData("elementStyle"),delete this._element}}}CKEDITOR.dialog.add("creatediv",function(a){return b(a,"creatediv")}),CKEDITOR.dialog.add("editdiv",function(a){return b(a,"editdiv")})})()