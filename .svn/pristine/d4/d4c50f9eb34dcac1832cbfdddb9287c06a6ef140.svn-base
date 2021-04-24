Util = {
    chargeSateNode:null,
    flag:0,
    topo_data:[
    {"element": "node", "id": "cloud", "image": "cloud", "name": "Data center"},
    {"element": "node", "name": "Source", "id": "power", "icon": "icon_battery","state":"energy1"},
    {"element": "node", "name": "Network device", "id": "gateway", "image": "subnetwork", "icon": "icon_wall"}, 
    {"element": "node", "name": "Database", "id": "USMap", "icon": "icon_db"}, 
    {"element": "node", "name": "Server1", "id": "OfficeNetwork1", "icon": "icon_server"},
    {"element": "node", "name": "Server2", "id": "OfficeNetwork2", "icon": "icon_server"},     
    {"element": "node", "name": "Middleware", "id": "mailserver", "icon": "icon_middleware"}, 
    {"element": "node", "name": "Air conditioner", "id": "server1", "icon": "icon_air"}, 
    {"element": "node", "name": "Fire fighting", "id": "server2", "icon": "icon_fire"}, 
    {"element": "node", "name": "UPS", "id": "server3", "icon": "icon_power"}, 
    {"element": "node", "name": "OS1", "id": "server4", "icon": "icon_win7"}, 
    {"element": "node", "name": "mail server", "id": "server6", "icon": "icon_mail"}, 
    {"element": "node", "name": "Web server", "id": "server9", "icon": "icon_web"}, 
    {"element": "node", "name": "Storage server", "id": "server8", "icon": "icon_disk"}, 
    {"element": "node", "name": "OS2", "id": "server5", "icon": "icon_linux"}, 
    {"element": "node", "name": "OS3", "id": "server7", "icon": "icon_apple"}, 
    {"element": "node", "name": "FOC system", "id": "webserver", "icon": "icon_arrow_in"}, 
    {"element": "link", "from": "cloud", "to": "gateway", "name":"locate","arrow": "01"}, 
    {"element": "link", "from": "cloud", "to": "OfficeNetwork1","name":"locate","arrow": "01"}, 
    {"element": "link", "from": "cloud", "to": "OfficeNetwork2","name":"locate","arrow": "01"}, 
    {"element": "link", "from": "cloud", "to": "server1", "name":"depend","arrow": "01"}, 
    {"element": "link", "from": "cloud", "to": "server2", "name":"depend","arrow": "01"},
    {"element": "link", "from": "cloud", "to": "server3", "name":"depend","arrow": "01"},      
    {"element": "link", "from": "gateway", "to": "OfficeNetwork1", "name":"link","arrow": "01"},  
    {"element": "link", "from": "OfficeNetwork1", "to": "mailserver", "name":"include","arrow": "01"},
    {"element": "link", "from": "OfficeNetwork1", "to": "server4", "name":"include","arrow": "01"},  
    {"element": "link", "from": "OfficeNetwork1", "to": "server6", "name":"include","arrow": "01"},  
    {"element": "link", "from": "OfficeNetwork1", "to": "server9", "name":"include","arrow": "01"},  
    {"element": "link", "from": "OfficeNetwork1", "to": "server8", "name":"include","arrow": "01"},  
    {"element": "link", "from": "OfficeNetwork2", "to": "server5","name":"include","arrow": "01"}, 
    {"element": "link", "from": "OfficeNetwork2", "to": "server7","name":"include","arrow": "01"}, 
    {"element": "link", "from": "OfficeNetwork2", "to": "USMap","name":"include","arrow": "01"},     
    {"element": "link", "from": "webserver", "to": "mailserver", "name":"include","arrow": "01"}, 
    {"element": "link", "from": "webserver", "to": "USMap", "name":"include","arrow": "01"},
    {"element": "link", "from": "server1", "to": "power", "name":"use","arrow": "01"}
    ],
    alarmCode:["网元断链告警","设备掉电","基站退出服务","小区关断告警","小区关断告警","基带单元处于初始化状态"],
    needAddPoint: function(p1, p2){
        var linkWidth = 8;
        var equalX = Math.abs(p1.x-p2.x)<linkWidth/2 ? true : false;
        var equalY = Math.abs(p1.y-p2.y)<linkWidth/2 ? true : false;
        var equalXY = Math.abs(Math.abs(p2.x-p1.x)-Math.abs(p2.y-p1.y))<linkWidth/2 ? true : false;
        if (equalX || equalY || equalXY){
            return false;
        }else{
            return true;
        }
    },
    straightOblique: function(p1, p2){
        var pointX, pointY;
        if (Math.abs(p2.x-p1.x) > Math.abs(p2.y-p1.y)){
            var sign = p2.x>p1.x ? 1 : -1;
            pointX = p2.x - Math.abs(p2.y-p1.y)*sign;
            pointY = p1.y;
        }else{
            var sign = p2.y>p1.y ? 1 : -1;
            pointX = p1.x;
            pointY = p2.y - Math.abs(p2.x-p1.x)*sign;
        }
        return {x:pointX, y:pointY};
    },
    obliqueStraight: function(p1, p2){
        var pointX, pointY;
        if (Math.abs(p2.x-p1.x) > Math.abs(p2.y-p1.y)){
           var sign = p2.x>p1.x ? 1 : -1;
           pointX = p1.x + Math.abs(p2.y-p1.y)*sign;
           pointY = p2.y;
       }else{
           var sign = p2.y>p1.y ? 1 : -1;
           pointX = p2.x;
           pointY = p1.y + Math.abs(p2.x-p1.x)*sign;
       }
       return {x:pointX, y:pointY};
   },
   addSubjoinPoints: function(p1, p, p2, offset) {
    var pts = new twaver.List();
    var list = new twaver.List();
    var l1 = _twaver.math.getDistance(p1, p);
    var n1 = l1<offset?l1:offset;
    var l2 = _twaver.math.getDistance(p2, p);
    var n2 = l2<offset?l2:offset;

    var m1 = {x:p.x+(p1.x-p.x)*n1/l1, y:p.y+(p1.y-p.y)*n1/l1};
    var m2 = {x:p.x+(p2.x-p.x)*n2/l2, y:p.y+(p2.y-p.y)*n2/l2};
    pts.add(m1);
    pts.add(p);
    pts.add(m2);
    return pts;
},
createElement: function(box, item){
    var element;
    if(item.element == 'link'){
        var from = box.getDataById(item.from);
        var to = box.getDataById(item.to);
        var link = new twaver.Link(from, to);
        link.setStyle('shadow.blur',10);
        link.setStyle('shadow.xoffset',6);
        link.setStyle('shadow.yoffset',6);
        link.setStyle('link.width',2);
        link.setStyle('link.color','#4DA492');
        link.setStyle('outer.width', 0);            
        link.setStyle('arrow.from.color', '#4DA492');
        link.setStyle('arrow.to.color', '#4DA492');
        if(item.arrow){
            if(item.arrow=="10" || item.arrow=="11") link.setStyle('arrow.from', true);
            if(item.arrow=="01" || item.arrow=="11") link.setStyle('arrow.to', true);
        }               
        box.add(link);
        element=link;
    }
    if(item.element =='node'){
        var node = new twaver.Node(item.id);
        if(item.image){
            node.setImage(item.image);
            if(item.image=='group') node.setImage(twaver.Defaults.IMAGE_GROUP);
            if(item.image=='subnetwork') node.setImage(twaver.Defaults.IMAGE_SUBNETWORK);
        }               
        if(item.icon){
            node.setStyle('icons.names', [item.icon]);
            node.setStyle('icons.position', 'bottomright.topleft');
        }
        if(item.state) {
            node.setStyle("image.state", item.state);
            if(!Util.chargeSateNode && item.state.indexOf("engery")) {
                Util.chargeSateNode = node;
            }
        }
        node.setStyle('shadow.blur',10);
        node.setStyle('shadow.xoffset',5);
        node.setStyle('shadow.yoffset',5);
        box.add(node);
        element=node;
    }

    if(element){
        element.setStyle('label.font', '11px "Microsoft Yahei"');
        element.setName(item.name);
    }
},
changeState:function() {
    if(this.chargeSateNode ) {
        setInterval(function() {
            if(Util.flag > 3) {
                Util.flag = 0;
            }
            Util.flag++;
            Util.chargeSateNode.setStyle('image.state', "energy" + Util.flag);
        },500);
    }
},
showTopo: function(id,element,network2, width, height,left,top, title){
    var width=width || 600;
    var height=height || 400;

    var div=document.getElementById(id);
    if(div){
        document.body.removeChild(div);
    }
    div=document.createElement('div');
    div.setAttribute('id', id);
    div.style.display = 'block';
    div.style.position = 'absolute';
    div.style.width=width || "50%";
    div.style.height=height || "50%";
    div.style['border-radius']='5px';
    if(element instanceof twaver.ShapeLink){
        div.style['background-color']=element.getStyle('link.color').colorRgb(0.8);
    }else if(element instanceof twaver.Node){
        // div.style['background-color']="#CDCDCD".colorRgb(0.8);
        div.style['background-color']="#b1d85c".colorRgb(0.9);
    }
    div.style.left = left || '50%'; 
    div.style.top = top || '50%';
    document.body.appendChild(div);

    if(network2){
        div.appendChild(network2.getView());
        var w = parseInt(width), h = parseInt(height);
        network2.adjustBounds({x: w * 0.02, y: 0, width: w * 0.96, height: h*0.9});
    }

    var span=document.createElement('span');
    span.style.display = 'block';
    span.style['color']='black';
    span.style['font-size']='15px';
    span.style.position = 'absolute';
    span.style.left = '5%';
    span.style.top = '6px';
    span.innerHTML=element.getToolTip() ? element.getToolTip() +title:  element.getName()+title;
    div.appendChild(span);
    return div;
},
showDialog: function(id,element,content, width, height,left,top) {
    var width=width || 600;
    var height=height || 400;

    var div=document.getElementById(id);
    if(div){
        document.body.removeChild(div);
    }
    div=document.createElement('div');
    div.setAttribute('id', id);
    div.style.display = 'block';
    div.style.position = 'absolute';
    div.style.width=width || "50%";
    div.style.height=height || "50%";
    div.style['border-radius']='5px';
    if(element instanceof twaver.ShapeLink){
        div.style['background-color']=element.getStyle('link.color').colorRgb(0.8);
    }else if(element instanceof twaver.Node){
        // div.style['background-color']="#CDCDCD".colorRgb(0.8);
        div.style['background-color']="#b1d85c".colorRgb(0.9);
    }
    div.style.left = left || '50%'; 
    div.style.top = top || '50%';
    document.body.appendChild(div);

    if(content){
       content.setAttribute('id', id + "table");
       content.style.display = 'block';
       content.style.position = 'absolute';
       content.style.left = '5%';
       content.style.top = '15%';
       content.style.width="90%";
       content.style.height="80%";
       div.appendChild(content);
   }

   var span=document.createElement('span');
   span.style.display = 'block';
   span.style['color']='black';
   span.style['font-size']='15px';
   span.style.position = 'absolute';
   span.style.left = '5%';
   span.style.top = '6px';
   span.innerHTML=element.getToolTip() ? element.getToolTip() + " 4G网络告警信息" :  element.getName();
   div.appendChild(span);

   var span=document.createElement('span');
   span.style.display = 'block';
   span.style['color']='black';
   span.style['font-size']='15px';
   span.style.position = 'absolute';
   span.style.left = '49%';
   span.style.top = '100%';
   span.setAttribute('class','org_bot_cor');
   if(element instanceof twaver.ShapeLink){
       span.style['border-color'] = element.getStyle('link.color').colorRgb(0.8) + ' transparent  transparent transparent';
   }else if(element instanceof twaver.Node){
       span.style['border-color'] = '#CDCDCD'.colorRgb(0.8) + ' transparent  transparent transparent';
   }
   div.appendChild(span);

   var img=document.createElement('img');
   img.style.position = 'absolute';
   img.style.right= '2%';
   img.style.top = '2%';
   img.style.width = '20px';
   img.style.height = '20px';
   img.setAttribute('src', './js/subway/close.png');
   img.onclick = function () {
       document.body.removeChild(div);
   };
   
div.appendChild(img);
return div;
},
showButtonList: function(id,element,table,content, width, height,left,top){
    var width=width || 200;
    var height=height || 40;
    var div=document.getElementById(id);
    if(div){
        document.body.removeChild(div);
    }
    div=document.createElement('div');
    div.setAttribute('id', id);
    div.style.display = 'block';
    div.style.position = 'absolute';
    div.style.width=width || "50%";
    div.style.height=height || "50%";
    div.style['border-radius']='5px';
    if(element instanceof twaver.ShapeLink){
        div.style['background-color']=element.getStyle('link.color').colorRgb(0.8);
    }else if(element instanceof twaver.Node){
        div.style['background-color']="white";
        // div.style['background-color']=element.getClient('lineColor').colorRgb(0.8);
    }
    div.style.left = left || '50%'; 
    div.style.top = top || '50%';
    document.body.appendChild(div);

    var span=document.createElement('span');
    span.style.display = 'block';
    span.style['color']='black';
    span.style.position = 'absolute';
    span.style.left = (parseInt(width) - 20)/2 + 'px';
    span.style.top = '100%';
    span.setAttribute('class','org_bot_cor');
    if(element instanceof twaver.ShapeLink){
        span.style['border-color'] = element.getStyle('link.color').colorRgb(0.8) + ' transparent  transparent transparent';
    } else if(element instanceof twaver.Node){
        // span.style['border-color'] = '#CDCDCD' + ' transparent  transparent transparent';
        span.style['border-color'] = element.getClient('lineColor').colorRgb(0.1) + ' transparent  transparent transparent';
    }
    div.appendChild(span);

    var button = document.createElement('button');
    button.style['width'] = '16.66%';
    button.style['height'] = '90%';
    button.style['border'] = '5%';
    button.style['color'] = 'black';
    button.style['border-radius']='5px';
    button.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
    button.innerHTML = "展示";
    button.style['text-align']  = 'center';
    button.onmousemove = function(e) {
        this.style['background-color'] = element.getClient('lineColor').colorRgb(0.3) || '#CDCDCD';
    }
    button.onmouseout = function(e){
        this.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
    }
    button.onclick = function () {
     var dialog = document.getElementById(id);
     dialog && document.body.removeChild(dialog);
     var box3d = new mono.DataBox();
     var networkPane = document.createElement('div');
     networkPane.setAttribute('id','networkPane');
     network.getView().appendChild(networkPane);
     setup("networkPane");
     networkPane.style['position'] = 'absolute';
     networkPane.style['left'] = '260px';
     networkPane.style['top'] = '0px';
     $('#networkPane').animate({
        top:'100px',
    },'normal','swing',function(){
    });
};
div.appendChild(button);

var button = document.createElement('button');
button.style['width'] = '16.66%';
button.style['height'] = '90%';
button.style['border'] = '5%';
button.style['color'] = 'black';
button.style['border-radius']='5px';
button.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
button.innerHTML = "测试";
button.style['text-align']  = 'center';
button.onmousemove = function(e) {
    this.style['background-color'] = element.getClient('lineColor').colorRgb(0.3) || '#CDCDCD';
}
button.onmouseout = function(e){
    this.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
}
button.onclick = function () {

};
div.appendChild(button);
var button = document.createElement('button');
button.style['width'] = '16.66%';
button.style['height'] = '90%';
button.style['border'] = '5%';
button.style['color'] = 'black';
button.style['border-radius']='5px';
button.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
button.innerHTML = "告警";
button.style['text-align']  = 'center';
button.onmousemove = function(e) {
    this.style['background-color'] = element.getClient('lineColor').colorRgb(0.3) || '#CDCDCD';
}
button.onmouseout = function(e){
    this.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
}
button.onclick = function (e) {
    var dialog = document.getElementById(id);
    dialog && document.body.removeChild(dialog);
    var left = e.clientX, top = e.clientY;
    table._visibleFunction = function(data){
        return true;
    }
    table.invalidateDisplay();
    table.invalidateModel();
    Util.showDialog('dialog_alarm',element,content,"660px","200px",(left - 660/2)+'px',(top - 220)+'px');
    $('#dialog_alarm').animate({
        top:(top - 200)+'px',
    },'normal','swing',function(){
    });

};
div.appendChild(button);
var button = document.createElement('button');
button.style['width'] = '16.66%';
button.style['height'] = '90%';
button.style['border'] = '5%';
button.style['color'] = 'black';
button.style['border-radius']='5px';
button.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
button.innerHTML = "故障";
button.style['text-align']  = 'center';
button.onmousemove = function(e) {
    this.style['background-color'] = element.getClient('lineColor').colorRgb(0.3) || '#CDCDCD';
}
button.onmouseout = function(e){
    this.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
}
button.onclick = function () {

};
div.appendChild(button);

var button = document.createElement('button');
button.style['width'] = '16.66%';
button.style['height'] = '90%';
button.style['border'] = '5%';
button.style['color'] = 'black';
button.style['border-radius']='5px';
button.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
button.style['text-align']  = 'center';
button.innerHTML = "图纸";
button.onmousemove = function(e) {
    this.style['background-color'] = element.getClient('lineColor').colorRgb(0.3) || '#CDCDCD';
}
button.onmouseout = function(e){
    this.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
}
button.onclick = function (e) {
    var dialog = document.getElementById(id);
    dialog && document.body.removeChild(dialog);
    var box2 = new twaver.ElementBox();
    var network2 = new twaver.vector.Network(box2);
    var view = network2.getView();
    var autoLayouter = new twaver.layout.AutoLayouter(box2);
        // network2.setZoomManager(new twaver.vector.MixedZoomManager(network2,false));
        var items = Util.topo_data;
        var i,item;
        for(i = 0;i < items.length; i++){
            item = items[i];
            Util.createElement(box2, item);
        }
        var self = this;
        var hGap=80;
        autoLayouter.getDimension=function (node) {
            if (node instanceof twaver.Group && node.getChildrenSize() > 0) {
                var rect = null;
                for (var i = 0, n = node.getChildrenSize(); i < n; i++) {
                    var child = node.getChildAt(i);
                    if (child instanceof twaver.Node) {
                        if (rect) {
                            rect = _twaver.math.unionRect(rect, child.getRect());
                        } else {
                            rect = child.getRect();
                        }
                    }
                }
                if (rect) {
                    return { width: rect.width+hGap, height: rect.height };
                } else {
                    return null;
                }
            } else {
                return { width: node.getWidth()+hGap, height: node.getHeight() };
            }
        },
        autoLayouter.doLayout('hierarchic', function(){
            network2.zoomOverview();
        });
        var left = e.clientX, top = e.clientY;
        var width = 760, height = 360;
        Util.showTopo('dialog_topo',element,network2,width+"px",height+"px",'260px','0px','图纸');
        Util.changeState();
        $('#dialog_topo').animate({
            top:'100px',
        },'normal','swing',function(){
        });
    };
    div.appendChild(button);
    var button = document.createElement('button');
    button.style['width'] = '16.66%';
    button.style['text-align']  = 'center';
    button.style['height'] = '90%';
    button.style['border'] = '5%';
    button.style['color'] = 'black';
    button.style['border-radius']='5px';
    button.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';;
    button.innerHTML = "电路";
    button.onmousemove = function(e) {
        this.style['background-color'] = element.getClient('lineColor').colorRgb(0.3) || '#CDCDCD';
    }
    button.onmouseout = function(e){
        this.style['background-color'] = element.getClient('lineColor').colorRgb(0.1) || '#CDCDCD';
    }
    button.onclick = function (e) {
        var dialog = document.getElementById(id);
        dialog && document.body.removeChild(dialog);
        var box3 = new twaver.ElementBox();
        var network3 = new twaver.vector.Network(box3);
        var left = e.clientX, top = e.clientY;
        var width = 760, height = 360;
        Util.showTopo('dialog_topo',element,network3,width+"px",height+"px",'260px','0px','主接线图');
        $('#dialog_topo').animate({
            top:'100px',
        },'normal','swing',function(){
        });
        var points = new twaver.List();
        var link;

        var node1 = createNode(box3,{x:435,y:19});
        node1.setToolTip("node1");
        node1.setImage("singleSwitch");

        var node2 = createNode(box3,{x:452,y:15},"QF1:AC INPUT\n1600A3P");
        node2.setToolTip("node2");

        var node3 = createNode(box3,{x:39,y:60});
        node3.setImage("mainLine");
        node3.setToolTip("node3");

        var node4 = createNode(box3,{x:76,y:63},"140KVA");
        node4.setToolTip("node4");

        var node5 = createNode(box3,{x:256,y:86});
        node5.setImage("singleSwitch");
        node5.setToolTip("node5");


        var _node6 = createNode(box3,{x:268,y:84},"KO1:AC INPUT\n800A/3P");
        _node6.setToolTip("_node6");

        var node6 = createNode(box3,{x:763,y:87});
        node6.setImage("singleSwitch");
        node6.setToolTip("node6");
        var node7 = createNode(box3,{x:773,y:86},"QF2:AC INPUT\n1250A/3P");
        node7.setToolTip("node7");

        var node8 = createNode(box3,{x:85,y:134});
        node8.setImage("doubleSwitch");
        node8.setToolTip("node8");

        var node9 = createNode(box3,{x:72,y:130},"400A");
        node9.setClient("rotate", -90);
        node9.setToolTip("node9");

            // var node10 = createNode(box3,{x:105,y:118},"切换开关");
            // node10.setToolTip("node10");

            var node11 = createNode(box3,{x:749,y:115}," ACsource\n200KVA*4");
            node11.setSize(50,30);
            node11.setToolTip("node11");
            node11.setImage("textOutLine");

            var node12 = createNode(box3,{x:6,y:173},"Data Center Lab");
            node12.setToolTip("node12");

            // var node13 = createNode(box3,{x:31,y:202},"A区/D区\n选择开关");
            // node13.setToolTip("node13");

            var node14 = createNode(box3,{x:97,y:203});
            node14.setImage("doubleSwitch");
            node14.setToolTip("node14");

            var node15 = createNode(box3,{x:81,y:196},"400A");
            node15.setToolTip("node15");
            node15.setClient("rotate", -90);

            var node16 = createNode(box3,{x:7,y:255},"D Area Test");
            node16.setToolTip("node16");

            // var node17 = createNode(box3,{x:130,y:217},"市电/油机\n选择开关");
            // node17.setToolTip("node17");

            var node18 = createNode(box3,{x:154,y:220},"400A*2");
            node18.setToolTip("node18");
            node18.setClient("rotate", -90);

            var node19 = createCircle(box3,{x:116, y:274});
            node19.setToolTip("node19");

            var node20 = createCircle(box3,{x:134, y:254});
            node20.setToolTip("node20");

            var node21 = createCircle(box3,{x:264, y:160});
            node21.setToolTip("node21");


            points = new twaver.List();
            points.add({x: node20.getX() + node20.getWidth()/2, y: node21.getY() + node21.getHeight()/2});
            link = createShapeLink(box3,node21, node20, points);

            var node22 = createCircle(box3,{x:390, y:160});
            node22.setToolTip("node22");

            var node23 = createCircle(box3,{x:540, y:160});
            node23.setToolTip("node23");
            link = createLink(box3,node22, node23, "left");

            var node24 = createCircle(box3,{x:630, y:160});
            node24.setToolTip("node24");
            link = createLink(box3,node23, node24);

            var node25 = createNode(box3,{x:296,y:195});
            node25.setToolTip("node25");
            node25.setImage("ddSwitch");

            var node26 = createNode(box3,{x:235,y:188},"K3");
            node26.setToolTip("node26");

            var node27 = createNode(box3,{x:243,y:194},"800A");
            node27.setToolTip("node27");
            node27.setClient("rotate", -90);

            var node28 = createNode(box3,{x:315,y:187},"K4");
            node28.setToolTip("node28");

            var node29 = createNode(box3,{x:295,y:193},"800A");
            node29.setToolTip("node29");
            node29.setClient("rotate", -90);

            var node30 = createCircle(box3,{x:390, y:340});
            node30.setToolTip("node30");
            link = createLink(box3,node22, node30);

            var node31 = createNode(box3,{x:507,y:235});
            node31.setToolTip("node31");
            node31.setImage("ddSwitch");

            var node32 = createNode(box3,{x:597,y:235});
            node32.setToolTip("node32");
            node32.setImage("ddSwitch");

            var node33 = createNode(box3,{x:447,y:229},"K1");
            node33.setToolTip("node33");
            var node34 = createNode(box3,{x:454,y:234},"800A");
            node34.setToolTip("node34");
            node34.setClient("rotate", -90);

            var _node34 = createNode(box3,{x:513,y:227},"K2");
            _node34.setToolTip("_node34");
            var node35 = createNode(box3,{x:519,y:235},"800A");
            node35.setToolTip("node35");
            node35.setClient("rotate", -90);

            var node36 = createNode(box3,{x:554,y:227},"K3");
            node36.setToolTip("node36");

            var node37 = createNode(box3,{x:537,y:235},"800A");
            node37.setToolTip("node37");
            node37.setClient("rotate", -90);

            var node38 = createNode(box3,{x:627,y:229},"K4");
            node38.setToolTip("node38");

            var node39 = createNode(box3,{x:603,y:235},"800A");
            node39.setToolTip("node39");
            node39.setClient("rotate", -90);

            var node40 = createNode(box3,{x:168,y:256.5});
            node40.setToolTip("node40");
            node40.setImage("doubleRightSwitch");

            var node41 = createNode(box3,{x:306,y:241});
            node41.setToolTip("node41");
            node41.setImage("doubleCircle");

            var node42 = createNode(box3,{x:314,y:268},"500KVA\n380V-480V/500V");
            node42.setClient("font","8px arial");
            node42.setToolTip("node42");

            var node43 = createNode(box3,{x:100,y:343},"800A");
            node43.setToolTip("node43");
            node43.setClient("rotate", -90);

            // var node44 = createNode(box3,{x:136,y:336},"市电/油机\n选择开关");
            // node44.setToolTip("node44");

            var node45 = createNode(box3,{x:198,y:344});
            node45.setToolTip("node45");
            node45.setImage("dReverseSwitch");

            var node46 = createNode(box3,{x:168,y:293});
            node46.setToolTip("node46");
            node46.setImage("doubleRightSwitch");

            var node47 = createNode(box3,{x:203,y:400});
            node47.setToolTip("node47");
            node47.setImage("ddSwitch");

            var node48 = createNode(box3,{x:141,y:396},"K5");
            node48.setToolTip("node48");
            var node49 = createNode(box3,{x:150,y:402},"800A");
            node49.setToolTip("node49");
            node49.setClient("rotate", -90);

            var node50 = createNode(box3,{x:218,y:396},"K6");
            node50.setToolTip("node50");
            var node51 = createNode(box3,{x:200,y:403},"800A");
            node51.setToolTip("node51");
            node51.setClient("rotate", -90);

            // var node52 = createNode(box3,{x:111,y:431},"主路电源选择开关");

            var node53 = createNode(box3,{x:295,y:397},"K7");
            node53.setToolTip("node53");

            var node54 = createNode(box3,{x:305,y:403},"800A");
            node54.setToolTip("node54");
            node54.setClient("rotate", -90);

            var node55 = createNode(box3,{x:363,y:397},"K8");
            node55.setToolTip("node55");
            var node56 = createNode(box3,{x:374,y:403},"800A");
            node56.setToolTip("node56");
            node56.setClient("rotate", -90);

            var node57 = createNode(box3,{x:357,y:400});
            node57.setToolTip("node57");
            node57.setImage("ddSwitch");

            // var node58 = createNode(box3,{x:368,y:429},"旁路电源\n选择开关");
            // node58.setToolTip("node58");

            // var node59 = createNode(box3,{x:448,y:274},"主路电源选择开关");
            // node59.setToolTip("node59");
            // var node60 = createNode(box3,{x:635,y:275},"旁路电源选择开关");
            // node60.setToolTip("node60");

            var node61 = createCircle(box3,{x:477, y:309});
            node61.setToolTip("node61");

            var node62 = createCircle(box3,{x:525, y:309});
            node62.setToolTip("node62");

            var node63 = createCircle(box3,{x:586, y:309});
            node63.setToolTip("node63");

            var node64 = createCircle(box3,{x:712, y:309});
            node64.setToolTip("node64");

            var node65 = createNode(box3,{x:453, y:310});
            node65.setImage("horizoanlLine");
//            node65.setToolTip("node65");

var node66 = createNode(box3,{x:453, y:340});
node66.setImage("horizoanlLine");
//            node66.setToolTip("node66");

var node67 = createCircle(box3,{x:508, y:339});
node67.setToolTip("node67");

var node68 = createCircle(box3,{x:615, y:339});
node68.setToolTip("node68");

var node69 = createCircle(box3,{x:631, y:339});
node69.setToolTip("node69");

var node70 = createCircle(box3,{x:748, y:339});
node70.setToolTip("node70");

            // var node71 = createNode(box3,{x:399,y:348},"主路\n接触器");
            // node71.setClient("font", "8px arial");
            // node71.setToolTip("node71");
            var node72 = createNode(box3,{x:417,y:353},"800A");
            node72.setToolTip("node72");
            node72.setClient("rotate", -90);

            // var node73 = createNode(box3,{x:487,y:342},"旁路\n接触器");
            // node73.setClient("font", "8px arial");
            // node73.setToolTip("node73");
            var node74 = createNode(box3,{x:504,y:346},"800A");
            node74.setClient("font", "8px arial");
            node74.setToolTip("node74");
            node74.setClient("rotate", -90);

            var node75 = createNode(box3,{x:469,y:354});
            node75.setToolTip("node75");
            node75.setImage("singleSwitch");

            var node76 = createNode(box3,{x:500,y:354});
            node76.setToolTip("node76");
            node76.setImage("singleSwitch");

            // var node77 = createNode(box3,{x:518,y:362},"主路\n接触器");
            // node77.setClient("font", "8px arial");
            // node77.setToolTip("node77");
            var node78 = createNode(box3,{x:532,y:359},"800A");
            node78.setClient("font", "8px arial");
            node78.setToolTip("node78");
            node78.setClient("rotate", -90);

            // var node79 = createNode(box3,{x:610,y:350},"旁路\n接触器");
            // node79.setClient("font", "8px arial");
            // node79.setToolTip("node79");
            var node80 = createNode(box3,{x:573,y:356},"800A");
            node80.setClient("font", "8px arial");
            node80.setToolTip("node80");
            node80.setClient("rotate", -90);

            var node81 = createNode(box3,{x:578,y:354});
            node81.setToolTip("node81");
            node81.setImage("singleSwitch");

            var node82 = createNode(box3,{x:623,y:354});
            node82.setToolTip("node82");
            node82.setImage("singleSwitch");

            // var node83 = createNode(box3,{x:642,y:352},"主路\n接触器");
            // node83.setClient("font", "8px arial");
            // node83.setToolTip("node83");
            var node84 = createNode(box3,{x:656,y:355},"800A");
            node84.setClient("font", "8px arial");
            node84.setToolTip("node84");
            node84.setClient("rotate", -90);

            // var node85 = createNode(box3,{x:730,y:352},"旁路\n接触器");
            // node85.setClient("font", "8px arial");
            // node85.setToolTip("node85");
            var node86 = createNode(box3,{x:692,y:359},"800A");
            node86.setClient("font", "8px arial");
            node86.setToolTip("node86");
            node86.setClient("rotate", -90);

            var node87 = createNode(box3,{x:704,y:354});
            node87.setToolTip("node87");
            node87.setImage("singleSwitch");

            var node88 = createNode(box3,{x:740,y:354});
            node88.setToolTip("node88");
            node88.setImage("singleSwitch");

            var node89 = createNode(box3,{x:460,y:392});
            node89.setClient("textName","B-1")
            node89.setToolTip("node89");
            node89.setImage("inputOutSwitch");

            var node90 = createNode(box3,{x:574,y:392});
            node90.setClient("textName","B-2")
            node90.setToolTip("node90");
            node90.setImage("inputOutSwitch");

            var node91 = createNode(box3,{x:699,y:392});
            node91.setClient("textName","B-3")
            node91.setToolTip("node91");
            node91.setImage("inputOutSwitch");


            var node92 = createNode(box3,{x:45, y:464});
            node92.setImage("horizoanlLine");
//            node92.setToolTip("node92");

var node93 = createNode(box3,{x:45, y:497});
node93.setImage("horizoanlLine");
//            node93.setToolTip("node93");

var node94 = createCircle(box3,{x:70, y:463});
node94.setToolTip("node94");

var node95 = createCircle(box3,{x:221, y:463});
node95.setToolTip("node95");

var node96 = createCircle(box3,{x:111, y:496});
node96.setToolTip("node96");

var node97 = createCircle(box3,{x:248, y:496});
node97.setToolTip("node97");

var node98 = createCircle(box3,{x:360, y:496});
node98.setToolTip("node98");

var node99 = createCircle(box3,{x:375, y:496});
node99.setToolTip("node99");

            // var node100 = createNode(box3,{x:480,y:471},"输出\n接触器");
            // node100.setClient("font", "8px arial");
            // node100.setToolTip("node100");

            var node101 = createNode(box3,{x:434,y:477},"800A");
            node101.setClient("font", "8px arial");
            node101.setToolTip("node101");
            node101.setClient("rotate", -90);


            // var node102 = createNode(box3,{x:591,y:471},"输出\n接触器");
            // node102.setClient("font", "8px arial");
            // node102.setToolTip("node102");

            var node103 = createNode(box3,{x:549,y:477},"800A");
            node103.setClient("font", "8px arial");
            node103.setToolTip("node103");
            node103.setClient("rotate", -90);


            // var node104 = createNode(box3,{x:719,y:471},"输出\n接触器");
            // node104.setClient("font", "8px arial");
            // node104.setToolTip("node104");

            var node105 = createNode(box3,{x:676,y:477},"800A");
            node105.setClient("font", "8px arial");
            node105.setToolTip("node105");
            node105.setClient("rotate", -90);

            var node106 = createNode(box3,{x:485,y:469});
            node106.setToolTip("node106");
            node106.setImage("singleSwitch");

            var node107 = createNode(box3,{x:599,y:469});
            node107.setToolTip("node107");
            node107.setImage("singleSwitch");

            var node108 = createNode(box3,{x:724,y:469});
            node108.setToolTip("node108");
            node108.setImage("singleSwitch");

            // var node109 = createNode(box3,{x:13,y:527},"主路\n接触器");
            // node109.setClient("font", "8px arial");
            // node109.setToolTip("node109");
            var node110 = createNode(box3,{x:35,y:514},"800A");
            node110.setClient("font", "8px arial");
            node110.setToolTip("node110");
            node110.setClient("rotate", -90);

            // var node111 = createNode(box3,{x:92,y:529},"旁路\n接触器");
            // node111.setClient("font", "8px arial");
            // node111.setToolTip("node111");
            var node112 = createNode(box3,{x:56,y:536},"800A");
            node112.setClient("font", "8px arial");
            node112.setToolTip("node112");
            node112.setClient("rotate", -90);


            // var node113 = createNode(box3,{x:160,y:534},"主路\n接触器");
            // node113.setClient("font", "8px arial");
            // node113.setToolTip("node113");
            var node114 = createNode(box3,{x:186,y:540},"800A");
            node114.setClient("font", "8px arial");
            node114.setToolTip("node114");
            node114.setClient("rotate", -90);

            // var node115 = createNode(box3,{x:230,y:535},"旁路\n接触器");
            // node115.setClient("font", "8px arial");
            // node115.setToolTip("node115");
            var node116 = createNode(box3,{x:199,y:541},"800A");
            node116.setClient("font", "8px arial");
            node116.setToolTip("node116");
            node116.setClient("rotate", -90);


            var node117 = createNode(box3,{x:61,y:526});
            node117.setToolTip("node117");
            node117.setImage("singleSwitch");

            var node118 = createNode(box3,{x:102,y:526});
            node118.setToolTip("node118");
            node118.setImage("singleSwitch");

            var node119 = createNode(box3,{x:213,y:526});
            node119.setToolTip("node119");
            node119.setImage("singleSwitch");

            var node120 = createNode(box3,{x:240,y:526});
            node120.setToolTip("node120");
            node120.setImage("singleSwitch");

            // var node121 = createNode(box3,{x:280,y:531},"主路\n接触器");
            // node121.setClient("font", "8px arial");
            // node121.setToolTip("node121");
            var node122 = createNode(box3,{x:305,y:536},"800A");
            node122.setClient("font", "8px arial");
            node122.setToolTip("node122");
            node122.setClient("rotate", -90);

            // var node123 = createNode(box3,{x:363,y:533},"旁路\n接触器");
            // node123.setClient("font", "8px arial");
            // node123.setToolTip("node123");
            var node124 = createNode(box3,{x:323,y:537},"800A");
            node124.setClient("font", "8px arial");
            node124.setToolTip("node124");
            node124.setClient("rotate", -90);

            var node125 = createNode(box3,{x:329,y:526});
            node125.setToolTip("node125");
            node125.setImage("singleSwitch");

            var node126 = createNode(box3,{x:367,y:526});
            node126.setToolTip("node126");
            node126.setImage("singleSwitch");

            var node127 = createNode(box3,{x:55,y:580});
            node127.setClient("textName","A-1")
            node127.setToolTip("node127");
            node127.setImage("inputOutSwitch");

            var node128 = createNode(box3,{x:200,y:580});
            node128.setClient("textName","A-2")
            node128.setToolTip("node128");
            node128.setImage("inputOutSwitch");

            var node129 = createNode(box3,{x:324,y:580});
            node129.setClient("textName","A-3")
            node129.setToolTip("node129");
            node129.setImage("inputOutSwitch");

            var node130 = createNode(box3,{x:30,y:664},"800A");
            node130.setClient("font", "8px arial");
            node130.setToolTip("node130");
            node130.setClient("rotate", -90);

            // var node131 = createNode(box3,{x:71,y:657},"输出\n接触器");
            // node131.setClient("font", "8px arial");
            // node131.setToolTip("node131");


            var node132 = createNode(box3,{x:171,y:664},"800A");
            node132.setClient("font", "8px arial");
            node132.setToolTip("node132");
            node132.setClient("rotate", -90);

            // var node133 = createNode(box3,{x:219,y:656},"输出\n接触器");
            // node133.setClient("font", "8px arial");
            // node133.setToolTip("node133");


            var node134 = createNode(box3,{x:297,y:664},"800A");
            node134.setClient("font", "8px arial");
            node134.setToolTip("node134");
            node134.setClient("rotate", -90);

            // var node135 = createNode(box3,{x:341,y:657},"输出\n接触器");
            // node135.setClient("font", "8px arial");
            // node135.setToolTip("node135");


            var node136 = createNode(box3,{x:79,y:656});
            node136.setToolTip("node136");
            node136.setImage("singleSwitch");

            var node137 = createNode(box3,{x:225,y:656});
            node137.setToolTip("node137");
            node137.setImage("singleSwitch");

            var node138 = createNode(box3,{x:349,y:656});
            node138.setToolTip("node138");
            node138.setImage("singleSwitch");

            link = createLink(box3,node127, node136);
            link.setStyle("link.from.yoffset", node127.getHeight()/2);
            link.setStyle("link.to.yoffset", -node136.getHeight()/2);

            var node139 = createCircle(box3,{x:233, y:696});
            node139.setToolTip("node139");

            var node140 = createCircle(box3,{x:357, y:696});
            node140.setToolTip("node140");

            link = createLink(box3,node139, node140);


            var node141 = createCircle(box3,{x:425, y:696});
            node141.setToolTip("node141");

            link = createLink(box3,node140, node141);


            var node142 = createNode(box3,{x:74, y:767}, "Data Center Lab");
            node142.setToolTip("node142");

            var node143 = createNode(box3,{x:234,y:759});
            node143.setToolTip("node143");
            node143.setImage("singleSwitch");

            // var node144 = createNode(box3,{x:252, y:738}, "A区/B区负载\n切换开关");
            // node144.setToolTip("node144");

            // var node145 = createNode(box3,{x:136, y:802}, "数据中心/A区\n负载切换开关");
            // node145.setToolTip("node145");
            // node145.setClient("font", "7px arial");

            var node146 = createNode(box3,{x:209,y:805});
            node146.setToolTip("node146");
            node146.setImage("ddSwitch");

            var node147 = createNode(box3,{x:215, y:805}, "800A");
            node147.setToolTip("node147");
            node147.setClient("rotate", -90);

            var node148 = createNode(box3,{x:194, y:857});
            node148.setImage("textOutLine");
            node148.setClient("textName", "KEC:500KVA");
            node148.setToolTip("node148");


            var node149 = createNode(box3,{x:283, y:825});
            node149.setImage("textOutLine");
            node149.setClient("textName", "LEC:375KVA");
            node149.setToolTip("node149");

            var node150 = createNode(box3,{x:369, y:787});
            node150.setImage("textOutLine");
            node150.setClient("textName", "Feedback");
            node150.setToolTip("node150");

            var node151 = createNode(box3,{x:417,y:727});
            node151.setToolTip("node151");
            node151.setImage("singleSwitch");

            // var node152 = createNode(box3,{x:430, y:710}, "市电/AC\n回馈输入\n1250M/3P");
            // node152.setToolTip("node152");



            var node153 = createNode(box3,{x:457, y:757});
            node153.setImage("textOutLine");
            node153.setClient("textName", "K:200KW");
            node153.setToolTip("node153");

            var node154 = createNode(box3,{x:673, y:757});
            node154.setImage("textOutLine");
            node154.setClient("textName", "KEC:240KVA");
            node154.setToolTip("node154");

            var node155 = createNode(box3,{x:725, y:675});
            node155.setImage("textOutLine");
            node155.setClient("textName", "Feedback");
            node155.setToolTip("node155");

            var node156 = createNode(box3,{x:562,y:701});
            node156.setToolTip("node156");
            node156.setImage("ddSwitch");

            // var node157 = createNode(box3,{x:455, y:668}, "数据中心实验室");
            // node157.setToolTip("node157");

            // var node158 = createNode(box3,{x:598, y:635}, "A/B区负载\n切换开关");
            // node158.setToolTip("node158");

            // var node159 = createNode(box3,{x:735, y:623}, "市电/AC\n回馈输入\n1250/3P");
            // node159.setToolTip("node159");

            // var node160 = createNode(box3,{x:607, y:697}, "数据中心/D区\n负载切换开关");
            // node160.setToolTip("node160");

            // var node161 = createNode(box3,{x:523, y:768}, "K02\n负载总电源");
            // node161.setToolTip("node161");

            var node162 = createNode(box3,{x:563,y:703},"800A");
            node162.setClient("font", "8px arial");
            node162.setToolTip("node162");
            node162.setClient("rotate", -90);

            var node163 = createNode(box3,{x:548,y:754});
            node163.setToolTip("node163");
            node163.setImage("leftSingleSwitch");

            var node164 = createCircle(box3,{x:607, y:534});
            node164.setToolTip("node164");

            var node165 = createCircle(box3,{x:607, y:574});
            node165.setToolTip("node165");

            link = createLink(box3,node164, node165);

            var node166 = createNode(box3,{x:587,y:642});
            node166.setToolTip("node166");
            node166.setImage("dReverseSwitch");

            var node167 = createNode(box3,{x:736,y:630});
            node167.setToolTip("node167");
            node167.setImage("singleSwitch");

            var node168 = createNode(box3,{x:530,y:521});
            node168.setToolTip("node168");
            node168.setImage("leftSingleSwitch");

            var node169 = createNode(box3,{x:674,y:521});
            node169.setToolTip("node169");
            node169.setImage("leftSingleSwitch");

            var node170 = createNode(box3,{x:470,y:516});
            node170.setToolTip("node170");
            node170.setImage("patternRect");

            //to deal with scale.
            var node171 = createCircle(box3,{x:510, y:60});
            node171.setToolTip("node171");

            var node172 = createCircle(box3,{x:510, y:232});
            node172.setToolTip("node172");

            link = createLink(box3,node171, node172, "bottom");

            var node173 = createCircle(box3,{x:540, y:232});
            node173.setToolTip("node173");

            link = createLink(box3,node23, node173,"bottom");

            var node174 = createCircle(box3,{x:600, y:60});
            node174.setToolTip("node174");

            var node175 = createCircle(box3,{x:600, y:232});
            node175.setToolTip("node175");

            link = createLink(box3,node174, node175, "bottom");

            var node176 = createCircle(box3,{x:630, y:232});
            node176.setToolTip("node176");

            link = createLink(box3,node24, node176,"bottom");

            var node177 = createCircle(box3,{x:772, y:60});
            node177.setToolTip("node177");

            var node178 = createCircle(box3,{x:772, y:87});
            node178.setToolTip("node178");

            link = createLink(box3,node177, node178);

            var node179 = createCircle(box3,{x:772, y:101});
            node179.setToolTip("node179");

            var node180 = createCircle(box3,{x:772, y:112});
            node180.setToolTip("node180");

            link = createLink(box3,node179, node180);

            var node181 = createCircle(box3,{x:525, y:263});
            node181.setToolTip("node181");

            link = createLink(box3,node181, node62);

            var node182 = createCircle(box3,{x:615, y:263});
            node182.setToolTip("node182");

            link = createLink(box3,node182, node68);

            var node183 = createCircle(box3,{x:477, y:354});
            node183.setToolTip("node183");

            link = createLink(box3,node61, node183);

            var node184 = createCircle(box3,{x:477, y:368});
            node184.setToolTip("node184");

            var node185 = createCircle(box3,{x:477, y:395});
            node185.setToolTip("node185");

            link = createLink(box3,node184, node185);

            var node186 = createCircle(box3,{x:508, y:354});
            node186.setToolTip("node186");

            link = createLink(box3,node67, node186);

            var node187 = createCircle(box3,{x:508, y:368});
            node187.setToolTip("node187");

            var node188 = createCircle(box3,{x:508, y:395});
            node188.setToolTip("node188");

            link = createLink(box3,node187, node188);

            var node189 = createCircle(box3,{x:586, y:354});
            node189.setToolTip("node189");

            link = createLink(box3,node63, node189);

            var node190 = createCircle(box3,{x:586, y:368});
            node190.setToolTip("node190");

            var node191 = createCircle(box3,{x:586, y:395});
            node191.setToolTip("node191");

            link = createLink(box3,node190, node191);

            var node192 = createCircle(box3,{x:631, y:354});
            node192.setToolTip("node192");

            link = createLink(box3,node69, node192);

            var node193 = createCircle(box3,{x:631, y:368});
            node193.setToolTip("node193");

            var node194 = createCircle(box3,{x:631, y:395});
            node194.setToolTip("node194");

            link = createLink(box3,node193, node194);

            var node195 = createCircle(box3,{x:712, y:354});
            node195.setToolTip("node195");

            link = createLink(box3,node64, node195);

            var node196 = createCircle(box3,{x:712, y:368});
            node196.setToolTip("node196");

            var node197 = createCircle(box3,{x:712, y:395});
            node197.setToolTip("node197");

            link = createLink(box3,node196, node197);

            var node198 = createCircle(box3,{x:748, y:354});
            node198.setToolTip("node198");

            link = createLink(box3,node70, node198);

            var node199 = createCircle(box3,{x:748, y:368});
            node199.setToolTip("node199");

            var node200 = createCircle(box3,{x:748, y:395});
            node200.setToolTip("node200");

            link = createLink(box3,node199, node200);

            var node201 = createCircle(box3,{x:493, y:440});
            node201.setToolTip("node201");

            var node202 = createCircle(box3,{x:493, y:469});
            node202.setToolTip("node202");

            link = createLink(box3,node201, node202);

            var node203 = createCircle(box3,{x:493, y:484});
            node203.setToolTip("node203");

            var node204 = createCircle(box3,{x:530, y:534});
            node204.setToolTip("node204");

            points = new twaver.List();
            points.add({x:node106.getX() + node106.getWidth() / 2, y: node168.getY() + node168.getHeight()});
            link = createShapeLink(box3,node203, node204, points);

            var node205 = createCircle(box3,{x:607, y:440});
            node205.setToolTip("node205");

            var node206 = createCircle(box3,{x:607, y:469});
            node206.setToolTip("node206");

            link = createLink(box3,node205, node206);

            var node207 = createCircle(box3,{x:607, y:484});
            node207.setToolTip("node207");

            link = createLink(box3,node207, node164);

            var node208 = createCircle(box3,{x:732, y:440});
            node208.setToolTip("node208");

            var node209 = createCircle(box3,{x:732, y:469});
            node209.setToolTip("node209");

            link = createLink(box3,node208, node209);

            var node210 = createCircle(box3,{x:732, y:484});
            node210.setToolTip("node210");

            var node211 = createCircle(box3,{x:694, y:534});
            node211.setToolTip("node211");

            points = new twaver.List();
            points.add({x:node108.getX() + node108.getWidth() / 2, y: node169.getY() + node169.getHeight()});
            link = createShapeLink(box3,node210, node211, points);

            var node212 = createCircle(box3,{x:550, y:534});
            node212.setToolTip("node212");

            link = createLink(box3,node164, node212);

            var node213 = createCircle(box3,{x:674, y:534});
            node213.setToolTip("node213");

            link = createLink(box3,node164, node213);

            var node214 = createCircle(box3,{x:607, y:642});
            node214.setToolTip("node214");

            link = createLink(box3,node165, node214);

            var node215 = createCircle(box3,{x:596, y:656});
            node215.setToolTip("node215");

            var node216 = createCircle(box3,{x:596, y:701});
            node216.setToolTip("node216");

            link = createLink(box3,node216, node215);

            var node217 = createCircle(box3,{x:586, y:642});
            node217.setToolTip("node217");

            points = new twaver.List();
            points.add({x:node166.getX(), y: (node166.getY() + node165.getY())/2});
            points.add({x:node141.getX() + node141.getWidth()/2, y: (node166.getY() + node165.getY())/2});
            link = createShapeLink(box3,node217, node141, points);

            var node218 = createCircle(box3,{x:744, y:630});
            node218.setToolTip("node218");

            points = new twaver.List();
            points.add({x:node167.getX() + node167.getWidth()/2, y: node165.getY() + node165.getHeight()/2});
            link = createShapeLink(box3,node218, node165, points);

            var node219 = createCircle(box3,{x:744, y:645});
            node219.setToolTip("node219");

            var node220 = createCircle(box3,{x:744, y:673});
            node220.setToolTip("node220");

            link = createLink(box3,node219, node220);

            var node221 = createCircle(box3,{x:580, y:729});
            node221.setToolTip("node221");

            var node222 = createCircle(box3,{x:580, y:767});
            node222.setToolTip("node222");

            link = createLink(box3,node221, node222);

            var node223 = createCircle(box3,{x:671, y:767});
            node223.setToolTip("node223");

            var node224 = createCircle(box3,{x:567, y:767});
            node224.setToolTip("node224");

            link = createLink(box3,node223, node224);

            var node225 = createCircle(box3,{x:525, y:767});
            node225.setToolTip("node225");

            var node226 = createCircle(box3,{x:548, y:767});
            node226.setToolTip("node226");

            link = createLink(box3,node225, node226);

            var node227 = createCircle(box3,{x:425, y:727});
            node227.setToolTip("node227");

            link = createLink(box3,node141, node227);

            var node228 = createCircle(box3,{x:425, y:742});
            node228.setToolTip("node228");

            var node229 = createCircle(box3,{x:425, y:785});
            node229.setToolTip("node229");

            link = createLink(box3,node229, node228);

            var node230 = createCircle(box3,{x:252, y:759});
            node230.setToolTip("node230");

            points = new twaver.List();
            points.add({x:node150.getX() + node150.getWidth()/2, y: node165.getY() + node165.getHeight()/2});
            points.add({x:node150.getX() + node150.getWidth()/2, y: node151.getY()});
            points.add({x:node143.getX() + node143.getWidth(), y: node151.getY()});
            link = createShapeLink(box3,node165, node230, points);

            var node231 = createCircle(box3,{x:233, y:759});
            node231.setToolTip("node231");

            link = createLink(box3,node139, node231);

            var node232 = createCircle(box3,{x:243, y:774});
            node232.setToolTip("node232");

            var node233 = createCircle(box3,{x:243, y:804});
            node233.setToolTip("node233");

            link = createLink(box3,node232, node233);

            var node234 = createCircle(box3,{x:243, y:780});
            node234.setToolTip("node234");

            var node235 = createCircle(box3,{x:301, y:823});
            node235.setToolTip("node235");

            points = new twaver.List();
            points.add({x: node149.getX() + node149.getWidth()/2 - 15, y: node143.getY() + node143.getHeight() + node143.getHeight()/2});
            link = createShapeLink(box3,node234, node235, points);

            var node236 = createCircle(box3,{x:227, y:833});
            node234.setToolTip("node234");

            var node237 = createCircle(box3,{x:227, y:855});
            node235.setToolTip("node235");

            link = createLink(box3,node236, node237);

            var node238 = createCircle(box3,{x:74 + node142.getWidth()/2 , y:765 - node142.getHeight()/2});
            node238.setToolTip("node238");

            var node239 = createCircle(box3,{x:212, y:804});
            node239.setToolTip("node239");

            points = new twaver.List();
            points.add({x: node146.getX() + 5, y: node142.getY() - node142.getHeight()/2});
            link = createShapeLink(box3,node238, node239, points);

            var node240 = createCircle(box3,{x:233, y:669});
            node240.setToolTip("node240");

            link = createLink(box3,node240, node139);

            var node241 = createCircle(box3,{x:357, y:669});
            node241.setToolTip("node241");

            link = createLink(box3,node241, node140);

            var node242 = createCircle(box3,{x:87, y:669});
            node242.setToolTip("node242");

            points = new twaver.List();
            points.add({x: node136.getX() + node136.getWidth()/2, y: node139.getY() + node139.getHeight()/2});
            link = createShapeLink(box3,node242, node139, points);

            var node243 = createCircle(box3,{x:233, y:628});
            node243.setToolTip("node243");

            var node244 = createCircle(box3,{x:233, y:656});
            node244.setToolTip("node244");

            link = createLink(box3,node243, node244);

            var node245 = createCircle(box3,{x:357, y:628});
            node245.setToolTip("node245");

            var node246 = createCircle(box3,{x:357, y:656});
            node246.setToolTip("node246");

            link = createLink(box3,node245, node246);

            var node247 = createCircle(box3,{x:87, y:628});
            node247.setToolTip("node247");

            var node248 = createCircle(box3,{x:87, y:656});
            node248.setToolTip("node248");

            link = createLink(box3,node247, node248);

            var node249 = createCircle(box3,{x:70, y:540});
            node249.setToolTip("node249");

            var node250 = createCircle(box3,{x:70, y:583});
            node250.setToolTip("node250");

            link = createLink(box3,node249, node250);

            var node251 = createCircle(box3,{x:111, y:540});
            node251.setToolTip("node251");

            var node252 = createCircle(box3,{x:111, y:583});
            node252.setToolTip("node252");

            link = createLink(box3,node251, node252);

            var node253 = createCircle(box3,{x:221, y:540});
            node253.setToolTip("node253");

            var node254 = createCircle(box3,{x:221, y:583});
            node254.setToolTip("node254");

            link = createLink(box3,node253, node254);

            var node255 = createCircle(box3,{x:248, y:540});
            node255.setToolTip("node255");

            var node256 = createCircle(box3,{x:248, y:583});
            node256.setToolTip("node256");

            link = createLink(box3,node255, node256);

            var node257 = createCircle(box3,{x:337, y:540});
            node257.setToolTip("node257");

            var node258 = createCircle(box3,{x:337, y:583});
            node258.setToolTip("node258");

            link = createLink(box3,node257, node258);

            var node259 = createCircle(box3,{x:375, y:540});
            node259.setToolTip("node259");

            var node260 = createCircle(box3,{x:375, y:583});
            node260.setToolTip("node260");

            link = createLink(box3,node259, node260);

            var node261 = createCircle(box3,{x:70, y:526});
            node261.setToolTip("node261");

            link = createLink(box3,node94, node261);

            var node262 = createCircle(box3,{x:111, y:526});
            node262.setToolTip("node262");

            link = createLink(box3,node96, node262);

            var node263 = createCircle(box3,{x:221, y:526});
            node263.setToolTip("node263");

            link = createLink(box3,node95, node263);

            var node264 = createCircle(box3,{x:248, y:526});
            node264.setToolTip("node264");

            link = createLink(box3,node97, node264);

            var node265 = createCircle(box3,{x:375, y:526});
            node265.setToolTip("node265");

            link = createLink(box3,node99, node265);

            var node266 = createCircle(box3,{x:337, y:526});
            node266.setToolTip("node266");

            points = new twaver.List();
            points.add({x:node21.getX() + node21.getWidth()/2 , y: node53.getY() + node53.getHeight()});
            points.add({x:node125.getX() + node125.getWidth()/2 , y: node53.getY() + node53.getHeight()});
            link = createShapeLink(box3,node21, node266, points);

            var node267 = createCircle(box3,{x:221, y:428});
            node267.setToolTip("node267");

            link = createLink(box3,node267, node95);

            var node268 = createCircle(box3,{x:375, y:428});
            node268.setToolTip("node268");

            link = createLink(box3,node268, node99);

            var node269 = createCircle(box3,{x:207, y:358});
            node269.setToolTip("node269");

            var node270 = createCircle(box3,{x:207, y:398});
            node270.setToolTip("node270");

            link = createLink(box3,node269, node270);

            var node271 = createCircle(box3,{x:207, y:363});
            node271.setToolTip("node271");

            var node272 = createCircle(box3,{x:360, y:398});
            node272.setToolTip("node272");

            points = new twaver.List();
            points.add({x:node57.getX() + 5 ,y: node45.getY() + node45.getHeight() + 5});
            link = createShapeLink(box3,node272, node271, points);

            var node273 = createCircle(box3,{x:390, y:398});
            node273.setToolTip("node273");

            link = createLink(box3,node30, node273);

            var node274 = createCircle(box3,{x:236, y:398});
            node274.setToolTip("node274");

            points = new twaver.List();
            points.add({x:node47.getX() + node47.getWidth() - 5 ,y:node30.getY() + node30.getHeight()/2});
            link = createShapeLink(box3,node30, node274, points);

            var node275 = createCircle(box3,{x:314, y:267});
            node275.setToolTip("node275");

            var node276 = createCircle(box3,{x:216, y:344});
            node276.setToolTip("node276");

            points = new twaver.List();
            points.add({x:node41.getX() + node41.getWidth()/2,y: node46.getY() + node46.getHeight()/2});
            points.add({x:node45.getX() + node41.getWidth(),y: node46.getY() + node46.getHeight()/2});
            link = createShapeLink(box3,node275, node276, points);

            var node277 = createCircle(box3,{x:314, y:223});
            node277.setToolTip("node277");

            var node278 = createCircle(box3,{x:314, y:240});
            node278.setToolTip("node278");

            link = createLink(box3,node277, node278);

            var node279 = createCircle(box3,{x:329, y:193});
            node279.setToolTip("node279");

            points = new twaver.List();
            points.add({x:node25.getX() + node25.getWidth() - 5,y: node22.getY() + node22.getHeight()/2});
            link = createShapeLink(box3,node22, node279, points);

            var node280 = createCircle(box3,{x:299, y:193});
            node280.setToolTip("node280");

            points = new twaver.List();
            points.add({x:node25.getX() + 5,y: node21.getY() + node21.getHeight()/2});
            link = createShapeLink(box3,node21, node280, points);

            var node281 = createCircle(box3,{x:196, y:344});
            node281.setToolTip("node281");

            var node282 = createCircle(box3,{x:182, y:301});
            node282.setToolTip("node282");

            points = new twaver.List();
            points.add({x:node45.getX(),y: node46.getY() + node46.getHeight()/2});
            link = createShapeLink(box3,node282, node281, points);

            var node283 = createCircle(box3,{x:182, y:264.5});
            node283.setToolTip("node283");

            points = new twaver.List();
            points.add({x:node45.getX(),y: node40.getY() + node40.getHeight()/2});
            link = createShapeLink(box3,node283, node281, points);

            var node284 = createCircle(box3,{x:166, y:274});
            node284.setToolTip("node284");

            link = createLink(box3,node19, node284);

            var node285 = createCircle(box3,{x:166, y:254});
            node285.setToolTip("node285");

            link = createLink(box3,node20, node285);

            var node286 = createCircle(box3,{x:166, y:311});
            node286.setToolTip("node286");

            points = new twaver.List();
            points.add({x:node19.getX() + node19.getWidth()/2,y: node46.getY() + node46.getHeight()});
            link = createShapeLink(box3,node19, node286, points);

            var node287 = createCircle(box3,{x:166, y:291});
            node287.setToolTip("node287");

            points = new twaver.List();
            points.add({x:node20.getX() + node20.getWidth()/2,y: node46.getY()});
            link = createShapeLink(box3,node20, node287, points);

            var node288 = createCircle(box3,{x:116, y:217});
            node288.setToolTip("node288");

            link = createLink(box3,node288, node19);

            var node289 = createCircle(box3,{x:95, y:217});
            node289.setToolTip("node289");

            var node290 = createCircle(box3,{x:7 + node16.getWidth()/2, y:238 + node16.getHeight()/2});
            node290.setToolTip("node290");

            points = new twaver.List();
            points.add({x:node14.getX(), y: node16.getY()});
            link = createShapeLink(box3,node289, node290, points);

            var node289 = createCircle(box3,{x:105, y:202});
            node289.setToolTip("node289");

            var node290 = createCircle(box3,{x:105, y:148});
            node290.setToolTip("node290");

            link = createLink(box3,node290, node289);

            var node291 = createCircle(box3,{x:83, y:148});
            node291.setToolTip("node291");

            var node292 = createCircle(box3,{x:6 + node12.getWidth()/2, y:171+ node12.getHeight()});
            node292.setToolTip("node292");

            points = new twaver.List();
            points.add({x:node8.getX(), y: node12.getY() + node12.getHeight()});
            link = createShapeLink(box3,node291, node292, points);

            var node293 = createCircle(box3,{x:264, y:101});
            node293.setToolTip("node293");

            link = createLink(box3,node293, node21,"bottom");

            var node294 = createCircle(box3,{x:264, y:60});
            node294.setToolTip("node294");

            var node295 = createCircle(box3,{x:264, y:84});
            node295.setToolTip("node295");

            link = createLink(box3,node294, node295);

            var node296 = createCircle(box3,{x:772, y:143});
            node296.setToolTip("node296");

            points = new twaver.List();
            points.add({x:node11.getX() + node11.getWidth()/2,y: node24.getY() + node24.getHeight()/2});
            link = createShapeLink(box3,node296, node24, points, "left");

            var node297 = createCircle(box3,{x:444, y:33});
            node297.setToolTip("node297");

            var node298 = createCircle(box3,{x:444, y:60});
            node298.setToolTip("node298");

            link = createLink(box3,node297, node298);

            var node299 = createCircle(box3,{x:93, y:134});
            node299.setToolTip("node299");

            var node300 = createCircle(box3,{x:93, y:60});
            node300.setToolTip("node300");

            link = createLink(box3,node300, node299,"bottom");

            _twaver.callLater(function(){
                network3.zoomOverview();
            })
        }
        function createNode(box,location,label,state) {
            var node = new twaver.Node();
            if(label) {
                node.setClient("textName",label);
                node.setImage("textNode");
            } else {
                node.setStyle("image.state","state1");
            }
            node.setLocation(location.x, location.y);
            box.add(node);
            return node;
        }
        function createCircle(box,location) {
            var node = new twaver.Node();
            node.setSize(4,4);
            node.setStyle("body.type","vector");
            node.setStyle("vector.shape","circle");
            node.setStyle('vector.fill', true);
            node.setStyle('vector.fill.color', 'green');
            node.setLocation(location.x, location.y);
            box.add(node);
            return node;
        }
        function createLink(box,from, to, state) {
            var link = new twaver.Link(from, to);
            link.setStyle("link.width", 1);
            link.setStyle("link.color", "blue");
            link.setStyle("icons.names", ["icon"]);
            if(state) {
                if(state == "bottom" || state == "top") {
                    link.setStyle("icons.xoffset",-2);
                } else {
                    link.setStyle("icons.yoffset",-2);
                }
                link.setStyle("image.state",state);
            }
            box.add(link);
            return link;
        }
        function createShapeLink(box,from, to, points, state) {
            var shapeLink = new twaver.ShapeLink(from, to);
            shapeLink.setPoints(points);
            shapeLink.setStyle("link.width", 1);
            shapeLink.setStyle("link.color", "blue");
            shapeLink.setStyle("icons.names", ["icon"]);
            box.add(shapeLink);
            return shapeLink;
        }
        div.appendChild(button);
        return div;
    },
    createTopo: function(){

    },
    createInfoPane: function(data) {
      if(!data) return;
      var pane = document.createElement('div');
      pane.setAttribute('class', 'easyui-panel');
      pane.style['width'] = "100%";
      pane.style['height'] = "100%";
      pane.style['padding'] = '0px 0px';

      var div = document.createElement('div');
      div.style['position'] = "absolute";
      div.style['width'] = "50%";
      div.style['height'] = "30%";
      div.style['top'] = "20%";
      div.style['background-color']= data.getClient('lineColor');
      var label = document.createElement('div');
      label.style['position'] = "absolute";
      label.innerHTML = data.getClient('lineNumber');
      div.appendChild(label);
      pane.appendChild(div);
      return pane;
  },
  registerNormalImage: function (url, name) {
      var image = new Image();
      image.src = url;
      image.onload = function() {
       twaver.Util.registerImage(name, image, image.width, image.height);
       image.onload = null;
       network.invalidateElementUIs();
   };
},
init: function() {
    Array.intersect = function () {  
        var result = new Array();  
        var obj = {};  
        for (var i = 0; i < arguments.length; i++) {  
            for (var j = 0; j < arguments[i].length; j++) {  
                var str = arguments[i][j];  
                if (!obj[str]) {  
                    obj[str] = 1;  
                }  
                else {  
                    obj[str]++;  
                    if (obj[str] == arguments.length)  
                    {  
                        result.push(str);  
                    }  
            }//end else  
        }//end for j  
    }//end for i  
    return result;  
}  

var reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;  
String.prototype.colorRgb = function(a){  
   var sColor = this.toLowerCase();  
   if(sColor && reg.test(sColor)){  
    if(sColor.length === 4){  
     var sColorNew = "#";  
     for(var i=1; i<4; i+=1){  
      sColorNew += sColor.slice(i,i+1).concat(sColor.slice(i,i+1));     
  }  
  sColor = sColorNew;  
}  
var sColorChange = [];  
for(var i=1; i<7; i+=2){  
 sColorChange.push(parseInt("0x"+sColor.slice(i,i+2)));    
}  
if(a){
 return "rgba(" + sColorChange.join(",") + "," + a + ")";  
}else{
 return "rgb(" + sColorChange.join(",") + ")";  
}
}else{  
    return sColor;    
}  
};  
},
addAlarm: function (alarmID, staNode, alarmSeverity, alarmBox,random) {
  var alarm = new twaver.Alarm(alarmID, staNode.getId(), alarmSeverity);
  alarm.setClient("MAPPINGID",this.alarmCode[random]);
  alarm.setClient("raisedTime",new Date());
  alarm.setClient("platform",staNode.getName());
  alarm.setAcked(Math.random()* 10 > 5? true:false);
  alarmBox.add(alarm);
},
registerImage: function(){
  var linkWidth = 8;
  twaver.Util.registerImage('pin_start',{
      "w": 235.15625,
      "h": 200,
      "origin": {
        "x": 0,
        "y": 0
    },
    "clip": true,
    "translate": {
        "x": 0,
        "y": 0
    },
    "scale": {
        "x": 0.1953125,
        "y": 0.1953125
    },
    "v": [
    {
      "shape": "path",
      "data": "M605.486974 0.077787c-175.182226-4.004165-330.343626 147.15307-326.33946 320.333213 0 64.066643 45.046858 169.175978 112.116624 276.287396 68.070808 107.111418 118.122872 178.18535 174.181184 253.263446 10.010413 13.013537 23.02395 20.020826 40.041652 20.020826 16.016661 0 31.03228-8.00833 40.041652-20.020826 56.058312-75.078097 107.111418-146.152028 174.181184-253.263446 67.069766-107.111418 112.116624-212.220753 112.116624-276.287396C935.687594 147.230856 782.528277-3.926379 605.486974 0.077787L605.486974 0.077787 605.486974 0.077787 605.486974 0.077787zM628.510924 774.883745c-5.005206 7.007289-14.014578 11.011454-23.02395 11.011454-8.00833 0-18.018743-3.003124-22.022908-11.011454C433.307873 570.671322 339.209991 396.490137 339.209991 320.410999c0-72.074973 26.027074-134.139533 78.081221-185.192639 52.054147-51.053106 115.119748-77.080179 188.195762-77.080179 73.076014 0 136.141615 26.027074 188.195762 77.080179 53.055188 51.053106 79.082262 113.117666 79.082262 185.192639 0 39.04061-22.022908 98.102046-66.068725 179.186391C763.651498 580.681735 703.589021 671.776492 628.510924 774.883745L628.510924 774.883745 628.510924 774.883745 628.510924 774.883745zM603.484892 1024.00002c-114.118707 0-220.229084-10.010413-295.30718-30.031239-40.041652-10.010413-71.073932-22.022908-93.09684-37.038528-27.028115-17.017702-42.043734-39.04061-42.043734-63.065601 0-31.03228 12.012495-54.05623 37.038528-71.073932 28.029156-18.018743 73.076014-28.029156 135.140574-29.030197l1.001041 43.044775c-53.055188 0-91.094757 9.009372-112.116624 22.022908-12.012495 8.00833-18.018743 20.020826-18.018743 35.036445 0 17.017702 32.033321 40.041652 103.107253 59.061436C394.267262 971.945873 488.365143 982.099292 603.484892 982.099292c110.114542 0 212.220753-11.011454 283.294685-29.030197 69.071849-17.017702 101.10517-40.041652 101.10517-59.061436 0-8.00833-4.004165-16.016661-13.013537-25.026032-10.010413-10.010413-42.043734-36.037486-111.115583-36.037486l-3.003124 0-1.001041-43.044775c31.03228 0 60.062477 4.004165 85.08851 13.013537 25.026032 9.009372 45.046858 21.021867 60.062477 36.037486 17.017702 17.017702 26.027074 35.036445 26.027074 55.057271 0 24.024991-14.014578 46.047899-41.042693 63.065601-22.022908 15.015619-53.055188 27.028115-93.09684 37.038528C822.569928 1013.989607 718.60464 1024.00002 603.484892 1024.00002L603.484892 1024.00002 603.484892 1024.00002 603.484892 1024.00002zM367.239147 813.924355c1.001041 12.012495-8.00833 22.022908-20.020826 23.02395l-32.033321 2.002083c-12.012495 0-22.022908-9.009372-22.022908-20.020826-1.001041-12.012495 8.00833-22.022908 20.020826-23.02395l32.033321-2.002083C356.227693 793.903529 367.239147 802.912901 367.239147 813.924355L367.239147 813.924355 367.239147 813.924355zM911.662603 813.924355c-1.001041 12.012495-11.011454 21.021867-22.022908 20.020826l-32.033321-1.001041c-12.012495 0-21.021867-10.010413-21.021867-22.022908 1.001041-12.012495 10.010413-21.021867 22.022908-20.020826l32.033321 1.001041C902.653231 791.901447 911.662603 801.91186 911.662603 813.924355L911.662603 813.924355 911.662603 813.924355zM517.824359 332.852512c0-46.476917 37.610551-84.087468 84.087468-84.087468 46.476917 0 84.087468 37.610551 84.087468 84.087468s-37.610551 84.087468-84.087468 84.087468C555.43491 416.939981 517.824359 379.329429 517.824359 332.852512L517.824359 332.852512zM517.824359 332.852512",
      "fill": "#1296db"
  }
  ]
});
  twaver.Util.registerImage('pin_end',{
      "w": 235.15625,
      "h": 200,
      "origin": {
        "x": 0,
        "y": 0
    },
    "clip": true,
    "translate": {
        "x": 0,
        "y": 0
    },
    "scale": {
        "x": 0.1953125,
        "y": 0.1953125
    },
    "v": [
    {
      "shape": "path",
      "data": "M605.486974 0.077787c-175.182226-4.004165-330.343626 147.15307-326.33946 320.333213 0 64.066643 45.046858 169.175978 112.116624 276.287396 68.070808 107.111418 118.122872 178.18535 174.181184 253.263446 10.010413 13.013537 23.02395 20.020826 40.041652 20.020826 16.016661 0 31.03228-8.00833 40.041652-20.020826 56.058312-75.078097 107.111418-146.152028 174.181184-253.263446 67.069766-107.111418 112.116624-212.220753 112.116624-276.287396C935.687594 147.230856 782.528277-3.926379 605.486974 0.077787L605.486974 0.077787 605.486974 0.077787 605.486974 0.077787zM628.510924 774.883745c-5.005206 7.007289-14.014578 11.011454-23.02395 11.011454-8.00833 0-18.018743-3.003124-22.022908-11.011454C433.307873 570.671322 339.209991 396.490137 339.209991 320.410999c0-72.074973 26.027074-134.139533 78.081221-185.192639 52.054147-51.053106 115.119748-77.080179 188.195762-77.080179 73.076014 0 136.141615 26.027074 188.195762 77.080179 53.055188 51.053106 79.082262 113.117666 79.082262 185.192639 0 39.04061-22.022908 98.102046-66.068725 179.186391C763.651498 580.681735 703.589021 671.776492 628.510924 774.883745L628.510924 774.883745 628.510924 774.883745 628.510924 774.883745zM603.484892 1024.00002c-114.118707 0-220.229084-10.010413-295.30718-30.031239-40.041652-10.010413-71.073932-22.022908-93.09684-37.038528-27.028115-17.017702-42.043734-39.04061-42.043734-63.065601 0-31.03228 12.012495-54.05623 37.038528-71.073932 28.029156-18.018743 73.076014-28.029156 135.140574-29.030197l1.001041 43.044775c-53.055188 0-91.094757 9.009372-112.116624 22.022908-12.012495 8.00833-18.018743 20.020826-18.018743 35.036445 0 17.017702 32.033321 40.041652 103.107253 59.061436C394.267262 971.945873 488.365143 982.099292 603.484892 982.099292c110.114542 0 212.220753-11.011454 283.294685-29.030197 69.071849-17.017702 101.10517-40.041652 101.10517-59.061436 0-8.00833-4.004165-16.016661-13.013537-25.026032-10.010413-10.010413-42.043734-36.037486-111.115583-36.037486l-3.003124 0-1.001041-43.044775c31.03228 0 60.062477 4.004165 85.08851 13.013537 25.026032 9.009372 45.046858 21.021867 60.062477 36.037486 17.017702 17.017702 26.027074 35.036445 26.027074 55.057271 0 24.024991-14.014578 46.047899-41.042693 63.065601-22.022908 15.015619-53.055188 27.028115-93.09684 37.038528C822.569928 1013.989607 718.60464 1024.00002 603.484892 1024.00002L603.484892 1024.00002 603.484892 1024.00002 603.484892 1024.00002zM367.239147 813.924355c1.001041 12.012495-8.00833 22.022908-20.020826 23.02395l-32.033321 2.002083c-12.012495 0-22.022908-9.009372-22.022908-20.020826-1.001041-12.012495 8.00833-22.022908 20.020826-23.02395l32.033321-2.002083C356.227693 793.903529 367.239147 802.912901 367.239147 813.924355L367.239147 813.924355 367.239147 813.924355zM911.662603 813.924355c-1.001041 12.012495-11.011454 21.021867-22.022908 20.020826l-32.033321-1.001041c-12.012495 0-21.021867-10.010413-21.021867-22.022908 1.001041-12.012495 10.010413-21.021867 22.022908-20.020826l32.033321 1.001041C902.653231 791.901447 911.662603 801.91186 911.662603 813.924355L911.662603 813.924355 911.662603 813.924355zM517.824359 332.852512c0-46.476917 37.610551-84.087468 84.087468-84.087468 46.476917 0 84.087468 37.610551 84.087468 84.087468s-37.610551 84.087468-84.087468 84.087468C555.43491 416.939981 517.824359 379.329429 517.824359 332.852512L517.824359 332.852512zM517.824359 332.852512",
      "fill": "#d81e06"
  }
  ]
});
  //大站点图
  twaver.Util.registerImage('station1',{
	    w: linkWidth*2,
		h: linkWidth*2,
	    v:  [{ shape: 'circle',
		          r: 8,//控制站点大小
		          lineColor: '#FF0000',
		          lineWidth: linkWidth*0.2,
		          fill: 'white'}
	    ]
	    
	});
  
//中站点图
   twaver.Util.registerImage('station2',{
	    w: linkWidth*2,
		h: linkWidth*2,
	    v:  [{ shape: 'circle',
		          r: 7.5,//控制站点大小
		          lineColor: '#FF0000',
		          lineWidth: linkWidth*0.2,
		          fill: 'white'}
	    ]
	    
	});
  twaver.Util.registerImage('station3',{
	    w: linkWidth*1.6,
		h: linkWidth*1.6,
	    v:  [{ shape: 'circle',
		          r: 7,//控制站点大小
		          lineColor: '#FF0000',
		          lineWidth: linkWidth*0.2,
		          fill: 'white'}
	    ]
	    
	});
	twaver.Util.registerImage('station4',{
	    w: linkWidth*1.6,
		h: linkWidth*1.6,
	    v:  [{ shape: 'circle',
		          r: 6.5,//控制站点大小
		          lineColor: '#FF0000',
		          lineWidth: linkWidth*0.2,
		          fill: 'white'}
	    ]
	    
	});
	twaver.Util.registerImage('station5',{
	    w: linkWidth*1.6,
		h: linkWidth*1.6,
	    v:  [{ shape: 'circle',
		          r: 6.2,//控制站点大小
		          lineColor: '#FF0000',
		          lineWidth: linkWidth*0.2,
		          fill: 'white'}
	    ]
	    
	});
	twaver.Util.registerImage('station6',{
	    w: linkWidth*1.6,
		h: linkWidth*1.6,
	    v:  [{ shape: 'circle',
		          r: 6,//控制站点大小
		          lineColor: '#FF0000',
		          lineWidth: linkWidth*0.2,
		          fill: 'white'}
	    ]
	    
	});
	twaver.Util.registerImage('station7',{
	    w: linkWidth*1.6,
		h: linkWidth*1.6,
	    v:  [{ shape: 'circle',
		          r: 5.9,//控制站点大小
		          lineColor: '#FF0000',
		          lineWidth: linkWidth*0.2,
		          fill: 'white'}
	    ]
	    
	});
	twaver.Util.registerImage('station8',{
	    w: linkWidth*1.6,
		h: linkWidth*1.6,
	    v:  [{ shape: 'circle',
		          r: 5.8,//控制站点大小
		          lineColor: '#FF0000',
		          lineWidth: linkWidth*0.2,
		          fill: 'white'}
	    ]
	    
	});
  
  twaver.Util.registerImage('station',{
    w: linkWidth*1.6,
    h: linkWidth*1.6,
    onMouseEnter: function (data, view) {
        data.setClient('focus', true);
    },
    onMouseLeave: function (data, view) {
        data.setClient('focus', false);
    },
    v: function (data, view) {
        var result = [];
        if(data.getClient('focus')){
         result.push({
          shape: 'circle',
          r: linkWidth*0.7,
          lineColor:  data.getClient('lineColor'),
          lineWidth: linkWidth*0.2,
          fill: 'white',
      });
         result.push({
          shape: 'circle',
          r: linkWidth*0.2,//站点得中心点大小
          fill:  data.getClient('lineColor'),
      });

     }else{
         result.push({
          shape: 'circle',
          r: linkWidth*0.6,//控制站点大小
          lineColor: data.getClient('lineColor'),
          lineWidth: linkWidth*0.2,
          fill: 'white',
      });
     }
     if(data.getClient('click')){
         result.push({
          shape: "vector",
          name: "glowCircle",
          w: linkWidth*3,
          h: linkWidth*3
      });
     }
     if(data.getClient('dbclick')){
         result.push({
          shape: "vector",
          name: "loading",
          w: linkWidth*5,
          h: linkWidth*5
      });
     }
     return result;
 }
});
   //支线共用站图标
   twaver.Util.registerImage('shareStop', {
   	w: linkWidth*1.8,
   	h: linkWidth*1.8,
    onMouseEnter: function (data, view) {
        data.setClient('focus', true);
    },
    onMouseLeave: function (data, view) {
        data.setClient('focus', false);
    },
    v: function (data, view) {
     var result = [];
     if(data.getClient('focus')){
      result.push({
       shape: 'circle',
       r: linkWidth*0.8,
       lineColor: data.getClient('lineColor'),
       lineWidth: linkWidth*0.2,
       fill: 'white',
   });
      result.push({
       shape: 'circle',
       r: linkWidth*0.3,
       lineColor: data.getClient('lineColor'),
       lineWidth: linkWidth*0.1,
       fill: 'white',
   });
  }else{
      result.push({
       shape: 'circle',
       r: linkWidth*0.7,
       lineColor:  data.getClient('lineColor'),
       lineWidth: linkWidth*0.2,
       fill: 'white',
   });
      result.push({
       shape: 'circle',
       r: linkWidth*0.2,
       fill: data.getClient('lineColor'),
   });
  }
  if(data.getClient('click')){
      result.push({
       shape: "vector",
       name: "glowCircle",
       w: linkWidth*3,
       h: linkWidth*3
   });
  }
  if(data.getClient('dbclick')){
      result.push({
       shape: "vector",
       name: "loading",
       w: linkWidth*5,
       h: linkWidth*5
   });
  }
  return result;
}
});

    //换乘站图标
    twaver.Util.registerImage('transStop', {
    	w: linkWidth*2.4,
    	h: linkWidth*2.4,
        onMouseEnter: function (data, view) {
            data.setClient('focus', true);
        },
        onMouseLeave: function (data, view) {
            data.setClient('focus', false);
        },
        v: function (data, view) {
          var result = [];
          result.push({
             shape: "vector",
             name: "translation",
             w: linkWidth*2.4,
             h: linkWidth*2.4
         });

          if(data.getClient('click')){
             result.push({
                shape: "vector",
                name: "glowCircle",
                w: linkWidth*3,
                h: linkWidth*3
            });
         }
         if(data.getClient('dbclick')){
             result.push({
                shape: "vector",
                name: "loading",
                    // x:0,
                    // y:0,
                    w: linkWidth*5,
                    h: linkWidth*5
                });
         }
         return result;
     }
 });


    //shanghai Metro icon
    twaver.Util.registerImage('beijingMetro', {
    	w: 160,
    	h: 160,
    	origin: {x: 0, y: 0},
    	clip: true,
    	v: [{
    		shape: 'circle',
    		cx: 80,
    		cy: 80,
    		r: 60,
    		lineColor: 'black',
    		fill: 'white',
    		lineWidth: 0,
    	},{
    		shape: "path",
    		data: "M31.04,114.277c10.835,15.422,28.762,25.547,49,25.547c27.555,0,50.884-18.832,57.75-44.304l-13.279-0.045l-20.281-21.88L82,100L63.152,72L41.151,96.4L1.66,96.214C0.573,91,0,85.546,0,80C0,35.945,35.944,0,80,0c36.563,0,67.558,24.778,77.02,58.414h-21.262c-8.677-22.333-30.422-38.238-55.758-38.238c-31.915,0-58.142,25.231-59.741,56.754l19.285-0.015l22.922-28.4L82.18,74.605l21.1-26.272l22.348,28.158l16.403-0.045v0.03h17.9c0.046,1.177,0.076,2.339,0.076,3.516C160,124.056,124.07,160,80,160c-31.8,0-59.4-18.728-72.266-45.723H31.04z",
    		fill: "#EC1B23"
    	}]
    });
    //线路编号
    twaver.Util.registerImage('lineSign',{
    	w: 40,
    	h: 60,
    	font: '30px arial',
    	v: function (data, view) {
    		var result = [];
    		result.push(
    		{
    			shape: 'rect',
    			x: -15,
    			y: -18,
    			w: 32,
    			h: 36,
    			lineColor: data.getClient('lineColor'),
    			fill: data.getClient('lineColor'),
    		});
    		result.push(
    		{
    			shape: 'text',
    			text: data.getClient('lineNum'),
    			lineColor: 'black',
    			lineWidth:  1,
    			fill: 'white',
    		});
    		return result;
    	}
    });

    //airport
    twaver.Util.registerImage('airport',{
    	"w": 124,
    	"h": 124,
    	"origin": {
    		"x": 0,
    		"y": 0
    	},
    	"clip": true,
    	"translate": {
    		"x": 0,
    		"y": 0
    	},
    	"v": [
    	{
    		"shape": "ellipse",
    		"cx": 62,
    		"cy": 62,
    		"rx": 62,
    		"ry": 62,
    		"fill": "#7C7C7C"
    	},
    	{
    		"shape": "path",
    		"data": "M112.417,90.833V73.667l-43.75-26.348V16.667C68.667,13,65.667,10,62,10s-6.667,3-6.667,6.667  v30.652l-43.75,26.348v17.167l43.75-18.795v23.578L43.292,104.5v9.5L62,105.333L80.708,114v-9.5l-12.042-8.884V72.038  L112.417,90.833z",
    		"fill": "#FFFFFF"
    	}
    	]
    });

    //railway
    twaver.Util.registerImage('railway',{
    	"w": 124,
    	"h": 124,
    	"origin": {
    		"x": 0,
    		"y": 0
    	},
    	"clip": true,
    	"translate": {
    		"x": 0,
    		"y": 0
    	},
    	"v": [
    	{
    		"shape": "ellipse",
    		"cx": 62,
    		"cy": 62,
    		"rx": 62,
    		"ry": 62,
    		"fill": "#7C7C7C"
    	},
    	{
    		"shape": "g",
    		"v": [
    		{
    			"shape": "path",
    			"data": "M38.892,95.274l5.868-8.75c-8.617-5.779-13.762-15.412-13.762-25.768   c0-17.095,13.907-31.002,31.001-31.002c17.095,0,31.002,13.907,31.002,31.002c0,10.355-5.145,19.988-13.762,25.768l5.868,8.75   c11.54-7.74,18.43-20.644,18.43-34.518c0-19.733-13.836-36.284-32.313-40.492v-2.088c0-1.931-1.58-3.512-3.512-3.512H56.288   c-1.931,0-3.512,1.58-3.512,3.512v2.088c-18.477,4.208-32.313,20.759-32.313,40.492C20.463,74.631,27.352,87.535,38.892,95.274z",
    			"fill": "#FFFFFF"
    		},
    		{
    			"shape": "path",
    			"data": "M66.587,93.094c0,0-0.146-13.315,0-19.022c0.146-5.707,10.974-8.926,10.974-8.926v-6.731   c0-3.38-2.766-6.146-6.146-6.146H52.584c-3.38,0-6.146,2.766-6.146,6.146v6.731c0,0,10.828,3.219,10.974,8.926   c0.146,5.707,0,19.022,0,19.022s0.585,5.414-6.731,7.024c-7.316,1.61-18.29,2.488-18.29,2.488v6.731h59.218v-6.731   c0,0-10.974-0.878-18.29-2.488C66.002,98.508,66.587,93.094,66.587,93.094z",
    			"fill": "#FFFFFF"
    		}
    		]
    	}
    	]
    });

    //compass
    twaver.Util.registerImage('compass',{
    	"w": 124,
    	"h": 124,
    	"origin": {
    		"x": 0,
    		"y": 0
    	},
    	"clip": true,
    	"translate": {
    		"x": 0,
    		"y": 0
    	},
    	"v": [
    	{
    		"shape": "ellipse",
    		"cx": 62,
    		"cy": 62,
    		"rx": 62,
    		"ry": 62,
    		"fill": "#7C7C7C"
    	},
    	{
    		"shape": "g",
    		"v": [
    		{
    			"shape": "g",
    			"v": [
    			{
    				"shape": "path",
    				"data": "M62.076,107.3c-4.039,0-8.104-0.531-12.111-1.604    c-24.766-6.637-39.516-32.185-32.88-56.951C20.299,36.747,27.994,26.72,38.75,20.51c10.758-6.21,23.286-7.859,35.286-4.646    c24.767,6.637,39.516,32.186,32.88,56.952C103.701,84.813,96.006,94.84,85.25,101.05C78.085,105.187,70.133,107.3,62.076,107.3z     M62.01,17.275c-19.206,0-36.826,12.834-42.027,32.247c-6.209,23.168,7.59,47.067,30.759,53.275    c11.225,3.01,22.946,1.465,33.009-4.345s17.26-15.19,20.267-26.414l0,0c6.209-23.168-7.59-47.068-30.759-53.276    C69.502,17.755,65.726,17.275,62.01,17.275z",
    				"fill": "#FFFFFF"
    			}
    			]
    		},
    		{
    			"shape": "g",
    			"v": [
    			{
    				"shape": "path",
    				"data": "M75.543,10.236l-46.232,92.852l23.805-9.151l16.04,19.827L75.543,10.236z M59.263,90.235    L53.4,72.974l-3.923,14.64l-2.363-0.633l4.992-18.629l2.528,0.677L60.5,86.276l3.919-14.626l2.364,0.633l-4.992,18.629    L59.263,90.235z",
    				"fill": "#FFFFFF"
    			}
    			]
    		}
    		]
    	}
    	]
    });


    //换乘站图标
    twaver.Util.registerImage('translation', {
    	w: 124,
    	h: 124,
    	v: function (data, view) {
    		var result = [];
    		result.push({
    			shape: 'ellipse',
    			rx: 62,
    			ry: 62,
    			fill: "#FFFFFF"
    		});
    		if(data.getClient('focus')){
    			result.push({
    				shape:'vector',
    				name:'rotateArrow'
    			});
    		}else{
    			result.push({
    				shape:'vector',
    				name:'doubleArrow'
    			});
    		}
    		return result;
    	}
    });
    twaver.Util.registerImage('rotateArrow', {
    	w: 124,
    	h: 124,
    	v: [{
    		shape: 'vector',
    		name: 'doubleArrow',
    		rotate: 360,
    		animate: [{
    			attr: 'rotate',
    			to: 0,
    			dur: 2000,
    			reverse: false,
    			repeat: Number.POSITIVE_INFINITY
    		}]
    	}]
    });
    twaver.Util.registerImage('doubleArrow', {
    	w: 124,
    	h: 124,
    	v: function (data, view) {
    		var result = [];
    		result.push({
    			shape: 'vector',
    			name: 'arrow',
    			fill:data.getClient('focus')?"green":"#7C7C7C"
    		});
    		result.push({
    			shape: 'vector',
    			name: 'arrow',
    			rotate: 180,
    			fill:data.getClient('focus')?"red":"#7C7C7C"
    		});
    		return result;
    	}
    });
    twaver.Util.registerImage('arrow', {
    	w: 124,
    	h: 124,
    	origin: {x: 0, y: 0},
    	v: [{
    		shape: "path",
    		data: "M57.193,16.114c-22.433,0-40.642,14.713-41.37,40.35H5.71l18.453,27.193l18.453-27.193   h-9.895c-0.583-8.449,7.656-33.067,28.382-33.067c20.831,0,30.468,10.488,30.468,10.488S79.626,16.114,57.193,16.114z"
    	}]
    });

    twaver.Util.registerImage('loading', {
    	w: 100,
    	h: 100,
    	cache: false,
    	v: [{
    		shape: 'vector',
    		name: 'loading_ball',
    		rotate: 0,
    		alpha:1,
    		animate: [{
    			attr: 'alpha',
    			to: 0.3,
    			dur: 1000,
    			reverse: true,
    			repeat: Number.POSITIVE_INFINITY
    		},{
    			attr: 'rotate',
    			to: 360,
    			dur: 2000,
    			reverse: false,
    			repeat: Number.POSITIVE_INFINITY
    		}]
    	},{
    		shape: 'vector',
    		name: 'loading_ball',
    		rotate: 45,
    		alpha:1,
    		animate: [{
    			attr: 'alpha',
    			to: 0.3,
    			dur: 1000,
    			reverse: true,
    			repeat: Number.POSITIVE_INFINITY
    		},{
    			attr: 'rotate',
    			to: 405,
    			dur: 2000,
    			reverse: false,
    			repeat: Number.POSITIVE_INFINITY
    		}]
    	},{
    		shape: 'vector',
    		name: 'loading_ball',
    		rotate: 90,
    		alpha:1,
    		animate: [{
    			attr: 'alpha',
    			to: 0.3,
    			dur: 1000,
    			reverse: true,
    			repeat: Number.POSITIVE_INFINITY
    		},{
    			attr: 'rotate',
    			to: 450,
    			dur: 2000,
    			reverse: false,
    			repeat: Number.POSITIVE_INFINITY
    		}]
    	},{
    		shape: 'vector',
    		name: 'loading_ball',
    		rotate: 135,
    		alpha:1,
    		animate: [{
    			attr: 'alpha',
    			to: 0.3,
    			dur: 1000,
    			reverse: true,
    			repeat: Number.POSITIVE_INFINITY
    		},{
    			attr: 'rotate',
    			to: 495,
    			dur: 2000,
    			reverse: false,
    			repeat: Number.POSITIVE_INFINITY
    		}]
    	},{
    		shape: 'vector',
    		name: 'loading_ball',
    		rotate: 180,
    		alpha:1,
    		animate: [{
    			attr: 'alpha',
    			to: 0.3,
    			dur: 1000,
    			reverse: true,
    			repeat: Number.POSITIVE_INFINITY
    		},{
    			attr: 'rotate',
    			to: 540,
    			dur: 2000,
    			reverse: false,
    			repeat: Number.POSITIVE_INFINITY
    		}]
    	}]
    });
    twaver.Util.registerImage('loading_ball', {
    	w: 100,
    	h: 100,  
    	v: [{
    		shape: 'circle',
    		cx: -40,
    		cy: 0, 
    		r:10,
    		lineWidth:1,
    		lineColor: '#EC6C00',
    		fill: 'white',
    	}],
    });

    twaver.Util.registerImage('glowCircle', {
    	w: 36,
    	h: 36,      
    	v: [{
    		shape: 'circle',
    		cx: 0,
    		cy: 0,
    		r: 18,
    		lineWidth: 0,
    		lineColor:'#EC6C00',
    		alpha:0,
    		fill: '#EC6C00',
    		gradient: 'radial.center',
    		animate: [{
    			attr: 'alpha',
    			to:1,
    			dur:1500,
    			reverse:true,
    			repeat:Number.POSITIVE_INFINITY
    		}]
    	}]
    });

    var icon_scale=1.3;

    twaver.Util.registerImage('center', {
        "w": 16,"h": 16,"origin": {"x": 0,"y": 0},
        "v": [
        {
            "shape": "ellipse","cx": 8,"cy": 8,"rx": 8,"ry": 8,
            "gradient": {
                "id": "SVGID_1_","type": "linear","x1": 2.3438,"y1": 2.3438,
                "x2": 13.6575,"y2": 13.6575,
                "stop": [
                {"offset": "0","color": "#58AC9A"},
                {"offset": "1","color": "#248576"}
                ]
            }
        },
        {
            "shape": "path",
            "data": "M13.549,9.049c0.131-0.132,0.087-0.238-0.098-0.238H9.147c-0.186,0-0.337,0.151-0.337,0.337v4.303   c0,0.186,0.106,0.23,0.238,0.1l0.998-0.998c0.131-0.132,0.345-0.132,0.477,0l0.783,0.783c0.131,0.132,0.346,0.132,0.477,0   l1.553-1.552c0.131-0.131,0.131-0.346,0-0.477l-0.785-0.784c-0.131-0.131-0.131-0.345,0-0.476L13.549,9.049z",
            "fill": "#FFFFFF"
        },
        {
            "shape": "path",
            "data": "M2.45,6.951C2.319,7.082,2.363,7.189,2.549,7.189h4.304c0.186,0,0.337-0.151,0.337-0.337V2.549   c0-0.186-0.107-0.229-0.238-0.099L5.953,3.448c-0.131,0.131-0.346,0.131-0.477,0L4.692,2.664c-0.131-0.131-0.345-0.131-0.477,0   L2.664,4.217c-0.131,0.131-0.131,0.345,0,0.476l0.784,0.784c0.131,0.131,0.131,0.346,0,0.477L2.45,6.951z",
            "fill": "#FFFFFF"
        },
        {
            "shape": "path",
            "data": "M6.951,13.55c0.131,0.131,0.238,0.086,0.238-0.099V9.147c0-0.186-0.151-0.337-0.337-0.337H2.549   c-0.186,0-0.229,0.106-0.099,0.238l0.998,0.998c0.131,0.131,0.131,0.345,0,0.477l-0.784,0.783c-0.131,0.131-0.131,0.346,0,0.477   l1.553,1.552c0.131,0.132,0.345,0.132,0.476,0l0.784-0.783c0.131-0.132,0.346-0.132,0.477,0L6.951,13.55z",
            "fill": "#FFFFFF"
        },
        {
            "shape": "path",
            "data": "M9.048,2.45C8.917,2.319,8.811,2.363,8.81,2.549l0.001,4.304c0,0.186,0.151,0.337,0.336,0.337h4.304   c0.185,0,0.229-0.107,0.099-0.238l-0.998-0.998c-0.131-0.131-0.131-0.346,0-0.477l0.784-0.784c0.132-0.131,0.132-0.345,0-0.477   l-1.552-1.552c-0.131-0.131-0.346-0.131-0.477,0l-0.784,0.784c-0.131,0.131-0.345,0.131-0.476,0L9.048,2.45z",
            "fill": "#FFFFFF"
        }
        ]
    } );
    twaver.Util.registerImage('gather', {"w": 16,"h": 16,"origin": {"x": 0,"y": 0},
        "v": [
        {
            "shape": "path",
            "data": "M16,15.375C16,15.72,15.721,16,15.375,16H0.625C0.28,16,0,15.72,0,15.375V0.625    C0,0.28,0.28,0,0.625,0h14.75C15.721,0,16,0.28,16,0.625V15.375z",
            "gradient": {
                "id": "SVGID_1_","type": "linear",
                "x1": 0.1836,"y1": 0.1836,"x2": 15.8173,"y2": 15.8173,
                "stop": [
                {"offset": "0","color": "#61B7D9"},
                {"offset": "1","color": "#0089C1"}
                ]
            }
        },
        {
            "shape": "path",
            "data": "M12.879,5.521l0.867,0.866C13.886,6.527,14,6.479,14,6.282V2.36C14,2.162,13.838,2,13.641,2H9.719   C9.52,2,9.473,2.114,9.613,2.255l0.865,0.865c0.141,0.141,0.141,0.369,0,0.51L8,6.108L5.521,3.63c-0.14-0.141-0.14-0.369,0-0.51   l0.866-0.865C6.527,2.114,6.48,2,6.282,2H2.36C2.162,2,2,2.162,2,2.36v3.922c0,0.197,0.115,0.245,0.254,0.105l0.866-0.866   c0.14-0.14,0.369-0.14,0.509,0L6.108,8l-2.479,2.479c-0.14,0.14-0.369,0.14-0.509,0L2.254,9.612C2.115,9.473,2,9.521,2,9.718v3.922   C2,13.838,2.162,14,2.36,14h3.922c0.198,0,0.246-0.114,0.105-0.255L5.521,12.88c-0.14-0.141-0.14-0.369,0-0.51L8,9.892l2.479,2.479   c0.141,0.141,0.141,0.369,0,0.51l-0.865,0.865C9.473,13.886,9.52,14,9.719,14h3.922C13.838,14,14,13.838,14,13.64V9.718   c0-0.197-0.114-0.245-0.254-0.105l-0.867,0.866c-0.14,0.14-0.369,0.14-0.508,0L9.892,8l2.479-2.479   C12.51,5.382,12.739,5.382,12.879,5.521z M7.989,8L8,7.989L8.011,8L8,8.011L7.989,8z",
            "fill": "#FFFFFF"
        }
        ]
    });
    twaver.Util.registerImage('icon_db',{
        "w": 12,
        "h": 16,
        scale: icon_scale,
        "origin": {
            "x": 0,
            "y": 0
        },
        "v": [
        {
            "shape": "path",
            "data": "M6,16.001c-2.888,0-5.997-0.842-6-2.69L0,2.688C0,0.841,3.11,0,6,0s6,0.841,6,2.688v10.62  C11.996,15.159,8.888,16.001,6,16.001z",
            "fill": "#FFFFFF"
        },
        {
            "shape": "ellipse",
            "cx": 6,
            "cy": 2.68,
            "rx": 4.852,
            "ry": 1.691,
            "gradient": {
                "id": "SVGID_1_",
                "type": "linear",
                "x1": 1.1479,
                "y1": 2.6812,
                "x2": 10.8516,
                "y2": 2.6812,
                "stop": [
                {
                    "offset": "0",
                    "color": "#DC4F03"
                },
                {
                    "offset": "0.4892",
                    "color": "#DF780D"
                },
                {
                    "offset": "1",
                    "color": "#DC4F03"
                }
                ]
            }
        },
        {
            "shape": "path",
            "data": "M6,5.371c-2.679,0-4.85-0.756-4.852-1.69h0v2.534c0,0.148,0.07,0.288,0.172,0.424  C1.86,7.367,3.743,7.906,6,7.906c2.259,0,4.141-0.539,4.68-1.268c0.102-0.136,0.172-0.275,0.172-0.424V3.681l0,0  C10.85,4.615,8.68,5.371,6,5.371z",
            "gradient": {
                "id": "SVGID_2_",
                "type": "linear",
                "x1": 1.1479,
                "y1": 5.7935,
                "x2": 10.8516,
                "y2": 5.7935,
                "stop": [
                {
                    "offset": "0",
                    "color": "#DC4F03"
                },
                {
                    "offset": "0.4892",
                    "color": "#DF780D"
                },
                {
                    "offset": "1",
                    "color": "#DC4F03"
                }
                ]
            }
        },
        {
            "shape": "path",
            "data": "M9.18,8.48C8.326,8.74,7.223,8.904,6,8.904S3.674,8.74,2.82,8.48c-1.016-0.31-1.672-0.76-1.672-1.269  v2.536c0,0.146,0.07,0.287,0.172,0.422c0.54,0.729,2.422,1.269,4.68,1.269c2.259,0,4.141-0.539,4.68-1.269  c0.102-0.135,0.172-0.275,0.172-0.422V7.212C10.852,7.721,10.197,8.171,9.18,8.48z",
            "gradient": {
                "id": "SVGID_3_",
                "type": "linear",
                "x1": 1.1479,
                "y1": 9.3252,
                "x2": 10.8516,
                "y2": 9.3252,
                "stop": [
                {
                    "offset": "0",
                    "color": "#DC4F03"
                },
                {
                    "offset": "0.4892",
                    "color": "#DF780D"
                },
                {
                    "offset": "1",
                    "color": "#DC4F03"
                }
                ]
            }
        },
        {
            "shape": "path",
            "data": "M9.18,12.042c-0.854,0.26-1.957,0.422-3.18,0.422s-2.326-0.162-3.18-0.422  c-1.016-0.311-1.672-0.76-1.672-1.27v2.536v0.001h0C1.15,14.244,3.321,15.001,6,15.001c2.68,0,4.85-0.757,4.852-1.691l0,0v-0.001  v-2.536C10.852,11.282,10.197,11.731,9.18,12.042z",
            "gradient": {
                "id": "SVGID_4_",
                "type": "linear",
                "x1": 1.1479,
                "y1": 12.8867,
                "x2": 10.8516,
                "y2": 12.8867,
                "stop": [
                {
                    "offset": "0",
                    "color": "#DC4F03"
                },
                {
                    "offset": "0.4892",
                    "color": "#DF780D"
                },
                {
                    "offset": "1",
                    "color": "#DC4F03"
                }
                ]
            }
        }
        ]
    });
    twaver.Util.registerImage('cloud', {
        "w": 64,
        "h": 44,
        "origin": {
            "x": 0,
            "y": 0
        },
        "v": [
        {
            "shape": "path",
            "data": "M57.477,13.271C55.93,7.851,50.947,3.88,45.037,3.88c-1.912,0-3.727,0.418-5.361,1.165   C36.873,1.946,32.824,0,28.321,0C21.957,0,16.5,3.89,14.188,9.424c-0.183-0.006-0.364-0.014-0.549-0.014   C6.106,9.41,0,15.527,0,23.073c0,7.545,6.106,13.661,13.639,13.661c1.8,0,3.516-0.353,5.089-0.986   C21.06,40.619,26.167,44,32.097,44c4.835,0,9.124-2.246,11.808-5.717c1.666,0.63,3.477,0.98,5.373,0.98   C57.408,39.264,64,32.907,64,25.066C64,20.152,61.41,15.821,57.477,13.271z",
            "gradient": {
                "id": "SVGID_1_",
                "type": "linear",
                "x1": 19.6367,
                "y1": 2.646,
                "x2": 43.9219,
                "y2": 44.7091,
                "stop": [
                {
                    "offset": "0",
                    "color": "#FFFFFF"
                },
                {
                    "offset": "0.3353",
                    "color": "#FEFEFE"
                },
                {
                    "offset": "0.5355",
                    "color": "#F9F9F9"
                },
                {
                    "offset": "0.7003",
                    "color": "#EFEFEF"
                },
                {
                    "offset": "0.8458",
                    "color": "#E1E1E1"
                },
                {
                    "offset": "0.9773",
                    "color": "#CDCECE"
                },
                {
                    "offset": "1",
                    "color": "#C9CACA"
                }
                ]
            }
        },
        {
            "shape": "path",
            "data": "M28.321,2c3.752,0,7.35,1.599,9.871,4.387l0.982,1.086l1.332-0.609   c1.429-0.653,2.953-0.984,4.53-0.984c4.857,0,9.183,3.265,10.517,7.94l0.205,0.721l0.63,0.408C59.902,17.228,62,21.009,62,25.066   c0,6.726-5.707,12.197-12.723,12.197c-1.602,0-3.172-0.286-4.666-0.852l-1.384-0.523l-0.905,1.171   C39.895,40.199,36.168,42,32.097,42c-4.956,0-9.496-2.793-11.565-7.115l-0.81-1.693l-1.741,0.701   c-1.386,0.559-2.847,0.842-4.341,0.842C7.221,34.734,2,29.503,2,23.073C2,16.642,7.221,11.41,13.639,11.41   c0.125,0,0.247,0.004,0.37,0.009l0.115,0.004l1.378,0.044l0.531-1.272C18.113,5.217,22.937,2,28.321,2 M28.321,0   C21.957,0,16.5,3.89,14.188,9.424c-0.183-0.006-0.364-0.014-0.549-0.014C6.106,9.41,0,15.527,0,23.073   c0,7.545,6.106,13.661,13.639,13.661c1.8,0,3.516-0.353,5.089-0.986C21.06,40.619,26.167,44,32.097,44   c4.835,0,9.124-2.246,11.808-5.717c1.666,0.63,3.477,0.98,5.373,0.98C57.408,39.264,64,32.907,64,25.066   c0-4.914-2.59-9.245-6.523-11.795C55.93,7.851,50.947,3.88,45.037,3.88c-1.912,0-3.727,0.418-5.361,1.165   C36.873,1.946,32.824,0,28.321,0L28.321,0z",
            "gradient": {
                "id": "SVGID_2_",
                "type": "linear",
                "x1": 19.6367,
                "y1": 2.646,
                "x2": 43.9219,
                "y2": 44.7091,
                "stop": [
                {
                    "offset": "0",
                    "color": "#C9CACA"
                },
                {
                    "offset": "1",
                    "color": "#727171"
                }
                ]
            }
        }
        ]
    });
    twaver.Util.registerImage('icon_disk',{
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin": {
            "x": 0,
            "y": 0
        },
        "v": [
        {
            "shape": "path",
            "data": "M14,11c0,0.553-0.447,1-1,1H1c-0.552,0-1-0.447-1-1V1c0-0.553,0.448-1,1-1h12c0.553,0,1,0.447,1,1V11z",
            "fill": "#FFFFFF"
        },
        {
            "shape": "path",
            "data": "M12,1h-1v3.98H3V1H2C1.448,1,1,1.447,1,2v8c0,0.553,0.448,1,1,1h1V6h8v5h1c0.553,0,1-0.447,1-1V2    C13,1.447,12.553,1,12,1z",
            "fill": "#ED6C00"
        },
        {
            "shape": "rect",
            "x": 4,
            "y": 7,
            "w": 6,
            "h": 4,
            "fill": "#ED6C00"
        },
        {
            "shape": "path",
            "data": "M4,1v2.98h6V1H4z M9,3H8V2h1V3z",
            "fill": "#ED6C00"
        }
        ]
    });
    twaver.Util.registerImage('icon_wall', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin": {
            "x": 0,
            "y": 0
        },
        "v": [
        {
            "shape": "path",
            "data": "M6.59,16.001c-3.886,0-6.211-3.865-6.548-10.883L0,4.236l0.865-0.178C3.474,3.522,5.469,1.738,5.7,1.396   L6.641,0l0.852,1.415c0.219,0.323,2.215,2.107,4.823,2.644l0.865,0.178l-0.042,0.882C12.801,12.136,10.476,16.001,6.59,16.001z",
            "fill": "#FFFFFF"
        },
        {
            "shape": "path",
            "data": "M6.59,2.101c-0.297,0.535-2.549,2.482-5.35,3.058c0.161,3.359,1,9.599,5.35,9.599s5.188-6.239,5.35-9.599   C9.139,4.583,6.887,2.636,6.59,2.101z",
            "fill": "#ED6C00"
        }
        ]
    });
    twaver.Util.registerImage('icon_web', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin": {
            "x": 0,
            "y": 0
        },
        "v": [
        {
            "shape": "ellipse",
            "cx": 8,
            "cy": 8,
            "rx": 8,
            "ry": 8,
            "fill": "#FFFFFF"
        },
        {
            "shape": "path",
            "data": "M13.874,11.8c0.023-0.035,0.044-0.071,0.065-0.107c0.105-0.17,0.206-0.345,0.297-0.524   c0.031-0.062,0.061-0.123,0.09-0.186c0.075-0.16,0.146-0.322,0.209-0.489c0.029-0.074,0.057-0.15,0.083-0.227   c0.055-0.16,0.103-0.323,0.146-0.487c0.021-0.083,0.045-0.165,0.064-0.249c0.037-0.172,0.066-0.347,0.092-0.522   c0.012-0.078,0.027-0.155,0.035-0.233C14.984,8.52,15,8.262,15,8c0-3.866-3.133-7-7-7C4.134,1,1,4.134,1,8   c0,0.355,0.035,0.702,0.086,1.043c0.008,0.052,0.014,0.104,0.023,0.154c0.06,0.345,0.142,0.68,0.25,1.005c0,0.001,0,0.002,0,0.003   v-0.001c0.905,2.729,3.441,4.708,6.454,4.786c0,0,0,0.001,0.001,0.001C7.877,14.992,7.938,15,8,15c0.348,0,0.688-0.033,1.021-0.083   c0.001,0,0.003,0,0.004,0l0,0c1.242-0.183,2.378-0.688,3.317-1.434v0.001c0.001-0.001,0.003-0.002,0.005-0.004   C12.943,13.007,13.458,12.44,13.874,11.8z M2.077,8c0-0.146,0.011-0.288,0.021-0.43C2.564,7.628,2.17,7.934,2.364,8.735   c0.206,0.853,1.294,2,1.823,2.559c0.326,0.343,1.221,1.377,2.256,2.415C3.932,13.022,2.077,10.727,2.077,8z M8,13.923   c-0.09,0-0.178-0.009-0.267-0.014c-0.251-0.293-0.385-0.729-0.517-1.292c-0.206-0.882,0.529-2.381,0.565-3.234   c0.035-0.854,0.024-0.824-0.594-0.874C6.57,8.46,6.364,8.029,5.834,7.677C5.305,7.322,5.217,7.235,2.776,6.971   C2.461,6.937,2.743,6.675,2.682,6.521c0.063-0.277,0.37-0.76,0.471-1.021c0.471-2.153,2.896-2.939,3.249-3.198   C6.911,2.159,7.446,2.077,8,2.077c0.216,0,0.006-0.022,0.216,0C8.56,2.203,8.928,2.884,8.874,3.384   c-0.177,1.647-0.375,1.107,0.333,2.44c0.655,1.234,1.479,0.882,2.862,0.793c1.383-0.088,1.471,1.03,1.117,2.941   c-0.146,0.797-0.221,1.317-0.298,1.779C11.822,12.896,10.029,13.923,8,13.923z",
            "fill": "#ED6C00"
        }
        ]
    } );

    twaver.Util.registerImage('icon_mail', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin": {
            "x": 0,
            "y": 0
        },
        "v": [
        {
            "shape": "rect",
            "x": 0,
            "y": 0,
            "w": 16,
            "h": 12,
            "fill": "#FFFFFF"
        },
        {
            "shape": "path",
            "data": "14.053,1 1.946,1 8,5.19 z",
            "fill": "#ED6C00"
        },
        {
            "shape": "path",
            "data": "1,1.624 1,11 15,11 15,1.65 8,6.501 z",
            "fill": "#ED6C00"
        }
        ]
    });

    twaver.Util.registerImage('icon_win7', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v":[{"shape":"path","data":"6.5,1.078 6.5,1.078 0,2.013 0,6.289 0,7.539 0,11.855 6.5,12.77 7.5,12.91 14,13.824 14,7.333 14,6.504 14,0 z","fill":"#FFFFFF"},{"shape":"path","data":"6.5,2.089 1,2.879 1,6.52 6.5,6.414 z","fill":"#ED6C00"},{"shape":"path","data":"1,7.308 1,10.986 6.5,11.76 6.5,7.414 z","fill":"#ED6C00"},{"shape":"path","data":"13,6.345 13,1.154 7.5,1.945 7.5,6.414 z","fill":"#ED6C00"},{"shape":"path","data":"7.5,11.901 13,12.674 13,7.49 7.5,7.414 z","fill":"#ED6C00"}]
    });

    twaver.Util.registerImage('icon_middleware', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v": [  {
          "shape": "path",
          "data": "M3.25,12.5v-2.146C2.749,10.15,2.35,9.751,2.146,9.25H0v-6h2.146C2.35,2.749,2.749,2.35,3.25,2.146V0h3l0,0   h3v2.146c0.502,0.204,0.9,0.604,1.105,1.104H12.5v3l0,0v3h-2.145c-0.205,0.501-0.604,0.9-1.105,1.104V12.5H3.25z",
          "fill": "#FFFFFF"
      },
      {
          "shape": "path",
          "data": "M11.5,5.25v-1h-2V4c0-0.553-0.447-1-1-1H8.25V1h-1v2h-2V1h-1v2H4C3.447,3,3,3.447,3,4v0.25H1v1h2v2H1v1h2   V8.5c0,0.553,0.447,1,1,1h0.25v2h1v-2h2v2h1v-2H8.5c0.553,0,1-0.447,1-1V8.25h2v-1h-2v-2H11.5z M4.351,8.068V4.433H8.15v3.636   H4.351z",
          "fill": "#ED6C00"
      }]
  });

    twaver.Util.registerImage('icon_linux', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v":[{"shape":"path","data":"M14.595,5.311c-0.36-0.283-0.788-0.453-1.306-0.521l-0.137-0.018c-0.222-1.093-0.996-2.716-1.823-3.72   C10.761,0.363,9.953,0,8.989,0C8.274,0,7.627,0.199,7.278,0.307l-0.18,0.036c-0.208,0-0.464-0.086-0.531-0.113L6.434,0.174   L6.291,0.157C6.215,0.148,6.139,0.144,6.065,0.144c-1.242,0-2.185,1.132-2.695,3.179L3.22,3.327   c-1.786,0.055-2.677,0.81-2.772,0.896L0.352,4.309l-0.07,0.106c-0.29,0.438-0.358,0.962-0.195,1.475   c0.606,1.9,4.861,3.724,6.662,4.42l0.067,0.026l0.071,0.016c1.403,0.32,2.67,0.481,3.766,0.481c3.798,0,4.776-1.913,5.133-2.61   C16.55,6.847,15.132,5.731,14.595,5.311z","fill":"#FFFFFF"},{"shape":"path","data":"M9.122,6.192c1.339,0.096,2.38-0.202,3.1-0.869c0.008-0.677-0.758-2.538-1.664-3.636    C9.625,0.557,8.042,1.122,7.477,1.292c-0.565,0.17-1.3-0.141-1.3-0.141C4.94,1.008,4.385,3.258,4.239,3.979    C4.955,4.868,6.388,6.004,9.122,6.192z","fill":"#ED6C00"},{"shape":"path","data":"M13.979,6.098c-0.265-0.208-0.553-0.282-0.819-0.318c-0.067,0.076-0.122,0.156-0.198,0.228    C12.133,6.807,11.003,7.21,9.598,7.21c-0.178,0-0.359-0.007-0.545-0.02C5.696,6.959,4.028,5.426,3.251,4.326    C1.779,4.372,1.116,4.967,1.116,4.967c-1.103,1.668,5.993,4.41,5.993,4.41c6.587,1.498,7.52-1.131,7.803-1.64    C15.194,7.229,14.77,6.72,13.979,6.098z","fill":"#ED6C00"}]
    });

    twaver.Util.registerImage('icon_apple', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v":[{"shape":"path","data":"M4.12,14.035c-1.317,0-2.166-1.222-2.673-1.952c-1.079-1.559-2.183-4.737-0.802-7.111   c0.696-1.215,1.976-1.986,3.335-2.007c0.001,0,0.002,0,0.002,0c0.339,0,0.647,0.057,0.923,0.134   c0.116-0.726,0.48-1.375,0.853-1.807C6.37,0.576,7.373,0.07,8.25,0.036L9.188,0l0.097,0.933C9.356,1.627,9.196,2.35,8.841,2.994   c0.643,0.118,1.707,0.479,2.452,1.559l0.57,0.827l-0.829,0.566c-0.233,0.15-0.87,0.621-0.862,1.452   c0.011,1.076,0.877,1.459,0.976,1.499l0.857,0.348l-0.265,0.889c-0.096,0.312-0.38,1.131-0.958,1.975   c-0.55,0.798-1.301,1.89-2.648,1.912c-0.001,0-0.001,0-0.002,0c-0.632,0-1.043-0.179-1.343-0.31   c-0.245-0.106-0.393-0.171-0.655-0.171c-0.286,0-0.444,0.068-0.707,0.181c-0.305,0.131-0.685,0.293-1.226,0.312L4.12,14.035z","fill":"#FFFFFF"},{"shape":"path","data":"M10.787,9.831c-0.015,0.046-0.251,0.868-0.831,1.713c-0.502,0.729-1.02,1.464-1.84,1.477   c-0.806,0.014-1.063-0.48-1.983-0.48c-0.919,0-1.207,0.467-1.969,0.494c-0.787,0.032-1.393-0.796-1.896-1.522   C1.24,10.026,0.448,7.301,1.51,5.475C2.033,4.561,2.973,3.98,3.996,3.965C4.767,3.95,5.501,4.486,5.97,4.486   c0.481,0,1.369-0.649,2.305-0.552c0.392,0.017,1.489,0.164,2.195,1.187C10.415,5.159,9.158,5.9,9.172,7.407   C9.191,9.227,10.77,9.824,10.787,9.831 M7.662,2.959c0.422-0.514,0.7-1.222,0.627-1.924c-0.603,0.024-1.338,0.4-1.774,0.912   C6.129,2.393,5.789,3.111,5.883,3.805C6.553,3.846,7.242,3.455,7.662,2.959","fill":"#ED6C00"}]
    });

    twaver.Util.registerImage('icon_server', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v":[{"shape":"path","data":"M9.986,15c0,0.552-0.448,1-1,1H1c-0.552,0-1-0.448-1-1V1c0-0.552,0.448-1,1-1h7.986c0.552,0,1,0.448,1,1V15   z","fill":"#FFFFFF"},{"shape":"path","data":"M8.986,13.989C8.986,14.547,8.533,15,7.975,15H2.011C1.453,15,1,14.547,1,13.989V2.011   C1,1.453,1.453,1,2.011,1h5.964c0.558,0,1.011,0.453,1.011,1.011V13.989z","fill":"#ED6C00"},{"shape":"ellipse","cx":6.768,"cy":11.43,"rx":1,"ry":1,"fill":"#FFFFFF"},{"shape":"path","data":"M7.993,3.5c0,0.276-0.224,0.5-0.5,0.5h-5c-0.276,0-0.5-0.224-0.5-0.5l0,0c0-0.276,0.224-0.5,0.5-0.5h5   C7.769,3,7.993,3.224,7.993,3.5L7.993,3.5z","fill":"#FFFFFF"},{"shape":"path","data":"M7.993,5.5c0,0.276-0.224,0.5-0.5,0.5h-5c-0.276,0-0.5-0.224-0.5-0.5l0,0c0-0.276,0.224-0.5,0.5-0.5h5   C7.769,5,7.993,5.224,7.993,5.5L7.993,5.5z","fill":"#FFFFFF"},{"shape":"path","data":"M7.993,7.5c0,0.276-0.224,0.5-0.5,0.5h-5c-0.276,0-0.5-0.224-0.5-0.5l0,0c0-0.276,0.224-0.5,0.5-0.5h5   C7.769,7,7.993,7.224,7.993,7.5L7.993,7.5z","fill":"#FFFFFF"}]
    }); 

    twaver.Util.registerImage('icon_fire', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v":[{"shape":"path","data":"M4.359,15.691l-0.069-0.01c-2.06-0.289-3.646-1.739-4.141-3.784C-0.344,9.863,0.414,7.79,2.079,6.614   c2.395-1.69,2.28-4.846,2.279-4.877L4.279,0L5.82,0.805c0.242,0.127,5.922,3.144,6.379,7.734c0.242,2.431-0.997,4.762-3.681,6.931   l-0.275,0.222H4.359z","fill":"#FFFFFF"},{"shape":"path","data":"M4.428,14.691c-3.609-0.506-4.643-5.234-1.773-7.26s2.701-5.74,2.701-5.74s11.312,5.909,2.532,13   c0,0,1.667-3.989-1.372-6.5c0,0-0.04,1.78-1.37,2.73C3.819,11.871,4.428,14.691,4.428,14.691z","fill":"#ED6C00"}]
    }); 

    twaver.Util.registerImage('icon_power', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v":[{"shape":"path","data":"M10.829,5.024c0-0.874-0.711-1.586-1.586-1.586H9.136V1.808C9.136,0.811,8.325,0,7.329,0   S5.521,0.811,5.521,1.808v1.631H5.308V1.808C5.308,0.811,4.497,0,3.5,0S1.693,0.811,1.693,1.808v1.631H1.586   C0.711,3.438,0,4.15,0,5.024C0,5.543,0.254,6,0.64,6.29L0.638,6.604c-0.001,0.185,0.011,4.22,3.073,5.521v1.918H7.17v-1.918   c3.062-1.302,3.074-5.337,3.073-5.521l-0.002-0.357C10.597,5.956,10.829,5.519,10.829,5.024z","fill":"#FFFFFF"},{"shape":"path","data":"M9.243,4.438H8.136v-2.63C8.136,1.362,7.775,1,7.329,1C6.883,1,6.521,1.362,6.521,1.808v2.63H4.308v-2.63    C4.308,1.362,3.946,1,3.5,1S2.693,1.362,2.693,1.808v2.63H1.586C1.262,4.438,1,4.7,1,5.024C1,5.348,1.262,5.61,1.586,5.61h7.657    c0.324,0,0.586-0.262,0.586-0.586C9.829,4.7,9.567,4.438,9.243,4.438z","fill":"#ED6C00"},{"shape":"path","data":"M1.638,6.61c0,0-0.026,4.063,3.073,4.792v1.641H6.17v-1.641C9.269,10.673,9.243,6.61,9.243,6.61H1.638z","fill":"#ED6C00"}]
    }); 

    twaver.Util.registerImage('icon_air', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v":[{"shape":"path","data":"M5.776,14c-1.429,0-2.027-0.656-2.277-1.207c-0.288-0.635-0.199-1.395,0.042-2.119   c-0.093,0.009-0.187,0.015-0.282,0.015c-1.1,0-2.532-0.618-3.112-3.56c-0.283-1.437-0.159-2.453,0.38-3.108   c0.265-0.322,0.755-0.706,1.589-0.706c0.387,0,0.8,0.09,1.205,0.229C3.287,3.194,3.315,2.832,3.432,2.468   c0.374-1.163,1.53-1.942,3.437-2.319C7.378,0.049,7.82,0,8.219,0c1.403,0,2.003,0.635,2.259,1.168   c0.31,0.643,0.222,1.42-0.023,2.158c0.093-0.01,0.187-0.015,0.282-0.015c1.1,0,2.532,0.618,3.112,3.56   c0.283,1.437,0.159,2.453-0.38,3.108c-0.265,0.322-0.755,0.706-1.589,0.706l0,0c-0.388,0-0.8-0.089-1.205-0.227   c0.033,0.348,0.005,0.708-0.111,1.071c-0.374,1.164-1.53,1.944-3.438,2.32C6.618,13.951,6.176,14,5.776,14z","fill":"#FFFFFF"},{"shape":"path","data":"M12.867,7.064C11.944,2.382,8.919,4.985,8.404,5.47C8.344,5.415,8.283,5.363,8.217,5.316    C8.221,5.311,12.184,0.12,7.062,1.13C2.379,2.054,4.983,5.079,5.467,5.594C5.413,5.653,5.361,5.715,5.314,5.781    C5.309,5.777,0.118,1.814,1.128,6.936c0.923,4.683,3.948,2.079,4.464,1.595c0.059,0.055,0.121,0.106,0.186,0.154    C5.775,8.689,1.811,13.88,6.933,12.87c4.683-0.923,2.079-3.948,1.595-4.464c0.055-0.059,0.106-0.121,0.154-0.186    C8.687,8.223,13.877,12.186,12.867,7.064z","fill":"#ED6C00"},{"shape":"ellipse","cx":6.998,"cy":7,"rx":1,"ry":1,"fill":"#FFFFFF"}]
    }); 

    twaver.Util.registerImage('icon_arrow_in', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v":[{"shape":"path","data":"11.276,8.887 11.276,6.898 11.276,5.932 11.276,3.942 10.976,3.942 12.828,2.09 10.738,0 8.886,1.853 8.886,1.553 6.898,1.553 5.931,1.553 3.942,1.553 3.942,1.854 2.09,0.001 0,2.091 1.851,3.942 1.553,3.941 1.553,5.932 1.553,6.898 1.553,8.887 1.853,8.887 0,10.739 2.09,12.829 3.942,10.978 3.942,11.276 5.931,11.276 6.897,11.276 8.886,11.276 8.886,10.977 10.738,12.829 12.828,10.739 10.977,8.887 z","fill":"#FFFFFF"},{"shape":"path","data":"5.898,10.277 5.898,6.931 2.552,6.931 2.552,7.887 4.267,7.887 1.414,10.74 2.09,11.415 4.943,8.563 4.942,10.277 z","fill":"#ED6C00"},{"shape":"path","data":"6.931,2.553 6.93,5.898 10.276,5.898 10.276,4.942 8.561,4.942 11.414,2.09 10.738,1.414 7.886,4.266 7.886,2.553 z","fill":"#ED6C00"},{"shape":"path","data":"2.553,5.898 5.898,5.899 5.898,2.553 4.943,2.553 4.943,4.267 2.09,1.415 1.414,2.091 4.267,4.943 2.553,4.942 z","fill":"#ED6C00"},{"shape":"path","data":"10.276,6.931 6.931,6.931 6.931,10.277 7.886,10.277 7.886,8.562 10.739,11.415 11.414,10.739 8.562,7.887 10.276,7.887 z","fill":"#ED6C00"}]
    }); 

    twaver.Util.registerImage('icon_arrow_out', {
        "w": 16,
        "h": 16,
        "scale": icon_scale, 
        "origin":{"x":0,"y":0},
        "v":[{"shape":"path","data":"11.999,5.469 12,0 6.53,0 6.53,2.991 5.47,2.991 5.47,0 0.001,0 0.001,5.469 2.991,5.469 2.991,6.53 0.001,6.53 0,11.999 5.47,11.999 5.47,9.008 6.53,9.007 6.53,11.999 11.999,12 11.999,6.53 9.009,6.53 9.009,5.469 z","fill":"#FFFFFF"},{"shape":"path","data":"1.001,7.53 1,10.999 4.469,10.999 4.469,10.008 2.692,10.008 5.649,7.051 4.949,6.35 1.991,9.307 1.992,7.53 z","fill":"#ED6C00"},{"shape":"path","data":"10.999,4.469 11,1 7.531,1 7.531,1.991 9.308,1.991 6.351,4.949 7.051,5.65 10.009,2.692 10.008,4.469 z","fill":"#ED6C00"},{"shape":"path","data":"4.469,1 1.001,1 1.001,4.469 1.992,4.469 1.992,2.691 4.949,5.649 5.65,4.948 2.692,1.991 4.469,1.991 z","fill":"#ED6C00"},{"shape":"path","data":"7.531,10.999 10.999,11 10.999,7.53 10.008,7.53 10.008,9.308 7.051,6.35 6.35,7.051 9.308,10.009 7.531,10.008 z","fill":"#ED6C00"}]
    });

    twaver.Util.registerImage('icon_battery', {
        "w": 10,
        "h": 16,
        "scale": icon_scale,
        "origin": {
            "x": 0,
            "y": 0
        },
        "v": [
        {
            "shape": "path",
            "data": "M2,16c-1.103,0-2-0.897-2-2V4c0-1.103,0.897-2,2-2h0.5V1.5C2.5,0.673,3.172,0,4,0h2  c0.827,0,1.5,0.673,1.5,1.5V2H8c1.104,0,2,0.897,2,2v10c0,1.103-0.896,2-2,2H2z",
            "fill": "#FFFFFF"
        },
        {
            "shape": "path",
            "data": "M8,3H6.5V1.5C6.5,1.224,6.276,1,6,1H4C3.723,1,3.5,1.224,3.5,1.5V3H2C1.447,3,1,3.447,1,4v10  c0,0.553,0.447,1,1,1h6c0.553,0,1-0.447,1-1V4C9,3.447,8.552,3,8,3z M8,14H2L2,4h6V14z",
            "fill": "#ED6C00"
        },
        {
            "shape": "path",
            "data": "6.5,6 5.5,6 5.5,5 4.5,5 4.5,6 3.5,6 3.5,7 4.5,7 4.5,8 5.5,8 5.5,7 6.5,7 z",
            "fill": "#ED6C00",
            "state": "path2"
        },
        {
            "shape": "rect",
            "x": 3,
            "y": 11,
            "w": 4,
            "h": 2,
            "fill": "#ED6C00",
            "state": ["energy1","energy2","energy3"]
        },
        {
            "shape": "rect",
            "x": 3,
            "y": 8,
            "w": 4,
            "h": 2,
            "fill": "#ED6C00",
            "state": ["energy2","energy3"]
        },
        {
            "shape": "rect",
            "x": 3,
            "y": 5,
            "w": 4,
            "h": 2,
            "fill": "#ED6C00",
            "state": ["energy3"]
        },
        {
            "shape": "rect",
            "x": 3,
            "y": 5,
            "w": 4,
            "h": 8,
            "fill": "#ED6C00",
            "state": "full"
        },
        {
            "shape": "path",
            "data": "6.5,6 5.5,6 5.5,5 4.5,5 4.5,6 3.5,6 3.5,7 4.5,7 4.5,8 5.5,8 5.5,7 6.5,7 z",
            "fill": "#ED6C00",
            "state": ["positive","pole"]
        },
        {
            "shape": "rect",
            "x": 3.5,
            "y": 11,
            "w": 3,
            "h": 1,
            "fill": "#ED6C00",
            "state": ["negative","pole"]
        },
        {
            "shape": "path",
            "data": "6.718,8.102 5,8.102 5,6.102 3.281,9.898 5,9.898 5,11.898 z",
            "fill": "#ED6C00",
            "state": ["charge"]
        }
        ]
    });
    twaver.Util.registerImage('singleSwitch', {
        w: 20,
        h: 15,
        lineWidth: 2,
        origin: {
            x: 0,
            y: 0
        },
        v: [
        {
            shape: 'line',
            lineColor: "#E26067",
            p1: {
                x: 0,
                y: 0
            },
            p2: {
                x: 10,
                y: 15
            },
            state: ["state1"]
        },
        {
            shape: 'line',
            lineColor: "#E26067",
            p1: {
                x: 10,
                y: 0
            },
            p2: {
                x: 10,
                y: 15
            },
            state: ["state2"]
        }
        ]
    });
    twaver.Util.registerImage('icon', {
        w: 5,
        h: 5,
        lineWidth: 1,
        origin: {
            x: 0,
            y: 0
        },
        v: [
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 0,
                y: 2.5
            },
            p2: {
                x: 5,
                y: 0
            },
            state: ["left"]
        },
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 5,
                y: 0
            },
            p2: {
                x: 5,
                y: 5
            },
            state: ["left"]
        },
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 5,
                y: 5
            },
            p2: {
                x: 0,
                y: 2.5
            },
            state: ["left"]
        },

        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 0,
                y: 0
            },
            p2: {
                x: 5,
                y: 2.5
            },
            state: ["right"]
        },
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 5,
                y: 2.5
            },
            p2: {
                x: 0,
                y: 5
            },
            state: ["right"]
        },
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 0,
                y: 5
            },
            p2: {
                x: 0,
                y: 0
            },
            state: ["right"]
        },

        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 2.5,
                y: 0
            },
            p2: {
                x: 0,
                y: 5
            },
            state: ["top"]
        },
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 0,
                y: 5
            },
            p2: {
                x: 2.5,
                y: 0
            },
            state: ["top"]
        },
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 0,
                y: 5
            },
            p2: {
                x: 0,
                y: 0
            },
            state: ["top"]
        },
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 0,
                y: 0
            },
            p2: {
                x: 5,
                y: 0
            },
            state: ["bottom"]
        },
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 5,
                y: 0
            },
            p2: {
                x: 2.5,
                y: 5
            },
            state: ["bottom"]
        },
        {
            shape: 'line',
            lineColor: "green",
            p1: {
                x: 2.5,
                y: 5
            },
            p2: {
                x: 0,
                y: 0
            },
            state: ["bottom"]
        }

        ]
    });
