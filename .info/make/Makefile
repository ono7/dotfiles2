# =========== #
#  Interface  #
# =========== #

BLACK := $(shell tput -Txterm setab 0 && tput -Txterm setaf 7)
RED := $(shell tput -Txterm setab 1 && tput -Txterm setaf 0)
GREEN := $(shell tput -Txterm setab 2 && tput -Txterm setaf 0)
YELLOW := $(shell tput -Txterm setab 3 && tput -Txterm setaf 0)
LIGHTPURPLE := $(shell tput -Txterm setab 4 && tput -Txterm setaf 0)
PURPLE := $(shell tput -Txterm setab 5 && tput -Txterm setaf 7)
BLUE := $(shell tput -Txterm setab 4 && tput -Txterm setaf 0)
WHITE := $(shell tput -Txterm setab 7 && tput -Txterm setaf 0)
RESET := $(shell tput -Txterm sgr0)
BLUE_TEXT := $(shell tput -Txterm setaf 4)
RED_TEXT := $(shell tput -Txterm setaf 1)
YELLOW_TEXT  := $(shell tput -Txterm setaf 3)

# make file for testing

SOURCE = $(wildcard *1.txt) # track all files ending with 1.txt
OBJS = $(SOURCE:.txt=.a) # .txt are targets and .a files are output of these targets

${OBJS}: # build for this targets *1.txt, in this directory
	@echo "${PURPLE} testing build ${RESET} outside color!"
	touch ${OBJS}

# target: dependency
${OBJS}: ${SOURCE} # rule: if OBS depends on SOURCE, if SOURCE changes, OBJS should be built

# examples on how to clean up using find

# find . -name *.pyc -delete
# find . -type d -name __pycache__ -d

