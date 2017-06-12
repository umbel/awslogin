# Makefile
# Assumes GOPATH is set up in your system, e.g., $HOME/go

export TARGET := awslogin

# Change this to the directory where you keep your binaries
MYBINDIR := $(HOME)/data/bin

default:
	go build -ldflags "-s -w" -o $(TARGET)
all:
	make clean
	go get -u github.com/aws/aws-sdk-go/...
	go get -u github.com/vaughan0/go-ini
	go get github.com/fatih/color
	go build -ldflags "-s -w" -o $(TARGET)
install:
	mv -v $(TARGET) $(MYBINDIR)/
clean:
	rm -rfv $(TARGET)
