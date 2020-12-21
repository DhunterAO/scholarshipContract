pragma solidity >=0.5.0;
pragma experimental ABIEncoderV2;

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

    // function get_scholar_list() public {
    //     return scholar_list;
    // }

    // 验证学生并发放对应的奖学金
    function auto_distribute(uint8 scholar_id, string[2] memory proof1, string[2][2] memory proof2, string[2] memory proof3, string[1] memory proof4, string memory receiver_string) public payable returns (bool) {
        // 验证零知识
        bool success = verify(scholar_id, proof1, proof2, proof3, proof4);
        require(success == true, "Proof is not correct!");
        

        address payable receiver = parseAddr(receiver_string);

        // 查询应发奖学金的数额
        uint256 amount = scholar_list[scholar_id].amount;
        
        // 发放奖学金给学生
        receiver.transfer(amount);
    }
    
    function verify(uint8 scholar_id, string[2] memory proof1, string[2][2] memory proof2, string[2] memory proof3, string[1] memory proof4) public returns (bool) {
        // index: 第几个奖学金
        // proof: 9个字符串形式uint256
        
        bytes4 methodId = bytes4(keccak256("verifyTx(uint256[2],uint256[2][2],uint256[2],uint256[1])"));
        address contract_address = scholar_list[scholar_id].addr;
        
        uint256[2] memory proof1_uint256;
        proof1_uint256[0] = stringToUint256(proof1[0]);
        proof1_uint256[1] = stringToUint256(proof1[1]);
        uint256[2][2] memory proof2_uint256;
        proof2_uint256[0][0] = stringToUint256(proof2[0][0]);
        proof2_uint256[0][1] = stringToUint256(proof2[0][1]);
        proof2_uint256[1][0] = stringToUint256(proof2[1][0]);
        proof2_uint256[1][1] = stringToUint256(proof2[1][1]);
        uint256[2] memory proof3_uint256;
        proof3_uint256[0] = stringToUint256(proof3[0]);
        proof3_uint256[1] = stringToUint256(proof3[1]);
        uint256[1] memory proof4_uint256;
        proof4_uint256[0] = stringToUint256(proof4[0]);
        

        (bool success, bytes memory returnData) = contract_address.call(methodId, scholar_id, proof1_uint256, proof2_uint256, proof3_uint256, proof4_uint256);

        return success;
    }


    function parseAddr(string memory _a) public pure returns (address payable _parsedAddress) {
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

    function stringToUint256(string memory s) public returns (uint256 result) {
        // https://ethereum.stackexchange.com/questions/62371/convert-a-string-to-a-uint256-with-error-handling
        bytes memory b = bytes(s);
        uint256 result = 0;
        bool success = false;
        uint256 tmp;
        for (uint256 i = 0; i < b.length; i++) { 
            tmp = uint256(uint8(b[i]));
            if (tmp >= 48 && tmp <= 57) {
                result = result * 10 + (tmp - 48); 
                success = true;
            } else {
                result = 0;
                success = false;
                break;
            }
        }
        return result;
    }
}