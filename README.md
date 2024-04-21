https://github.com/xqdoo00o/ChatGPT-to-API  
`docker-compose.yml`  
> [!TIP]
> 如果没有账号，将部署代码中包含harPool和account.txt的这两行注释即可（据说不登录账号会比较智障，请自行测试）
- for those ips which can access chatgpt
```bash
services:
  app:
    image: sheepgreen/chatgpt-to-api
    container_name: cta
    restart: always
    ports:
      - 8080:8080
    volumes:
      - ./harPool:/cta/harPool #如无账号可删
      - ./api_keys.txt:/cta/api_keys.txt #自建key，说明详见作者项目
      - ./accounts.txt:/cta/accounts.txt #如无账号可删
    environment:
      SERVER_HOST: 0.0.0.0
```
- if your ip is blocked, use this
```bash
services:
  app:
    image: sheepgreen/chatgpt-to-api
    container_name: cta
    restart: always
    ports:
      - 8080:8080
    volumes:
      - ./harPool:/cta/harPool #如无账号可删
      - ./api_keys.txt:/cta/api_keys.txt #自建key，说明详见作者项目
      - ./accounts.txt:/cta/accounts.txt #如无账号可删
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
