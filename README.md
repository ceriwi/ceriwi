# Ceriwi - Si laba-laba pengumpul data

## how to use 
```bash
git clone git://github.com/ceriwi/example-config.git
cd example-config
docker-compose up -d
docker exec myceriwi run --db-migration
cat config/blogjs-1.json | docker exec -i myceriwi run --config
```