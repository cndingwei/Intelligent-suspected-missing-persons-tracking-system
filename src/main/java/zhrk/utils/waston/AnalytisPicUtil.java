package zhrk.utils.waston;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ibm.watson.developer_cloud.service.security.IamOptions;
import com.ibm.watson.developer_cloud.visual_recognition.v3.VisualRecognition;
import com.ibm.watson.developer_cloud.visual_recognition.v3.model.ClassifiedImages;
import com.ibm.watson.developer_cloud.visual_recognition.v3.model.Classifier;
import com.ibm.watson.developer_cloud.visual_recognition.v3.model.ClassifyOptions;
import com.ibm.watson.developer_cloud.visual_recognition.v3.model.DeleteClassifierOptions;
import com.ibm.watson.developer_cloud.visual_recognition.v3.model.DetectFacesOptions;
import com.ibm.watson.developer_cloud.visual_recognition.v3.model.DetectedFaces;
import com.ibm.watson.developer_cloud.visual_recognition.v3.model.UpdateClassifierOptions;

public class AnalytisPicUtil {

	public static void main(String[] args) {
		/*List<ClassScorePo> list = getClassScore("E:/model/1.jpg");
		if(list.size() > 0) {
			for(ClassScorePo spo :list) {
				System.out.println("获取结果：" + spo.getClassName() + "+++" + spo.getScore());
			}
		}*/
		//upModel("黄蓉", "E:/model/黄蓉.zip");
		//human_1067421620
		System.out.println(faceAnalytis("E:/model/3.JPG"));
	}
	/**
	 * 图片根据model进行分析，上传的可以是zip压缩文件，也可以是图片路径。
	 * @param path
	 * @return
	 * 2018年8月23日 下午3:34:37
	 */
	public static List<ClassScorePo> getClassScore(String path) {
		VisualRecognition service = new VisualRecognition("2018-03-19");
		service.setEndPoint("https://gateway.watsonplatform.net/visual-recognition/api");

		IamOptions options = new IamOptions.Builder().apiKey("E_KL9V22pwMAeVgbETwIaZxU3q7lZnfqDBjpUGTOISSZ").build();
		service.setIamCredentials(options);

		List<ClassScorePo> claList = new ArrayList<>();
		try {
			InputStream imagesStream = new FileInputStream(new File(path));
			ClassifyOptions classifyOptions = new ClassifyOptions.Builder()
				.imagesFile(imagesStream)
				.imagesFilename("human")
				.threshold((float) 0.3)
				.classifierIds(Arrays.asList("human_1934342452"))
				.build();
			ClassifiedImages result = service.classify(classifyOptions).execute();
			JSONObject jsonObject = new JSONObject(result);
			JSONArray ja = jsonObject.getJSONArray("images");
			
			if(ja.length() > 0) {
				DecimalFormat df = new DecimalFormat("0.000");
				for(int i = 0;i<ja.length();i++) {
					JSONObject jo = ja.getJSONObject(i);	
					JSONArray cla = jo.getJSONArray("classifiers").getJSONObject(0).getJSONArray("classes");
					if(cla.length() > 0) {
						JSONObject clajson = cla.getJSONObject(0);
						ClassScorePo spo = new ClassScorePo();
						spo.setClassName(clajson.getString("className"));
						spo.setScore(df.format(clajson.getDouble("score")));
						claList.add(spo);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return claList;
	}
	
	/**
	 * 根据上传的model名称，删除model
	 * @param modelName
	 * 2018年8月23日 下午3:40:08
	 */
	public static void deleteModel(String modelName) {
		IamOptions options = new IamOptions.Builder().apiKey("E_KL9V22pwMAeVgbETwIaZxU3q7lZnfqDBjpUGTOISSZ").build();
		VisualRecognition service = new VisualRecognition("2018-03-19", options);
		DeleteClassifierOptions deleteClassifierOptions = new DeleteClassifierOptions.Builder(modelName).build();
		service.deleteClassifier(deleteClassifierOptions).execute();
	}
	
	/**
	 * 更新model
	 * @param modelName
	 * @param path
	 * 2018年8月23日 下午4:39:05
	 */
	public static void upModel(String modelName,String path) {
		IamOptions options = new IamOptions.Builder().apiKey("E_KL9V22pwMAeVgbETwIaZxU3q7lZnfqDBjpUGTOISSZ").build();

		VisualRecognition service = new VisualRecognition("2018-03-19", options);
		String classifierId = "human_1934342452";

		try {
			InputStream negativeExamples = new FileInputStream("E:/model/崔健.zip");
			UpdateClassifierOptions updateClassifierOptions = new UpdateClassifierOptions.Builder()
					.classifierId(classifierId).addClass(modelName, new File(path))
					.negativeExamples(negativeExamples).negativeExamplesFilename("崔健.zip").build();

			service.updateClassifier(updateClassifierOptions).execute();
			Classifier updatedDogs = service.updateClassifier(updateClassifierOptions).execute();
			System.out.println(updatedDogs);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 初步实现对照片中性别，年龄段的分析
	 */
	public static boolean faceAnalytis(String picPath) {
		IamOptions options = new IamOptions.Builder().apiKey("E_KL9V22pwMAeVgbETwIaZxU3q7lZnfqDBjpUGTOISSZ").build();
		VisualRecognition service = new VisualRecognition("2018-03-19", options);
		try {
			DetectFacesOptions detectFacesOptions = new DetectFacesOptions.Builder()
			  .imagesFile(new File(picPath))
			  .build();
			DetectedFaces result = service.detectFaces(detectFacesOptions).execute();
			JSONObject jsonObject = new JSONObject(result);
			JSONArray faces = jsonObject.getJSONArray("images").getJSONObject(0).getJSONArray("faces");
			if(faces.length() > 0 ) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
