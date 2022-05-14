# 챕터3

## 컨트렉트의 불변성

- 컨트랙트를 배포하고 나면, 컨트랙트는 변하지 않는다(Immutable). 다시 말하자면 컨트랙트를 수정하거나 업데이트할 수 없다는 것.
- 컨트랙트로 배포한 최초의 코드는 항상, 블록체인에 영구적으로 존재.솔리디티에 있어서 보안이 굉장히 큰 이슈인 이유. 컨트랙트 코드에 결점이 있다면,이후에 고칠 수 있는 방법이 전혀 없다.
- 외부 의존성
## 소유 가능한 컨트렉트
- 예시
```solidity
/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}
```
- 생성자(Constructor): function Ownable()는 생성자이네. 컨트랙트와 동일한 이름을 가진,생략할 수 있는 특별한 함수. 이 함수는 컨트랙트가 생성될 때 딱 한 번만 실행.
- 함수 제어자(Function Modifier): modifier onlyOwner(). 제어자는 다른 함수들에 대한 접근을 제어하기 위해 사용되는 일종의 유사 함수. 보통 함수 실행 전의 요구사항 충족 여부를 확인하는 데에 사용. onlyOwner의 경우에는 접근을 제한해서 오직 컨트랙트의 소유자만 해당 함수를 실행할 수 있도록 하기 위해 사용될 수 있다. 
-  Ownable 컨트랙트는 기본적으로 다음과 같은 것들을 하네:
```
- 컨트랙트가 생성되면 컨트랙트의 생성자가 owner에 msg.sender(컨트랙트를 배포한 사람)를 대입한다.
- 특정한 함수들에 대해서 오직 소유자만 접근할 수 있도록 제한 가능한 onlyOwner 제어자를 추가한다.
- 새로운 소유자에게 해당 컨트랙트의 소유권을 옮길 수 있도록 한다.
```

## OnlyOwner함수 제어자
- 함수제어자는 함수처럼 보이자만 fuction대신 modifier을사용
- 함수 정의부 끝에 해당 함수의 작동방식을 바꾸도록 제어자의 이름을 붙일수 있음
```solidity
/**
 * @dev Throws if called by any account other than the owner.
 */
modifier onlyOwner() {
  require(msg.sender == owner);
  _;
}
//다음과 같이 사용

contract MyContract is Ownable {
  event LaughManiacally(string laughter);

  // 아래 `onlyOwner`의 사용 방법
  function likeABoss() external onlyOwner {
    LaughManiacally("Muahahahaha");
  }
}
```
## Gas
- Dapp함수를 실행할떄 마다 가스 사용
- 얼마나 많은 가스를 필요하는지는  그함수의 로직이 얼마나 복잡한지에 따라 달라짐
- 함수를 실행하는 것은 사용자들에게 실제 돈을 쓰게 하기 때문에 이더리움에서 코드 최적화는 가장 중요
- 무한 반복문을 써서 네트워크를 방해하거나 자원소모가 큰 연산을 써서 네트워크 자원을 모두 사용하지 못하도록
- uint대신 uint8을 사용하는것은 가스소모를 줄이는데 아무영향없다 (uint크기에 상관없이 256비트의 저장공간을 미리 잡아 놓기 때문에)
- struct안에서는 예외 (더 작은 크기의 uint사용)
```solidity
struct NormalStruct {
  uint a;
  uint b;
  uint c;
}

struct MiniMe {
  uint32 a;
  uint32 b;
  uint c;
}

// `mini`는 구조체 압축을 했기 때문에 `normal`보다 가스를 조금 사용할 것이네.
NormalStruct normal = NormalStruct(10, 20, 30);
MiniMe mini = MiniMe(10, 20, 30); 
```
## 시간단위
- now 변수를 쓰면 현재의 유닉스 타입스탬프
- seconds, minutes, hours, days, weeks, years 단위 포함
-  1 minutes는 60, 1 hours는 3600(60초 x 60 분), 1 days는 86400(24시간 x 60분 x 60초) 같이 변환
```solidity
uint lastUpdated;

// `lastUpdated`를 `now`로 설정
function updateTimestamp() public {
  lastUpdated = now;
}

// 마지막으로 `updateTimestamp`가 호출된 뒤 5분이 지났으면 `true`를, 5분이 아직 지나지 않았으면 `false`를 반환
function fiveMinutesHavePassed() public view returns (bool) {
  return (now >= (lastUpdated + 5 minutes));
}
```
## 좀비 재사용 대기 시간
- pricate또는 internal함수에 인수로서 구조체의 srorage포인터를 전달가능
```solidity
function _doStuff(Zombie storage _zombie) internal {
  // _zombie로 할 수 있는 것들을 처리
}
```
## Public함수 보안
```solidity
```
## 함수 제어자의 또 다른 특징
- 함수제어자는 인수또한 받을수 있음
```solidity
// 사용자의 나이를 저장하기 위한 매핑
mapping (uint => uint) public age;

// 사용자가 특정 나이 이상인지 확인하는 제어자
modifier olderThan(uint _age, uint _userId) {
  require (age[_userId] >= _age);
  _;
}

// 차를 운전하기 위햐서는 16살 이상이어야 하네(적어도 미국에서는).
// `olderThan` 제어자를 인수와 함께 호출하려면 이렇게 하면 되네:
function driveCar(uint _userId) public olderThan(16, _userId) {
  // 필요한 함수 내용들
}
```
## 좀비 제어자
```solidity
// 사용자의 나이를 저장하기 위한 매핑
mapping (uint => uint) public age;

// 사용자가 특정 나이 이상인지 확인하는 제어자
modifier olderThan(uint _age, uint _userId) {
  require (age[_userId] >= _age);
  _;
}

// 차를 운전하기 위햐서는 16살 이상이어야 하네(적어도 미국에서는).
function driveCar(uint _userId) public olderThan(16, _userId) {
  // 필요한 함수 내용들
}
```
## View함수를 사용해 절약하기
- view 함수는 사용자의 의해 외부에서 호출되었을 때 가스를 전혀 소모하지 않는다
- view 함수가 블록체인 상에서 어떤 것도 수정하지 않기 때문 데이터읽기
- 가능한 external view함수를 쓰는것 (가스 사용 최적화)
## Storage는 비싸다
- solidity에서 비싼 연산중 하나인 storage를 쓰는것 그중에서도 쓰기연산
- 데이터의 일부를 쓰거나 바꿀때마다 블록체인에 영구적으로 기록되기 때문
- 비용을 최소화하기 위해 진짜 필요한 경우 아니면 storage에 데이터를 쓰지 않는 것이 좋음
- Storage보다는 memory사용해서 함수끝날때까지만 사용 (가스절약)
```solidity
function getArray() external pure returns(uint[]) {
  // 메모리에 길이 3의 새로운 배열을 생성한다.
  uint[] memory values = new uint[](3);
  // 여기에 특정한 값들을 넣는다.
  values.push(1);
  values.push(2);
  values.push(3);
  // 해당 배열을 반환한다.
  return values;
}
```
## For반복문
```solidity
function getEvens() pure external returns(uint[]) {
  uint[] memory evens = new uint[](5);
  // 새로운 배열의 인덱스를 추적하는 변수
  uint counter = 0;
  // for 반복문에서 1부터 10까지 반복함
  for (uint i = 1; i <= 10; i++) {
    // `i`가 짝수라면...
    if (i % 2 == 0) {
      // 배열에 i를 추가함
      evens[counter] = i;
      // `evens`의 다음 빈 인덱스 값으로 counter를 증가시킴
      counter++;
    }
  }
  return evens;
}
```