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
- BabyDoge 컨트랙트는 Doge 컨트랙트를 상속하네. 즉, 자네가 BabyDoge 컨트랙트를 컴파일해서 구축할 때, BabyDoge 컨트랙트가 catchphrase() 함수와 anotherCatchphrase() 함수에 모두 접근할 수 있다는 뜻
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
```solidity
import "./someothercontract.sol";

contract newContract is SomeOtherContract {

}
```
## Storage vs Memory
- Storage는 블록체인 상에 영구적으로 저장되는 변수를 의미하지.
-  Memory는 임시적으로 저장되는 변수로, 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 지워지지. 두 변수는 각각 컴퓨터 하드 디스크와 RAM과 같지.
-   상태 변수(함수 외부에 선언된 변수)는 초기 설정상 storage로 선언되어 블록체인에 영구적으로 저장되는 반면, 함수 내에 선언된 변수는 memory로 자동 선언되어서 함수 호출이 종료되면 사라지지.
-   
```solidity
contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ 꽤 간단해 보이나, 솔리디티는 여기서 
    // `storage`나 `memory`를 명시적으로 선언해야 한다는 경고 메시지를 발생한다. 
    // 그러므로 `storage` 키워드를 활용하여 다음과 같이 선언해야 한다:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...이 경우, `mySandwich`는 저장된 `sandwiches[_index]`를 가리키는 포인터이다.
    // 그리고 
    mySandwich.status = "Eaten!";
    // ...이 코드는 블록체인 상에서 `sandwiches[_index]`을 영구적으로 변경한다. 

    // 단순히 복사를 하고자 한다면 `memory`를 이용하면 된다: 
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...이 경우, `anotherSandwich`는 단순히 메모리에 데이터를 복사하는 것이 된다. 
    // 그리고 
    anotherSandwich.status = "Eaten!";
    // ...이 코드는 임시 변수인 `anotherSandwich`를 변경하는 것으로 
    // `sandwiches[_index + 1]`에는 아무런 영향을 끼치지 않는다. 그러나 다음과 같이 코드를 작성할 수 있다: 
    sandwiches[_index + 1] = anotherSandwich;
    // ...이는 임시 변경한 내용을 블록체인 저장소에 저장하고자 하는 경우이다.
  }
}
```
## 좀비 DNA
```solidity
function testDnaSplicing() public {
  uint zombieDna = 2222222222222222;
  uint targetDna = 4444444444444444;
  uint newZombieDna = (zombieDna + targetDna) / 2;
  // ^ 3333333333333333이 될 것이다
}
```
##  함수 접근 제어자 더 알아보기
- internal은 함수가 정의된 컨트랙트를 상속하는 컨트랙트에서도 접근이 가능하다 점을 제외하면 private과 동일하지. **(우리한테 필요한 게 바로 internal인 것 같군
- external은 함수가 컨트랙트 바깥에서만 호출될 수 있고 컨트랙트 내의 다른 함수에 의해 호출될 수 없다는 점을 제외하면 public과 동일
```solidity
contract Sandwich {
  uint private sandwichesEaten = 0;

  function eat() internal {
    sandwichesEaten++;
  }
}

contract BLT is Sandwich {
  uint private baconSandwichesEaten = 0;

  function eatWithBacon() public returns (string) {
    baconSandwichesEaten++;
    // eat 함수가 internal로 선언되었기 때문에 여기서 호출이 가능하다 
    eat();
  }
}
```
## 좀비가 무엇을 먹나요?
- 블록체인 상에 있으면서 우리가 소유하지 않은 컨트랙트와 우리 컨트랙트가 상호작용을 하려면 우선 인터페이스를 정의해야 하네.
```solidity
contract LuckyNumber {
  mapping(address => uint) numbers;

  function setNum(uint _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint) {
    return numbers[_myAddress];
  }
}
```
약간 다르지만, 인터페이스를 정의하는 것이 컨트랙트를 정의하는 것과 유사하다는 걸 참고하게. 먼저, 다른 컨트랙트와 상호작용하고자 하는 함수만을 선언할 뿐(이 경우, getNum이 바로 그러한 함수이지) 다른 함수나 상태 변수를 언급하지 않네.

다음으로, 함수 몸체를 정의하지 않지. 중괄호 {, }를 쓰지 않고 함수 선언을 세미콜론(;)으로 간단하게 끝내지.
```solidity
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}
```
## 인터페이스 
```solidity
아래와 같이 인터페이스가 정의되면
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}

다음과 같이 컨트랙트에서 인터페이스를 이용할 수 있지:
contract MyContract {
  address NumberInterfaceAddress = 0xab38...
  // ^ 이더리움상의 FavoriteNumber 컨트랙트 주소이다
  NumberInterface numberContract = NumberInterface(NumberInterfaceAddress)
  // 이제 `numberContract`는 다른 컨트랙트를 가리키고 있다.

  function someFunction() public {
    // 이제 `numberContract`가 가리키고 있는 컨트랙트에서 `getNum` 함수를 호출할 수 있다:
    uint num = numberContract.getNum(msg.sender);
    // ...그리고 여기서 `num`으로 무언가를 할 수 있다
  }
}
```
## 다수의 반환값 처리하기
```solidity
function multipleReturns() internal returns(uint a, uint b, uint c) {
  return (1, 2, 3);
}

function processMultipleReturns() external {
  uint a;
  uint b;
  uint c;
  // 다음과 같이 다수 값을 할당한다:
  (a, b, c) = multipleReturns();
}

// 혹은 단 하나의 값에만 관심이 있을 경우: 
function getLastReturnValue() external {
  uint c;
  // 다른 필드는 빈칸으로 놓기만 하면 된다: 
  (,,c) = multipleReturns();
}
```
## 보너스: 키티 유전자
- 레슨 1에서 배운 내용을 떠올려 보면, 좀비의 외모를 결정하는 데 있어서 16자리 DNA 중에서 처음 12자리만 이용되지. 그러니 마지막에서 2자리 숫자를 활용하여 "특별한" 특성을 만들어 보세.

고양이 좀비는 DNA 마지막 2자리로 99를 갖는다고 해 보세 (고양이는 9개의 목숨을 가졌다고 할 만큼 생명력이 강하므로). 그러면 우리 코드에서는 만약(if) 좀비가 고양이에서 생성되면 좀비 DNA의 마지막 2자리를 99로 설정한다.
```solidity
function eatBLT(string sandwich) public {
  // 스트링 간의 동일 여부를 판단하기 위해 keccak256 해시 함수를 이용해야 한다는 것을 기억하자 
  if (keccak256(sandwich) == keccak256("BLT")) {
    eat();
  }
}
```
## 마무리하기 Wrapping It Up
```js
var abi = /* abi generated by the compiler */
var ZombieFeedingContract = web3.eth.contract(abi)
var contractAddress = /* our contract address on Ethereum after deploying */
var ZombieFeeding = ZombieFeedingContract.at(contractAddress)

// 우리 좀비의 ID와 타겟 고양이 ID를 가지고 있다고 가정하면 
let zombieId = 1;
let kittyId = 1;

// 크립토키티의 이미지를 얻기 위해 웹 API에 쿼리를 할 필요가 있다. 
// 이 정보는 블록체인이 아닌 크립토키티 웹 서버에 저장되어 있다.
// 모든 것이 블록체인에 저장되어 있으면 서버가 다운되거나 크립토키티 API가 바뀌는 것이나 
// 크립토키티 회사가 크립토좀비를 싫어해서 고양이 이미지를 로딩하는 걸 막는 등을 걱정할 필요가 없다 ;) 
let apiUrl = "https://api.cryptokitties.co/kitties/" + kittyId
$.get(apiUrl, function(data) {
  let imgUrl = data.image_url
  // 이미지를 제시하기 위해 무언가를 한다 
})

// 유저가 고양이를 클릭할 때:
$(".kittyImage").click(function(e) {
  // 우리 컨트랙트의 `feedOnKitty` 메소드를 호출한다 
  ZombieFeeding.feedOnKitty(zombieId, kittyId)
})

// 우리의 컨트랙트에서 발생 가능한 NewZombie 이벤트에 귀를 기울여서 이벤트 발생 시 이벤트를 제시할 수 있도록 한다: 
ZombieFactory.NewZombie(function(error, result) {
  if (error) return
  // 이 함수는 레슨 1에서와 같이 좀비를 제시한다: 
  generateZombie(result.zombieId, result.name, result.dna)
})
```

