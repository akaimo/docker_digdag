# docker_digdag
Sample High Availability fot Digdag with Docker

## Requirements
- Docker
- Docker Compose

## Usage
### Start-up
```
make
```

### Job registration
```
make push
```
There are sample jobs in the `workflows` directory.
```
ls workflows
```

### UI Link
- [localhost:65432](http://localhost:65432)

### Build Image
```
make build
```

