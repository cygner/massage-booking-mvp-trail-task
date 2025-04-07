import {
  HttpException,
  HttpStatus,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateBookingDto } from './dto/create-booking.dto';
import { Booking } from './entities/booking.entity';
import { DeepPartial, Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/entities/user.entity';
import { Massage } from 'src/massage/entities/massage.entity';
import { FirebaseService } from 'src/firebase/firebase.service';

@Injectable()
export class BookingService {
  constructor(
    private firebaseService: FirebaseService,

    @InjectRepository(User)
    private usersRepository: Repository<User>,

    @InjectRepository(Booking)
    private bookingRepository: Repository<Booking>,

    @InjectRepository(Massage)
    private massageRepository: Repository<Massage>,
  ) {}

  async create(
    createBookingDto: CreateBookingDto,
  ): Promise<{ booking_ref_id: number }> {
    const { booking_time, email, massage_id } = createBookingDto;

    const user = await this.usersRepository.findOne({
      where: { email },
    });

    const massage = await this.massageRepository.findOne({
      where: { id: parseInt(massage_id) },
    });

    if (!user) {
      throw new NotFoundException('User with this email not found');
    }

    if (!massage) {
      throw new NotFoundException('Selected massage not found');
    }

    try {
      const bookingObject = this.bookingRepository.create({
        booking_time,
        user_id: user.id,
        massage_id: massage_id,
      } as DeepPartial<Booking>);

      const booking = await this.bookingRepository.save(bookingObject);

      await this.firebaseService.sendNotification(user.firebase_token, {
        title: 'Your booking has confirmed!',
        body: `You booking ref id is #${booking.id}`,
      });

      return { booking_ref_id: booking.id };
    } catch (error) {
      throw new HttpException(
        {
          status: HttpStatus.INTERNAL_SERVER_ERROR,
          error: 'Internal server error',
        },
        HttpStatus.INTERNAL_SERVER_ERROR,
        {
          cause: error,
        },
      );
    }
  }

  async findBookingsByUserId(id: number): Promise<{ bookings: Booking[] }> {
    const user = await this.usersRepository.findOne({ where: { id } });

    if (!user) {
      throw new NotFoundException('User not found');
    }

    try {
      const bookings = await this.bookingRepository.find({
        where: { user_id: { id } },
        relations: { user_id: true, massage_id: true },
        select: {
          user_id: {
            password: false,
          },
        },
      });

      return { bookings };
    } catch (error) {
      throw new HttpException(
        {
          status: HttpStatus.INTERNAL_SERVER_ERROR,
          error: 'Internal server error',
        },
        HttpStatus.INTERNAL_SERVER_ERROR,
        {
          cause: error,
        },
      );
    }
  }
}
