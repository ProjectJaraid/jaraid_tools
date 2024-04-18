---
title: "Read me: jaraid_tools"
author: Till Grallert
date: 2019-03-19 12:34:39 +0200
---

# generate the ZMO website

1. Update the RSS files:
    + Run *Jaraid RSS* on the TEI file and
    + upload the resulting RSS files to projectjaraid.github.io
2. Run *Jaraid current development* on the TEI file
3. Copy the resulting HTML to projectjaraid.github.io

# oXygen project file

The oXygen project file provides a number of XSLT transformation scenarios to transform our XML TEI data into a static HTML site based on the ZMO's layout. This is legacy code last touched in 2014!

1. *Jaraid ZMO delivered*: This was the original code for the ZMO website and makes use of `xslt/zmo-website/HTML v4e6 ZMO.xsl`
2. *Jaraid current development*: Later updates to the ZMO website have been generated using this transformation that makes use of `xslt/zmo-website/HTML v4e12 ZMO.xsl`
    + make sure to run the transformation *Jaraid RSS* beforehand in order to generate an up-to-date RSS file.