import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'io.ionic.starter',
  appName: 'IonicIntegration',
  webDir: 'www',
  server: {
    androidScheme: 'https',
    iosScheme: 'http://192.168.0.105:8100'

  },
  plugins: {
    PushNotifications: {
      presentationOptions: ["badge", "sound", "alert"],
    },
  },
};

export default config;
