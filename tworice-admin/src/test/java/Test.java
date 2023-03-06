

import com.alibaba.fastjson.JSON;

import java.io.File;
import java.util.Arrays;

public class Test {

    public static void main(String[] args) {
        Integer a = new Integer(1);
        Integer[] arr = new Integer[]{a};
        Object[] arrr = new Object[]{arr};
        System.out.println(JSON.toJSONString(arrr));
    }

}
