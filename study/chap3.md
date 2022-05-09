# 챕터3

## 컨트렉트의 불변성

- 컨트랙트를 배포하고 나면, 컨트랙트는 변하지 않는다(Immutable). 다시 말하자면 컨트랙트를 수정하거나 업데이트할 수 없다는 것.
- 컨트랙트로 배포한 최초의 코드는 항상, 블록체인에 영구적으로 존재한다네. 이것이 바로 솔리디티에 있어서 보안이 굉장히 큰 이슈인 이유라네. 만약 자네의 컨트랙트 코드에 결점이 있다면, 그것을 이후에 고칠 수 있는 방법이 전혀 없다네.
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
- 생성자(Constructor): function Ownable()는 생성자이네. 컨트랙트와 동일한 이름을 가진,생략할 수 있는 특별한 함수이지. 이 함수는 컨트랙트가 생성될 때 딱 한 번만 실행된다네.
- 함수 제어자(Function Modifier): modifier onlyOwner(). 제어자는 다른 함수들에 대한 접근을 제어하기 위해 사용되는 일종의 유사 함수라네. 보통 함수 실행 전의 요구사항 충족 여부를 확인하는 데에 사용하지. onlyOwner의 경우에는 접근을 제한해서 오직 컨트랙트의 소유자만 해당 함수를 실행할 수 있도록 하기 위해 사용될 수 있지. 우리는 다음 챕터에서 함수 제어자에 대해 더 살펴보고, _;라는 이상한 것이 뭘 하는 것인지 알아볼 것이네.
- indexed 키워드: 이건 걱정하지 말게. 우린 아직 이게 필요하지 않아.
-  Ownable 컨트랙트는 기본적으로 다음과 같은 것들을 하네:
```
- 컨트랙트가 생성되면 컨트랙트의 생성자가 owner에 msg.sender(컨트랙트를 배포한 사람)를 대입한다.
- 특정한 함수들에 대해서 오직 소유자만 접근할 수 있도록 제한 가능한 onlyOwner 제어자를 추가한다.
- 새로운 소유자에게 해당 컨트랙트의 소유권을 옮길 수 있도록 한다.
```

## OnlyOwner함수 제어자
```solidity
```
## Gas
```solidity
```
## 시간단위
```solidity
```
## 좀비 재사용 대기 시간
```solidity
```
## Public함수 보안
```solidity
```
## 함수 제어자의 또 다른 특징
```solidity
```
## 좀비 제어자
```solidity
```
## View함수를 사용해 절약하기
```solidity
```
## Storage는 비싸다
```solidity
```
## For반복문
```solidity
```
## 마무리
```solidity
```
