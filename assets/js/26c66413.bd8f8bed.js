"use strict";(self.webpackChunkassembly_guide=self.webpackChunkassembly_guide||[]).push([[809],{3905:(e,t,r)=>{r.d(t,{Zo:()=>c,kt:()=>g});var a=r(7294);function n(e,t,r){return t in e?Object.defineProperty(e,t,{value:r,enumerable:!0,configurable:!0,writable:!0}):e[t]=r,e}function o(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),r.push.apply(r,a)}return r}function i(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?o(Object(r),!0).forEach((function(t){n(e,t,r[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):o(Object(r)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))}))}return e}function l(e,t){if(null==e)return{};var r,a,n=function(e,t){if(null==e)return{};var r,a,n={},o=Object.keys(e);for(a=0;a<o.length;a++)r=o[a],t.indexOf(r)>=0||(n[r]=e[r]);return n}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(a=0;a<o.length;a++)r=o[a],t.indexOf(r)>=0||Object.prototype.propertyIsEnumerable.call(e,r)&&(n[r]=e[r])}return n}var s=a.createContext({}),p=function(e){var t=a.useContext(s),r=t;return e&&(r="function"==typeof e?e(t):i(i({},t),e)),r},c=function(e){var t=p(e.components);return a.createElement(s.Provider,{value:t},e.children)},m={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},d=a.forwardRef((function(e,t){var r=e.components,n=e.mdxType,o=e.originalType,s=e.parentName,c=l(e,["components","mdxType","originalType","parentName"]),d=p(r),g=n,u=d["".concat(s,".").concat(g)]||d[g]||m[g]||o;return r?a.createElement(u,i(i({ref:t},c),{},{components:r})):a.createElement(u,i({ref:t},c))}));function g(e,t){var r=arguments,n=t&&t.mdxType;if("string"==typeof e||n){var o=r.length,i=new Array(o);i[0]=d;var l={};for(var s in t)hasOwnProperty.call(t,s)&&(l[s]=t[s]);l.originalType=e,l.mdxType="string"==typeof e?e:n,i[1]=l;for(var p=2;p<o;p++)i[p]=r[p];return a.createElement.apply(null,i)}return a.createElement.apply(null,r)}d.displayName="MDXCreateElement"},1851:(e,t,r)=>{r.r(t),r.d(t,{assets:()=>s,contentTitle:()=>i,default:()=>m,frontMatter:()=>o,metadata:()=>l,toc:()=>p});var a=r(7462),n=(r(7294),r(3905));const o={id:"pcb-power",title:"Power up",sidebar_label:"1. Power up",description:"How to get power to the APC PCB",slug:"pcb-power",image:"/img/assembly/apc.jpg"},i=void 0,l={unversionedId:"pcb-power",id:"pcb-power",title:"Power up",description:"How to get power to the APC PCB",source:"@site/docs/pcb-power.md",sourceDirName:".",slug:"/pcb-power",permalink:"/apc/pcb-power",draft:!1,tags:[],version:"current",frontMatter:{id:"pcb-power",title:"Power up",sidebar_label:"1. Power up",description:"How to get power to the APC PCB",slug:"pcb-power",image:"/img/assembly/apc.jpg"},sidebar:"mySidebar",previous:{title:"General tips",permalink:"/apc/general-tips"},next:{title:"2. Small components",permalink:"/apc/pcb-small_components"}},s={},p=[],c={toc:p};function m(e){let{components:t,...o}=e;return(0,n.kt)("wrapper",(0,a.Z)({},c,o,{components:t,mdxType:"MDXLayout"}),(0,n.kt)("admonition",{type:"info"},(0,n.kt)("p",{parentName:"admonition"},"This guide's components' brands and body colors (and even the PCB color itself) may look different from yours, and that's okay! What's important is that the part types and values are in the right spots.")),(0,n.kt)("admonition",{type:"note"},(0,n.kt)("p",{parentName:"admonition"},"Take your time and make sure the LED and switch are perfectly flat against the PCB before soldering all of their pins.")),(0,n.kt)("p",null,"First, we'll get power to the board and make sure our battery is working."),(0,n.kt)("ol",null,(0,n.kt)("li",{parentName:"ol"},"Find the ",(0,n.kt)("strong",{parentName:"li"},"330 ohm resistor"),"; its color bands are ",(0,n.kt)("em",{parentName:"li"},"Orange Orange Brown"),". Solder it into ",(0,n.kt)("strong",{parentName:"li"},"R101"),".",(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},(0,n.kt)("img",{alt:"330 resistor to R101",src:r(2132).Z,width:"1920",height:"1080"})))),(0,n.kt)("li",{parentName:"ol"},"The ",(0,n.kt)("strong",{parentName:"li"},"LED")," goes to ",(0,n.kt)("strong",{parentName:"li"},"D101"),".",(0,n.kt)("ol",{parentName:"li"},(0,n.kt)("li",{parentName:"ol"},"Note that the footprint on the PCB is a circle with one flat side. Insert the ",(0,n.kt)("strong",{parentName:"li"},"LED")," so its flat side matches that footprint."),(0,n.kt)("li",{parentName:"ol"},"Hold in place and solder. Make sure it's flat against the PCB. ",(0,n.kt)("img",{alt:"LED, perfectly flat against PCB, at D101",src:r(9823).Z,width:"1920",height:"1080"})))),(0,n.kt)("li",{parentName:"ol"},"The ",(0,n.kt)("strong",{parentName:"li"},"slider switch")," goes to ",(0,n.kt)("strong",{parentName:"li"},"S101"),".",(0,n.kt)("ol",{parentName:"li"},(0,n.kt)("li",{parentName:"ol"},"It doesn't have polarity and can go in either direction, but, just like the ",(0,n.kt)("strong",{parentName:"li"},"LED"),", it does need to be perfectly flat against the PCB."),(0,n.kt)("li",{parentName:"ol"},"Confirm it's flat before soldering soldering all of its pads. ",(0,n.kt)("img",{alt:"Switch, perfectly flat against PCB, at S101",src:r(4479).Z,width:"1920",height:"1080"})))),(0,n.kt)("li",{parentName:"ol"},"Next up is the ",(0,n.kt)("strong",{parentName:"li"},"9v battery snap"),".",(0,n.kt)("ol",{parentName:"li"},(0,n.kt)("li",{parentName:"ol"},"Feed its wires through the hole by ",(0,n.kt)("strong",{parentName:"li"},"BT101"),". This acts as a stress relief, preventing strain at the solder joints whenever you replace the battery.\n",(0,n.kt)("img",{alt:"9v snap wires in their relief hole",src:r(6414).Z,width:"1920",height:"1080"})),(0,n.kt)("li",{parentName:"ol"},"Insert and solder wires into place: red to ",(0,n.kt)("strong",{parentName:"li"},"+")," and black to ",(0,n.kt)("strong",{parentName:"li"},"-"),(0,n.kt)("img",{alt:"9v snap wires in place at BT101",src:r(7618).Z,width:"1920",height:"1080"})))),(0,n.kt)("li",{parentName:"ol"},(0,n.kt)("strong",{parentName:"li"},"Test it!"),(0,n.kt)("ol",{parentName:"li"},(0,n.kt)("li",{parentName:"ol"},"Connect a ",(0,n.kt)("strong",{parentName:"li"},"battery")," to the ",(0,n.kt)("strong",{parentName:"li"},"9v snap"),", and slide the ",(0,n.kt)("strong",{parentName:"li"},"switch")," back and forth. You should see the ",(0,n.kt)("strong",{parentName:"li"},"LED")," turn on and off. Nice!\n",(0,n.kt)("img",{alt:"Testing power",src:r(4396).Z,width:"1920",height:"1080"})),(0,n.kt)("li",{parentName:"ol"},"If you don't, don't worry; it's just time to debug. ",(0,n.kt)("em",{parentName:"li"},"Don't move on to the next step until you've got this working."),(0,n.kt)("ul",{parentName:"li"},(0,n.kt)("li",{parentName:"ul"},"Check all your solder joints."),(0,n.kt)("li",{parentName:"ul"},"Verify ",(0,n.kt)("strong",{parentName:"li"},"LED")," is placed correctly and matches its footprint."),(0,n.kt)("li",{parentName:"ul"},"Is the ",(0,n.kt)("strong",{parentName:"li"},"battery")," dead?"),(0,n.kt)("li",{parentName:"ul"},"Are the ",(0,n.kt)("strong",{parentName:"li"},"battery")," wires in the right spots?"))))),(0,n.kt)("li",{parentName:"ol"},"Trim leads if you haven't already, and remove the ",(0,n.kt)("strong",{parentName:"li"},"battery")," before continuing.")))}m.isMDXComponent=!0},6414:(e,t,r)=>{r.d(t,{Z:()=>a});const a=r.p+"assets/images/9v-relief-3c76e82a0fe6ff3175ba3885ed6e7431.jpg"},7618:(e,t,r)=>{r.d(t,{Z:()=>a});const a=r.p+"assets/images/9v-wires-4a472b55b00a574c11746080011cfded.jpg"},9823:(e,t,r)=>{r.d(t,{Z:()=>a});const a=r.p+"assets/images/led-flat-3c906b69467fe843d5d1bc7c9b5e9cb3.jpg"},4396:(e,t,r)=>{r.d(t,{Z:()=>a});const a=r.p+"assets/images/power-1955cce66a5cdd7a8198904963838475.jpg"},2132:(e,t,r)=>{r.d(t,{Z:()=>a});const a=r.p+"assets/images/r101-94496cd19461954b357ff2a08031fd85.jpg"},4479:(e,t,r)=>{r.d(t,{Z:()=>a});const a=r.p+"assets/images/switch-flat-435f86f4d36875d9ab32004dd37b830b.jpg"}}]);