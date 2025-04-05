import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { BookingService } from './booking.service';
import { CreateBookingDto } from './dto/create-booking.dto';

@Controller('booking')
export class BookingController {
  constructor(private readonly bookingService: BookingService) {}

  @Post()
  create(@Body() createBookingDto: CreateBookingDto) {
    return this.bookingService.create(createBookingDto);
  }

  @Get('/user/:userId')
  findAll(@Param('userId') userId: string) {
    return this.bookingService.findBookingsByUserId(+userId);
  }
}
