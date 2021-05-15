pragma solidity 0.8.4;

contract mappedWithUnorderedIndexAndDelete {
  // listPointer keeps track of entity's place in entityList
  struct EntityStruct {
    uint entityData;
    uint listPointer;
  }

  mapping(address => EntityStruct) public entityStructs;
  address[] public entityList;

  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    if(entityList.length == 0) return false;
    return (entityList[entityStructs[entityAddress].listPointer] == entityAddress);
  }

  function getEntityCount() public view returns(uint entityCount) {
    return entityList.length;
  }

  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    entityList.push(entityAddress);
    entityStructs[entityAddress].listPointer = entityList.length - 1;
    return true;
  }

  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }

  // arrays can be shortened by removing the last element
  // and moving it to the element that should be removed
  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    uint rowToDelete = entityStructs[entityAddress].listPointer;
    address keyToMove   = entityList[entityList.length-1];
    entityList[rowToDelete] = keyToMove;
    entityStructs[keyToMove].listPointer = rowToDelete;
    entityList.pop();
    delete entityStructs[entityAddress];
    return true;
  }
}