import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-page1',
  templateUrl: './page1.page.html',
  styleUrls: ['./page1.page.scss'],
})
export class Page1Page implements OnInit {

  constructor(private router: Router) {
    
  }
  ngOnInit() {
    this.initializeApp();

  }

  async initializeApp() {

  }
  
  navigateTo(value: string) {
    this.router.navigate([`/${value}`]);

  }

}
