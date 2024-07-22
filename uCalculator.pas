unit uCalculator;

interface
uses
  System.SysUtils, System.Variants;

type
  TCalculator = class
    public
      memoryNum: Double;
      function CalculateAll(AStr : string): string;
      function CalculateFirstPrior(ANum: ShortInt; AStr : string): string;
      function CalculateSecondPrior(ANum: ShortInt; AStr : string): string;
  end;

implementation



function TCalculator.CalculateFirstPrior(ANum: ShortInt;AStr : string): string;
var
  I, J, iNumFirst, iNumSecond: ShortInt;
  firstNum, secondNum, answ: Double;
begin
  for I := 1 to ANum do
  begin
    for J := 1 to AStr.Length do
    begin
      if (AStr[J] = '*') or (AStr[J] = '/') then
      begin
        iNumFirst := J - 1;
        while not((iNumFirst = 1) or (AStr[iNumFirst -1 ] in ['+', '-', '*', '/'])) do
          iNumFirst := iNumFirst - 1;
        firstNum := StrToFloat(Copy(AStr, iNumFirst, J-iNumFirst));
        iNumSecond := J + 1;
        while not((iNumSecond = AStr.Length) or (AStr[iNumSecond + 1] in ['+', '-', '*', '/'])) do
          iNumSecond := iNumSecond + 1;
        secondNum := StrToFloat(Copy(AStr, J + 1, iNumSecond - J));
        if AStr[J] = '*' then
          answ := firstNum * secondNum
        else
        begin
          if (secondNum <> 0) then
            answ := firstNum / secondNum
          else
            begin
              Result := 'Невозможно деление на 0';
              exit;
            end;
        end;
        AStr := Copy(AStr, 1, iNumFirst-1) + FloatToStr(answ) + Copy(AStr, iNumSecond + 1);
        break;
      end;
    end;
  end;
  Result := AStr;
end;

function TCalculator.CalculateSecondPrior(ANum: ShortInt;AStr : string): string;
var
  I, J, iNumSecond: ShortInt;
  firstNum, secondNum, answ: Double;
begin
  for I := 1 to ANum do
  begin
    for J := 1 to AStr.Length do
    begin
      if (AStr[J] = '+') or (AStr[J] = '-') then
      begin
        iNumSecond := J + 1;
        firstNum := StrToFloat(Copy(AStr, 1, J - 1));
        while not((iNumSecond = AStr.Length) or (AStr[iNumSecond + 1] in ['+', '-'])) do
          iNumSecond := iNumSecond + 1;
        secondNum := StrToFloat(Copy(AStr, J + 1, iNumSecond - J));
        if AStr[J] = '+' then
          answ := firstNum + secondNum
        else
          answ := firstNum - secondNum;
        AStr := FloatToStr(answ) + Copy(AStr, iNumSecond + 1);
        break;
      end;
    end;
  end;
  Result := AStr;
end;

function TCalculator.CalculateAll(AStr : string): string;
var
  I, J, iNumFirst, iNumSecond, numAct, numFirstAct: ShortInt;
  firstNum, secondNum, answ: Double;
  actFirst, actSecond: Char;
begin
   numAct := 0;
  numFirstAct := 0;
  firstNum := 0;
  iNumFirst := 1;
  for I := 1 to AStr.Length do
  begin
    if (AStr[I] in ['+', '-']) then
      numAct := numAct + 1;
    if (AStr[I] in ['*', '/']) then
      numFirstAct := numFirstAct + 1;
  end;
  if AStr[AStr.Length] in ['*','/','-','+'] then
  begin
    Result := 'Некорректная запись';
    exit;
  end;
  AStr := CalculateFirstPrior(numFirstAct, AStr);
  if AStr <> 'Невозможно деление на 0' then
    AStr := CalculateSecondPrior(numAct, AStr);
  Result := AStr;
end;

end.
