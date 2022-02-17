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
