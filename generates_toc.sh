#!/bin/bash

BEGIN="$(grep -En '^Petit guide' install.md | cut -d':' -f1)"

tail -n +"${BEGIN}" install.md > /tmp/install.md.old

git clone https://github.com/ekalinin/github-markdown-toc.git
bash github-markdown-toc/gh-md-toc /tmp/install.md.old > /tmp/install.md.toc
rm -rf github-markdown-toc
sed -i 's/Table of Contents/Sommaire/g' /tmp/install.md.toc
sed -i 's/=================/========/g' /tmp/install.md.toc
sed -i 's/Created by/Créé par/g' /tmp/install.md.toc
echo >> /tmp/install.md.toc
cat /tmp/install.md.old >> /tmp/install.md.toc
mv /tmp/install.md.toc install.md
rm -f /tmp/install.md.old
