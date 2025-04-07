import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { BookingModule } from './booking/booking.module';
import { MassageModule } from './massage/massage.module';
import { User } from './auth/entities/user.entity';
import { Massage } from './massage/entities/massage.entity';
import { Booking } from './booking/entities/booking.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { FirebaseModule } from './firebase/firebase.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    TypeOrmModule.forRoot({
      type: 'sqlite',
      database: './database/booking_app.sqlite',
      entities: [User, Massage, Booking],
      synchronize: true,
    }),
    AuthModule,
    BookingModule,
    MassageModule,
    FirebaseModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
