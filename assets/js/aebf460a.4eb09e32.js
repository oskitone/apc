"use strict";(self.webpackChunkassembly_guide=self.webpackChunkassembly_guide||[]).push([[906],{3905:(t,e,n)=>{n.d(e,{Zo:()=>u,kt:()=>c});var r=n(7294);function a(t,e,n){return e in t?Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[e]=n,t}function i(t,e){var n=Object.keys(t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(t);e&&(r=r.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),n.push.apply(n,r)}return n}function l(t){for(var e=1;e<arguments.length;e++){var n=null!=arguments[e]?arguments[e]:{};e%2?i(Object(n),!0).forEach((function(e){a(t,e,n[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(n)):i(Object(n)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(n,e))}))}return t}function o(t,e){if(null==t)return{};var n,r,a=function(t,e){if(null==t)return{};var n,r,a={},i=Object.keys(t);for(r=0;r<i.length;r++)n=i[r],e.indexOf(n)>=0||(a[n]=t[n]);return a}(t,e);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(t);for(r=0;r<i.length;r++)n=i[r],e.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(t,n)&&(a[n]=t[n])}return a}var p=r.createContext({}),s=function(t){var e=r.useContext(p),n=e;return t&&(n="function"==typeof t?t(e):l(l({},e),t)),n},u=function(t){var e=s(t.components);return r.createElement(p.Provider,{value:e},t.children)},d={inlineCode:"code",wrapper:function(t){var e=t.children;return r.createElement(r.Fragment,{},e)}},m=r.forwardRef((function(t,e){var n=t.components,a=t.mdxType,i=t.originalType,p=t.parentName,u=o(t,["components","mdxType","originalType","parentName"]),m=s(n),c=a,g=m["".concat(p,".").concat(c)]||m[c]||d[c]||i;return n?r.createElement(g,l(l({ref:e},u),{},{components:n})):r.createElement(g,l({ref:e},u))}));function c(t,e){var n=arguments,a=e&&e.mdxType;if("string"==typeof t||a){var i=n.length,l=new Array(i);l[0]=m;var o={};for(var p in e)hasOwnProperty.call(e,p)&&(o[p]=e[p]);o.originalType=t,o.mdxType="string"==typeof t?t:a,l[1]=o;for(var s=2;s<i;s++)l[s]=n[s];return r.createElement.apply(null,l)}return r.createElement.apply(null,n)}m.displayName="MDXCreateElement"},1746:(t,e,n)=>{n.r(e),n.d(e,{assets:()=>p,contentTitle:()=>l,default:()=>d,frontMatter:()=>i,metadata:()=>o,toc:()=>s});var r=n(7462),a=(n(7294),n(3905));const i={id:"3d-printing",title:"3D-Printing",sidebar_label:"3D-Printing",description:"How to 3D-print your APC's parts",slug:"3d-printing",image:"/img/assembly/apc.jpg"},l=void 0,o={unversionedId:"3d-printing",id:"3d-printing",title:"3D-Printing",description:"How to 3D-print your APC's parts",source:"@site/docs/3d_printing.md",sourceDirName:".",slug:"/3d-printing",permalink:"/apc/3d-printing",draft:!1,tags:[],version:"current",frontMatter:{id:"3d-printing",title:"3D-Printing",sidebar_label:"3D-Printing",description:"How to 3D-print your APC's parts",slug:"3d-printing",image:"/img/assembly/apc.jpg"},sidebar:"mySidebar",previous:{title:"Inventory",permalink:"/apc/inventory"},next:{title:"General tips",permalink:"/apc/general-tips"}},p={},s=[{value:"Models",id:"models",level:2},{value:"Notes",id:"notes",level:2}],u={toc:s};function d(t){let{components:e,...i}=t;return(0,a.kt)("wrapper",(0,r.Z)({},u,i,{components:e,mdxType:"MDXLayout"}),(0,a.kt)("admonition",{type:"note"},(0,a.kt)("p",{parentName:"admonition"},"If you bought a kit with 3D-printed parts included, you can skip this step.")),(0,a.kt)("admonition",{type:"info"},(0,a.kt)("p",{parentName:"admonition"},"If you don't have access to a 3D printer and can't get the parts made, you can still assemble the kit's electronics without them. Continue on to the next step.")),(0,a.kt)("h2",{id:"models"},"Models"),(0,a.kt)("p",null,"Download STLs of the models from:\n",(0,a.kt)("a",{parentName:"p",href:"https://www.printables.com/model/224313-apc-atari-punk-console"},"https://www.printables.com/model/224313-apc-atari-punk-console")),(0,a.kt)("p",null,"There are four files to print:"),(0,a.kt)("p",null,(0,a.kt)("img",{alt:"Exploded CAD view of the four models",src:n(7745).Z,width:"1229",height:"885"})),(0,a.kt)("table",null,(0,a.kt)("thead",{parentName:"table"},(0,a.kt)("tr",{parentName:"thead"},(0,a.kt)("th",{parentName:"tr",align:null},"Part"),(0,a.kt)("th",{parentName:"tr",align:null},"Count"),(0,a.kt)("th",{parentName:"tr",align:null},"Layer Height"),(0,a.kt)("th",{parentName:"tr",align:null},"Supports?"),(0,a.kt)("th",{parentName:"tr",align:null},"Estimated Time"))),(0,a.kt)("tbody",{parentName:"table"},(0,a.kt)("tr",{parentName:"tbody"},(0,a.kt)("td",{parentName:"tr",align:null},"Wheels"),(0,a.kt)("td",{parentName:"tr",align:null},"2"),(0,a.kt)("td",{parentName:"tr",align:null},".2mm"),(0,a.kt)("td",{parentName:"tr",align:null},"No"),(0,a.kt)("td",{parentName:"tr",align:null},"1hr 8min")),(0,a.kt)("tr",{parentName:"tbody"},(0,a.kt)("td",{parentName:"tr",align:null},"Enclosure top"),(0,a.kt)("td",{parentName:"tr",align:null},"1"),(0,a.kt)("td",{parentName:"tr",align:null},".2mm"),(0,a.kt)("td",{parentName:"tr",align:null},"No"),(0,a.kt)("td",{parentName:"tr",align:null},"4hr")),(0,a.kt)("tr",{parentName:"tbody"},(0,a.kt)("td",{parentName:"tr",align:null},"Switch clutch"),(0,a.kt)("td",{parentName:"tr",align:null},"1"),(0,a.kt)("td",{parentName:"tr",align:null},".2mm"),(0,a.kt)("td",{parentName:"tr",align:null},"No"),(0,a.kt)("td",{parentName:"tr",align:null},"20min")),(0,a.kt)("tr",{parentName:"tbody"},(0,a.kt)("td",{parentName:"tr",align:null},"Enclosure bottom"),(0,a.kt)("td",{parentName:"tr",align:null},"1"),(0,a.kt)("td",{parentName:"tr",align:null},".2mm"),(0,a.kt)("td",{parentName:"tr",align:null},"No"),(0,a.kt)("td",{parentName:"tr",align:null},"48min")))),(0,a.kt)("h2",{id:"notes"},"Notes"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Models assume Fused Deposition Modeling with a standard .4mm nozzle. Using a bigger nozzle will likely result in a loss of detail and possibly missing internal walls."),(0,a.kt)("li",{parentName:"ul"},"The 3D-printed parts were designed using PLA. Other filament types like ABS are not recommended and will likely have fit or tolerance issues. (If you find that you need to drill or file your prints, that's a good sign there'll be other problems too.)"),(0,a.kt)("li",{parentName:"ul"},"They also don't need supports and should already be rotated to the correct orientation for printing."),(0,a.kt)("li",{parentName:"ul"},"Watch the first couple layers of the enclosure pieces while printing, especially around the text engravings ","\u2014"," if you see bad adhesion, stop the print to remedy the situation and start again."),(0,a.kt)("li",{parentName:"ul"},'If the prints aren\'t fitting together well, check to see that the corners aren\'t bulging. See if your slicer has settings for "coasting" or "linear advance."'),(0,a.kt)("li",{parentName:"ul"},"The switch clutch has two narrow support walls that will ",(0,a.kt)("a",{parentName:"li",href:"https://twitter.com/oskitone/status/1367957529406316545"},"break off when it's done printing"),".")))}d.isMDXComponent=!0},7745:(t,e,n)=>{n.d(e,{Z:()=>r});const r=n.p+"assets/images/3d-printed-parts-fba454bae26bc25db3a2ffaf44026769.png"}}]);