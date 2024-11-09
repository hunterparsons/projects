# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -std=c++11

# Target executable name
TARGET = database

# Source files and their corresponding object files
SRCS = src/main.cpp src/SDFuncs.cpp src/studentFuncs.cpp src/subjFuncs.cpp
OBJS = $(SRCS:.cpp=.o)

# Header files
HEADERS = head.h

# Rule to build the final executable
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)

# Rule to build each object file
%.o: %.cpp $(HEADERS)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean rule to remove all generated files
.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET)
