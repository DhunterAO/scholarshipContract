pragma solidity >=0.5.0 <0.7.0;

contract Project {
    
    constructor() public {
        // ...
    }

    // 验证学生并发放对应的奖学金
    function auto_distribute(string proof, address receiver) public payable {
        // 验证零知识
        require(verify(proof) == true, "Proof is not correct!");
        
        // 查询应发奖学金的数额
        uint256 amount = get_amount_from_proof(proof);
        
        // 发放奖学金给学生
        receiver.transfer(amount);
    }
    
    function get_amount_from_proof(string proof){
        uint256 amount;
        // ...
        
        return amount;
    }
    
    function verify(string proof) returns (bool) public{
        // ...
        return true;
    }

}