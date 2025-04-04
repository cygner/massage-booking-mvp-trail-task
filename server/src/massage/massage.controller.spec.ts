import { Test, TestingModule } from '@nestjs/testing';
import { MassageController } from './massage.controller';
import { MassageService } from './massage.service';

describe('MassageController', () => {
  let controller: MassageController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MassageController],
      providers: [MassageService],
    }).compile();

    controller = module.get<MassageController>(MassageController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
