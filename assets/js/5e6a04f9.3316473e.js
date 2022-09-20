"use strict";(self.webpackChunkassembly_guide=self.webpackChunkassembly_guide||[]).push([[878],{3905:(e,t,r)=>{r.d(t,{Zo:()=>u,kt:()=>m});var n=r(7294);function o(e,t,r){return t in e?Object.defineProperty(e,t,{value:r,enumerable:!0,configurable:!0,writable:!0}):e[t]=r,e}function i(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),r.push.apply(r,n)}return r}function a(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?i(Object(r),!0).forEach((function(t){o(e,t,r[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):i(Object(r)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))}))}return e}function l(e,t){if(null==e)return{};var r,n,o=function(e,t){if(null==e)return{};var r,n,o={},i=Object.keys(e);for(n=0;n<i.length;n++)r=i[n],t.indexOf(r)>=0||(o[r]=e[r]);return o}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(n=0;n<i.length;n++)r=i[n],t.indexOf(r)>=0||Object.prototype.propertyIsEnumerable.call(e,r)&&(o[r]=e[r])}return o}var s=n.createContext({}),c=function(e){var t=n.useContext(s),r=t;return e&&(r="function"==typeof e?e(t):a(a({},t),e)),r},u=function(e){var t=c(e.components);return n.createElement(s.Provider,{value:t},e.children)},p={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},h=n.forwardRef((function(e,t){var r=e.components,o=e.mdxType,i=e.originalType,s=e.parentName,u=l(e,["components","mdxType","originalType","parentName"]),h=c(r),m=o,b=h["".concat(s,".").concat(m)]||h[m]||p[m]||i;return r?n.createElement(b,a(a({ref:t},u),{},{components:r})):n.createElement(b,a({ref:t},u))}));function m(e,t){var r=arguments,o=t&&t.mdxType;if("string"==typeof e||o){var i=r.length,a=new Array(i);a[0]=h;var l={};for(var s in t)hasOwnProperty.call(t,s)&&(l[s]=t[s]);l.originalType=e,l.mdxType="string"==typeof e?e:o,a[1]=l;for(var c=2;c<i;c++)a[c]=r[c];return n.createElement.apply(null,a)}return n.createElement.apply(null,r)}h.displayName="MDXCreateElement"},2888:(e,t,r)=>{r.r(t),r.d(t,{assets:()=>s,contentTitle:()=>a,default:()=>p,frontMatter:()=>i,metadata:()=>l,toc:()=>c});var n=r(7462),o=(r(7294),r(3905));const i={id:"pcb-troubleshooting",title:"PCB troubleshooting",description:"Common problems that come up when soldering the APC PCB.",sidebar_label:"PCB troubleshooting",image:"/img/assembly/apc.jpg",slug:"/pcb-troubleshooting"},a=void 0,l={unversionedId:"pcb-troubleshooting",id:"pcb-troubleshooting",title:"PCB troubleshooting",description:"Common problems that come up when soldering the APC PCB.",source:"@site/docs/pcb-troubleshooting.md",sourceDirName:".",slug:"/pcb-troubleshooting",permalink:"/apc/pcb-troubleshooting",draft:!1,tags:[],version:"current",frontMatter:{id:"pcb-troubleshooting",title:"PCB troubleshooting",description:"Common problems that come up when soldering the APC PCB.",sidebar_label:"PCB troubleshooting",image:"/img/assembly/apc.jpg",slug:"/pcb-troubleshooting"},sidebar:"mySidebar",previous:{title:"Schematic",permalink:"/apc/schematic"},next:{title:"Source and License",permalink:"/apc/source-and-license"}},s={},c=[{value:"General tips",id:"general-tips",level:2},{value:"Specific issues",id:"specific-issues",level:2}],u={toc:c};function p(e){let{components:t,...r}=e;return(0,o.kt)("wrapper",(0,n.Z)({},u,r,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("h2",{id:"general-tips"},"General tips"),(0,o.kt)("p",null,'Any of these problems can cause a variety of "just not working right" errors in a circuit. Familiarize yourself with these troubleshooting checks and do them regularly.'),(0,o.kt)("ul",null,(0,o.kt)("li",{parentName:"ul"},"Turn the PCB over and check all solder joints. A majority of problems are caused by insufficient or errant soldering. Familiarize yourself with what a good joint looks like in the ",(0,o.kt)("a",{parentName:"li",href:"https://learn.adafruit.com/adafruit-guide-excellent-soldering"},"Adafruit Guide To Excellent Soldering"),"."),(0,o.kt)("li",{parentName:"ul"},"Is the chip in the right orientation? It will have a notch/dimple that should match the footprint outline on the PCB."),(0,o.kt)("li",{parentName:"ul"},"Does the battery have enough power? It should measure 9 volts. Try replacing with a fresh battery and see if that solves your issue.")),(0,o.kt)("h2",{id:"specific-issues"},"Specific issues"),(0,o.kt)("ul",null,(0,o.kt)("li",{parentName:"ul"},"If there\u2019s buzzing, check for any metal scraps stuck to the speaker.")))}p.isMDXComponent=!0}}]);