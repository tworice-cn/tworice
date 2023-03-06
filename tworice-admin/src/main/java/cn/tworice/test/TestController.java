package cn.tworice.test;

import cn.tworice.common.po.Admin;
import cn.tworice.common.vo.RequestResult;
import cn.tworice.system.service.AdminService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("test")
@CrossOrigin
public class TestController {
    @Resource
    private AdminService adminService;

    @GetMapping("")
    public RequestResult get() {
        List<Admin> adminList = adminService.getAdminList(0, 10, new Admin());
        return RequestResult.success().appendData("list", adminList);
    }
}