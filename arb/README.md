# 国际化文件说明

## 文件结构
- `intl_en.arb` - 英文翻译文件（模板文件）
- `intl_zh_CN.arb` - 简体中文翻译文件
- `intl_ja.arb` - 日语翻译文件
- `intl_ru.arb` - 俄语翻译文件

## 修改后生成语言文件

修改任何 `.arb` 文件后，需要执行以下命令来生成对应的 Dart 语言文件：

```bash
# 1. 如果是第一次使用，需要先激活 intl_utils 工具
dart pub global activate intl_utils

# 2. 生成语言文件
dart pub global run intl_utils:generate
```

生成的文件将位于 `lib/l10n/intl/` 目录中。

## 注意事项
- 英文文件 `intl_en.arb` 是模板文件，其他语言文件应该包含相同的 key
- 添加新的翻译条目时，请确保所有语言文件都包含对应的翻译
- 生成后的文件不要手动修改，它们会在下次生成时被覆盖