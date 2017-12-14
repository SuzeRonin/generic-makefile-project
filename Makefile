SRC_DIR   = ./src
INC_DIR   = ./include
LIB_DIR   = ./lib
BUILD_DIR = ./build
BIN_DIR   = ./bin
TEST_DIR  = ./test

SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(SRCS:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)
TESTS := $(wildcard $(TEST_DIR)/*Test.cpp)

APP = a.out
CXX = g++
CXXFLAGS = -Wall \
           -Wextra \
           -Wuninitialized \
           -Wmissing-declarations \
           -pedantic \
           -O0 \
	   -std=c++17 \
           -MMD \
           -MP \
	   -I$(INC_DIR)
LD  = g++
LDFLAGS = -L$(LIB_DIR)


$(BIN_DIR)/$(APP) : $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^


$(BUILD_DIR)/%.o : $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<



.PHONY: clean test

GTEST_MAIN = $(LIB_DIR)/libgmock_main.a 
GTEST_INC = .
GTEST_LIB = -lgtest
GTEST_FLAGS = -pthread #needed by gtest

test:	$(BIN_DIR)/$(APP)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(TESTS) -I$(GTEST_INC) $(GTEST_LIB) $(GTEST_MAIN) $(GTEST_FLAGS) -o $(BIN_DIR)/$@
	./$(BIN_DIR)/$@


clean:
	$(RM) $(OBJS) $(DEPS)

-include $(DEPS)




