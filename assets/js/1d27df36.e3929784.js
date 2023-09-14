"use strict";(self.webpackChunkassembly_guide=self.webpackChunkassembly_guide||[]).push([[578],{3905:(e,t,n)=>{n.d(t,{Zo:()=>c,kt:()=>g});var r=n(7294);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function l(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function i(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var s=r.createContext({}),p=function(e){var t=r.useContext(s),n=t;return e&&(n="function"==typeof e?e(t):l(l({},t),e)),n},c=function(e){var t=p(e.components);return r.createElement(s.Provider,{value:t},e.children)},m={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},u=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,o=e.originalType,s=e.parentName,c=i(e,["components","mdxType","originalType","parentName"]),u=p(n),g=a,d=u["".concat(s,".").concat(g)]||u[g]||m[g]||o;return n?r.createElement(d,l(l({ref:t},c),{},{components:n})):r.createElement(d,l({ref:t},c))}));function g(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=n.length,l=new Array(o);l[0]=u;var i={};for(var s in t)hasOwnProperty.call(t,s)&&(i[s]=t[s]);i.originalType=e,i.mdxType="string"==typeof e?e:a,l[1]=i;for(var p=2;p<o;p++)l[p]=n[p];return r.createElement.apply(null,l)}return r.createElement.apply(null,n)}u.displayName="MDXCreateElement"},8816:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>s,contentTitle:()=>l,default:()=>m,frontMatter:()=>o,metadata:()=>i,toc:()=>p});var r=n(7462),a=(n(7294),n(3905));const o={id:"pcb-small_components",title:"Small components",sidebar_label:"2. Small components",description:"Soldering the APC's small components",slug:"pcb-small_components",image:"/img/assembly/apc.jpg"},l=void 0,i={unversionedId:"pcb-small_components",id:"pcb-small_components",title:"Small components",description:"Soldering the APC's small components",source:"@site/docs/pcb-small_components.md",sourceDirName:".",slug:"/pcb-small_components",permalink:"/apc/pcb-small_components",draft:!1,tags:[],version:"current",frontMatter:{id:"pcb-small_components",title:"Small components",sidebar_label:"2. Small components",description:"Soldering the APC's small components",slug:"pcb-small_components",image:"/img/assembly/apc.jpg"},sidebar:"mySidebar",previous:{title:"1. Power up",permalink:"/apc/pcb-power"},next:{title:"3. Bigger components",permalink:"/apc/pcb-bigger_components"}},s={},p=[],c={toc:p};function m(e){let{components:t,...o}=e;return(0,a.kt)("wrapper",(0,r.Z)({},c,o,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("admonition",{type:"note"},(0,a.kt)("p",{parentName:"admonition"},"Take your time and make sure the 1k trim pot is perfectly flat against the PCB before soldering all of its pins.")),(0,a.kt)("p",null,"Next we'll do the remaining small, passive components."),(0,a.kt)("ol",null,(0,a.kt)("li",{parentName:"ol"},"There are two small ceramic capacitors:",(0,a.kt)("ol",{parentName:"li"},(0,a.kt)("li",{parentName:"ol"},"The one marked ",(0,a.kt)("em",{parentName:"li"},"103")," is for ",(0,a.kt)("strong",{parentName:"li"},".01uF")," (also known as 10nF). It goes to ",(0,a.kt)("strong",{parentName:"li"},"C101"),".\n",(0,a.kt)("img",{alt:".01uF to C101",src:n(5818).Z,width:"1920",height:"1080"})),(0,a.kt)("li",{parentName:"ol"},"The other's marked ",(0,a.kt)("em",{parentName:"li"},"104"),", for ",(0,a.kt)("strong",{parentName:"li"},".1uF"),", and goes to ",(0,a.kt)("strong",{parentName:"li"},"C102"),".\n",(0,a.kt)("img",{alt:".1uF to C102",src:n(4552).Z,width:"1920",height:"1080"})))),(0,a.kt)("li",{parentName:"ol"},"The last cap is an electrolytic ",(0,a.kt)("strong",{parentName:"li"},"10uF")," capacitor at ",(0,a.kt)("strong",{parentName:"li"},"C103"),".",(0,a.kt)("ul",{parentName:"li"},(0,a.kt)("li",{parentName:"ul"},"Match the capacitor's white stripe to the white part of the footprint.\n",(0,a.kt)("img",{alt:"10uF to C103",src:n(2032).Z,width:"1920",height:"1080"})))),(0,a.kt)("li",{parentName:"ol"},"The remaining resistor is ",(0,a.kt)("strong",{parentName:"li"},"1k ohms"),", colored ",(0,a.kt)("em",{parentName:"li"},"Brown Black Red"),".",(0,a.kt)("ul",{parentName:"li"},(0,a.kt)("li",{parentName:"ul"},"Solder to ",(0,a.kt)("strong",{parentName:"li"},"R102"),".\n",(0,a.kt)("img",{alt:"1k ohms to R102",src:n(7427).Z,width:"1920",height:"1080"})))),(0,a.kt)("li",{parentName:"ol"},"The small, blue ",(0,a.kt)("strong",{parentName:"li"},"1k trim potentiometer")," goes to ",(0,a.kt)("strong",{parentName:"li"},"RV103"),". It's marked ",(0,a.kt)("em",{parentName:"li"},"102"),". Make sure it's flat against the PCB. ",(0,a.kt)("ul",{parentName:"li"},(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("img",{alt:"1k trim pot to 102",src:n(8898).Z,width:"1920",height:"1080"})))),(0,a.kt)("li",{parentName:"ol"},"Nothing to test here, but check all solder joints and trim leads before moving on. We're almost done!")))}m.isMDXComponent=!0},5818:(e,t,n)=>{n.d(t,{Z:()=>r});const r=n.p+"assets/images/c101-d79f288fc98ebc86f7b99a6ff4e89e52.jpg"},4552:(e,t,n)=>{n.d(t,{Z:()=>r});const r=n.p+"assets/images/c102-f485b2adb3fa8212e126808d1d236ee4.jpg"},2032:(e,t,n)=>{n.d(t,{Z:()=>r});const r=n.p+"assets/images/c103-80888fcabbff50775a22152e327f0476.jpg"},7427:(e,t,n)=>{n.d(t,{Z:()=>r});const r=n.p+"assets/images/r102-b880d67118a5ceecdebc46c9ebb53e50.jpg"},8898:(e,t,n)=>{n.d(t,{Z:()=>r});const r=n.p+"assets/images/vol-flat-9572b63041f1e6e901b0a5877a7aac08.jpg"}}]);