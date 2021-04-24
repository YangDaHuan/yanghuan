CKEDITOR.dialog.add("link",function(a){function d(a){return a.replace(/'/g,"\\$&")}function e(a){var e,f=b,g,h;e=[c,"("];for(var i=0;i<f.length;i++)g=f[i].toLowerCase(),h=a[g],0<i&&e.push(","),e.push("'",h?d(encodeURIComponent(a[g])):"","'");return e.push(")"),e.join("")}function f(a){for(var b,c=a.length,d=[],e=0;e<c;e++)b=a.charCodeAt(e),d.push(b);return"String.fromCharCode("+d.join(",")+")"}function g(a){return(a=a.getAttribute("class"))?a.replace(/\s*(?:cke_anchor_empty|cke_anchor)(?:\s*$)?/g,""):""}var b,c,h=CKEDITOR.plugins.link,i=function(){var b=this.getDialog(),c=b.getContentElement("target","popupFeatures"),b=b.getContentElement("target","linkTargetName"),d=this.getValue();if(c&&b)switch(c=c.getElement(),c.hide(),b.setValue(""),d){case"frame":b.setLabel(a.lang.link.targetFrameName),b.getElement().show();break;case"popup":c.show(),b.setLabel(a.lang.link.targetPopupName),b.getElement().show();break;default:b.setValue(d),b.getElement().hide()}},j=/^javascript:/,k=/^mailto:([^?]+)(?:\?(.+))?$/,l=/subject=([^;?:@&=$,\/]*)/,m=/body=([^;?:@&=$,\/]*)/,n=/^#(.*)$/,o=/^((?:http|https|ftp|news):\/\/)?(.*)$/,p=/^(_(?:self|top|parent|blank))$/,q=/^javascript:void\(location\.href='mailto:'\+String\.fromCharCode\(([^)]+)\)(?:\+'(.*)')?\)$/,r=/^javascript:([^(]+)\(([^)]+)\)$/,s=/\s*window.open\(\s*this\.href\s*,\s*(?:'([^']*)'|null)\s*,\s*'([^']*)'\s*\)\s*;\s*return\s*false;*\s*/,t=/(?:^|,)([^=]+)=(\d+|yes|no)/gi,u=function(a,d){var e=d&&(d.data("cke-saved-href")||d.getAttribute("href"))||"",f,h,i={};e.match(j)&&("encode"==z?e=e.replace(q,function(a,b,c){return"mailto:"+String.fromCharCode.apply(String,b.split(","))+(c&&c.replace(/\\'/g,"'"))}):z&&e.replace(r,function(a,d,e){if(d==c){i.type="email";for(var a=i.email={},d=/(^')|('$)/g,e=e.match(/[^,\s]+/g),f=e.length,g,h,j=0;j<f;j++)g=decodeURIComponent,h=e[j].replace(d,"").replace(/\\'/g,"'"),h=g(h),g=b[j].toLowerCase(),a[g]=h;a.address=[a.name,a.domain].join("@")}}));if(!i.type)if(f=e.match(n))i.type="anchor",i.anchor={},i.anchor.name=i.anchor.id=f[1];else if(f=e.match(k)){h=e.match(l),e=e.match(m),i.type="email";var u=i.email={};u.address=f[1],h&&(u.subject=decodeURIComponent(h[1])),e&&(u.body=decodeURIComponent(e[1]))}else e&&(h=e.match(o))?(i.type="url",i.url={},i.url.protocol=h[1],i.url.url=h[2]):i.type="url";if(d){f=d.getAttribute("target"),i.target={},i.adv={};if(f)f.match(p)?i.target.type=i.target.name=f:(i.target.type="frame",i.target.name=f);else if(f=(f=d.data("cke-pa-onclick")||d.getAttribute("onclick"))&&f.match(s)){i.target.type="popup";for(i.target.name=f[1];e=t.exec(f[2]);)"yes"!=e[2]&&"1"!=e[2]||e[1]in{height:1,width:1,top:1,left:1}?isFinite(e[2])&&(i.target[e[1]]=e[2]):i.target[e[1]]=!0}f=function(a,b){var c=d.getAttribute(b);null!==c&&(i.adv[a]=c||"")},f("advId","id"),f("advLangDir","dir"),f("advAccessKey","accessKey"),i.adv.advName=d.data("cke-saved-name")||d.getAttribute("name")||"",f("advLangCode","lang"),f("advTabIndex","tabindex"),f("advTitle","title"),f("advContentType","type"),CKEDITOR.plugins.link.synAnchorSelector?i.adv.advCSSClasses=g(d):f("advCSSClasses","class"),f("advCharset","charset"),f("advStyles","style"),f("advRel","rel")}f=i.anchors=[];var v;if(CKEDITOR.plugins.link.emptyAnchorFix){u=a.document.getElementsByTag("a"),e=0;for(h=u.count();e<h;e++)(v=u.getItem(e),v.data("cke-saved-name")||v.hasAttribute("name"))&&f.push({name:v.data("cke-saved-name")||v.getAttribute("name"),id:v.getAttribute("id")})}else{u=new CKEDITOR.dom.nodeList(a.document.$.anchors),e=0;for(h=u.count();e<h;e++)v=u.getItem(e),f[e]={name:v.getAttribute("name"),id:v.getAttribute("id")}}if(CKEDITOR.plugins.link.fakeAnchor){u=a.document.getElementsByTag("img"),e=0;for(h=u.count();e<h;e++)(v=CKEDITOR.plugins.link.tryRestoreFakeAnchor(a,u.getItem(e)))&&f.push({name:v.getAttribute("name"),id:v.getAttribute("id")})}return this._.selectedElement=d,i},v=function(a){a.target&&this.setValue(a.target[this.id]||"")},w=function(a){a.adv&&this.setValue(a.adv[this.id]||"")},x=function(a){a.target||(a.target={}),a.target[this.id]=this.getValue()||""},y=function(a){a.adv||(a.adv={}),a.adv[this.id]=this.getValue()||""},z=a.config.emailProtection||"";z&&"encode"!=z&&(c=b=void 0,z.replace(/^([^(]+)\(([^)]+)\)$/,function(a,d,e){c=d,b=[],e.replace(/[^,\s]+/g,function(a){b.push(a)})}));var A=a.lang.common,B=a.lang.link;return{title:B.title,minWidth:350,minHeight:230,contents:[{id:"info",label:B.info,title:B.info,elements:[{id:"linkType",type:"select",label:B.type,"default":"url",items:[[B.toUrl,"url"],[B.toAnchor,"anchor"],[B.toEmail,"email"]],onChange:function(){var b=this.getDialog(),c=["urlOptions","anchorOptions","emailOptions"],d=this.getValue(),e=b.definition.getContents("upload"),e=e&&e.hidden;d=="url"?(a.config.linkShowTargetTab&&b.showPage("target"),e||b.showPage("upload")):(b.hidePage("target"),e||b.hidePage("upload"));for(e=0;e<c.length;e++){var f=b.getContentElement("info",c[e]);f&&(f=f.getElement().getParent().getParent(),c[e]==d+"Options"?f.show():f.hide())}b.layout()},setup:function(a){a.type&&this.setValue(a.type)},commit:function(a){a.type=this.getValue()}},{type:"vbox",id:"urlOptions",children:[{type:"hbox",widths:["25%","75%"],children:[{id:"protocol",type:"select",label:A.protocol,"default":"http://",items:[["http://‎","http://"],["https://‎","https://"],["ftp://‎","ftp://"],["news://‎","news://"],[B.other,""]],setup:function(a){a.url&&this.setValue(a.url.protocol||"")},commit:function(a){a.url||(a.url={}),a.url.protocol=this.getValue()}},{type:"text",id:"url",label:A.url,required:!0,onLoad:function(){this.allowOnChange=!0},onKeyUp:function(){this.allowOnChange=!1;var a=this.getDialog().getContentElement("info","protocol"),b=this.getValue(),c=/^((javascript:)|[#\/\.\?])/i,d=/^(http|https|ftp|news):\/\/(?=.)/i.exec(b);d?(this.setValue(b.substr(d[0].length)),a.setValue(d[0].toLowerCase())):c.test(b)&&a.setValue(""),this.allowOnChange=!0},onChange:function(){this.allowOnChange&&this.onKeyUp()},validate:function(){var a=this.getDialog();return a.getContentElement("info","linkType")&&a.getValueOf("info","linkType")!="url"?!0:/javascript\:/.test(this.getValue())?(alert(A.invalidValue),!1):this.getDialog().fakeObj?!0:CKEDITOR.dialog.validate.notEmpty(B.noUrl).apply(this)},setup:function(a){this.allowOnChange=!1,a.url&&this.setValue(a.url.url),this.allowOnChange=!0},commit:function(a){this.onChange(),a.url||(a.url={}),a.url.url=this.getValue(),this.allowOnChange=!1}}],setup:function(){this.getDialog().getContentElement("info","linkType")||this.getElement().show()}},{type:"button",id:"browse",hidden:"true",filebrowser:"info:url",label:A.browseServer}]},{type:"vbox",id:"anchorOptions",width:260,align:"center",padding:0,children:[{type:"fieldset",id:"selectAnchorText",label:B.selectAnchor,setup:function(a){a.anchors.length>0?this.getElement().show():this.getElement().hide()},children:[{type:"hbox",id:"selectAnchor",children:[{type:"select",id:"anchorName","default":"",label:B.anchorName,style:"width: 100%;",items:[[""]],setup:function(a){this.clear(),this.add("");for(var b=0;b<a.anchors.length;b++)a.anchors[b].name&&this.add(a.anchors[b].name);a.anchor&&this.setValue(a.anchor.name),(a=this.getDialog().getContentElement("info","linkType"))&&a.getValue()=="email"&&this.focus()},commit:function(a){a.anchor||(a.anchor={}),a.anchor.name=this.getValue()}},{type:"select",id:"anchorId","default":"",label:B.anchorId,style:"width: 100%;",items:[[""]],setup:function(a){this.clear(),this.add("");for(var b=0;b<a.anchors.length;b++)a.anchors[b].id&&this.add(a.anchors[b].id);a.anchor&&this.setValue(a.anchor.id)},commit:function(a){a.anchor||(a.anchor={}),a.anchor.id=this.getValue()}}],setup:function(a){a.anchors.length>0?this.getElement().show():this.getElement().hide()}}]},{type:"html",id:"noAnchors",style:"text-align: center;",html:'<div role="note" tabIndex="-1">'+CKEDITOR.tools.htmlEncode(B.noAnchors)+"</div>",focus:!0,setup:function(a){a.anchors.length<1?this.getElement().show():this.getElement().hide()}}],setup:function(){this.getDialog().getContentElement("info","linkType")||this.getElement().hide()}},{type:"vbox",id:"emailOptions",padding:1,children:[{type:"text",id:"emailAddress",label:B.emailAddress,required:!0,validate:function(){var a=this.getDialog();return!a.getContentElement("info","linkType")||a.getValueOf("info","linkType")!="email"?!0:CKEDITOR.dialog.validate.notEmpty(B.noEmail).apply(this)},setup:function(a){a.email&&this.setValue(a.email.address),(a=this.getDialog().getContentElement("info","linkType"))&&a.getValue()=="email"&&this.select()},commit:function(a){a.email||(a.email={}),a.email.address=this.getValue()}},{type:"text",id:"emailSubject",label:B.emailSubject,setup:function(a){a.email&&this.setValue(a.email.subject)},commit:function(a){a.email||(a.email={}),a.email.subject=this.getValue()}},{type:"textarea",id:"emailBody",label:B.emailBody,rows:3,"default":"",setup:function(a){a.email&&this.setValue(a.email.body)},commit:function(a){a.email||(a.email={}),a.email.body=this.getValue()}}],setup:function(){this.getDialog().getContentElement("info","linkType")||this.getElement().hide()}}]},{id:"target",requiredContent:"a[target]",label:B.target,title:B.target,elements:[{type:"hbox",widths:["50%","50%"],children:[{type:"select",id:"linkTargetType",label:A.target,"default":"notSet",style:"width : 100%;",items:[[A.notSet,"notSet"],[B.targetFrame,"frame"],[B.targetPopup,"popup"],[A.targetNew,"_blank"],[A.targetTop,"_top"],[A.targetSelf,"_self"],[A.targetParent,"_parent"]],onChange:i,setup:function(a){a.target&&this.setValue(a.target.type||"notSet"),i.call(this)},commit:function(a){a.target||(a.target={}),a.target.type=this.getValue()}},{type:"text",id:"linkTargetName",label:B.targetFrameName,"default":"",setup:function(a){a.target&&this.setValue(a.target.name)},commit:function(a){a.target||(a.target={}),a.target.name=this.getValue().replace(/\W/gi,"")}}]},{type:"vbox",width:"100%",align:"center",padding:2,id:"popupFeatures",children:[{type:"fieldset",label:B.popupFeatures,children:[{type:"hbox",children:[{type:"checkbox",id:"resizable",label:B.popupResizable,setup:v,commit:x},{type:"checkbox",id:"status",label:B.popupStatusBar,setup:v,commit:x}]},{type:"hbox",children:[{type:"checkbox",id:"location",label:B.popupLocationBar,setup:v,commit:x},{type:"checkbox",id:"toolbar",label:B.popupToolbar,setup:v,commit:x}]},{type:"hbox",children:[{type:"checkbox",id:"menubar",label:B.popupMenuBar,setup:v,commit:x},{type:"checkbox",id:"fullscreen",label:B.popupFullScreen,setup:v,commit:x}]},{type:"hbox",children:[{type:"checkbox",id:"scrollbars",label:B.popupScrollBars,setup:v,commit:x},{type:"checkbox",id:"dependent",label:B.popupDependent,setup:v,commit:x}]},{type:"hbox",children:[{type:"text",widths:["50%","50%"],labelLayout:"horizontal",label:A.width,id:"width",setup:v,commit:x},{type:"text",labelLayout:"horizontal",widths:["50%","50%"],label:B.popupLeft,id:"left",setup:v,commit:x}]},{type:"hbox",children:[{type:"text",labelLayout:"horizontal",widths:["50%","50%"],label:A.height,id:"height",setup:v,commit:x},{type:"text",labelLayout:"horizontal",label:B.popupTop,widths:["50%","50%"],id:"top",setup:v,commit:x}]}]}]}]},{id:"upload",label:B.upload,title:B.upload,hidden:!0,filebrowser:"uploadButton",elements:[{type:"file",id:"upload",label:A.upload,style:"height:40px",size:29},{type:"fileButton",id:"uploadButton",label:A.uploadSubmit,filebrowser:"info:url","for":["upload","upload"]}]},{id:"advanced",label:B.advanced,title:B.advanced,elements:[{type:"vbox",padding:1,children:[{type:"hbox",widths:["45%","35%","20%"],children:[{type:"text",id:"advId",requiredContent:"a[id]",label:B.id,setup:w,commit:y},{type:"select",id:"advLangDir",requiredContent:"a[dir]",label:B.langDir,"default":"",style:"width:110px",items:[[A.notSet,""],[B.langDirLTR,"ltr"],[B.langDirRTL,"rtl"]],setup:w,commit:y},{type:"text",id:"advAccessKey",requiredContent:"a[accesskey]",width:"80px",label:B.acccessKey,maxLength:1,setup:w,commit:y}]},{type:"hbox",widths:["45%","35%","20%"],children:[{type:"text",label:B.name,id:"advName",requiredContent:"a[name]",setup:w,commit:y},{type:"text",label:B.langCode,id:"advLangCode",requiredContent:"a[lang]",width:"110px","default":"",setup:w,commit:y},{type:"text",label:B.tabIndex,id:"advTabIndex",requiredContent:"a[tabindex]",width:"80px",maxLength:5,setup:w,commit:y}]}]},{type:"vbox",padding:1,children:[{type:"hbox",widths:["45%","55%"],children:[{type:"text",label:B.advisoryTitle,requiredContent:"a[title]","default":"",id:"advTitle",setup:w,commit:y},{type:"text",label:B.advisoryContentType,requiredContent:"a[type]","default":"",id:"advContentType",setup:w,commit:y}]},{type:"hbox",widths:["45%","55%"],children:[{type:"text",label:B.cssClasses,requiredContent:"a(cke-xyz)","default":"",id:"advCSSClasses",setup:w,commit:y},{type:"text",label:B.charset,requiredContent:"a[charset]","default":"",id:"advCharset",setup:w,commit:y}]},{type:"hbox",widths:["45%","55%"],children:[{type:"text",label:B.rel,requiredContent:"a[rel]","default":"",id:"advRel",setup:w,commit:y},{type:"text",label:B.styles,requiredContent:"a{cke-xyz}","default":"",id:"advStyles",validate:CKEDITOR.dialog.validate.inlineStyle(a.lang.common.invalidInlineStyle),setup:w,commit:y}]}]}]}],onShow:function(){var a=this.getParentEditor(),b=a.getSelection(),c=null;(c=h.getSelectedLink(a))&&c.hasAttribute("href")?b.getSelectedElement()||b.selectElement(c):c=null,this.setupContent(u.apply(this,[a,c]))},onOk:function(){var a={},b=[],c={},g=this.getParentEditor();this.commitContent(c);switch(c.type||"url"){case"url":var h=c.url&&c.url.protocol!=void 0?c.url.protocol:"http://",i=c.url&&CKEDITOR.tools.trim(c.url.url)||"";a["data-cke-saved-href"]=i.indexOf("/")===0?i:h+i;break;case"anchor":h=c.anchor&&c.anchor.id,a["data-cke-saved-href"]="#"+(c.anchor&&c.anchor.name||h||"");break;case"email":var j=c.email,h=j.address;switch(z){case"":case"encode":var i=encodeURIComponent(j.subject||""),k=encodeURIComponent(j.body||""),j=[];i&&j.push("subject="+i),k&&j.push("body="+k),j=j.length?"?"+j.join("&"):"",z=="encode"?(h=["javascript:void(location.href='mailto:'+",f(h)],j&&h.push("+'",d(j),"'"),h.push(")")):h=["mailto:",h,j];break;default:h=h.split("@",2),j.name=h[0],j.domain=h[1],h=["javascript:",e(j)]}a["data-cke-saved-href"]=h.join("")}if(c.target)if(c.target.type=="popup"){for(var h=["window.open(this.href, '",c.target.name||"","', '"],l=["resizable","status","location","toolbar","menubar","fullscreen","scrollbars","dependent"],i=l.length,j=function(a){c.target[a]&&l.push(a+"="+c.target[a])},k=0;k<i;k++)l[k]=l[k]+(c.target[l[k]]?"=yes":"=no");j("width"),j("left"),j("height"),j("top"),h.push(l.join(","),"'); return false;"),a["data-cke-pa-onclick"]=h.join(""),b.push("target")}else c.target.type!="notSet"&&c.target.name?a.target=c.target.name:b.push("target"),b.push("data-cke-pa-onclick","onclick");c.adv&&(h=function(d,e){var f=c.adv[d];f?a[e]=f:b.push(e)},h("advId","id"),h("advLangDir","dir"),h("advAccessKey","accessKey"),c.adv.advName?a.name=a["data-cke-saved-name"]=c.adv.advName:b=b.concat(["data-cke-saved-name","name"]),h("advLangCode","lang"),h("advTabIndex","tabindex"),h("advTitle","title"),h("advContentType","type"),h("advCSSClasses","class"),h("advCharset","charset"),h("advStyles","style"),h("advRel","rel")),h=g.getSelection(),a.href=a["data-cke-saved-href"];if(this._.selectedElement){g=this._.selectedElement,i=g.data("cke-saved-href"),j=g.getHtml(),g.setAttributes(a),g.removeAttributes(b),c.adv&&c.adv.advName&&CKEDITOR.plugins.link.synAnchorSelector&&g.addClass(g.getChildCount()?"cke_anchor":"cke_anchor_empty");if(i==j||c.type=="email"&&j.indexOf("@")!=-1)g.setHtml(c.type=="email"?c.email.address:a["data-cke-saved-href"]),h.selectElement(g);delete this._.selectedElement}else h=h.getRanges()[0],h.collapsed&&(g=new CKEDITOR.dom.text(c.type=="email"?c.email.address:a["data-cke-saved-href"],g.document),h.insertNode(g),h.selectNodeContents(g)),g=new CKEDITOR.style({element:"a",attributes:a}),g.type=CKEDITOR.STYLE_INLINE,g.applyToRange(h),h.select()},onLoad:function(){a.config.linkShowAdvancedTab||this.hidePage("advanced"),a.config.linkShowTargetTab||this.hidePage("target")},onFocus:function(){var a=this.getContentElement("info","linkType");a&&a.getValue()=="url"&&(a=this.getContentElement("info","url"),a.select())}}})