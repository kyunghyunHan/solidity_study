# 챕터4

## payable
- payable은 이더를 받을수 있는 함수
```solidity
contract OnlineStore {
  function buySomething() external payable {
    // 함수 실행에 0.001이더가 보내졌는지 확실히 하기 위해 확인:
    require(msg.value == 0.001 ether);
    // 보내졌다면, 함수를 호출한 자에게 디지털 아이템을 전달하기 위한 내용 구성:
    transferThing(msg.sender);
  }
}
```
- msg.value는 컨트렉트로 이더가 얼마나 보내졌는지 확인하는 방법
- ether은 기존적으로 포함된 단위
- value는 봉투안에 현금을 넣는것과 같음 - 편지와 돈이 모두 수령인에게 전달

## 출금 
```solidity
contract GetPaid is Ownable {
  function withdraw() external onlyOwner {
    owner.transfer(this.balance);
  }
}
```
- transfer함수를 사용해서 이더를 특정주소로 전달
- this.balance는 컨트랙트에 저장되어 있는 전체 잔액을 반환
- 100명이 사용자가 컨트렉트의 1이더를 지불했다면 this.balance는 100ether
```solidity
uint itemFee = 0.001 ether;
msg.sender.transfer(msg.value - itemFee);
```
## 난수
- 솔리디티에서 난수를 만들기 기장 좋은 방법은 keccak256해시 함수 사용
```solidity
// Generate a random number between 1 and 100:
uint randNonce = 0;
uint random = uint(keccak256(now, msg.sender, randNonce)) % 100;
randNonce++;
uint random2 = uint(keccak256(now, msg.sender, randNonce)) % 100;
```
- 이더리움에서 컨트렉트의 함수를 실행하면 트래잭션 으로서 네트워크의 노드 하나 혹은 여러 노드에 실행을 알리게 되고 그후 네트워크의 노드들은 여러개의 트래잭션을 모으고 pow와 함께 블록으로 네트워크에 배포
- 한 노드가 어떤 pow를 풀면 다른 노드들은 그 poW 를 풀려는 시도를 멈추고 해당 노드가 보낸 트래잭션이 유효한지 검증
## 이더리움에서 어떻게 난수를 안전하게 만들어 낼수 있나
- 이더리움 블록체인 외부의 난수 함수에 접글할수 있도록 오라클을 사용

## 공통 로직 구조 개선