//顶角向左单刀开关
twaver.Util.registerImage('leftSingleSwitch', {
    w: 20,
    h: 15,
    lineWidth: 2,
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'line',
        lineColor: "#E26067",
        p1: {
            x: 0,
            y: 15
        },
        p2: {
            x: 20,
            y: 0
        },
        state: ["state1"]
    },
    {
        shape: 'line',
        lineColor: "#E26067",
        p1: {
            x: 0,
            y: 15
        },
        p2: {
            x: 20,
            y: 15
        },
        state: ["state2"]
    }
    ]
});

//正三角双刀开关 顶角面向上
twaver.Util.registerImage('doubleSwitch', {
    w: 20,
    h: 15,
    lineWidth: 2,
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 10,
            y: 0
        },
        p2: {
            x: 20,
            y: 15
        },
        state: ["state1"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 10,
            y: 0
        },
        p2: {
            x: 0,
            y: 15
        },
        state: ["state2"]
    }
    ]
});
//倒三角双刀开关 顶角面向下
twaver.Util.registerImage('dReverseSwitch', {
    w: 20,
    h: 15,
    lineWidth: 2,
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 0,
            y: 0
        },
        p2: {
            x: 10,
            y: 15
        },
        state: ["state1"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 20,
            y: 0
        },
        p2: {
            x: 10,
            y: 15
        },
        state: ["state2"]
    }
    ]
});
//右三角双刀开关 顶角面向右
twaver.Util.registerImage('doubleRightSwitch', {
    w: 15,
    h: 20,
    lineWidth: 2,
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 0,
            y: 0
        },
        p2: {
            x: 15,
            y: 10
        },
        state: ["state1"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 0,
            y: 20
        },
        p2: {
            x: 15,
            y: 10
        },
        state: ["state2"]
    }
    ]
});
//双刀双掷开关
twaver.Util.registerImage('ddSwitch', {
    w: 40,
    h: 30,
    lineWidth: 2,
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 0,
            y: 0
        },
        p2: {
            x: 5,
            y: 15
        },
        state: ["state1"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 30,
            y: 0
        },
        p2: {
            x: 35,
            y: 15
        },
        state: ["state1"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 5,
            y: 0
        },
        p2: {
            x: 5,
            y: 15
        },
        state: ["state2"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 35,
            y: 0
        },
        p2: {
            x: 35,
            y: 15
        },
        state: ["state2"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 5,
            y: 15
        },
        p2: {
            x: 35,
            y: 15
        },
        state: ["state1", "state2"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 5,
            y: 15
        },
        p2: {
            x: 5,
            y: 30
        },
        state: ["state1", "state2"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 5,
            y: 30
        },
        p2: {
            x: 35,
            y: 30
        },
        state: ["state1", "state2"]
    },
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 35,
            y: 15
        },
        p2: {
            x: 35,
            y: 30
        },
        state: ["state1", "state2"]
    },
    {
        shape: 'text',
        text: '',
        textAlign: 'left',
        textBaseline: 'top',
        x: 7,
        y: 0,
        state: ["state1", "state2"]
    }
    ]
});

