FROM golang:1.13.1 as builder

# Copy the code from the host and compile it
WORKDIR $GOPATH/src/github.com/kedacore/sample-go-storage-queue

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go install ./...

FROM scratch
COPY --from=builder /go/bin/receive /go/bin/send /usr/local/bin/
# Scratch image requires this line for ca certificate
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
CMD ["receive"]