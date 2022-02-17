pragma solidity ^0.8.11;

import "./One.sol";  //다른파일에서 불러올 때
contract KittyInterface {
  //유전자"를 포함한 모든 키티 데이터를 반환하는 getKitty라는 함수
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
contract ZombieFeeding is ZombieFactory { //상속
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
   KittyInterface kittyContract = KittyInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];// Storage는 블록체인 상에 영구적으로 저장되는 변수를 의미하지.
    _targetDna = _targetDna % dnaModulus;// Memory는 임시적으로 저장되는 변수로, 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 지워지지.
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }

}
