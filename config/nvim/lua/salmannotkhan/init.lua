require("salmannotkhan.remap")
require("salmannotkhan.set")
require("salmannotkhan.lazy")

vim.cmd[[
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
nnoremap = :FormatXML<Cr>
]]
