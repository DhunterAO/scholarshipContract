pragma solidity >=0.5.0 <0.7.0;

contract Project {
    // create a new struct Scholar to store the information of scholar
    struct Scholar {
        uint8 id;
        string name;
        string description;
        uint amount;
        address addr;
    }
    
    uint8[] public scholar_id_list;
    // scholar list is the total list of all scholar
    mapping (uint8 => Scholar) public scholar_list;
    
    // in constructor, the contract initializes the scholar list
    constructor() public {
        // initialize the scholar list
        
    }

    function get_scholar_list() public {
        return scholar_list 
        }
    }

    // 验证学生并发放对应的奖学金
    function auto_distribute(uint8 scholar_id, string memory proof, address payable receiver) public payable {
        // 验证零知识
        require(verify(scholar_id, proof) == true, "Proof is not correct!");
        
        // 查询应发奖学金的数额
        uint256 amount = scholar_list[scholar_id_list[index]].amount;
        
        // 发放奖学金给学生
        receiver.transfer(amount);
    }
    
    function verify(uint8 index, string memory proof) public returns (bool) {
        // ...
        return true;
    }

}