pragma solidity ^0.4.0;

import "./Settings.sol";

contract Certificate  {  
  address public owner;
  uint256 public totalSupply;
  mapping (address => uint256) balances;
  mapping (address => mapping (address => uint256)) allowed;

  modifier ifOwner() {
    if (msg.sender != owner) {
      throw;
    } else {
      _;
    }
  }

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256  _value);

  function Certificate() {
    owner = msg.sender;
  }

  function balanceOf(address _owner) constant returns (uint256 balance) {
    return balances[_owner];
  }

  function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
    if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
      //...
      return true;
    } else {
      return false;
    }
  }

  function transfer(address _to, uint256 _value) returns (bool success) {
    if (balances[msg.sender] >= _value && _value > 0) {
      //...
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  function approve(address _spender, uint256 _value) returns (bool success) {
    //...
    success = true;
    return success;
  }

  function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
    //...
    return remaining;
  }

  function setOwner(address _owner) ifOwner returns (bool success) {
    owner = _owner;
    return true;
  }

}

contract Token {

  address public owner;
  address public config;
  address public certificateLedger;
  address public dao;  
  uint256 public totalSupply;
  mapping (address => uint256) balances;
  mapping (address => bool) seller;
  mapping (address => mapping (address => uint256)) allowed;

  modifier ifOwner() {
    if (msg.sender != owner) throw;
    _;
  }  
  
  modifier ifDao() {
    if (msg.sender != dao) throw;
    _;
  }

  modifier ifSales() {
    if (!seller[msg.sender]) throw; 
    _; 
  }

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256  _value);

  function safeToAdd(uint a, uint b) returns (bool) {
    return (a + b >= a);
  }

  function safeToSubtract(uint a, uint b) returns (bool) {
    return (b <= a);
  }

  function addSafely(uint a, uint b) returns (uint result) {
    if (!safeToAdd(a, b)) {
      throw;
    } else {
      result = a + b;
      return result;
    }
  }

  function subtractSafely(uint a, uint b) returns (uint) {
    if (!safeToSubtract(a, b)) throw;
    return a - b;
  }

  function balanceOf(address _owner) constant returns (uint256 balance) {
    return balances[_owner];
  }

  function transfer(address _to, uint256 _value) returns (bool success) {
    if (balances[msg.sender] >= _value && _value > 0) {
      //...
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
    if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
      //...
      return true;
    } else {
      return false;
    }
  }

  function approve(address _spender, uint256 _value) returns (bool success) {
    //...
    success = true;
    return success;
  }

  function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
    remaining = allowed[_owner][_spender];
    return remaining;
  }

  function isSeller(address _query) returns (bool isseller) {
    return seller[_query];
  }

  function registerSeller(address _tokensales) ifDao returns (bool success) {
    seller[_tokensales] = true;
    return true;
  }

  function unregisterSeller(address _tokensales) ifDao returns (bool success) {
    seller[_tokensales] = false;
    return true;
  }

  function registerDao(address _dao) ifOwner returns (bool success) {
    dao = _dao;
    return true;
  }

  function setDao(address _newdao) ifDao returns (bool success) {
    dao = _newdao;
    return true;
  }

  function setOwner(address _newowner) ifDao returns (bool success) {
    if(Certificate(certificateLedger).setOwner(_newowner)) {
      owner = _newowner;
      success = true;
    } else {
      success = false;
    }
    return success;
  }

}
