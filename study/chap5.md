# 챕터5

## 이더리움 상의 토큰
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

## 리팩토링
## ERC721: 전송 로직 
## ERC721: Approve
## ERC721: takeOwnership
## 오버플로우 막기

## SafeMath 파트 2
 
##  SafeMath 파트 3 
## SafeMath 파트 4
## 주석(Comment)
