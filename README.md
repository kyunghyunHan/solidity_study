# 솔리디티 스터디
## 실행
### 클라이언트
```js
npm run build
```
### 서버
- 모듈다운
```
npm i
```
- 동시실행
```js
npm run dev
```

# 블록체인과 이더리움

## 블록체인 어플리케이션
- Dapp=Decentralized Application
- 자체적인 화폐 기능을 가지고 있다.(암호 화폐 결제 시스템)
- 제도권에서 벗어난 글러벌 에플리케이션:특정 국가,기업에 의해 관리되고 있다
- 애플리케이션으로 인한 수익(암호화페)에 대해 과세가 되지 않는다

## 이더리움 Dapp(Dapp)
- 이더리움에 배포된 Smart contract와 연계되는 애플리케이션(front/back-end)
- 여러 개발 언어를 지원하는 web3 라이브러리를 이용하여 다양하게 구현 가능
 | 개발언어 | 라이브러리 | URL | 
| -------- | :------: | -------- | 
| Javascript  | web3.js   |https://web3js.readthedocs.io/en/1.0/|

| 개발언어 | 라이브러리 | URL |
|---|:---:|---:|
| Javascript| web3.js  | https://web3js.readthedocs.io/en/1.0/|

## 개발환경 구성

- 트러플 :자바스크립트 기반의 개발환경 ->npm으로 설치(Node.js설치)
- 트러플의 기능:컴파일,테스트,배포 자동화 도구 -> 솔리디티 컴파일러 포함
- 가나쉬:로컬 가상 이더리움 :CLI버전과 GUI버전

## 설치
```
npm i -g turffle
```
```
truffle unbox react
```

###  솔리디티 개발환경 구성
- 솔리디티 소스파일 작성
- - yakindu:솔리디티 전용 이클립스 ,
- - Atom + Solidity package:솔리디티 패키지 존재,
- - websrorm/Intellij IDEA + Solidty plugin

- - REMIX
- 컴파일 ,테스트,배포가 가능하다
- 간단한 코딩,컨트렉트 테스트에 적합하다

```
mkdir hello
```
```
cd hello
```
```
truffle init
```
## truffle init으로 생성된 소스 디렉토리 구조
<img width="793" alt="스크린샷 2022-01-10 오후 2 12 38" src="https://user-images.githubusercontent.com/88940298/148731227-e62d47c0-5998-4e1a-9b71-6203d49c7ff5.png">

- contracts : 작성한 소스파일(.sol)들을 저장한다
- migrations :배포스크립트를 저장한다
- test :테스트 스크립트를 저장한다
- truffle.js:설정파일


## helloworld.sol
```sol
pragma solidity ^0.8.11;
//컴파일러 버전 
// ^ 의미:셈버 node.js 버전

contract HelloWorld {//컨트렉트가 생성될떄 파라미터를 받아서 그리팅 상태변수 초기화,쓰기 읽기 를 하는 컨트렉트
    //솔리디티의 컨트렉트 
    //대소문자 동일하게
    string public greeting; //변수선언 :문자열 타입이 모든사람이 볼수있는 변수
    //디폴트= 프라이빗
    //public = 읽기전용
    //솔리디티=정적
    
    constructor(string memory _greeting) {
        greeting = _greeting;
    }
    //생성자 
    function setGreeting(string memory _greeting ) public {
        greeting = _greeting;
    }

    function say() public view returns(string memory) {
        return greeting;
    }
}
```
- json파일 생성
```
truffle compile
```

- 배포타겟설정

```sol
module.exports={
    networks:{
         development:{host:"127.0.0.1",port:7545,network_id:"5777"}
    }
};
```
- 컨트렉트 배포

```sol
truffle migrate --newwork davelopment //--reset
```
- 가나시 연결
```
truffle console --newwork davelopment 
```
```
web3.eth.accounts
```
- 주소확인 

