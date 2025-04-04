import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from './auth.service';
import { UserRegisterDto } from './dto/user-regiser.dto';
import { UserLoginDto } from './dto/user-login-dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  register(@Body() userRegisterDto: UserRegisterDto) {
    return this.authService.register(userRegisterDto);
  }

  @Post('login')
  create(@Body() userLoginDto: UserLoginDto) {
    return this.authService.login(userLoginDto);
  }
}
