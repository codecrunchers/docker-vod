#docker run --rm -it -v $PWD:/go/src/github.com/treeder/dockergo -w /go/src/github.com/treeder/dockergo treeder/glide init
#docker run --rm -it -v $PWD:/go/src/github.com/treeder/dockergo -w /go/src/github.com/treeder/dockergo treeder/glide update
docker run --rm -v "$PWD":/go/src/github.com/treeder/dockergo -w /go/src/github.com/treeder/dockergo iron/go:dev go build -o app
