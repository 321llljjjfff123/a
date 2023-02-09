// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
contract Array {
    
    //局部变量内存中只能定义定长数组，动态数组只能存在于状态变量中

    uint[] public nums = [1, 2, 3]; //动态数组，并赋了初始值
    uint[3] public numsFixeed = [4, 5, 6]; //定长数组，并赋了初始值

    function examples() external {
        nums.push(4); //push()向数组尾部推入数字（动态数组可以，定长数组不可以）

        delete nums[1]; //[1, 0, 3, 4] 将对应索引位置的值修改为默认值（uint默认值为0），不会修改数组的长度
                
        nums.pop(); //弹出数组末尾的数组元素[1, 0, 3]

        uint len = nums.length; //获取数组的长度

        //在内存中创建数组
        //局部变量
        //memory定义位置 
        //new一个数组（需写上长度，内存中无法创建动态数组）
        //在内存中定义了一个名称为a的数组
        //因为a是定义在内存中，所以无法使用改变长度的方法，如pop，push，只能根据索引修改值
        uint[] memory a = new uint[](5);
    }

    function returnArray() external view returns (uint[] memory) { //返回一个数组，是内存的存储类型
    //memory返回整个数组时使用
        return nums;
    }


    //定义一个动态数组
    uint[] public arr;
    //删除数组中的元素
    //采用循环删除，将后一个赋给前一个,pop数组末尾，若数组很长十分消耗gas
    //[1, 2, 3] [1, 3, 3] [1, 3] 
    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound");
        for(uint i = _index; i < arr.length - 1; i++)
            arr[i] = arr[i+1];
        arr.pop();
    }

    //测试remove
    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        assert(arr.length == 4);
        assert(arr[3] == 5);

    arr = [1];
    remove(0);
    // [] 只有一个元素时，remove后数组为空，长度为0
    assert(arr.length == 0);
    }






    //删除数组元素
    //优点：节约gas费用 缺点：打乱了原有数组顺序
    //2 [1, 2, 3， 4， 5] [1, 2, 5， 4， 5] [1, 2, 5, 4] 
    function remove2(uint _index) public {
        require(_index < arr.length, "index out of bound");
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test2() external {
        arr = [1, 2, 3, 4, 5];
        remove2(2);
        assert(arr[2] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);
        // [] 只有一个元素时，remove后数组为空，长度为0
        assert(arr.length == 0);
    }
}