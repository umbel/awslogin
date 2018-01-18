# Makefile
# Assumes GOPATH is already set up in your system, e.g., $HOME/go

export TARGET := awslogin

default:
	go build -ldflags "-s -w" -o $(TARGET)
all:
	make clean
	go get -u github.com/aws/aws-sdk-go/...
	go get -u github.com/vaughan0/go-ini
	go get github.com/fatih/color
	go build -ldflags "-s -w" -o $(TARGET)
clean:
	rm -rfv $(TARGET)
