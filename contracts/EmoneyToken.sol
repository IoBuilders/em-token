pragma solidity ^0.5.0;

import "./IERC20.sol";
import "./ITwoStepTransferableToken.sol";
import "./IHoldable.sol";
import "./INativeHoldable.sol";

contract EmoneyToken is IERC20, ITwoStepTransferableToken, IHoldable, INativeHoldable {
    function isTransferOperatorFor(address _operator, address _from) external view returns (bool);

    function authorizeTransferOperator(address _operator) external returns (bool);

    function revokeTransferOperator(address _operator) external returns (bool);

    function operatorSend(
        string calldata _operationId,
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool);
}
