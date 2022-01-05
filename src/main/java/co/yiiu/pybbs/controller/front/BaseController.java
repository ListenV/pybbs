package co.yiiu.pybbs.controller.front;

import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.ISystemConfigService;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Objects;

// 基础Controller，增强一些方法
public class BaseController {

    @Resource
    private ISystemConfigService systemConfigService;

    // 方便重定向
    protected String redirect(String path) {
        return "redirect:" + path;
    }

    // 获取用户Session
    protected User getUser() {
        HttpServletRequest request = ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder
                .getRequestAttributes())).getRequest();
        HttpSession session = request.getSession();
        return (User) session.getAttribute("_user");
    }

    // 只针对前台页面的模板路径渲染，后台不变
    protected String render(String path) {
//        return String.format("theme/%s/%s", systemConfigService.selectAllConfig().get("theme").toString(), path);
        return String.format("front/%s", path);
    }

}
