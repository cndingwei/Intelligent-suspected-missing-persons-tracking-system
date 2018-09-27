package zhrk.utils.waston;

import java.io.File;

import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.MatOfRect;
import org.opencv.core.Point;
import org.opencv.core.Rect;
import org.opencv.core.Scalar;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.videoio.VideoCapture;
import com.googlecode.javacv.cpp.opencv_highgui;
import com.jfinal.kit.Ret;
public class VideoToImgUtils {

	static{
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
	}
	
	public static void main(String[] args) {
		VideoToImgUtils.getImages("e://10010.mp4");
	}

	public static Ret getImages(String path) {
		// 读取视频文件
		VideoCapture cap = new VideoCapture(path);
		// 判断视频是否打开
		if (cap.isOpened()) {
			// 总帧数
			double frameCount = cap.get(opencv_highgui.CV_CAP_PROP_FRAME_COUNT);
			// 帧率
			double fps = cap.get(opencv_highgui.CV_CAP_PROP_FPS);
			// 时间长度
			double len = frameCount / fps;
			Double d_s = new Double(len);
			Mat frame = new Mat();
			Integer count = 0;
			deleteDir("src/main/webapp/viewImg/img");
			for (int i = 0; i < d_s.intValue(); i++) {
				// 设置视频的位置(单位:毫秒)
				cap.set(opencv_highgui.CV_CAP_PROP_POS_MSEC, i * 3000);
				// 读取下一帧画面
				if (cap.read(frame)) {
					count ++;
					// 保存画面到本地目录
					String fileName = "src/main/webapp/viewImg/img/" + i + ".jpg";
					Imgcodecs.imwrite(fileName, frame);
					Mat image = Imgcodecs.imread(new File(fileName).getAbsolutePath());
					//初始化人脸识别类
				    MatOfRect faceDetections = new MatOfRect();
				    //添加识别模型
				    String xmlPath = VideoToImgUtils.class.getClassLoader().getResource("haarcascade_frontalface_alt.xml").getPath().substring(1);
				    CascadeClassifier faceDetector = new CascadeClassifier(xmlPath);
				    //识别脸
				    faceDetector.detectMultiScale(image, faceDetections);
				    if(faceDetections.toArray().length == 0) {
				    	File file = new File(fileName);
				    	file.delete();
				    }else {
				    	// 画出脸的位置
					    for (Rect rect : faceDetections.toArray()) {
					    	Imgproc.rectangle(image,new Point(rect.x, rect.y), new Point(rect.x + rect.width, rect.y + rect.height), new Scalar(0, 0, 255), 2);
					    }
					    Imgcodecs.imwrite(fileName, image);
				    }
				}
			}
			// 关闭视频文件
			cap.release();
			return Ret.ok("msg", count);
		}else {
			return Ret.fail("msg", "视频未读取到");
		}
	}
	
	/**
	 * 清空文件夹中的内容
	 * @param path
	 * @return
	 * 2018年8月17日 上午10:46:05
	 */
	public static boolean deleteDir(String path){
		File file = new File(path);
		if(!file.exists()){//判断是否待删除目录是否存在
			System.err.println("The dir are not exists!");
			return false;
		}
		
		String[] content = file.list();//取得当前目录下所有文件和文件夹
		for(String name : content){
			File temp = new File(path, name);
			if(temp.isDirectory()){//判断是否是目录
				deleteDir(temp.getAbsolutePath());//递归调用，删除目录里的内容
			}else{
				if(!temp.delete()){//直接删除文件
					System.err.println("Failed to delete " + name);
				}
			}
		}
		return true;
	}
}
