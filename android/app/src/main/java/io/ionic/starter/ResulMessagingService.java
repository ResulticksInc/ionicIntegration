package io.ionic.starter;

import android.util.Log;

import androidx.annotation.NonNull;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import io.mob.resu.reandroidsdk.ReAndroidSDK;

public class ResulMessagingService extends FirebaseMessagingService {
  @Override
  public void onMessageReceived(@NonNull RemoteMessage message) {
    super.onMessageReceived(message);
    Log.e("onMessageReceived", message.getData().toString());
    if(ReAndroidSDK.getInstance(this).onReceivedCampaign(message.getData())){
    }
  }
}
