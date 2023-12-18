# Deploy ~

# docker build
```shell
docker buildx build --build-arg BUILDKIT_INLINE_CACHE=1 --cache-from=tailwind-blog:latest -t tailwind-blog:latest -f Dockerfile ./next-app 
```

# docker run
```shell
docker run --name tailwind -d -p 3004:3004 tailwind-blog:latest
```
