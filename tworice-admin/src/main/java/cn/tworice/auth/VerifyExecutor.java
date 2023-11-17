package cn.tworice.auth;

import cn.tworice.auth.service.VerifyManger;
import cn.tworice.common.util.AgingMap;
import cn.tworice.system.service.whiteList.SystemWhiteListService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * 实现VerifyManger接口，重写这些方法
 * 重写本类可实现权限验证内容
 * @author 二饭 [2022/11/6]
 **/
@Service
@Primary
public class VerifyExecutor implements VerifyManger {

    @Value("${tworice.dev:false}")
    private boolean dev;

    @Resource
    private SystemWhiteListService whiteListService;

    /**
     * 在线用户存储Map
     * <用户ID,用户Token>
     **/
    private final AgingMap<String, String> onlineMap = new AgingMap<>();

    private final Map<String, List<String>> ADMIN_RESOURCES = new HashMap<>();

    @Override
    public boolean online(String key, String token) {
        return this.onlineMap.put(key, token)!=null;
    }

    @Override
    public Map<String, String> onlineMap() {
        return this.onlineMap.getMap();
    }

    @Override
    public boolean offline(String key) {
        return this.onlineMap.remove(key) != null;
    }

    @Override
    public boolean exist(String key, String token) {
        return this.onlineMap.exist(key,token);
    }

    /**
     * TODO 未完善用户请求权限核验
     * @param key 用户Key
     * @param token 用户Token
     * @param url 用户请求的资源
     * @return boolean
     * @author 二饭 [2022/11/7]
     **/
    @Override
    public boolean auth(String key, String token, String url) {
        if(this.dev){
            return true;
        }
        if(!whiteListService.ipVerify()){
            return false;
        }

        if (this.exist(key, token)) {
//            List<String> urls = this.ADMIN_RESOURCES.get(key);
//            System.out.println("用户请求地址：" + url);
//            System.out.println("核验结果："+urls.contains(url));
            return true;
        }else{
            return false;
        }

    }

    /**
     * TODO 添加用户资源列表
     * @param adminID 用户Key
     * @param resources 用户资源列表
     * @return boolean 返回是否添加成功
     * @author 二饭 [2022/11/7]
     **/
    @Override
    public boolean addAdminResources(String adminID, String[] resources) {
        List<String> urls = Arrays.asList(resources);
        System.out.println("当前用户资源列表："+urls.toString());
        return this.ADMIN_RESOURCES.put(adminID, urls) != null;
    }
}