"use strict";(self.webpackChunkassembly_guide=self.webpackChunkassembly_guide||[]).push([[937],{3905:(e,t,n)=>{n.d(t,{Zo:()=>p,kt:()=>f});var r=n(7294);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function s(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function i(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var l=r.createContext({}),c=function(e){var t=r.useContext(l),n=t;return e&&(n="function"==typeof e?e(t):s(s({},t),e)),n},p=function(e){var t=c(e.components);return r.createElement(l.Provider,{value:t},e.children)},u={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},m=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,o=e.originalType,l=e.parentName,p=i(e,["components","mdxType","originalType","parentName"]),m=c(n),f=a,d=m["".concat(l,".").concat(f)]||m[f]||u[f]||o;return n?r.createElement(d,s(s({ref:t},p),{},{components:n})):r.createElement(d,s({ref:t},p))}));function f(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=n.length,s=new Array(o);s[0]=m;var i={};for(var l in t)hasOwnProperty.call(t,l)&&(i[l]=t[l]);i.originalType=e,i.mdxType="string"==typeof e?e:a,s[1]=i;for(var c=2;c<o;c++)s[c]=n[c];return r.createElement.apply(null,s)}return r.createElement.apply(null,n)}m.displayName="MDXCreateElement"},3599:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>l,contentTitle:()=>s,default:()=>u,frontMatter:()=>o,metadata:()=>i,toc:()=>c});var r=n(7462),a=(n(7294),n(3905));const o={id:"what-youll-be-making",title:"Oskitone APC Assembly Guide",sidebar_label:"What You'll Be Making",description:"How to solder and assemble the Oskitone APC Electronics Kit",slug:"/",image:"/img/assembly/apc.jpg"},s=void 0,i={unversionedId:"what-youll-be-making",id:"what-youll-be-making",title:"Oskitone APC Assembly Guide",description:"How to solder and assemble the Oskitone APC Electronics Kit",source:"@site/docs/what_youll_be_making.md",sourceDirName:".",slug:"/",permalink:"/apc/",draft:!1,tags:[],version:"current",frontMatter:{id:"what-youll-be-making",title:"Oskitone APC Assembly Guide",sidebar_label:"What You'll Be Making",description:"How to solder and assemble the Oskitone APC Electronics Kit",slug:"/",image:"/img/assembly/apc.jpg"},sidebar:"mySidebar",next:{title:"Inventory",permalink:"/apc/inventory"}},l={},c=[{value:"Um, WHAT",id:"um-what",level:2}],p={toc:c};function u(e){let{components:t,...o}=e;return(0,a.kt)("wrapper",(0,r.Z)({},p,o,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("p",null,(0,a.kt)("a",{target:"_blank",href:n(8099).Z},(0,a.kt)("img",{alt:"APC",src:n(1712).Z,width:"838",height:"450"}))),(0,a.kt)("p",null,"A decapitated robot head? An extraterrestrial communicator? A specter summoner?"),(0,a.kt)("p",null,"Nope (and yep!), it's an ",(0,a.kt)("a",{parentName:"p",href:"https://en.wikipedia.org/wiki/Atari_Punk_Console"},"APC"),"!"),(0,a.kt)("p",null,(0,a.kt)("strong",{parentName:"p"},"Demo:")," ",(0,a.kt)("a",{parentName:"p",href:"https://vimeo.com/518375593"},"https://vimeo.com/518375593"),(0,a.kt)("br",null),"\n",(0,a.kt)("strong",{parentName:"p"},"Purchase:")," ",(0,a.kt)("a",{parentName:"p",href:"https://www.oskitone.com/product/apc"},"APC (fully assembled)"),", ",(0,a.kt)("a",{parentName:"p",href:"https://www.oskitone.com/product/apc-diy-electronics-kit"},"APC DIY Electronics Kit"),(0,a.kt)("br",null),"\n",(0,a.kt)("strong",{parentName:"p"},"Blog post:")," ",(0,a.kt)("a",{parentName:"p",href:"https://blog.tommy.sh/posts/oskitone-makes-an-atari-punk-console/"},"https://blog.tommy.sh/posts/oskitone-makes-an-atari-punk-console/"),(0,a.kt)("br",null),"\n",(0,a.kt)("strong",{parentName:"p"},"Source code:")," ",(0,a.kt)("a",{parentName:"p",href:"https://github.com/oskitone/apc"},"https://github.com/oskitone/apc")),(0,a.kt)("h2",{id:"um-what"},"Um, WHAT"),(0,a.kt)("p",null,"The APC (Atari Punk Console) is some kind of noise toy. Its circuit was originally described in the early 80s but it was such a hit that it's become something of a go-to project for folks new to electronics and soldering! There are ",(0,a.kt)("em",{parentName:"p"},"tons")," of versions of it but they all share the same basic parts."),(0,a.kt)("p",null,(0,a.kt)("img",{alt:"An assembled Oskitone APC",src:n(5618).Z,width:"1920",height:"1080"})),(0,a.kt)("p",null,"The Oskitone APC is the function of the classic circuit in an Oskitone form. It's not very useful or musically pleasant, but it's fun!"),(0,a.kt)("p",null,"I wrote a lot of words about this particular Atari Punk Console here, its design and history with the POLY555, and some other stuff here: ",(0,a.kt)("a",{parentName:"p",href:"https://blog.tommy.sh/posts/oskitone-makes-an-atari-punk-console/"},"Oskitone Makes an Atari Punk Console")))}u.isMDXComponent=!0},8099:(e,t,n)=>{n.d(t,{Z:()=>r});const r=n.p+"assets/files/apc-10-60-838-450-32-a7cf87da369ed924383f4be6f8aa12c8.gif"},1712:(e,t,n)=>{n.d(t,{Z:()=>r});const r=n.p+"assets/images/apc-10-60-838-450-32-a7cf87da369ed924383f4be6f8aa12c8.gif"},5618:(e,t,n)=>{n.d(t,{Z:()=>r});const r=n.p+"assets/images/apc-be7b88af7fd6a5be42f6728a89b528bb.jpg"}}]);