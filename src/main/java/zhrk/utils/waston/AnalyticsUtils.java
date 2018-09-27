package zhrk.utils.waston;
import java.io.File;
import java.io.FileNotFoundException;
import org.opencv.core.Core;
import org.opencv.videoio.VideoCapture;
import com.ibm.watson.developer_cloud.service.security.IamOptions;
import com.ibm.watson.developer_cloud.visual_recognition.v3.*;
import com.ibm.watson.developer_cloud.visual_recognition.v3.model.*;

public class AnalyticsUtils {

	/*
	 * Necessary instruction to use opencv
	 */
	static { 
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
	}

	public static void main(String[] args) {
		VisualRecognition service = new VisualRecognition("2018-03-19");
		IamOptions iamOptions = new IamOptions.Builder().apiKey("iFFfV0B-y7_OGB8kBIx7gmBaAXc3wjDpQdHuXCKvVEm6").build();
		service.setIamCredentials(iamOptions);
		File image = new File("10023.jpg");
		VideoCapture video = new VideoCapture("e://10010.mp4");
		System.out.println(video.isOpened());
		try {
			DetectFacesOptions detectFacesOptions = new DetectFacesOptions.Builder().imagesFile(image).build();
			DetectedFaces result = service.detectFaces(detectFacesOptions).execute();
			System.out.println(result);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
}