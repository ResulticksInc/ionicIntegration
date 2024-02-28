import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { IonHeader, IonToolbar, IonTitle, IonContent } from '@ionic/angular';
import { PushNotifications, PermissionStatus, Token, PushNotificationSchema, ActionPerformed } from '@capacitor/push-notifications';

declare var ReCordovaPlugin: any;

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})

export class HomePage implements OnInit {

  fcmToken = "";

  constructor(private router: Router) {
    
   }

  ngOnInit() {
    this.initializeApp();
  }

  async initializeApp() {
    var userJourney = {
      screenName: window.location.href,
    };
    ReCordovaPlugin.screenNavigation(userJourney);
  }

  

  

  appConversionTracking(): void {
    var appConversionData = {
      data: {
        name: "logesh",
        age: "22",
        mail: "logeshwarlogs05@gmail.com",
      },
    };
    ReCordovaPlugin.appConversionTracking(appConversionData);
    ReCordovaPlugin.appConversionTracking();
  
  }
  

  locationUpdate() {

    var location = {
      latitude: 13.067439,
      longitude: 80.237617,
    };
    ReCordovaPlugin.locationUpdate(location);

  }

  onTrackEvent() {
   var resEvent2 = {
      eventName: 'Product Purchased',
      data: {
        productId: 'P234234',
        productName: 'Mobile Phone'
      }
    }
    ReCordovaPlugin.customEvent(resEvent2);
  
  }

  navigateTo(value: string) {
    this.router.navigate([`/${value}`]);
  
  }
}

