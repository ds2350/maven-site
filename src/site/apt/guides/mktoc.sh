#!/bin/sh

toc=`pwd`/index.apt

find . -name '*~' -exec rm -rf {} \;

#
# Top matter
#

echo " ------ " > $toc
echo " Summary of Maven 2.x documentation " >> $toc
echo " ------ " >> $toc
echo " Jason van Zyl " >> $toc
echo " ------ " >> $toc
echo " 12 October 2005 " >> $toc
echo " ------ " >> $toc
echo >> $toc
echo "Documentation" >> $toc
echo >> $toc

#
# Getting started guide
#

echo "* Getting Started Guide" >> $toc
echo >> $toc
echo " * {{{getting-started/index.html}Getting Started Guide}}" >> $toc

#
# Mini Guides
#

echo >> $toc
echo "* Mini Guides" >> $toc
echo >> $toc

(
  cd mini

  for i in `ls -d guide-*`
  do
   if [ -d $i ]
   then
     (
       cd $i
       title=`grep "^ *Guide" ${i}.apt | sed 's/^ *//'`
       i=`echo $i | sed 's/\.apt/\.html/'`
       [ ! -z "$title" ] && echo " * {{{mini/$i/$i.html}$title}}" >> $toc && echo >> $toc
     )
   else
     title=`grep "^ Guide" $i | sed 's/^ *//'`
     i=`echo $i | sed 's/\.apt/\.html/'`
     [ ! -z "$title" ] && echo " * {{{mini/$i}$title}}" >> $toc && echo >> $toc
   fi
  
  done       
)       

#
# Introductions
#

echo >> $toc
echo "* Introductory Material" >> $toc
echo >> $toc

(
  cd introduction

  for i in `ls introduction-*.apt`
  do
   title=`grep "^ Introduction" $i | sed 's/^ *//'`
   i=`echo $i | sed 's/\.apt/\.html/'`   
   [ ! -z "$title" ] && echo " * {{{introduction/$i}$title}}" >> $toc && echo >> $toc
  done       
)       

#
# Plugins
#

echo >> $toc
echo "* Plugin Guides" >> $toc
echo >> $toc

(
  cd plugin

  for i in `ls guide-*.apt`
  do
   title=`grep "^ Guide" $i | sed 's/^ *//'`
   i=`echo $i | sed 's/\.apt/\.html/'`
   [ ! -z "$title" ] && echo " * {{{plugin/$i}$title}}" >> $toc && echo >> $toc
  done       
)       

#
# Developer Guides
#

echo >> $toc
echo "* Development Guides" >> $toc
echo >> $toc

(
  cd development

  for i in `ls guide-*.apt`
  do
   title=`grep "^ Guide" $i | sed 's/^ *//'`
   i=`echo $i | sed 's/\.apt/\.html/'`
   [ ! -z "$title" ] && echo " * {{{development/$i}$title}}" >> $toc && echo >> $toc
  done       
)       

cat >> $toc <<EOF

* Reference

 * {{{../ref/current/maven-model/maven.html}Project Descriptor}}
 
 * {{{../ref/current/maven-settings/settings.html}Settings Descriptor}}
 
 * {{{../plugins/index.html}Available Plug-ins}}
 
 * {{{../developers/mojo-api-specification.html}Mojo API}}
 
 * {{{../ant-tasks.html}Ant Tasks}}
 
 * {{{../glossary.html}Glossary}}
 
 * {{{../maven-conventions.html}Maven Conventions}}

 * {{{../articles.html}Articles}}
 
 []
EOF
