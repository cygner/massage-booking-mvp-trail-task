/* eslint-disable @typescript-eslint/no-unsafe-call */
import { Exclude, Expose } from 'class-transformer';
import { IsEmail, IsString } from 'class-validator';

// @Exclude()
export class UserResponseDto {
  @Expose()
  @IsString()
  name: string;

  @Expose()
  @IsEmail()
  email: string;

  @Expose()
  firebase_token: string;

  @Expose()
  created_at: Date;

  @Expose()
  updated_at: Date;
}
