#!/usr/bin/perl

use strict;
use lib "./t"; use MakeMakerFix;

WriteMakefile('Bits.pm', 'postamble' => <<'EOF');

inc_dir = $(INST_LIB)/$(FULLEXT)

$(inc_dir)/.exists: Makefile
	@ $(MKPATH) $(inc_dir) && $(TOUCH) $(inc_dir)/.exists
	@ inc_dir_abs=`cd $(inc_dir) && pwd`; \
	(cd /usr/include && h2ph -l -d $$inc_dir_abs -a \
	sys/stat.h sys/sysmacros.h); echo Ignored, OK; \
	$(TOUCH) $(inc_dir)/.exists

pure_all::   $(inc_dir)/.exists
EOF

