从ChatGPT网站模拟使用API  
如需使用[Railway](https://railway.app)平台部署请访问https://github.com/slippersheepig/ChatGPT-to-API-Railway  
源码https://github.com/xqdoo00o/ChatGPT-to-API
> [!TIP]
> 如果没有账号，将部署代码中包含harPool和account.txt的这两行注释即可（据说不登录账号会比较智障，请自行测试）

使用步骤（摘自原作者项目）
- 一、新建`harPool`文件夹，将获取到的`chatgpt.com.har`文件放到文件夹内（如无ChatGPT账号可跳过此步）  
`chatgpt.com.har`获取方法（如果此前已导出过`chat.openai.com.har`，也可以使用`chat.openai.com.har`代替`chatgpt.com.har`）
  + 使用基于chromium的浏览器（Chrome，Edge）打开浏览器开发者工具（F12），并切换到网络标签页，勾选保留日志选项。
  + 登录`https://chatgpt.com`，新建聊天并选择GPT-4模型，随意输入下文字，切换到GPT-3.5模型，随意输入下文字（如果不是付费账号，则忽略切换模型步骤，直接输入文字）。
  + 点击网络标签页下的导出HAR按钮，导出文件`chatgpt.com.har`，放置到harPool文件夹里。
- 二、新建`accounts.txt`文件，按如下格式录入保存账号信息（如无ChatGPT账号可跳过此步，注意冒号为`英文`冒号）
  + ```bash
    邮箱A:密码
    邮箱B:密码:2
    邮箱C:密码:2/5
    ...
    ```
  + 密码后的数字表示轮询次数，默认为1次。上例表示第一次对话使用账户A，而后两次对话使用账户B，账户C为Teams账户，接着五次对话使用账户C的Teams，然后两次使用账户C的个人，如此循环。
- 三、新建`api_keys.txt`文件，按如下格式录入保存key信息
  + ```bash
    sk-123456
    88888888
    ...
    ```
- 四、新建`docker-compose.yml`文件 ，根据需要按如下模板编辑保存
  + 若你的网络能直接访问ChatGTP
  + ```bash
    services:
      app:
        image: sheepgreen/chatgpt-to-api
        container_name: cta
        restart: always
        ports:
          - 8080:8080
        volumes:
          - ./harPool:/cta/harPool #如无账号可删此行
          - ./api_keys.txt:/cta/api_keys.txt #自建key，说明详见作者项目
          - ./accounts.txt:/cta/accounts.txt #如无账号可删此行
        environment:
          SERVER_HOST: 0.0.0.0
          ADMIN_PASSWORD: TotallySecurePassword #自行修改密码
    ```
  + 若你的网络不能直接访问ChatGPT
  + ```bash
    services:
      app:
        image: sheepgreen/chatgpt-to-api
        container_name: cta
        restart: always
        ports:
          - 8080:8080
        volumes:
          - ./harPool:/cta/harPool #如无账号可删此行
          - ./api_keys.txt:/cta/api_keys.txt #自建key，说明详见作者项目
          - ./accounts.txt:/cta/accounts.txt #如无账号可删此行
        environment:
          SERVER_HOST: 0.0.0.0
          ADMIN_PASSWORD: TotallySecurePassword #自行修改密码
          HTTP_PROXY: http://wgcf:40002
        depends_on:
          - wgcf
      wgcf:
        image: zenexas/wgcf-socks
        container_name: wgcf
        restart: always
    ```
- 五、文件位置关系如下图
  + ![image](https://github.com/slippersheepig/ChatGPT-to-API/assets/58287293/b1eda56d-5b43-410b-ac35-f9dd62ed748f)
- 六、运行`docker-compose up -d`即启动成功，API访问地址为`http://[ip]:8080/v1/chat/completions`，API KEY为`api_keys.txt`里填写的KEY，根据你使用的ChatGPT项目自行修改代理地址即可
  + 常见项目使用方法如下
    + https://github.com/ChatGPTNextWeb/ChatGPT-Next-Web
      + OPENAI_API_KEY=`api_keys.txt`里填写的KEY
      + BASE_URL=http://[ip]:8080
    + https://github.com/Chanzhaoyu/chatgpt-web
      + OPENAI_API_KEY=`api_keys.txt`里填写的KEY
      + OPENAI_API_BASE_URL=http://[ip]:8080
    + https://github.com/RockChinQ/QChatGPT
      + "keys": { "openai": ["`api_keys.txt`里填写的KEY"] }
      + "openai-chat-completions": { "base-url": "http://[ip]:8080/v1" }
- 七、注意事项
  + 版权归xqdoo00o所有，更多信息请查看作者项目
  + 关于谷歌等第三方登录账号如何部署及其他问题请参考作者项目说明，本项目恕不解答，请谅解
