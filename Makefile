# Please be aware that this makefile doesn't support multi-platform,
# which means you have to manually re-invent the wheels ;)


CC=gcc
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))
FLAGS=-g -c
SOURCEDIR=src
BUILDDIR=build
OBJDIR=$(BUILDDIR)/objects
EXEDIR=$(BUILDDIR)/out
EXE=projo
SOURCES = $(call rwildcard, $(SOURCEDIR), *.c)
RELOBJS = $(patsubst $(SOURCEDIR)/%.c, %.o, $(SOURCES))
ALLOBJDIRS = $(addprefix $(OBJDIR)/, $(dir $(RELOBJS)))
OBJECTS = $(addprefix $(OBJDIR)/, $(RELOBJS))

.PHONY: run

run:link
	@echo -----Results-----
	@$(EXEDIR)/$(EXE)

link:$(EXEDIR) $(EXEDIR)/$(EXE)

$(EXEDIR)/$(EXE):$(OBJECTS)
	$(CC) -o $@ $^

$(EXEDIR):
	@echo $(@D)
	@mkdir $(subst /,\,$(EXEDIR))

object: $(OBJECTS)

$(OBJECTS): $(OBJDIR)/%.o: $(SOURCEDIR)/%.c
	$(CC) $(FLAGS) $< -o $@

$(OBJECTS): | $(ALLOBJDIRS)

$(ALLOBJDIRS):
	@echo making $(@D)
	@mkdir $(subst /,\, $(@D))