```
truffle networks
```
- 함수저장 
```
let hello = await HelloWorld.at("0xF9b1d975E17d4D329faE3CE105Ea82B4bD6a5341")
```
```
hello.say()
```
- 결과변경
```
hello.setGreeting.sendTransaction("Hello.Blockchain")
```
- 스토리지 집접
```

```
- 가스비
```
truffle(ganache)> hello.setGreeting.estimateGas("hello")
30978
truffle(ganache)> hello.setGreeting.estimateGas("hello!!")
31002
```
- 가스비 리미트 지정
```
hello.setGreeting.estimateGas("hello!!",{gas:2000})
```
- 확인
```
web3.eth.getBlock("latest").gasLimit
```
## 트러플 단위테스트
- 자바스크립트 또는 솔리디티로 테스르 스크립트를 작성하여 단위테스트를 수행한다
- 자바스크립트 테스트 프레임워크 mocha를 기반으로 하고 describe대신 cotract함수를 사용한다
- 단위 테스트 묶음 contract()에서는 각 단위 테스트 케이스의 결과를 공유하므로 순서를 고려할 필요가 있다.
- 대부분의 메소드들은  비동기로 동작하므로 결과도 비동기적으로 작성해야 한다(promise,async/await)
<img width="835" alt="스크린샷 2022-01-11 오전 11 09 16" src="https://user-images.githubusercontent.com/88940298/148869078-c4c6e37a-2532-45b9-ac5c-fc0c9e9472b4.png">
<img width="835" alt="스크린샷 2022-01-11 오전 11 09 16" src="https://user-images.githubusercontent.com/88940298/148869183-729a69b4-6c60-4bf4-a096-8b694920aeaf.png">

```
truffle test ./test/test_hello.js
truffle test //전부테스트
```
<img width="835" alt="스크린샷 2022-01-11 오전 11 09 16" src="https://user-images.githubusercontent.com/88940298/148869489-89d26800-c928-43f8-8367-8ece9298c7a7.png">


## Truffle Box
- truffle box는 Dapp개발에 필요한(의존관계에 있는) 모듈들을 패키지화 한것
- Node.js의 npm 으로 모듈 관리를 하며 다양한 자바스크립트 기술과 결합되어 특히 UI+Smart contract으로 구현되는 Dapp 개발 환경을 빠르고 쉽게 구성할수 있도록 한다
- create-react-app과 유사한 역활

```
truffle unbox react
```
## 단위 테스트
- 컨트렉트 배포자가 아니면 kill()메소드가 실행되어서는 안된다
- 컴트렉트에 5eth를 전송하면 컨트렉트의 잔액은 5ETH가 되어야한다
- 0.1ETH를 베팅하면 컨트렉트의 잔액은 (5.1)ETH가되어야한다
- 플레이어는 베팅을 연속해서 두번 할수 없다(베팅한 후에는 항상 결과를 확인해야한디)




## 


## interface

- 인터페이스는 컨트랙트와 마찬가지로 contract 키워드를 사용해 생성할 수 있습니다.

다만, 다른 컨트랙트와 상호작용하는 함수만을 선언할 뿐, 다른 함수나 상태 변수를 사용하지 않습니다.

```
contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}
```
- 이렇게 생성한 인터페이스를 활용하기 위해서는 인자로 주소를 대입해 초기화해주면 됩니다.
```
contract KittyInterface {
  function getKitty(address _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract MyContract {
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  // 인터페이스를 사용하려면 고유의 address형 주소를 인자로 대입합니다.
  KittyInterface kitty = KittyInterface(ckAddress)

  function someFunction() public {
    // 이제 `kitty`가 가리키고 있는 컨트랙트에서 `getKitty` 함수를 호출할 수 있습니다.
    uint myKitty = kitty.getKitty(msg.sender);
  }
}
```

## 1장

