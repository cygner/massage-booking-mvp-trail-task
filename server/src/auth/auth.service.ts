import {
  ConflictException,
  HttpException,
  HttpStatus,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { UserRegisterDto } from './dto/user-regiser.dto';
import { UserLoginDto } from './dto/user-login-dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { Repository } from 'typeorm';
import { UserResponseDto } from './dto/user-response.dto';
import { plainToInstance } from 'class-transformer';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {}

  async register(registerDto: UserRegisterDto): Promise<UserResponseDto> {
    const { email } = registerDto;

    const userExists = await this.usersRepository.findOne({
      where: { email },
    });

    if (userExists) {
      throw new ConflictException('Email already exists');
    }

    try {
      const user = this.usersRepository.create(registerDto);
      const savedUser = await this.usersRepository.save(user);

      return plainToInstance(UserResponseDto, savedUser, {
        excludeExtraneousValues: true,
        enableImplicitConversion: true,
      });
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

  async login(loginDto: UserLoginDto): Promise<UserResponseDto> {
    const { email, password, firebase_token } = loginDto;

    const user = await this.usersRepository.findOne({ where: { email } });
    if (!user) {
      throw new UnauthorizedException('User not found');
    }

    const isPasswordValid = user.comparePassword(password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    if (firebase_token) {
      user.firebase_token = firebase_token;
      const updatedUser = await this.usersRepository.save(user);

      return plainToInstance(UserResponseDto, updatedUser, {
        excludeExtraneousValues: true,
        enableImplicitConversion: true,
      });
    }

    return plainToInstance(UserResponseDto, user, {
      excludeExtraneousValues: true,
      enableImplicitConversion: true,
    });
  }
}
