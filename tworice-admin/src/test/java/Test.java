

import com.alibaba.fastjson.JSON;

import java.io.File;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Test {

    public static void main(String[] args) {
        try {
            Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
            while (interfaces.hasMoreElements()) {
                NetworkInterface networkInterface = interfaces.nextElement();

                // 确保网络接口是无线网络接口（WLAN）
                if (networkInterface.isUp() && networkInterface.supportsMulticast() && !networkInterface.isLoopback()) {
                    byte[] macAddressBytes = networkInterface.getHardwareAddress();

                    if (macAddressBytes != null) {
                        StringBuilder macAddress = new StringBuilder();
                        for (int i = 0; i < macAddressBytes.length; i++) {
                            macAddress.append(String.format("%02X", macAddressBytes[i]));
                            if (i < macAddressBytes.length - 1) {
                                macAddress.append("-");
                            }
                        }
                        System.out.println("WLAN的MAC地址: " + macAddress.toString());
                    } else {
                        System.out.println("无法获取WLAN的MAC地址。");
                    }

                    // 一般情况下，一台计算机可能有多个网络适配器，我们只需要获取第一个WLAN的MAC地址即可
                    break;
                }
            }
        } catch (SocketException e) {
            e.printStackTrace();
        }
    }


}
