define("components/containerbuilder/containerbuilder",function(){function a(a){var b=a.Position.XPos,c=a.Position.YPos,d=a.Width.Value,e=a.Height.Value,f='<div class="arcComponentContainer" style="left: '+b+"px;"+"top: "+c+"px;"+"width: "+d+"px;"+"height: "+e+'px;"'+" />";return $(f)}return{createContainer:a}})