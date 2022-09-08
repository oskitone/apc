// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */

const _doc = id => ({
  type: "doc",
  id
});

const _category = (label, docIds = []) => ({
  label,
  type: "category",
  items: docIds.map(id => _doc(id))
});

const sidebars = {
  mySidebar: [
    _category("Getting Started", [
      "what-youll-be-making",
      "inventory"
      // "how-does-it-work"
    ]),
    _doc("3d-printing"),
    _category("PCB Assembly", [
      // "general-tips",
      "pcb-power",
      "pcb-small_components",
      "pcb-bigger_components",
      "pcb-test"
    ]),
    _doc("final_assembly"), // "care"
    _category("Appendix", ["hacks", "bom", "schematic", "source-and-license"])
  ]
};

module.exports = sidebars;
