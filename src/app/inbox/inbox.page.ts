import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

declare var ReCordovaPlugin: any;

@Component({
  selector: 'app-inbox',
  templateUrl: './inbox.page.html',
  styleUrls: ['./inbox.page.scss'],
})
export class InboxPage implements OnInit {
  notificationList: any[] = []; // Add this line to declare the property

  constructor(private router: Router) {
    
  }
  ngOnInit() {
    this.getReNotification();
    var userJourney = {
      screenName: window.location.href,
    };
    ReCordovaPlugin.screenNavigation(userJourney);
  }

  getReNotification() {
    ReCordovaPlugin.getNotification("notifications", (value: string) => {
      const jsonObject = JSON.parse(value);
      this.notificationList = Object.values(jsonObject);
      this.initializeApp();
    });
  }

  initializeApp() {
    // Additional initialization logic, if needed
  }

  readNotification(index: number) {
    // Handle logic for marking notification as read based on index
    // For example, you can update the notificationList or perform any other action
    let id = this.notificationList[index].id;
    var param = {
      notificationId: id,
    };
    ReCordovaPlugin.readNotification(param, () => {
      console.log("Read notification: " + id);
    });
    console.log("Read notification at index", index);
  }

  markUnread(index: number) {
    // Handle logic for marking notification as unread based on index
    // For example, you can update the notificationList or perform any other action
    let id = this.notificationList[index].id;
    var param = {
      notificationId: id,
    };
    ReCordovaPlugin.unReadNotification(param, () => {
      console.log("Unread notification: " + id);
    });
    console.log("Mark as unread notification at index", index);
  }

  deleteNotification(index: number) {
    // Handle logic for deleting notification based on index
    // For example, you can update the notificationList or perform any other action
    this.notificationList.splice(index, 1);
    let campId = this.notificationList[index].id;
    console.log(campId);
    var deleteObject = {
      campaignId: campId,
    };
    ReCordovaPlugin.deleteNotificationByCampaignId(deleteObject);
    console.log("Delete notification at index", index);
  }
  navigateTo(value: string) {
    this.router.navigate([`/${value}`]);

  }

}
