

import com.alibaba.fastjson.JSON;

import java.io.File;
import java.util.Arrays;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Test {

    public final static String lock = "1";


    public static void main(String[] args) {
        ExecutorService executorService = Executors.newFixedThreadPool(5);
        for (int i = 0; i < 5; i++) {
            executorService.submit(() -> {
                test();
            });
        }
    }

    public static void test() {
        System.out.println(1);
        synchronized (lock) {
            test1();
        }

        System.out.println(3);
    }

    public static void test1() {
        System.out.println(2);
        System.out.println(2);
        System.out.println(2);
        System.out.println(2);
        System.out.println(2);
        System.out.println(2);
        System.out.println(2);
    }

}
