# 챕터 1
## 컨트랙트
- 솔리디티 코드는 컨트랙트 안에 싸여 있지. 컨트랙트는 이더리움 애플리케이션의 기본적인 구성 요소로, 모든 변수와 함수는 어느 한 컨트랙트에 속하게 마련이지. 컨트랙트는 자네의 모든 프로젝트의 시작 지점
```solidity
contract HelloWorld {

}
```
## 상태변수
- 상태 변수는 컨트랙트 저장소에 영구적으로 저장
```solidity
contract Example {
  // 이 변수는 블록체인에 영구적으로 저장된다
  uint myUnsignedInteger = 100;
}
```
## 수학연산
```
덧셈: x + y
뺄셈: x - y,
곱셈: x * y
나눗셈: x / y
모듈로 / 나머지: x % y (이를테면, 13 % 5는 3이다. 왜냐면 13을 5로 나누면 나머지가 3이기 때문이다)
```
## 구조체
- 좀 더 복잡한 자료형을 필요로 할 때가 가끔 있을 거네. 이를 위해 솔리디티는 구조체를 제공
```solidity
struct Person {
  uint age;
  string name;
}
```

## 배열
- 솔리디티에는 _정적_ 배열과 _동적_ 배열
```solidity
// 2개의 원소를 담을 수 있는 고정 길이의 배열:
uint[2] fixedArray;
// 또다른 고정 배열으로 5개의 스트링을 담을 수 있다:
string[5] stringArray;
// 동적 배열은 고정된 크기가 없으며 계속 크기가 커질 수 있다:
uint[] dynamicArray;
```
```solidity
Person[] people; 
// 이는 동적 배열로, 원소를 계속 추가할 수 있다.
```
- 상태 변수가 블록체인에 영구적으로 저장될 수 있다는 걸 기억하나? 그러니 이처럼 구조체의 동적 배열을 생성하면 마치 데이터베이스처럼 컨트랙트에 구조화된 데이터를 저장하는 데 유용하네.
- Public 배열 : 다른 컨트랙트들이 이 배열을 읽을 수 있게 되지 (쓸 수는 없네). 이는 컨트랙트에 공개 데이터를 저장할 때 유용한 패턴이지.
```solidity
Person[] public people;
```
## 함수선언
- 함수 인자명을 언더스코어(_)로 시작해서 전역 변수와 구별하는 것이 관례이네 (의무는 아님). 

```solidity
function eatHamburgers(string _name, uint _amount) {

}
```
## 구조체와 배열 활용하기

```solidity
// 새로운 사람을 생성한다:
Person satoshi = Person(172, "Satoshi");

// 이 사람을 배열에 추가한다:
people.push(satoshi);
//이 두 코드를 조합하여 깔끔하게 한 줄로 표현할 수 있네:
people.push(Person(16, "Vitalik"));
```

## Private / Public 함수
- 그러니 기본적으로 함수를 private으로 선언하고, 공개할 함수만 public으로 선언하는 것이 좋지.

```solidity
uint[] numbers;

function _addToArray(uint _number) private {
  numbers.push(_number);
}
```
## 함수 더 알아보기

- 반환값:함수에서 어떤 값을 반환 받으려면 다음과 같이 선언해야 하네:
```solidity
string greeting = "What's up dog";

function sayHello() public returns (string) {
  return greeting;
}
```
- 함수제어자 : view : 함수를 view 함수로 선언한다네. 이는 함수가 데이터를 보기만 하고 변경하지 않는다는 뜻이지:
```solidity
function sayHello() public view returns (string) {
```
- 함수제어자 : pure :  함수는 앱에서 읽는 것도 하지 않고, 다만 반환값이 함수에 전달된 인자값에 따라서 달라지지. 그러니 이 경우에 함수를 pure로 선언
```solidity
function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}
```
## Keccak256과 형 변환 
```solidity
```
##  종합하기 
```solidity
```
## 이벤트
```solidity
```
## Web3.js
```solidity
```
