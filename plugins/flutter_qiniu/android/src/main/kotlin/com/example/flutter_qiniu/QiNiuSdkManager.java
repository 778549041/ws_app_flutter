package com.example.flutter_qiniu;

import android.util.Log;

import com.qiniu.android.http.ResponseInfo;
import com.qiniu.android.storage.Configuration;
import com.qiniu.android.storage.UpCompletionHandler;
import com.qiniu.android.storage.UpProgressHandler;
import com.qiniu.android.storage.UploadManager;
import com.qiniu.android.storage.UploadOptions;

import org.json.JSONObject;

/**
 * @author karma
 * @date 2020/7/24
 */
public class QiNiuSdkManager {
    private static final String TAG = "QiNiuSdkManager";
    private static volatile QiNiuSdkManager mIstance;
    private UploadManager uploadManager;

    public static QiNiuSdkManager getInstance() {
        if (mIstance == null) {
            synchronized (QiNiuSdkManager.class) {
                if (mIstance == null) {
                    mIstance = new QiNiuSdkManager();
                }
            }
        }
        return mIstance;
    }

    public void initConfig() {
        if (uploadManager == null) {
            //config配置上传参数
            Configuration configuration = new Configuration.Builder()
                    .connectTimeout(10)
                    .responseTimeout(60).build();
            uploadManager = new UploadManager(configuration, 3);
        }
    }

    public void upLoadImage(String filePath, String key, String token, final UploadInterface uploadInterface) {
        Log.d(TAG, "upLoadImage: filePath=" + filePath + "\r\n key=" + key + "\r\n token=" + token);
        if (uploadManager != null) {
            uploadManager.put(filePath, null, token, new UpCompletionHandler() {
                @Override
                public void complete(String key, ResponseInfo info, JSONObject response) {
                    if (info.isOK()) {
                        Log.d(TAG, "upload success" + response.toString());
                        if (uploadInterface != null) {
                            uploadInterface.uploadComplete(key, info, response);
                        }
                    } else {
                        Log.d(TAG, "upload fail");
                        if (uploadInterface != null) {
                            uploadInterface.uploadFail(key, info, response);
                        }
                    }
                    Log.d(TAG, key + ",\r\n " + info + ",\r\n " + response);
                }
            }, new UploadOptions(null, null, false, new UpProgressHandler() {
                @Override
                public void progress(String key, double percent) {
                    Log.d(TAG, "progress: " + key + ": " + percent);
                    if (uploadInterface != null) {
                        uploadInterface.uploadProgress(key, percent);
                    }
                }
            }, null));
        }
    }

    public interface UploadInterface {
        void uploadComplete(String key, ResponseInfo info, JSONObject response);

        void uploadFail(String key, ResponseInfo info, JSONObject response);

        void uploadProgress(String key, double percent);
    }
}
