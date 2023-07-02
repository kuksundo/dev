object frmActions: TfrmActions
  Left = 914
  Top = 579
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Thundax Macro Actions v1.1'
  ClientHeight = 329
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000040000130B0000130B00000000000000000000FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF000000000000000000B35A611AB35A618A0000000000000000000000000000
    00000000000000000000B35A618CB35A611E000000000000000000000000FFFF
    FF0000000000B35A6152B35A61EDB35A61460000000000000000000000000000
    00000000000000000000B35A613FB35A61EBB35A615F0000000000000000FFFF
    FF00B35A6134B35A61FBB35A6192000000000000000000000000000000000000
    0000000000000000000000000000B35A617BB35A61FEB35A614700000000FFFF
    FF00B35A61AEB35A61FFB35A61480000000000000000000000000000006E0000
    0037000000140000000000000000B35A612BB35A61FFB35A61C900000000FFFF
    FF00B35A61ECB35A61FFB35A6129000000000000000000000000000000FF0000
    00A90000005E0000001400000000B35A610AB35A61FFB35A61FEB35A610BFFFF
    FF00B35A61FCB35A61FFA44B5126000000FF000000FF000000FF000000FF0000
    00E2000000C8000000A000000037B35A6102B35A61FFB35A61FFB35A611AFFFF
    FF00B35A61E4B35A61FFB35A612C000000000000000000000000000000FF0000
    00BE000000480000001400000000B35A610EB35A61FFB35A61FAB35A6107FFFF
    FF00B35A619AB35A61FFB35A61520000000000000000000000000000006E0000
    0038000000140000000000000000B35A6136B35A61FFB35A61B600000000FFFF
    FF00B35A611CB35A61EBB35A61AA000000000000000000000000000000000000
    0000000000000000000000000000B35A6194B35A61F2B35A612B00000000FFFF
    FF0000000000B35A612AB35A61D3B35A61770000000000000000000000000000
    00000000000000000000B35A6170B35A61D7B35A61330000000000000000FFFF
    FF000000000000000000B35A6104B35A61590000000000000000000000000000
    00000000000000000000B35A615BB35A6104000000000000000000000000FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    0000FFFF0000FFFF0000E7E70000C7E300008FF100008E3100008E1000008000
    00008E1000008E3100008FF10000C7E30000E7E70000FFFF0000FFFF0000}
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 386
    Top = 52
    Width = 39
    Height = 13
    Caption = 'Actions:'
  end
  object btnSequence: TSpeedButton
    Left = 8
    Top = 8
    Width = 105
    Height = 33
    Caption = 'Play sequence'
    Glyph.Data = {
      F6060000424DF606000000000000360000002800000018000000180000000100
      180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0D6D5D5CAC6C6C9C6
      C6D6D5D5EDEDEDFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9BFB4B2A6776AB65F42
      D26234DB6733D96533C85C33A85D469C7770BDB9B9F4F4F4FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0CAC9B3614BE9
      6830FE9D55FFC372FFDD86FFE990FFE38BFFD07CFFB165FA8542D154279A6559
      CBCACAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB79D
      97DB5326FB8E4AF5B96BF7CF7CFADF89FCEE95FEF79CFDF198FAE38CF8D480F4
      C172F6A65DF77436B74829B0A9A8FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFB5928AEE5621F18D4AF0AB60F5BC6BF8CC76FBDB83FCE68DFCEC91FCE8
      8EFBDE85F8D07AF5C16EF2B163EE9D56F67839C64420ACA2A1FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFC4B3AFE94C1CEC7D3FED974FF1A959E5AF5FD6B065E2BF67
      FADC7EFEE385FCE083FAD97CF9CE73F7C068F3B05DEF9E52EA8A46F2682DBF42
      22C3C1C1FFFFFFFFFFFFFFFFFFEEEDEDCF502EEC662CE9813EEF9548EDA34EEF
      D8B7F2EDE0D0BF96CCAF61E9C766FDD976FDD473FACA6AF8BE60F5AF57F19E4B
      EC8941E67235F2521E9E5C4DF0F0F0FFFFFFFFFFFFBD978FEF4B18E4682DEA7F
      37F19441ECA148F8E9D2FFFFF8FFFFF8ECE5D2CDB983CEAA50EFC259FEC860FB
      BD58F6AE4EF29D44ED893AE7712FE55A23DA390FB5ACABFFFFFFFCFCFCCB5335
      E7501CE56626EB7D30F19239EE9F40F8E6CCFFFBF2FFF9ECFFFEF3FFFEF6E2D8
      BBCAAD68D7A43DF4B346FAAE46F59C3CEE8733E87028E25A20ED47159E6E64FE
      FEFEE0DBDAE04117E2541DE66420EC7A27F28F2FEF9C37F8E6CAFFFBF1FFF9EB
      FFF9ECFFF9ECFFFFF5FBF7ECDECDA9C79949DA9029F1942DF2862AE96E21E35C
      1DE84F1BBC462AE5E5E5CCABA5E94515E1581EE7661DEC761FF38A25F0982CF9
      E5C7FFFAF0FFF8EAFFF8EAFFF8EAFFF8EAFFF9ECFFFEF5F8F1E3D7BA91C47E31
      D76D12EA6E1DE5601DE5531DCE3F17CECBCBC3887BEA4A17E25A1EE8681DED75
      1CF4861DF19321F9E4C4FFFAEFFFF7E9FFF7E9FFF7E9FFF7E9FFF7E9FFF7E8FF
      F9EBFFFEF4F3E7D9CB986BD56418E7631DE4561ED63C12C3BEBDBF7B6CEA4918
      E25B1EE8681DED761CF4841BF18E1AF9E2C1FFF9EEFFF6E7FFF6E7FFF6E8FFF6
      E7FFF6E7FFF6E7FFF5E6FFF5E6FFFFFAF3E6D8D4681FE7621BE3561FD93C11C2
      BCBBC9958AEA4A1AE35D24E86B23ED751CF3821AF08C19F9E1C0FFF9EDFFF5E6
      FFF5E6FFF5E6FFF5E6FFF5E6FFF5E6FFFAEFFEF8EEF0D0AFE0873DE76E1CE768
      27E55B26D53F17CDC9C9DCC1BCE6491CE46734E97433ED7E2FF2811EEE8717F8
      E0C0FFF9EDFFF5E6FFF5E6FFF5E6FFF5E6FFF8ECFFFBF3F4DBB8E8A555E77B0F
      EE7C1FED7D36E77138E96536CC4622E3E2E2F4ECEBDD4D27E77044E97A42ED86
      43F28F3FED8929F7DDC0FFF8EDFFF5E6FFF5E6FFF7E9FFFCF4F8E9D1EAB25FEC
      8D13F38812F59135F08E46EC8346E87A49EF6639B55943FFFFFFFFFFFFD16951
      EB6E44E98355ED8A52F19452EE9950F8E3CDFFF8EEFFF6E8FFFAF0FBEFDCECC1
      82EC9C2BF59519FAA03CF7A14FF39C56F09255EC8855E9835AF1592DB69C97FF
      FFFFFFFFFFDAC1BDEC5429EA8B66ED9062F09761EE9D60F9E8D9FFFFFCFCF5EC
      F3D7B7EEB26BF4A94DFBB059FAB163F7AC66F4A665F29E64EE9765EC9169F082
      5CCB4D2CEBEAEAFFFFFFFFFFFFFFFFFFCF735EEF7852ED9B79EF9C72F0A06FF5
      C7A8F6D9C2EDB98BF1AB68F9B370F9B675F8B374F6B073F4AC73F3A774F1A274
      EE9D77EE9878EF562CBCA39EFFFFFFFFFFFFFFFFFFFFFFFFF0E9E8E5603FEE8C
      6BEFA789F1A783F1A77CF1A97AF4AF7DF6B582F6B582F6B582F5B482F4B283F3
      AF84F1AA84F0A987F0A78AF56B43B57464FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFEADCD9E26242F18C6CF1B197F2B396F3B292F4B592F4B692F4B792F4B7
      92F4B692F3B492F2B395F2B69CF3AA90F76F49B77A6BFDFDFDFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFF8EEECD37B67EC7857F3A88FF4BCA6F4C0A9
      F4BFA7F4BFA6F4BFA7F4C0A9F4C0AAF5B8A2F9987AE66340BC9890FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDE8C0B8DF
      7860E67658F18F71F2AF98F2B5A1F2B4A0F2A68EEF7F5FE17155C28071E0DBDA
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFEFEEFE3E1DDAAA0EB836EE97D63EA7C64E48C7ADABDB8F5
      F1F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnClick = btnSequenceClick
  end
  object Label4: TLabel
    Left = 181
    Top = 18
    Width = 49
    Height = 13
    Caption = 'iterations:'
  end
  object btnDelete: TSpeedButton
    Left = 281
    Top = 47
    Width = 23
    Height = 22
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F90E50022CCBFC8F2FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFBFC8F20022CC7F90E5FFFFFFFFFFFFFFFFFF8192E6
      0325CE3355FF0325CEC0C8F3FFFFFFFFFFFFFFFFFFFFFFFFC0C8F30325CE3355
      FF0325CE8192E6FFFFFFFFFFFF0729D288AAFF385AFF385AFF0729D2C1C9F4FF
      FFFFFFFFFFC1C9F40729D2385AFF385AFF88AAFF0729D2FFFFFFFFFFFFC2CBF4
      0C2ED588AAFF3E60FF3E60FF0C2ED5C2CBF4C2CBF40C2ED53E60FF3E60FF88AA
      FF0C2ED5C2CBF4FFFFFFFFFFFFFFFFFFC4CCF61234DA88AAFF4668FF4668FF12
      34DA1234DA4668FF4668FF88AAFF1234DAC4CCF6FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFC5CEF7183ADE88AAFF4F71FF4F71FF4F71FF4F71FF88AAFF183ADEC5CE
      F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7CFF81F41E37193FF59
      7BFF597BFF7193FF1F41E3C7CFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFC8D1F92547E86284FF6284FF6284FF6284FF2547E8C8D1F9FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCAD3FA2C4EED6C8EFF6C8EFF88
      AAFF88AAFF6C8EFF6C8EFF2C4EEDCAD3FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      CCD4FB3254F17597FF7597FF88AAFF3254F13254F188AAFF7597FF7597FF3254
      F1CCD4FBFFFFFFFFFFFFFFFFFFCDD6FD385AF67D9FFF7D9FFF88AAFF385AF6CD
      D6FDCDD6FD385AF688AAFF7D9FFF7D9FFF385AF6CDD6FDFFFFFFFFFFFF3D5FF9
      88AAFF83A5FF88AAFF3D5FF9CED7FDFFFFFFFFFFFFCED7FD3D5FF988AAFF83A5
      FF88AAFF3D5FF9FFFFFFFFFFFFA0B1FE4163FD88AAFF4163FDCFD8FEFFFFFFFF
      FFFFFFFFFFFFFFFFCFD8FE4163FD88AAFF4163FDA0B1FEFFFFFFFFFFFFFFFFFF
      A1B2FF4466FFD0D9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0D9FF4466
      FFA1B2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnClick = btnDeleteClick
  end
  object btnUp: TSpeedButton
    Left = 281
    Top = 68
    Width = 23
    Height = 22
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      EEEEEEE3E3E3D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1E9E9E9F0F0
      F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF34A07134A07134A07134
      A07134A07134A07134A071FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF32A1723DD7A83DD7A83DD7A83DD7A83DD7A832A173FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF30A47410C19010C09010
      C19010C19010C19030A474FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF2EA7760FC3920DCE9A0DCE990DCE990FC3922EA776FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2BA9790FC7950DD09C0D
      D09B0DD19C0FC8952BA978FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF28AD7B0FCD9A0ED39E0DD39E0DD39E0FCC9A28AC7BFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF24B07D0DD29E0ED6A10E
      D5A10ED5A10ED29F25B07EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF22B38021B380
      22B38022B38021B3800FD8A30ED8A30ED7A40ED8A30ED7A322B38022B38022B3
      8021B38021B380FFFFFFCAF2E61EB78330E2B32CE1B12CE1B10EDBA60FDAA60E
      DAA60FDAA60FDAA62BE1B12CE1B130E2B31EB783CAF2E6FFFFFFFFFFFFCAF2E6
      1BB9853BE7B90EDDA80FDCA80FDDA90FDDA90FDDA90FDCA90FDDA93BE7B91BB9
      85CAF2E6FFFFFFFFFFFFFFFFFFFFFFFFCAF2E618BD8855EDC40FE0AB0FDFAB0F
      E0AB0FDFAB0FE0AB55EDC418BD88CAF2E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFCAF2E615C08A78F5D10FE2AD0FE2AD10E1AD78F5D115C08ACAF2E6FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCAF2E612C28C85F7D50F
      E3AF85F7D513C28CCAF2E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFCAF2E611C48EFFFFFF11C48ECAF2E6FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCAF2E60F
      C68FCAF2E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnClick = btnUpClick
  end
  object btnDown: TSpeedButton
    Left = 281
    Top = 89
    Width = 23
    Height = 22
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCAF2E60FC68FCAF2E6FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCAF2E611
      C48EFFFFFF11C48ECAF2E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFCAF2E613C28C85F7D50FE3AF85F7D512C28CCAF2E6FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCAF2E615C08A78F5D110
      E1AD0FE2AD0FE2AD78F5D115C08ACAF2E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFCAF2E618BD8855EDC40FE0AB0FDFAB0FE0AB0FDFAB0FE0AB55EDC418BD
      88CAF2E6FFFFFFFFFFFFFFFFFFFFFFFFCAF2E61BB9853BE7B90FDDA90FDCA90F
      DDA90FDDA90FDDA90FDCA80EDDA83BE7B91BB985CAF2E6FFFFFFFFFFFFCAF2E6
      1EB78330E2B32CE1B12BE1B10FDAA60FDAA60EDAA60FDAA60EDBA62CE1B12CE1
      B130E2B31EB783CAF2E6FFFFFF21B38021B38022B38022B38022B3800ED7A30E
      D8A30ED7A40ED8A30FD8A321B38022B38022B38021B38022B380FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF25B07E0ED29F0ED5A10ED5A10ED6A10DD29E24B07DFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF28AC7B0FCC9A0D
      D39E0DD39E0ED39E0FCD9A28AD7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF2BA9780FC8950DD19C0DD09B0DD09C0FC7952BA979FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2EA7760FC3920D
      CE990DCE990DCE9A0FC3922EA776FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF30A47410C19010C19010C19010C09010C19030A474FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF32A1733DD7A83D
      D7A83DD7A83DD7A83DD7A832A172FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF34A07134A07134A07134A07134A07134A07134A071FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0E9E9E9D1D1D1D1D1D1D1
      D1D1D1D1D1D1D1D1D1D1D1D1D1D1E3E3E3EEEEEEFFFFFFFFFFFF}
    OnClick = btnDownClick
  end
  object Label7: TLabel
    Left = 448
    Top = 18
    Width = 145
    Height = 13
    Alignment = taRightJustify
    Caption = 'Mouse Position (x,y) (0,0)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 311
    Top = 18
    Width = 89
    Height = 13
    Caption = '0 will loop infinitely'
  end
  object btnStop: TSpeedButton
    Left = 112
    Top = 8
    Width = 63
    Height = 33
    Caption = 'Stop'
    Glyph.Data = {
      06080000424D060800000000000036000000280000001A000000190000000100
      180000000000D0070000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFDFDFDFFFFFCFFFFFFE6E6F87575E61212DD0000D30000
      D00000D00000D31212DD7575E7E5E5F8FFFFFFFFFFFDFDFDFDFEFEFEFFFFFFFF
      FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9FC24
      24DC0000C40000BD0505B20909B30909B20909B20909B30505B20000BD0000C4
      2525DCE9E9FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF7474E70000C60303B70909AD0808B90A0AD30A0AD90B0B
      E10B0BE10A0AD90A0AD30808B90909AD0303B70000C67474E7FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF2C2CDB0000C10808B00B
      0BD40E0EFF0F0FFF0F0FFF0E0EFF0E0EFF0E0EFF0E0EFF0F0FFF0F0FFF0E0EFF
      0B0BD40808B00000C02C2CDAFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
      FFFFFF5454E00000BB0A0AC41515FF1313FF1515FF0707FB1414FF1313FC1313
      FC1313FC1313FC1414FE0707FD1515FF1313FF1515FF0A0AC40000BB5454E0FF
      FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFB9B9F10000BB0F0FD31A1AFF1717F91B
      1BFF0000DB7A7AC30000EC1919FD1717F91717F91919FE0000ED7878C20000DD
      1B1BFF1717F91A1AFF0F0FD30000BBB9B9F0FFFFFFFFFFFF0000FFFFFFFFFFFF
      0000C60C0CD02020FF1C1CF82121FF0000D9DBDBE9FFFFFF9393D30000EC1E1E
      FC1E1EFC0000EB9090D2FFFFFFDBDBE70000D82121FF1C1CF82020FF0C0CD000
      00C6FFFFFFFFFFFF0000FFFFFF9494E70000BF2626FF2020F62222FB0000DDDB
      DBECFFFFFFFFFFFFFFFFFF9393D70000EC0000EC8E8ED5FFFFFFFFFFFFFFFFFF
      DADAE90000DC2323FB2020F62626FF0000BF9494E7FFFFFF0000FFFFFF1C1CCB
      1414E12222F92323F62424F57373D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F
      DB7878DAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6ECB1B1BF62626F62828F914
      14E11C1CCBFFFFFF0000FFFFFF0000B62626F94A4AF65D5DF65A5AF82D2DEB8A
      8AE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      8787DA0909EB2B2BF62A2AF32828F32626F90000B6FFFFFF0000B9B9EF0000BE
      5D5DFE6464F56060F65F5FF66565F93434EB8888E2FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF8686DD0909E93131F62E2EF32E2EF33131F36F
      6FFF0000BEB9B9EF00008D8DE50000C77E7EFC6969F46A6AF46A6AF46A6AF470
      70F74242EC7A7AE5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7575E20E0EEA
      3434F33232F03131F02525EF6565F37D7DFB0000C88D8DE500008282E10000C4
      8A8AFC7575F47676F47676F47676F47D7DF55252EF6C6CE6FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF7F7FE51F1FE84040F23535EF4242F17070F47777F588
      88FC0000C58282E100009696E50000C28B8BF47F7FF37F7FF37F7FF38686F458
      58EE7575EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8888E8
      5D5DEC9292F68686F48080F37F7FF38E8EF50000C39696E50000C9C9F10000C1
      6565E79191F78989F38F8FF46666EF7272EDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8181EA6161EC8E8EF48888F39090F76A
      6AE70000C0C9C9F10000FFFFFF0000B62525DA9B9BF39696F49090F34D4DEBFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF6969EE7070EFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF5353E78D8DF29696F49999F32F2FDC0000B6FFFFFF0000FFFFFF4444C9
      0000D38686EA9F9FF4A9A9F54F4FEBC3C3F8FFFFFFFFFFFFFFFFFF7070EE7676
      EF7575EF7474F0FFFFFFFFFFFFFFFFFFC4C4F84C4CEAA9A9F69F9FF48B8BEA00
      00D44444C9FFFFFF0000FFFFFFB8B8EC0000C03B3BE38D8DECA3A3F3BBBBF64B
      4BE9C2C2F8FFFFFF6F6FF07979EEAEAEF5AEAEF47979EF7171F0FFFFFFC3C3F8
      4848EABDBDF6A3A3F38C8CEC3E3EE30000C0B8B8ECFFFFFF0000FFFFFFFFFFFF
      1B1BBB0000D98D8DED8989EB9999F0C5C5F66262EB4646EB8787EEB8B8F5AEAE
      F4AEAEF4B8B8F48686EE4747EC5D5DEAC6C6F69898F08888EC8D8DED0000D91B
      1BBBFFFFFFFFFFFF0000FFFFFFFFFFFFEAEAF90000AE0000E1AFAFF29595EF8E
      8EEFABABF2A9A9F1BDBDF4BDBDF4BCBCF3BCBCF3BDBDF4BEBEF4A7A7F1ACACF2
      8D8DEE9595EFAFAFF20000E20000AEEAEAF9FFFFFFFFFFFF0000FFFFFFFFFFFF
      FFFFFFC3C3EA0000B40909E6B9B9F5A7A7F39D9DF29E9EF29B9BF19898F19C9C
      F29C9CF29898F19B9BF19E9EF29D9DF2A5A5F3B9B9F50C0CE60000B4C3C3EAFF
      FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFAAAAE20000AD0000E492
      92F2BEBEF5A8A8F2A3A3F2A4A4F2A4A4F2A4A4F2A4A4F2A3A3F2A7A7F2BBBBF4
      9A9AF40000E40000ADAAAAE2FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFDDDDF40000AA0000CB2828EE8A8AF4C4C4F8B9B9F6B4B4
      F5B3B3F5B7B7F5C4C4F99B9BF63232EF0000CB0000AADDDDF4FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87
      87D70000AC0000BF0000D71919E82E2EF03737F02121E90000D90000BF0000AC
      8787D7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFF06F6FCF3737BF1616
      B61616B63636BF6E6ECECFCFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF0000}
    OnClick = btnStopClick
  end
  object Label11: TLabel
    Left = 306
    Top = 117
    Width = 69
    Height = 13
    Caption = 'Custom Desc: '
  end
  object Label13: TLabel
    Left = 305
    Top = 90
    Width = 75
    Height = 13
    Caption = 'Execute Mode: '
  end
  object btnAddAction: TButton
    Left = 305
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Add Action'
    Enabled = False
    TabOrder = 0
    OnClick = btnAddActionClick
  end
  object ActionTypeCombo: TComboBox
    Left = 431
    Top = 49
    Width = 163
    Height = 21
    Style = csDropDownList
    ImeName = 'Microsoft IME 2010'
    TabOrder = 1
    OnChange = ActionTypeComboChange
    Items.Strings = (
      '')
  end
  object PageControl1: TPageControl
    Left = 304
    Top = 151
    Width = 289
    Height = 131
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Mouse Position'
      object Label2: TLabel
        Left = 16
        Top = 4
        Width = 10
        Height = 13
        Caption = 'x:'
      end
      object Label3: TLabel
        Left = 95
        Top = 4
        Width = 10
        Height = 13
        Caption = 'y:'
      end
      object Label12: TLabel
        Left = -2
        Top = 58
        Width = 280
        Height = 13
        Alignment = taRightJustify
        Caption = 'Focus X edit and [Ctrl + C] to copy mouse position'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtX: TEdit
        Left = 16
        Top = 23
        Width = 73
        Height = 21
        Hint = 'Ctrl + C : Capture mouse coordinate'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 0
        OnKeyDown = edtXKeyDown
      end
      object edtY: TEdit
        Left = 95
        Top = 23
        Width = 66
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Key strokes'
      ImageIndex = 1
      object Label5: TLabel
        Left = 4
        Top = 19
        Width = 40
        Height = 13
        Caption = 'Strokes:'
      end
      object Label6: TLabel
        Left = 4
        Top = 46
        Width = 51
        Height = 13
        Caption = 'Free Text:'
      end
      object Label10: TLabel
        Left = 3
        Top = 73
        Width = 54
        Height = 13
        Caption = 'Grid Index:'
      end
      object cmbStrokes: TComboBox
        Left = 72
        Top = 16
        Width = 145
        Height = 21
        Style = csDropDownList
        ImeName = 'Microsoft IME 2010'
        TabOrder = 0
        Items.Strings = (
          'TAB'
          'CLEAR'
          'RETURN'
          'SHIFT'
          'CONTROL'
          'ESCAPE'
          'SPACE'
          'LEFT'
          'UP'
          'RIGHT'
          'DOWN'
          'INSERT'
          'DELETE'
          'F1'
          'F2'
          'F3'
          'F4'
          'F5'
          'F6'
          'F7'
          'F8'
          'F9'
          'F10'
          'F11'
          'F12')
      end
      object edtFreeText: TEdit
        Left = 72
        Top = 43
        Width = 145
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 1
      end
      object edtIndex: TEdit
        Left = 72
        Top = 70
        Width = 41
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Waiting'
      ImageIndex = 2
      object Label8: TLabel
        Left = 5
        Top = 27
        Width = 62
        Height = 13
        Caption = 'Time (mSec):'
      end
      object edtTime: TSpinEdit
        Left = 70
        Top = 24
        Width = 121
        Height = 22
        MaxValue = 9999
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
    end
  end
  object Edit3: TEdit
    Left = 236
    Top = 15
    Width = 69
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 3
    Text = '1'
  end
  object ActionEditLB: TListBox
    Left = 8
    Top = 47
    Width = 272
    Height = 235
    Style = lbOwnerDrawFixed
    ImeName = 'Microsoft IME 2010'
    MultiSelect = True
    TabOrder = 4
    OnDblClick = ActionEditLBDblClick
    OnDrawItem = ActionEditLBDrawItem
  end
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 610
    Height = 41
    Align = alBottom
    TabOrder = 5
    object BitBtn1: TBitBtn
      Left = 112
      Top = 2
      Width = 75
      Height = 39
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 350
      Top = 1
      Width = 75
      Height = 39
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object CustomDescEdit: TEdit
    Left = 378
    Top = 114
    Width = 211
    Height = 21
    ImeName = 'Microsoft IME 2010'
    TabOrder = 6
  end
  object ExecModeRG: TRadioGroup
    Left = 378
    Top = 76
    Width = 215
    Height = 33
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Event'
      'Driver'
      'Hardware')
    TabOrder = 7
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 122
    Top = 104
  end
  object MainMenu1: TMainMenu
    Left = 168
    Top = 104
    object File1: TMenuItem
      Caption = 'File'
      object Load1: TMenuItem
        Caption = 'Load'
      end
      object Save1: TMenuItem
        Caption = 'Save'
      end
    end
  end
end
