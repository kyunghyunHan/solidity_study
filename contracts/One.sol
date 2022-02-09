pragma solidity ^0.4.19;
//1. 여기에 솔리디티 버전 적기
//2. 여기에 컨트랙트 생성
//솔리디티 코드는 컨트랙트 안에 싸여 있지. 컨트랙트는 이더리움 애플리케이션의 기본적인 구성 요소로, 모든 변수와 함수는 어느 한 컨트랙트에 속하게 마련이지. 컨트랙트는 자네의 모든 프로젝트의 시작 지점이라고 할 수 있지.
//부호 없는 정수: uint
//uint 자료형은 부호 없는 정수로, 값이 음수가 아니어야 한다는 의미네. 부호 있는 정수를 위한 int 자료형도 있네.
//참고: 솔리디티에서 uint는 실제로 uint256, 즉 256비트 부호 없는 정수의 다른 표현이지. uint8, uint16, uint32 등과 같이 uint를 더 적은 비트로 선언할 수도 있네. 하지만 앞으로의 레슨에서 다루게 될 특수한 경우가 아니라면 일반적으로 단순히 uint를 사용하지.
contract ZombieFactory {
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
    require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        
        _createZombie(_name, randDna);
    }

}
// 여기에 우리가 만든 컨트랙트에 접근하는 방법을 제시한다:
var abi = /* abi generated by the compiler */
var ZombieFactoryContract = web3.eth.contract(abi)
var contractAddress = /* our contract address on Ethereum after deploying */
var ZombieFactory = ZombieFactoryContract.at(contractAddress)
// `ZombieFactory`는 우리 컨트랙트의 public 함수와 이벤트에 접근할 수 있다.

// 일종의 이벤트 리스너가 텍스트 입력값을 취한다:
$("#ourButton").click(function(e) {
  var name = $("#nameInput").val()
  // 우리 컨트랙트의 `createRandomZombie`함수를 호출한다:
  ZombieFactory.createRandomZombie(name)
})

// `NewZombie` 이벤트가 발생하면 사용자 인터페이스를 업데이트한다
var event = ZombieFactory.NewZombie(function(error, result) {
  if (error) return
  generateZombie(result.zombieId, result.name, result.dna)
})

// 좀비 DNA 값을 받아서 이미지를 업데이트한다
function generateZombie(id, name, dna) {
  let dnaStr = String(dna)
  // DNA 값이 16자리 수보다 작은 경우 앞 자리를 0으로 채운다
  while (dnaStr.length < 16)
    dnaStr = "0" + dnaStr

  let zombieDetails = {
    // 첫 2자리는 머리의 타입을 결정한다. 머리 타입에는 7가지가 있다. 그래서 모듈로(%) 7 연산을 하여
    // 0에서 6 중 하나의 값을 얻고 여기에 1을 더해서 1에서 7까지의 숫자를 만든다. 
    // 이를 기초로 "head1.png"에서 "head7.png" 중 하나의 이미지를 불러온다:
    headChoice: dnaStr.substring(0, 2) % 7 + 1,
    // 두번째 2자리는 눈 모양을 결정한다. 눈 모양에는 11가지가 있다:
    eyeChoice: dnaStr.substring(2, 4) % 11 + 1,
    // 셔츠 타입에는 6가지가 있다:
    shirtChoice: dnaStr.substring(4, 6) % 6 + 1,
    // 마지막 6자리는 색깔을 결정하며, 360도(degree)까지 지원하는 CSS의 "filter: hue-rotate"를 이용하여 아래와 같이 업데이트된다:
    skinColorChoice: parseInt(dnaStr.substring(6, 8) / 100 * 360),
    eyeColorChoice: parseInt(dnaStr.substring(8, 10) / 100 * 360),
    clothesColorChoice: parseInt(dnaStr.substring(10, 12) / 100 * 360),
    zombieName: name,
    zombieDescription: "A Level 1 CryptoZombie",
  }


  return zombieDetails







//_매핑_은 솔리디티에서 구조화된 데이터를 저장하는 또다른 방법이지.
//매핑은 기본적으로 키-값 (key-value) 저장소로, 데이터를 저장하고 검색하는 데 이용된다. 첫번째 예시에서 키는 address이고 값은 uint이다. 두번째 예시에서 키는 uint이고 값은 string이다.
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;


//msg.sender를 활용하면 자네는 이더리움 블록체인의 보안성을 이용할 수 있게 되지. 즉, 누군가 다른 사람의 데이터를 변경하려면 해당 이더리움 주소와 관련된 개인키를 훔치는 것 밖에는 다른 방법이 없다는 것이네.

}