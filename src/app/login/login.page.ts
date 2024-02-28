import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { PushNotifications, PermissionStatus, Token, PushNotificationSchema, ActionPerformed } from '@capacitor/push-notifications';

declare var ReCordovaPlugin: any;


@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit{
  loginForm = {
    email: '',
    password: '',
  };

  fcmToken = "";

  constructor(private router: Router) {}

  ngOnInit() {
    this.initializeApp();
  }

  async initializeApp() {
    // Request push notification permissions

    PushNotifications.requestPermissions().then((permission: PermissionStatus) => {
      if (permission.receive === 'granted') {

        PushNotifications.register().then();

      } else {

      }
    });

    PushNotifications.addListener('registration', async (token: Token) => {
      console.log('FCM token: ' + token.value);

      this.fcmToken = token.value;
      localStorage.setItem("token", token.value);

      var deviceToken = {
        token: token.value,
      };
    
      ReCordovaPlugin.updatePushToken(deviceToken);
    });

    PushNotifications.addListener('pushNotificationReceived',
      (notification: PushNotificationSchema) => {
        console.log('Push received: ' + JSON.stringify(notification.data));

        // ReCordovaPlugin.setCustomNotification(JSON.stringify(notification.data));


      }
    );

    PushNotifications.addListener('pushNotificationActionPerformed',
      (notification: ActionPerformed) => {

        console.log('Push action' + JSON.stringify(notification.notification));

        // ReCordovaPlugin.setNotificationAction(JSON.stringify(notification.notification));
      }
    );

    var userJourney = {
      screenName: window.location.href,
    };
    ReCordovaPlugin.screenNavigation(userJourney);

  }

  async updatePushToken() {
    ReCordovaPlugin.updatePushToken(this.fcmToken);

  }
  login() {
      var resUser = {
        uniqueId: "logesh@gmail.com",
        name: "Logeshwar M",
        age: "23",
        email: "logesh@gmail.com ",
        phone: "",
        gender: "",
        token: this.fcmToken,
        profileUrl: '',
        dob: "",
        education: "",
        employed: true,
        married: true
      }
      ReCordovaPlugin.userRegister(resUser);
      this.router.navigate(['/home']); // 'home' should be replaced with the actual path of your homepage
    }
    // Your login logic goes here

    // Afer successful login, navigate to the homepage
  
}