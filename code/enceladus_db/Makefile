DB=enceladus
BUILD=$(CURDIR)/build.sql
SCRIPTS=$(CURDIR)/scripts
CSV='/var/lib/postgresql/cassini_data/curious_data/data/master_plan.csv'
MASTER=$(SCRIPTS)/import.sql
NORMALIZE=$(SCRIPTS)/normalize.sql

all: normalize
	psql $(DB) -f $(BUILD)

master:
	@cat $(MASTER) >> $(BUILD)

import: master
	@echo "COPY import.master_plan FROM $(CSV) WITH DELIMITER ',' HEADER CSV;" >> $(BUILD)

normalize:
	@cat $(NORMALIZE) >> ${BUILD}

clean:
	@rm -rf $(BUILD)

