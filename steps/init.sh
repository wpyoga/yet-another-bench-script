# @MERGE
. split-parts/override-locale.sh

# @MERGE
. split-parts/detect-arch.sh

# @MERGE
. split-parts/default-flags.sh

# @MERGE
. split-parts/parse-args.sh

# @MERGE
. split-parts/check-installed-utils.sh

# @MERGE
. split-parts/check-connectivity.sh

# @MERGE
. split-parts/print-help.sh

# @MERGE
. functions/format-size.sh

# @MERGE
. split-parts/gather-system-info.sh

# @MERGE
. split-parts/make-yabs-path.sh

# @MERGE
. split-parts/trap-signals.sh

# @MERGE
. functions/catch-abort.sh
