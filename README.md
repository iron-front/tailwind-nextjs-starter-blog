# Deploy ~

# docker build
```shell
docker buildx build --build-arg BUILDKIT_INLINE_CACHE=1 --cache-from=tailwind-blog:latest -t tailwind-blog:latest -f Dockerfile ./next-app 
```

# docker run
```shell
docker run -d -p 3005:3005 tailwind-blog:latest
```
