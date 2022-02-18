
pragma solidity >=0.4.22 <0.9.0;


import "./One.sol"; 

contract KittyInterface {
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

contract ZombieFeeding is ZombieFactory {
  KittyInterface kittyContract;//컨트랙트의 불변성  크립토키티 컨트랙트 주소의 업데이트가 가능하도록 바꿔보세.
//   address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

//   KittyInterface kittyContract = KittyInterface(ckAddress);


 function setKittyContractAddress(address _address) external {
    kittyContract = KittyInterface(_address);
  }//1.컨트랙트의 불변성  크립토키티 컨트랙트 주소의 업데이트가 가능하도록 바꿔보세.
  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(_species) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


/**  이더리움 DApp
1.이더리움에 컨트랙트를 배포하고 나면, 컨트랙트는 변하지 않는다 다시 말하자면 컨트랙트를 수정하거나 업데이트할 수 없다는 것
2.자네가 컨트랙트로 배포한 최초의 코드는 항상, 블록체인에 영구적으로 존재
3.

 */

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
