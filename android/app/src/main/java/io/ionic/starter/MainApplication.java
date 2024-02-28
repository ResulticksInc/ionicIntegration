package io.ionic.starter;

import android.app.Application;

import com.google.firebase.FirebaseApp;

import io.mob.resu.reandroidsdk.AppConstants;
import io.mob.resu.reandroidsdk.ReAndroidSDK;

public class MainApplication extends Application {
  public void onCreate() {
    super.onCreate();
    FirebaseApp.initializeApp(this);
    AppConstants.LogFlag = true;
    ReAndroidSDK.getInstance(this);
  }
}
