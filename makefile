include gmsl
.PHONY : FORCE
.SILENT :
.SUFFIXES : # Delete the default suffixes

MKDN_FILES = $(shell find "$(DOCUMENT_DIR)" -type f -name "*md")
HTML_FILES = $(patsubst $(DOCUMENT_DIR)/%.md,$(DOCUMENTROOT)/%.html,$(MKDN_FILES))

build: $(DOCUMENTROOT) $(DOCUMENT_DIR) $(HTML_FILES)
	$(info $@ $<)
	#${MAKE} $(HTML_FILES) 	
	touch $(@)

$(DOCUMENTROOT)%.html : $(DOCUMENT_DIR)%.md  
	$(info $$@:${@} $$<:${<})
	[ -d $(dir ${@}) ] || mkdir -pv $(dir ${@})
	plugin-mkdn2html.bash "${@}" "${<}" "$(dir $<)metadata.yaml"
