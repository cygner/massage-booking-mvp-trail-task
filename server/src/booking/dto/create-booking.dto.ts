/* eslint-disable @typescript-eslint/no-unsafe-call */
import { IsEmail, IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateBookingDto {
  @IsNotEmpty()
  @IsNumber()
  massage_id: number;

  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @IsString()
  booking_time: string;
}
