SPLIT_SCRIPTS = \
	yabs-split.sh \
	split-parts/*.sh \
	functions/*.sh \
	steps/*.sh \

all: yabs-merged.sh

yabs-merged.sh: $(SPLIT_SCRIPTS)
	merge-shell.sh yabs-split.sh > yabs-merged.sh

test: yabs-merged.sh
	@diff -u yabs.sh yabs-merged.sh
	@echo "Test passed"

clean:
	rm -f yabs-merged.sh