twaver.Util.registerImage('doubleCircle', {
    w: 20,
    h: 30,
    origin: {
        x: 0,
        y: 0
    },
    line: {
        width: 1,
        color: 'green'
    },
    v: [
    {
        shape: 'circle',
        cx: 10,
        cy: 10,
        r: 9
    },
    {
        shape: 'circle',
        cx: 10,
        cy: 19,
        r: 9
    }
    ]
});
twaver.Util.registerImage('mainLine', {
    w: 800,
    h: 3,
    lineWidth: 3,
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'line',
        lineColor: "green",
        p1: {
            x: 50,
            y: 2
        },
        p2: {
            x: 800,
            y: 2
        }
    }
    ]
});
twaver.Util.registerImage('horizoanlLine', {
    w: 350,
    h: 2,
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'line',
        lineWidth: 2,
        lineColor: "green",
        p1: {
            x: 0,
            y: 1
        },
        p2: {
            x: 500,
            y: 1
        }
    }
    ]
});
//虚线框
twaver.Util.registerImage('patternRect', {
    w: 300,
    h: 30,
    lineDash: [25,5],
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'rect',
        x: 0,
        y: 0,
        w: 300,
        h: 30,
        line: {
            width: 1,
            color: 'green'
        }
    }
    ]
});

//输入输出开关
twaver.Util.registerImage('inputOutSwitch', {
    w: 70,
    h: 50,
    font: 'bold 8px arial',
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'rect',
        x: 0,
        y: 0,
        w: 70,
        h: 50,
        line: {
            width: 2,
            color: 'green'
        }
    },
    {
        shape: 'line',
        lineWidth: 2,
        lineColor: "green",
        p1: {
            x: 0,
            y: 5
        },
        p2: {
            x: 70,
            y: 5
        }
    },
    {
        shape: 'line',
        lineWidth: 2,
        lineColor: "green",
        p1: {
            x: 0,
            y: 45
        },
        p2: {
            x: 70,
            y: 45
        }
    },
    {
        shape: 'text',
        text: '',
        textAlign: 'left',
        textBaseline: 'top',
        x: 0,
        y: 10
    },
    {
        shape: 'text',
        text: '',
        textAlign: 'left',
        textBaseline: 'top',
        x: 38,
        y: 10
    },
    {
        shape: 'text',
        text: '',
        textAlign: 'left',
        textBaseline: 'top',
        x: 25,
        y: 35
    },
    {
        shape: 'text',
        text: '<%= getClient("textName") %>',
        textAlign: 'left',
        textBaseline: 'top',
        font: 'bold 12px arial',
        x: 25,
        y: 20
    }
    ]
});

//带框的文本节点
twaver.Util.registerImage('textOutLine', {
    w: 70,
    h: 25,
    origin: {
        x: 0,
        y: 0
    },
    v: [
    {
        shape: 'rect',
        x: 0,
        y: 0,
        w: 70,
        h: 25,
        line: {
            width: 1,
            color: 'green'
        }
    },
    {
        shape: 'text',
        text: '<%= getClient("textName") %>',
        textAlign: 'center',
        textBaseline: 'top',
        font: 'bold 10px arial',
        x: 35,
        y: 8
    }
    ]
});

twaver.Util.registerImage('textNode', {
    w: 80,
    h: 30,
    origin: {
        x: 0.5,
        y: 0.5
    },
    v: [
    {
        shape: 'text',
        text: '<%= getClient("textName") %>',
        textAlign: 'center',
        textBaseline: 'top',
        font: 'bold 10px arial',
        rotate: '<%= getClient("rotate") %>',
        x: 0,
        y: 0
    }
    ]
});
}


}