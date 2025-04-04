import { Module } from '@nestjs/common';
import { BookingService } from './booking.service';
import { BookingController } from './booking.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Booking } from './entities/booking.entity';
import { User } from 'src/auth/entities/user.entity';
import { Massage } from 'src/massage/entities/massage.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Booking, User, Massage])],
  controllers: [BookingController],
  providers: [BookingService],
})
export class BookingModule {}
