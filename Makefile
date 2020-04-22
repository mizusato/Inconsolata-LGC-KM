# Makefile for Inconsolata font

FONTS=Inconsolata-LGC-KM.ttf \
      Inconsolata-LGC-KM-Bold.ttf \
      Inconsolata-LGC-KM-Italic.ttf \
      Inconsolata-LGC-KM-BoldItalic.ttf
OTFONTS=${FONTS:.ttf=.otf}
DOCUMENTS=README ChangeLog LICENSE
PKGS=InconsolataLGCKM.tar.xz InconsolataLGCKM-OT.tar.xz
FFCMD=for i in $?;do fontforge -lang=ff -c "Open(\"$$i\");Generate(\"$@\");Close()";done
TTFPKGCMD=rm -rf $*; mkdir $*; cp ${FONTS} ${DOCUMENTS} $*
OTFPKGCMD=rm -rf $*; mkdir $*; cp ${OTFONTS} ${DOCUMENTS} $*

.PHONY: all
all: ttf otf

.SUFFIXES: .sfd .ttf .otf

.sfd.ttf:
	${FFCMD}
.sfd.otf:
	${FFCMD}

.PHONY: ttf otf
ttf: ${FONTS}
otf: ${OTFONTS}

.SUFFIXES: .tar.xz .tar.gz .tar.bz2 .zip
.PHONY: dist
dist: ${PKGS}

InconsolataLGCKM.tar.xz: ${FONTS} ${DOCUMENTS}
	${TTFPKGCMD}; tar cfvJ $@ $*
InconsolataLGCKM.tar.gz: ${FONTS} ${DOCUMENTS}
	${TTFPKGCMD}; tar cfvz $@ $*
InconsolataLGCKM.tar.bz2: ${FONTS} ${DOCUMENTS}
	${TTFPKGCMD}; tar cfvj $@ $*
InconsolataLGCKM.zip: ${FONTS} ${DOCUMENTS}
	${TTFPKGCMD}; zip -9r $@ $*

InconsolataLGCKM-OT.tar.xz: ${OTFONTS} ${DOCUMENTS}
	${OTFPKGCMD}; tar cfvJ $@ $*
InconsolataLGCKM-OT.tar.gz: ${OTFONTS} ${DOCUMENTS}
	${OTFPKGCMD}; tar cfvz $@ $*
InconsolataLGCKM-OT.tar.bz2: ${OTFONTS} ${DOCUMENTS}
	${OTFPKGCMD}; tar cfvj $@ $*
InconsolataLGCKM-OT.zip: ${OTFONTS} ${DOCUMENTS}
	${OTFPKGCMD}; zip -9r $@ $*

ChangeLog: .git # GIT
	./mkchglog.rb > $@ # GIT

.PHONY: clean
clean:
	-rm -f ${FONTS} ${OTFONTS} ChangeLog
	-rm -rf ${PKGS} ${PKGS:.tar.xz=} ${PKGS:.tar.xz=.tar.bz2} \
	${PKGS:.tar.xz=.tar.gz} ${PKGS:.tar.xz=.zip}
