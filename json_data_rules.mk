# JSON files are run through jsonproc, which is a tool that converts JSON data to an output file
# based on an Inja template. https://github.com/pantor/inja

AUTO_GEN_TARGETS += $(DATA_SRC_SUBDIR)/wild_encounters.h
$(DATA_SRC_SUBDIR)/wild_encounters.h: $(DATA_SRC_SUBDIR)/wild_encounters.json $(DATA_SRC_SUBDIR)/wild_encounters.json.txt
	$(JSONPROC) $^ $@

$(C_BUILDDIR)/wild_encounter.o: c_dep += $(DATA_SRC_SUBDIR)/wild_encounters.h

AUTO_GEN_TARGETS += $(DATA_SRC_SUBDIR)/region_map/region_map_entries.h
$(DATA_SRC_SUBDIR)/region_map/region_map_entries.h: $(DATA_SRC_SUBDIR)/region_map/region_map_sections.json $(DATA_SRC_SUBDIR)/region_map/region_map_sections.entries.json.txt
	$(JSONPROC) $^ $@

$(C_BUILDDIR)/region_map.o: c_dep += $(DATA_SRC_SUBDIR)/region_map/region_map_entries.h

AUTO_GEN_TARGETS += $(DATA_SRC_SUBDIR)/region_map/region_map_entry_strings.h
$(DATA_SRC_SUBDIR)/region_map/region_map_entry_strings.h: $(DATA_SRC_SUBDIR)/region_map/region_map_sections.json $(DATA_SRC_SUBDIR)/region_map/region_map_sections.strings.json.txt
	$(JSONPROC) $^ $@

$(C_BUILDDIR)/region_map.o: c_dep += $(DATA_SRC_SUBDIR)/region_map/region_map_entry_strings.h


# INTERNATIONALIZATION
ITEMS_TEMPLATE = $(DATA_SRC_SUBDIR)/items.json.txt
SPECIES_TEMPLATE = $(DATA_SRC_SUBDIR)/text/species_names.json.txt

ifeq ($(INTL), FRENCH)
    ITEMS_TEMPLATE = $(DATA_SRC_SUBDIR)/items_french.json.txt
    SPECIES_TEMPLATE = $(DATA_SRC_SUBDIR)/text/species_names_french.json.txt
endif

# ITEMS
AUTO_GEN_TARGETS += $(DATA_SRC_SUBDIR)/items.h

$(DATA_SRC_SUBDIR)/items.h: $(DATA_SRC_SUBDIR)/items.json $(ITEMS_TEMPLATE)
	$(JSONPROC) $^ $@

$(C_BUILDDIR)/item.o: c_dep += $(DATA_SRC_SUBDIR)/items.h
# END ITEMS

# SPECIES TODO
AUTO_GEN_TARGETS += $(DATA_SRC_SUBDIR)/text/species_names.h

$(DATA_SRC_SUBDIR)/text/species_names.h: $(DATA_SRC_SUBDIR)/text/species_names.json $(SPECIES_TEMPLATE)
	$(JSONPROC) $^ $@
# END SPECIES