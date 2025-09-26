// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract ERC20{
    uint256 public totalSupply;
    string public name;
    string public symbol;
    uint8 public decimals;
    
    mapping(address=>uint256) public _balanceOf;
    mapping(address => mapping(address=>uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);


    constructor(uint256 _totalSupply,uint8 _decimals,string memory _tokenName,string memory _tokenSymbol){
      totalSupply=_totalSupply * (10 ** uint256(_decimals)) ;
      decimals=_decimals;
      name=_tokenName;
      symbol=_tokenSymbol;

      _balanceOf[msg.sender] = totalSupply;
      emit Transfer(address(0), msg.sender, totalSupply);
    }
 
 
   /// @notice Returns balance of `account`
    function balanceOf(address account) external view returns (uint256) {
        return _balanceOf[account];
    }

    /// @notice Transfer `amount` tokens from caller to `to`
    function transfer(address to, uint256 amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    /// @notice Returns current allowance `owner` gave `spender`
    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    /// @notice Approve `spender` to spend `amount` on behalf of caller
    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    /// @notice Transfer `amount` from `from` to `to` using allowance
    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        uint256 currentAllowance = _allowances[from][msg.sender];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");

        // Decrease allowance (avoid race conditions by setting explicit new value)
        _approve(from, msg.sender, currentAllowance - amount);
        _transfer(from, to, amount);
        return true;
    }

    // ---------- Internal helpers ----------

    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "ERC20: transfer from zero");
        require(to != address(0), "ERC20: transfer to zero");
        uint256 fromBalance = _balanceOf[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");

        _balanceOf[from] = fromBalance - amount;
        _balanceOf[to] += amount;

        emit Transfer(from, to, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from zero");
        require(spender != address(0), "ERC20: approve to zero");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    // Optional: mint & burn functions (only for examples — restrict access if used)
    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "ERC20: mint to zero");
        totalSupply += amount;
        _balanceOf[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    function _burn(address from, uint256 amount) internal {
        require(from != address(0), "ERC20: burn from zero");
        uint256 bal = _balanceOf[from];
        require(bal >= amount, "ERC20: burn amount exceeds balance");
        _balanceOf[from] = bal - amount;
        totalSupply -= amount;
        emit Transfer(from, address(0), amount);
    }

}