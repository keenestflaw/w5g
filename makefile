include gmsl
.PHONY : FORCE
.SILENT :
.SUFFIXES : # Delete the default suffixes


#shell                 = /usr/bin/bash
#MAKEFILE_PATH        := $(abspath $(lastword $(MAKEFILE_LIST)))
#MAKEFILE_DIR         := $(dir $(MAKEFILE_PATH))
#BASE_DIR             := $(shell realpath --relative-to=$(MAKEFILE_DIR) $(MAKEFILE_DIR))
#INSTALL_DIR          ?= $(BASE_DIR)# overwrite in command line or via project.mk 
#REALPATH_TO_BASE_DIR := realpath --relative-to=$(BASE_DIR)# this is the place to start from when accessing assests  



MKDN_FILES = $(shell find "$(DOCUMENT_DIR)" -type f -name "*md")
HTML_FILES = $(patsubst $(DOCUMENT_DIR)/%.md,$(DOCUMENTROOT)/%.html,$(MKDN_FILES))


build: $(DOCUMENTROOT) $(DOCUMENT_DIR) $(HTML_FILES) FORCE
	$(info $@ $<)

$(DOCUMENTROOT)%.html : $(DOCUMENT_DIR)%.md  
	$(info $$@:${@} $$<:${<})
	[ -d $(dir ${@}) ] || mkdir -pv $(dir ${@})
	plugin-mkdn2html.bash "${@}" "${<}" "$(dir $<)metadata.yaml" "$(DATA_DIR)"

# make targets run without accusing them to be PHONY
FORCE :
	$(info $@ $<)