```sol
pragma solidity >=0.4.22 <0.9.0;
//1. 여기에 솔리디티 버전 적기
//2. 여기에 컨트랙트 생성
//솔리디티 코드는 컨트랙트 안에 싸여 있지. 컨트랙트는 이더리움 애플리케이션의 기본적인 구성 요소로, 모든 변수와 함수는 어느 한 컨트랙트에 속하게 마련이지. 컨트랙트는 자네의 모든 프로젝트의 시작 지점이라고 할 수 있지.
//부호 없는 정수: uint
//uint 자료형은 부호 없는 정수로, 값이 음수가 아니어야 한다는 의미네. 부호 있는 정수를 위한 int 자료형도 있네.
//참고: 솔리디티에서 uint는 실제로 uint256, 즉 256비트 부호 없는 정수의 다른 표현이지. uint8, uint16, uint32 등과 같이 uint를 더 적은 비트로 선언할 수도 있네. 하지만 앞으로의 레슨에서 다루게 될 특수한 경우가 아니라면 일반적으로 단순히 uint를 사용하지.
import "./Ownable.sol";
contract ZombieFactory is Ownable {

  uint dnaDigits = 16;
   uint dnaModulus = 10 ** dnaDigits;
  
 /**수학연산
 덧셈: x + y
뺄셈: x - y,
곱셈: x * y
나눗셈: x / y
모듈로 / 나머지: x % y (이를테면, 13 % 5는 3이다. 왜냐면 13을 5로 나누면 나머지가 3이기 때문이다)
솔리디티는 지수 연산도 지원하지 (즉, "x의 y승", x^y이지): */
//구조체를 통해 여러 특성을 가진, 보다 복잡한 자료형을 생성할 수 있지.
 struct Zombie {
        string name;
        uint dna;
    }


     /**
     어떤 것의 모음집이 필요할 때 _배열_을 사용할 수 있네. 솔리디티에는 _정적_ 배열과 _동적_ 배열이라는 두 종류의 배열이 있지:
// 또다른 고정 배열으로 5개의 스트링을 담을 수 있다:
string[5] stringArray;
// 동적 배열은 고정된 크기가 없으며 계속 크기가 커질 수 있다:
uint[] dynamicArray;
구조체의 배열을 생성할 수도 있다. 이전 챕터의 Person 구조체를 이용하면:
Person[] people; // 이는 동적 배열로, 원소를 계속 추가할 수 있다.
상태 변수가 블록체인에 영구적으로 저장될 수 있다는 걸 기억하나? 그러니 이처럼 구조체의 동적 배열을 생성하면 마치 데이터베이스처럼 컨트랙트에 구조화된 데이터를 저장하는 데 유용하네.
Public 배열
public으로 배열을 선언할 수 있지. 솔리디티는 이런 배열을 위해 getter 메소드를 자동적으로 생성하지. 구문은 다음과 같네:
Person[] public people;
그러면 다른 컨트랙트들이 이 배열을 읽을 수 있게 되지 (쓸 수는 없네). 이는 컨트랙트에 공개 데이터를 저장할 때 유용한 패턴이지.
 */
Zombie[] public zombies;
//솔리디티에서 함수 선언은 
/**솔리디티에서 함수는 기본적으로 public으로 선언되네. 즉, 누구나 (혹은 다른 어느 컨트랙트가) 자네 컨트랙트의 함수를 호출하고 코드를 실행할 수 있다는 의미지.

확실히 이는 항상 바람직한 건 아닐 뿐더러, 자네 컨트랙트를 공격에 취약하게 만들 수 있지. 그러니 기본적으로 함수를 private으로 선언하고, 공개할 함수만 public으로 선언하는 것이 좋지. */

    function _createZombie(string _name, uint _dna) private {
      // function _createZombie(string _name, uint _dna) internal { 함수가 정의된 컨트랙트를 상속하는 컨트랙트에서도 접근이 가능
      // external = 함수가 컨트랙트 바깥에서만 호출될 수 잇고 컨트랙트 내의 다름 함수에 의해 호출될 수 없다는점을 제외하면 public과 동일
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }
function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }
function createRandomZombie(string _name) public {
  //. require를 활용하면 특정 조건이 참이 아닐 때 함수가 에러 메시지를 발생하고 실행을 멈추게 되지
    require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        
        _createZombie(_name, randDna);
    }

}
// // 여기에 우리가 만든 컨트랙트에 접근하는 방법을 제시한다:
// var abi = /* abi generated by the compiler */
// var ZombieFactoryContract = web3.eth.contract(abi)
// var contractAddress = /* our contract address on Ethereum after deploying */
// var ZombieFactory = ZombieFactoryContract.at(contractAddress)
// // `ZombieFactory`는 우리 컨트랙트의 public 함수와 이벤트에 접근할 수 있다.

// // 일종의 이벤트 리스너가 텍스트 입력값을 취한다:
// $("#ourButton").click(function(e) {
//   var name = $("#nameInput").val()
//   // 우리 컨트랙트의 `createRandomZombie`함수를 호출한다:
//   ZombieFactory.createRandomZombie(name)
// })

// // `NewZombie` 이벤트가 발생하면 사용자 인터페이스를 업데이트한다
// var event = ZombieFactory.NewZombie(function(error, result) {
//   if (error) return
//   generateZombie(result.zombieId, result.name, result.dna)
// })

// // 좀비 DNA 값을 받아서 이미지를 업데이트한다
// function generateZombie(id, name, dna) {
//   let dnaStr = String(dna)
//   // DNA 값이 16자리 수보다 작은 경우 앞 자리를 0으로 채운다
//   while (dnaStr.length < 16)
//     dnaStr = "0" + dnaStr

//   let zombieDetails = {
//     // 첫 2자리는 머리의 타입을 결정한다. 머리 타입에는 7가지가 있다. 그래서 모듈로(%) 7 연산을 하여
//     // 0에서 6 중 하나의 값을 얻고 여기에 1을 더해서 1에서 7까지의 숫자를 만든다. 
//     // 이를 기초로 "head1.png"에서 "head7.png" 중 하나의 이미지를 불러온다:
//     headChoice: dnaStr.substring(0, 2) % 7 + 1,
//     // 두번째 2자리는 눈 모양을 결정한다. 눈 모양에는 11가지가 있다:
//     eyeChoice: dnaStr.substring(2, 4) % 11 + 1,
//     // 셔츠 타입에는 6가지가 있다:
//     shirtChoice: dnaStr.substring(4, 6) % 6 + 1,
//     // 마지막 6자리는 색깔을 결정하며, 360도(degree)까지 지원하는 CSS의 "filter: hue-rotate"를 이용하여 아래와 같이 업데이트된다:
//     skinColorChoice: parseInt(dnaStr.substring(6, 8) / 100 * 360),
//     eyeColorChoice: parseInt(dnaStr.substring(8, 10) / 100 * 360),
//     clothesColorChoice: parseInt(dnaStr.substring(10, 12) / 100 * 360),
//     zombieName: name,
//     zombieDescription: "A Level 1 CryptoZombie",
//   }


  // return zombieDetails







//_매핑_은 솔리디티에서 구조화된 데이터를 저장하는 또다른 방법이지.
//매핑은 기본적으로 키-값 (key-value) 저장소로, 데이터를 저장하고 검색하는 데 이용된다. 첫번째 예시에서 키는 address이고 값은 uint이다. 두번째 예시에서 키는 uint이고 값은 string이다.
    // mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;


//msg.sender를 활용하면 자네는 이더리움 블록체인의 보안성을 이용할 수 있게 되지. 즉, 누군가 다른 사람의 데이터를 변경하려면 해당 이더리움 주소와 관련된 개인키를 훔치는 것 밖에는 다른 방법이 없다는 것이네.

contract ZombieFeeding is ZombieFactory {
  //상속
}

// }
```
## 2장
```
pragma solidity ^0.8.11;

import "./One.sol";  //다른파일에서 불러올 때
contract KittyInterface {
  //유전자"를 포함한 모든 키티 데이터를 반환하는 getKitty라는 함수
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}
contract ZombieFeeding is ZombieFactory { //상속
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
   KittyInterface kittyContract = KittyInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];// Storage는 블록체인 상에 영구적으로 저장되는 변수를 의미하지.
    _targetDna = _targetDna % dnaModulus;// Memory는 임시적으로 저장되는 변수로, 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 지워지지.
    uint newDna = (myZombie.dna + _targetDna) / 2;
      if (keccak256(_species) == keccak256("kitty")) {//보너스: 키티 유전자_species와 "kitty" 스트링 각각의 keccak256 해시값을 비교
      newDna = newDna - newDna % 100 + 99;//if 문 내에서 DNA 마지막 2자리를 99로 대체
    }
    _createZombie("NoName", newDna);
  }
  function feedOnKitty(uint _zombieId, uint _kittyId) public { //다수의 반환값 처리
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
     feedAndMultiply(_zombieId, kittyDna, "kitty");//feedAndMultiply가 호출될 때, "kitty"를 마지막 인자값으로 전달
  }
}


// var abi = /* abi generated by the compiler */
// var ZombieFeedingContract = web3.eth.contract(abi)
// var contractAddress = /* our contract address on Ethereum after deploying */
// var ZombieFeeding = ZombieFeedingContract.at(contractAddress)

// // 우리 좀비의 ID와 타겟 고양이 ID를 가지고 있다고 가정하면 
// let zombieId = 1;
// let kittyId = 1;

// // 크립토키티의 이미지를 얻기 위해 웹 API에 쿼리를 할 필요가 있다. 
// // 이 정보는 블록체인이 아닌 크립토키티 웹 서버에 저장되어 있다.
// // 모든 것이 블록체인에 저장되어 있으면 서버가 다운되거나 크립토키티 API가 바뀌는 것이나 
// // 크립토키티 회사가 크립토좀비를 싫어해서 고양이 이미지를 로딩하는 걸 막는 등을 걱정할 필요가 없다 ;) 
// let apiUrl = "https://api.cryptokitties.co/kitties/" + kittyId
// $.get(apiUrl, function(data) {
//   let imgUrl = data.image_url
//   // 이미지를 제시하기 위해 무언가를 한다 
// })

// // 유저가 고양이를 클릭할 때:
// $(".kittyImage").click(function(e) {
//   // 우리 컨트랙트의 `feedOnKitty` 메소드를 호출한다 
//   ZombieFeeding.feedOnKitty(zombieId, kittyId)
// })

// // 우리의 컨트랙트에서 발생 가능한 NewZombie 이벤트에 귀를 기울여서 이벤트 발생 시 이벤트를 제시할 수 있도록 한다: 
// ZombieFactory.NewZombie(function(error, result) {
//   if (error) return
//   // 이 함수는 레슨 1에서와 같이 좀비를 제시한다: 
//   generateZombie(result.zombieId, result.name, result.dna)
// })
```
## 3장

