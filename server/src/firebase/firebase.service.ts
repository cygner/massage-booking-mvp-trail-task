import { Injectable, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as admin from 'firebase-admin';

interface NotificationPayload {
  title: string;
  body: string;
  data?: Record<string, string>;
}

@Injectable()
export class FirebaseService implements OnModuleInit {
  constructor(private configService: ConfigService) {}

  onModuleInit() {
    const serviceAccount = this.configService.get(
      'FIREBASE_SERVICE_ACCOUNT',
    ) as string;

    admin.initializeApp({
      credential: admin.credential.cert(
        JSON.parse(serviceAccount) as admin.ServiceAccount,
      ),
    });
  }

  async sendNotification(token: string, payload: NotificationPayload) {
    try {
      const message = {
        notification: {
          title: payload.title,
          body: payload.body,
        },
        data: payload.data || {},
        token,
      };

      const response = await admin.messaging().send(message);
      return { success: true, response };
    } catch (error) {
      console.log('Error sending notification:', error);
      return { success: false };
    }
  }
}
