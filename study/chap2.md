# 챕터2
## 매핑과 주소
- 주소
1. 이더리움 블록체인은 은행 계좌와 같은 계정들로 이루어져 있지. 계정은 이더리움 블록체인상의 통화인 _이더_의 잔액을 가지지. 자네의 은행 계좌에서 다른 계좌로 돈을 송금할 수 있듯이, 계정을 통해 다른 계정과 이더를 주고 받을 수 있지.

- 매핑 : 매핑은 기본적으로 키-값 (key-value) 저장소로, 데이터를 저장하고 검색하는 데 이용된다
```solidity
// 금융 앱용으로, 유저의 계좌 잔액을 보유하는 uint를 저장한다: 
mapping (address => uint) public accountBalance;
// 혹은 userID로 유저 이름을 저장/검색하는 데 매핑을 쓸 수도 있다 
mapping (uint => string) userIdToName;
```

## Msg.sender
- 현재 함수를 호출한 사람 (혹은 스마트 컨트랙트)의 주소를 가리키는 msg.sender(전역변수)
- 솔리디티에서 함수 실행은 항상 외부 호출자가 시작하네. 컨트랙트는 누군가가 컨트랙트의 함수를 호출할 때까지 블록체인 상에서 아무 것도 안 하고 있을 것이네. 그러니 항상 msg.sender가 있어야 하네.
- msg.sender를 활용하면 자네는 이더리움 블록체인의 보안성을 이용할 수 있게 되지. 즉, 누군가 다른 사람의 데이터를 변경하려면 해당 이더리움 주소와 관련된 개인키를 훔치는 것 밖에는 다른 방법이 없다는 것이네.
```solidity
mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public {
  // `msg.sender`에 대해 `_myNumber`가 저장되도록 `favoriteNumber` 매핑을 업데이트한다 `
  favoriteNumber[msg.sender] = _myNumber;
  // ^ 데이터를 저장하는 구문은 배열로 데이터를 저장할 떄와 동일하다 
}

function whatIsMyNumber() public view returns (uint) {
  // sender의 주소에 저장된 값을 불러온다 
  // sender가 `setMyNumber`을 아직 호출하지 않았다면 반환값은 `0`이 될 것이다
  return favoriteNumber[msg.sender];
}

```
## Require
레슨 1에서 유저가 createRandomZombie를 호출하여 좀비 이름을 입력하면 새로운 좀비를 생성할 수 있도록 했네. 하지만, 만일 유저가 이 함수를 계속 호출해서 무제한으로 좀비를 생성한다면 게임이 매우 재미있지는 않을 걸세.

각 플레이어가 이 함수를 한 번만 호출할 수 있도록 만들어 보세. 이로써 새로운 플레이어들이 게임을 처음 시작할 때 좀비 군대를 구성할 첫 좀비를 생성하기 위해 createRandomZombie함수를 호출하게 될 것이네.

어떻게 하면 이 함수가 각 플레이어마다 한 번씩만 호출되도록 할 수 있을까?

이를 위해 require를 활용할 것이네. require를 활용하면 특정 조건이 참이 아닐 때 함수가 에러 메시지를 발생하고 실행을 멈추게 되지:
```solidity
function sayHiToVitalik(string _name) public returns (string) {
  // _name이 "Vitalik"인지 비교한다. 참이 아닐 경우 에러 메시지를 발생하고 함수를 벗어난다
  // (참고: 솔리디티는 고유의 스트링 비교 기능을 가지고 있지 않기 때문에 
  // 스트링의 keccak256 해시값을 비교하여 스트링 값이 같은지 판단한다)
  require(keccak256(_name) == keccak256("Vitalik"));
  // 참이면 함수 실행을 진행한다:
  return "Hi!";
}
```

## 상속
```solidity
contract Doge {
  function catchphrase() public returns (string) {
    return "So Wow CryptoDoge";
  }
}

contract BabyDoge is Doge {
  function anotherCatchphrase() public returns (string) {
    return "Such Moon BabyDoge";
  }
}
```
## Import
## Storage vs Memory
## 좀비 DNA
##  함수 접근 제어자 더 알아보기
## 좀비가 무엇을 먹나요?
## 인터페이스 
