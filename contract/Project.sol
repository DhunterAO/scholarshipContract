pragma solidity >=0.5.0 <0.7.0;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

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
    function auto_distribute(uint8 scholar_id, string memory proof1[2], string memory proof2[2][2], string memory proof3[2], string memory proof4[1], string receiver_string) public payable returns (bool) {
        // 验证零知识
        bool success = verify(scholar_id, proof);
        require(success == true, "Proof is not correct!");
        

        address payable receiver = string2address(receiver_string);

        // 查询应发奖学金的数额
        uint256 amount = scholar_list[scholar_id_list[index]].amount;
        
        // 发放奖学金给学生
        receiver.transfer(amount);
    }
    
    function verify(uint8 scholar_id, string memory proof1[2], string memory proof2[2][2], string memory proof3[2], string memory proof4[1]) public returns (bool) {
        // index: 第几个奖学金
        // proof: 9个字符串形式uint256
        
        bytes4 methodId = bytes4(keccak256("increaseAge(uint8,string)"));
        address contract_address = scholar_list[scholar_id].addr;
        
        (bool success, bytes memory returnData) = contract_address.call(methodId, scholar_id, proof1[2], proof2[2][2], proof3[2], proof4[1]);

        return success;
    }


    function parseAddr(string memory _a) public pure returns (address _parsedAddress) {
        // https://ethereum.stackexchange.com/questions/67436/a-solidity-0-5-x-function-to-convert-adress-string-to-ethereum-address
        bytes memory tmp = bytes(_a);
        uint160 iaddr = 0;
        uint160 b1;
        uint160 b2;
        for (uint i = 2; i < 2 + 2 * 20; i += 2) {
            iaddr *= 256;
            b1 = uint160(uint8(tmp[i]));
            b2 = uint160(uint8(tmp[i + 1]));
            if ((b1 >= 97) && (b1 <= 102)) {
                b1 -= 87;
            } else if ((b1 >= 65) && (b1 <= 70)) {
                b1 -= 55;
            } else if ((b1 >= 48) && (b1 <= 57)) {
                b1 -= 48;
            }
            if ((b2 >= 97) && (b2 <= 102)) {
                b2 -= 87;
            } else if ((b2 >= 65) && (b2 <= 70)) {
                b2 -= 55;
            } else if ((b2 >= 48) && (b2 <= 57)) {
                b2 -= 48;
            }
            iaddr += (b1 * 16 + b2);
        }
        return address(iaddr);
    }
}