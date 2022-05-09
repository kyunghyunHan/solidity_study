# 챕터3

## 컨트렉트의 불변성

- 1. 컨트랙트를 배포하고 나면, 컨트랙트는 변하지 않는다(Immutable). 다시 말하자면 컨트랙트를 수정하거나 업데이트할 수 없다는 것.
- 컨트랙트로 배포한 최초의 코드는 항상, 블록체인에 영구적으로 존재한다네. 이것이 바로 솔리디티에 있어서 보안이 굉장히 큰 이슈인 이유라네. 만약 자네의 컨트랙트 코드에 결점이 있다면, 그것을 이후에 고칠 수 있는 방법이 전혀 없다네.
- 외부 의존성
## 소유 가능한 컨트렉트
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
