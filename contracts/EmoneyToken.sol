pragma solidity ^0.5.0;

import "./IERC20.sol";
import "./ITwoStepTransferableToken.sol";
import "./IHoldable.sol";

contract EmoneyToken is IERC20, ITwoStepTransferableToken, IHoldable {

}