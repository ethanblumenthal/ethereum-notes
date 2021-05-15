pragma solidity 0.8.4;

contract simpleList {

  struct EntityStruct {
    address entityAddress;
    uint entityData;
  }

  // difficult to delete data from an array
  EntityStruct[] public entityStructs;

  function newEntity(address entityAddress, uint entityData) public returns(EntityStruct memory) {
    EntityStruct memory newEntity;
    newEntity.entityAddress = entityAddress;
    newEntity.entityData    = entityData;
    entityStructs.push(newEntity);
    return entityStructs[entityStructs.length - 1];
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityStructs.length;
  }
}