- 생성자(Constructor): function Ownable()는 생성자이네. 컨트랙트와 동일한 이름을 가진,생략할 수 있는 특별한 함수이지. 이 함수는 컨트랙트가 생성될 때 딱 한 번만 실행된다네.
- 함수 제어자(Function Modifier): modifier onlyOwner(). 제어자는 다른 함수들에 대한 접근을 제어하기 위해 사용되는 일종의 유사 함수라네. 보통 함수 실행 전의 요구사항 충족 여부를 확인하는 데에 사용하지. onlyOwner의 경우에는 접근을 제한해서 오직 컨트랙트의 소유자만 해당 함수를 실행할 수 있도록 하기 위해 사용될 수 있지. 우리는 다음 챕터에서 함수 제어자에 대해 더 살펴보고, _;라는 이상한 것이 뭘 하는 것인지 알아볼 것이네.
i- ndexed 키워드: 이건 걱정하지 말게. 우린 아직 이게 필요하지 않아



```

pragma solidity >=0.4.22 <0.9.0;


import "./One.sol"; 

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {
  KittyInterface kittyContract;//컨트랙트의 불변성  크립토키티 컨트랙트 주소의 업데이트가 가능하도록 바꿔보세.
//   address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

//   KittyInterface kittyContract = KittyInterface(ckAddress);


 function setKittyContractAddress(address _address) external {
    kittyContract = KittyInterface(_address);
  }//1.컨트랙트의 불변성  크립토키티 컨트랙트 주소의 업데이트가 가능하도록 바꿔보세.
  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(_species) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


/**  이더리움 DApp
1.이더리움에 컨트랙트를 배포하고 나면, 컨트랙트는 변하지 않는다 다시 말하자면 컨트랙트를 수정하거나 업데이트할 수 없다는 것
2.자네가 컨트랙트로 배포한 최초의 코드는 항상, 블록체인에 영구적으로 존재
3.

 */

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
## 4장

## 5장
## 6장