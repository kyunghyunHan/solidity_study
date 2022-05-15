# 챕터5

## 이더리움 상의 토큰

- ERC 20 :대체 가능
- ERC721 :대체 불가능
## ERC721 표준 , 다중 상속
```solidity
contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  function balanceOf(address _owner) public view returns (uint256 _balance);
  function ownerOf(uint256 _tokenId) public view returns (address _owner);
  function transfer(address _to, uint256 _tokenId) public;
  function approve(address _to, uint256 _tokenId) public;
  function takeOwnership(uint256 _tokenId) public;
}
```

##  balanceOf & ownerOf
- balanceOf: address를 받아, 해당 address가 토큰을 얼마나 가지고 있는지 반환
```solidity
 function balanceOf(address _owner) public view returns (uint256 _balance);
```
- ownerOf:토큰 ID(우리의 경우에는 좀비 ID)를 받아, 이를 소유하고 있는 사람의 address를 반환
```solidity
function ownerOf(uint256 _tokenId) public view returns (address _owner);
```
## 리팩토링
## ERC721: 전송 로직 
```solidity
function transfer(address _to, uint256 _tokenId) public;
function approve(address _to, uint256 _tokenId) public;
function takeOwnership(uint256 _tokenId) public;
```
## ERC721: Approve
## ERC721: takeOwnership
## 오버플로우 막기
- 오버플로우 : 
```solidity
uint8 number = 255;
number++;
```
```solidity 
using SafeMath for uint256;

uint256 a = 5;
uint256 b = a.add(3); // 5 + 3 = 8
uint256 c = a.mul(2); // 5 * 2 = 10
```
## SafeMath 파트 2
 ```solidity
 library SafeMath {

  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

 ```
##  SafeMath 파트 3 
## SafeMath 파트 4
## 주석(Comment)
