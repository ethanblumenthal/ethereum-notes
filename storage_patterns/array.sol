pragma solidity 0.8.4;

contract simpleList {

  struct EntityStruct {
    address entityAddress;
    uint entityData;
  }

  // difficult to delete data from an array
  EntityStruct[] public entityStructs;

  function newEntity(address entityAddress, uint entityData) public returns(EntityStruct memory) {
    EntityStruct memory entity;
    entity.entityAddress = entityAddress;
    entity.entityData    = entityData;
    entityStructs.push(entity);
    return entityStructs[entityStructs.length - 1];
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityStructs.length;
  }
}
