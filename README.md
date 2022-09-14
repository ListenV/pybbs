## 使用方法

- 前台地址：[http://localhost:8080/](http://localhost:8080/) 用户名密码自己注册
- 后台地址：[http://localhost:8080/adminlogin](http://localhost:8080/adminlogin) 用户名: test 密码: 123123

## 技术栈

- Spring-Boot
- Shiro
- MyBatis-Plus
- Bootstrap
- MySQL
- Freemarker
- Redis
- ElasticSearch
- WebSocket
- I18N

## 运行

还是看文档吧，更详细 [传送门](https://tomoya92.github.io/pybbs/#%E5%BF%AB%E9%80%9F%E5%BC%80%E5%A7%8B)

## 手动打包

```bash
mvn clean package
```

打包完成后，会在项目根目录下的target目录里生成一个`pybbs.jar`文件，解压运行 `java -jar pybbs.jar` 即可启动论坛服务
