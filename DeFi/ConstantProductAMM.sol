pragma solidity 0.8.13;

contract CPAMM {

    IERC20 public immutable token0;
    IERC20 public immutable token1;

    uint public reserve0;
    uint public reserve1;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token0, address _token1) {

        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    function _mint(address _to, uint _amount) private {

        totalSupply += _amount;

        balanceOf[_to] += _amount;
    }

    function _burn(address _from, uint _amount) private {

        totalSupply -= _amount;

        balanceOf[_from] -= _amount;
    }

    function _update(uint _res0, uint _res1) private {

        reserve0 = _res0;

        reserve1 = _res1;
    }

    function swap(address _tokenIn, uint _amountIn) external returns (uint amountOut) {

        require(_tokenIn == address(token0) || _tokenIn == address(token1));

        bool isToken0 = _tokenIn == address(token0);

        (IERC20 tokenIn, IERC20 tokenOut, uint resIn, uint resOut) = isToken0
            ? (token0, token1, reserve0, reserve1)
            : (token1, token0, reserve1, reserve0);

        tokenIn.transferFrom(msg.sender, address(this), _amountIn);

        uint amountIn = tokenIn.balanceOf(address(this)) - resIn;

        uint amountInWithFee = (amountIn * 997) / 1000;

        amountOut = (resOut * amountInWithFee) / (resIn + amountInWithFee);

        (uint res0, uint res1) = isToken0
            ? (resIn + amountIn, resOut - amountOut)
            : (resOut - amountOut, resIn + amountIn);

        _update(res0, res1);

        tokenOut.transfer(msg.sender, amountOut);
    }

    function addLiquidity(uint _amount0, uint _amount1) external returns (uint shares) {

        token0.transferFrom(msg.sender, address(this), _amount0);
        token1.transferFrom(msg.sender, address(this), _amount1);

        uint bal0 = token0.balanceOf(address(this));
        uint bal1 = token1.balanceOf(address(this));

        uint d0 = bal0 - reserve0;
        uint d1 = bal1 - reserve1;

        if (reserve0 > 0 || reserve1 > 0) {

            require(reserve0 * d1 == reserve1 * d0);
        }

        if (totalSupply > 0) {

            shares = _min((d0 * totalSupply) / reserve0, (d1 * totalSupply) / reserve1);

        } else {

            shares = _sqrt(d0 * d1);
        }

        require(shares > 0);

        _mint(msg.sender, shares);

        _update(bal0, bal1);
    }

    function removeLiquidity(uint _shares) external returns (uint d0, uint d1) {

        d0 = (reserve0 * _shares) / totalSupply;
        d1 = (reserve1 * _shares) / totalSupply;

        _burn(msg.sender, _shares);

        _update(reserve0 - d0, reserve1 - d1);

        if (d0 > 0) {

            token0.transfer(msg.sender, d0);
        }

        if (d1 > 0) {

            token1.transfer(msg.sender, d1);
        }
    }

    function _sqrt(uint y) private pure returns (uint z) {

        if (y > 3) {
 
            z = y;

            uint x = y / 2 + 1;

            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }   

        } else if (y != 0) {

            z = 1;
        }
    }

    function _min(uint x, uint y) private pure returns (uint) {

        return x <= y ? x : y;
    }

}

interface IERC20 {

    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    
    event Approval(address indexed owner, address indexed spender, uint amount);

}
