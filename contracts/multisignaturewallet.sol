pragma solidity ^0.5.0;
contract MultiSignatureWallet {
  struct Transaction {
    bool executed;
    address destination;
    uint value;
    byte data;
  }
  uint public transactionCount;
  mapping (uint => Transaction) public transactions;
  mapping (uint => mapping (address => bool)) public confirmations;
  modifier validRequirement(uint ownerCount,uint _required) {
    if( _required>ownerCount || _required == 0 || ownerCount == 0)
       revert();
    _;
  }
  constructor(address[] memory _owener, uint _required) public validRequire{

  }
  event Deposit(address indexed sender, uint value);
  function()external payable {
    if (msg.sender > 0) {
      emit Deposit(msg.sender,msg.value);
    }
  }
  constractor(address[] memory _owner, uint _required) public
      validRequirement(_owner.length, _required){
        //address[] public owners;
        //uint public required;
        //mapping (address => bool) public isOwner;
        for (uint i=0; i<_owner.length; i++){
          isOwner[_owner[i]] = true;
        }
        owners = _owners;
        requred = _required;
      }
  function submitTransaction(address destination, uint _required) public {
    require(isOwner[msg.sender]);
    transactionId = addTransaction(destination, value, data);
    confirmTransaaction(transactionId);
  }
  function confirmTransaction(uint transactionId) public{
    require(isOwner[msg.sender]);
    require(transactions[transactionId].destination != 0);
    require(confirmations[transactionId][msg.sender] == false);
    confirmations[transactionId][msg.sender] == true;
    emit Confirmation(msg.sender, transactionId);
    executeTranction(transactionId);
  }
  function revokeConfirmation(uint transactionId) public{}
  function executeTransaction(uint transactionId) public{
     require(transactions[trandsactionId].executed == false);
     if (isConfirmed(transactionId)) { 
       Transaction storage t = transactions[transactionId];
       t.executed = true;
       (bool success, bytes memory returnedData) = t.destination.call.value(t.value)(t.data);
       if (success)
           emit Execution(transactionId);
       else {
         emit ExecutionFailure(transactionId);
         t.executed = false;
       }
     }
  }
  function isConfirmed(uint transactionId) internal view return (bool) {
    uint count= 0 
    for ( uint i=0; i<owner.length; i++){
      if (confirmations[transactionId][owner[i]])
          count +=1;
      if (count == required)
          return true;
    }
  }
  function addTransaction(address destination, uint value, bytes memory data) internal return(uint transaction) {
    transactionId = trancactionCount;
    transactions[transactionId] = tarnsaction({
         destination: destination,
         value: value,
         data: data,
         executed: false
    });
    transactionCount +=1
    emit Submission(transactionId);
  }

}