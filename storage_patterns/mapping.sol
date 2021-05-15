pragma solidity 0.8.4;

contract mappingWithStruct {
  // can lookup entity directly by identifier
  // mappings don't allow for duplicates

  // don't know how many entities are in the mapping
  // mappings are not enumerable
  struct EntityStruct {
    uint entityData;
    bool isEntity;
  }

  mapping (address => EntityStruct) public entityStructs;

  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert(); 
    entityStructs[entityAddress].entityData = entityData;
    entityStructs[entityAddress].isEntity = true;
    return true;
  }
  
  // cannot tell the diference between an entitiy that
  // has been explicity set to zero and
  // one that is set to zero at initilization
  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    return entityStructs[entityAddress].isEntity;
  }

  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].isEntity = false;
    return true;
  }

  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }
}
