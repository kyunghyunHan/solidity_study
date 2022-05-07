# 챕터 1
## 컨트랙트
- 솔리디티 코드는 컨트랙트 안에 싸여 있지. 컨트랙트는 이더리움 애플리케이션의 기본적인 구성 요소로, 모든 변수와 함수는 어느 한 컨트랙트에 속하게 마련이지. 컨트랙트는 자네의 모든 프로젝트의 시작 지점
```sol
contract HelloWorld {

}
```
## 상태변수
- 상태 변수는 컨트랙트 저장소에 영구적으로 저장
```
contract Example {
  // 이 변수는 블록체인에 영구적으로 저장된다
  uint myUnsignedInteger = 100;
}
```