CXX = g++
SRCDIR = src
BUILDDIR = build
TARGET = myproject
TESTDIR = test
TESTTARGET = test_myproject

CXXFLAGS = -std=c++11 -I include
TESTFLAGS = -I$(TESTDIR) -I include

SRCEXT = cpp
SOURCES = $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS = $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))

TESTSOURCES = $(shell find $(TESTDIR) -type f -name *.$(SRCEXT))
TESTOBJECTS = $(patsubst $(TESTDIR)/%,$(BUILDDIR)/%,$(TESTSOURCES:.$(SRCEXT)=.o))

all: $(TARGET)

$(TARGET): $(OBJECTS)
	@mkdir -p $(BUILDDIR)
	@$(CXX) $^ -o $(TARGET)

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

test: $(TESTTARGET)
	./$(TESTTARGET) -r junit -o test_results.xml

$(TESTTARGET): $(TESTOBJECTS) $(filter-out $(BUILDDIR)/main.o, $(OBJECTS))
	@mkdir -p $(BUILDDIR)
	@$(CXX) $(CXXFLAGS) $(TESTFLAGS) -o $(TESTTARGET) $^

$(BUILDDIR)/%.o: $(TESTDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@$(CXX) $(CXXFLAGS) $(TESTFLAGS) -c -o $@ $<

clean:
	@rm -rf $(BUILDDIR) $(TARGET) $(TESTTARGET)

.PHONY: clean