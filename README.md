https://github.com/xqdoo00o/ChatGPT-to-API  
`docker-compose.yml`  
for those ips which can access chatgpt
```bash
services:
  app:
    image: sheepgreen/chatgpt-to-api
    container_name: cta
    restart: always
    ports:
      - 8080:8080
    volumes:
      - ./harPool:/cta/harPool
      - ./api_keys.txt:/cta/api_keys.txt
      - ./accounts.txt:/cta/accounts.txt
    environment:
      SERVER_HOST: 0.0.0.0
```
if your ip is blocked, use this
```bash
services:
  app:
    image: sheepgreen/chatgpt-to-api
    container_name: cta
    restart: always
    ports:
      - 8080:8080
    volumes:
      - ./harPool:/cta/harPool
      - ./api_keys.txt:/cta/api_keys.txt
      - ./accounts.txt:/cta/accounts.txt
    environment:
      SERVER_HOST: 0.0.0.0
      HTTP_PROXY: http://wgcf:40002
    depends_on:
      - wgcf
  wgcf:
    image: zenexas/wgcf-socks
    container_name: wgcf
    restart: always
```
版权归xqdoo00o所有，更多信息请查看作者项目
