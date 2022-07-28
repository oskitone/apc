// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  someSidebar: {
    "Getting Started": [
      "what-youll-be-making",
      "inventory"
      // "how-does-it-work"
    ],
    "3D-Printing": ["3d-printing"],
    "PCB Assembly": [
      // "general-tips",
      "pcb-power",
      "pcb-small_components",
      "pcb-bigger_components",
      "pcb-test"
    ],
    "Putting it all together": [
      "final_assembly"
      // "care"
    ],
    Appendix: [
      "hacks",
      "bom",
      "schematic"
      // "troubleshooting"
      //   "source-and-license"
    ]
  }
};

module.exports = sidebars;
