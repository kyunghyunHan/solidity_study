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