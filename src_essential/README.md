# 修复后的源文件

这个目录包含了已修复的关键源文件。

## 修复内容

### 1. `libs/UtilitiesLib/stdtypes.h`

**问题**: `log2` 函数与Windows SDK冲突

**修复**:
```c
// 重命名为 ilog2，添加兼容性宏
__forceinline static int ilog2(int val) { ... }
#define log2 ilog2
```

### 2. `libs/UtilitiesLib/utils/mathutil.h`

**问题**: `round` 函数与Windows SDK冲突

**修复**:
```c
// 重命名为 iround，添加兼容性宏
__forceinline static int iround(float a) { ... }
#define round iround
```

## 如何使用

将这些文件复制到对应的完整源码树位置：

```batch
copy src_essential\libs\UtilitiesLib\stdtypes.h I:\Night\Night\src\libs\UtilitiesLib\
copy src_essential\libs\UtilitiesLib\utils\mathutil.h I:\Night\Night\src\libs\UtilitiesLib\utils\
```

然后重新编译即可。

