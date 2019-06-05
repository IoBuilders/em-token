pragma solidity ^0.5.0;

import "./IERC20.sol";
import "./ITwoStepTransferableToken.sol";

contract EmoneyToken is IERC20, ITwoStepTransferableToken, IHoldableToken {

}
