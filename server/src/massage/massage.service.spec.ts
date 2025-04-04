import { Test, TestingModule } from '@nestjs/testing';
import { MassageService } from './massage.service';

describe('MassageService', () => {
  let service: MassageService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [MassageService],
    }).compile();

    service = module.get<MassageService>(MassageService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
