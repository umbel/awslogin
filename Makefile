# Makefile
# Assumes GOPATH is already set up in your system, e.g., $HOME/go

export TARGET := awslogin

default:
	go build -ldflags "-s -w" -o $(TARGET)
	GOOS=linux GOARCH=amd64 go build -ldflags "-s -w" -o $(TARGET)-linux
all:
	make clean
	go get -u github.com/aws/aws-sdk-go/...
	go get -u github.com/vaughan0/go-ini
	go get github.com/fatih/color
	GOOS=darwin GOARCH=amd64 go build -ldflags "-s -w" -o $(TARGET)
	GOOS=linux GOARCH=amd64 go build -ldflags "-s -w" -o $(TARGET)-linux
clean:
	rm -rfv $(TARGET)
	rm -rfv $(TARGET)-linux
