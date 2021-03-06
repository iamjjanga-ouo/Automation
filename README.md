# Automation

## AWS Automation
</br>

### ec2_cook.sh

매번 AWS Console에서 test instance를 stop <-> running을 하는것이 반복되어서 간단한 명령어로 사용할 수 있도록 script화 하였습니다.  
</br>

처음 실행했을 때
![first execution](https://i.imgur.com/K7e49Mw.png)

EC2 instance list 조회
![show ec2 instance list](https://i.imgur.com/Y4bXfxd.png)
- table형식으로 Availability zone, Instance id, tag, State를 출력합니다.

EC2 stopped -> running
![ec2 run](https://i.imgur.com/Yjyvzen.png)
- `Name` tag를 이용하여 instance를 running 상태로 변경합니다.

EC2 running -> stopped
![ec2 stop](https://i.imgur.com/DJZe2Fu.png)
- stopped 상태로 전환하기 위해서는 `instance-id`를 입력해 특정 instance만 정지할 수 있도록 합니다.  
</br>


**TO DO**  
필요에 의해 생각나면 추가
- [] : 