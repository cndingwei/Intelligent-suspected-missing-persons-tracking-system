package zhrk.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileUtil {

	public static final FileUtil instance = new FileUtil();

    public static int compareDate(Date start, Date end) {
    	 if (start.getTime() < end.getTime()) {//前
             return 1;
         } else if (start.getTime() > end.getTime()) {//后
             return -1;
         } else {
             return 0;
         }
    }
	
    // 随机一个文件名
    public String randomFileName() {
        Date dt = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyMMddHHmmss");
        String fileName = sdf.format(dt);
        return fileName;
    }

    /**
     * 修改文件名
     * @param filePath
     *            eg:D:/gai.jpg
     * @param extension 
     * @return
     */
    public String changeFileName(String filePath, String extension) {
        File file = new File(filePath);// 指定文件名及路径
        String dateName = randomFileName();
        String name = dateName + extension;
        //文件夹位置
        String path = filePath.substring(0, filePath.lastIndexOf("\\"));
        String newFilePath = path+"/"+name;
        file.renameTo(new File(newFilePath)); // 改名
        return name;
    }
    
    public String changepicName(String filePath, String extension) {
        File file = new File(filePath);// 指定文件名及路径
        String dateName = randomFileName();
        String name = dateName + extension;
        //文件夹位置
        String path = filePath.substring(0, filePath.lastIndexOf("/"));
        String newFilePath = path+"/"+name;
        file.renameTo(new File(newFilePath)); // 改名
        copyFile(newFilePath,"src/main/webapp/viewImg/reimg/" + name);
        return name;
    }

    /**
     * @param srcPath
     * @param destPath
     * 2018年8月30日 上午11:09:20
     */
	private void copyFile(String srcPath, String destPath) {
		 try {
			// 打开输入流
			FileInputStream fis = new FileInputStream(srcPath);
			// 打开输出流
			FileOutputStream fos = new FileOutputStream(destPath);
			int len = 0;
			while ((len = fis.read()) != -1) {
			    fos.write(len);
			}
			fos.close(); // 后开先关
			fis.close(); // 先开后关
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
