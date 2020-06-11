pragma solidity ^0.5.0;

import "./IERC20.sol";
import "./ITwoStepTransferableToken.sol";
import "./IHoldable.sol";
import "./INativeHoldable.sol";

contract EmoneyToken is IERC20, ITwoStepTransferableToken, IHoldable, INativeHoldable {
    function isDefaultOperator(address _defaultOperator) external view returns (bool);

    function isTransferOperatorFor(address _operator, address _from) external view returns (bool);

    function authorizeTransferOperator(address _operator) external returns (bool);

    function revokeTransferOperator(address _operator) external returns (bool);

    function operatorSend(
        string calldata _operationId,
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool);

    event Burn(
        address indexed burner,
        uint256 value
    );

    event Mint(
        address indexed to,
        uint256 amount
    );
}
