unit UnitArrayUtil;

interface

type
{Usage:
var
  data: JHDataArray<string>;
begin
  data.Append('Alpha');
  data.Append('Beta');
  Caption := IntToStr(data.Count) + ': ' data.Data[0] + ' & ' + data.Data[1];
end;
}
  JHDataArray<T> = record
    Data: array of T;
    procedure Append(const Value: T);
    function Count: integer;
  end;

{Usage:
var
  TestArray: TArray<Integer>;
begin
  TAppender<Integer>.Append(TestArray, 5);
end.
}
  TAryHelper<T> = class
    class procedure Append(var Arr: TArray<T>; const Value: T);
    class procedure Delete(var Arr: TArray<T>; const Index: Cardinal; Count: Cardinal = 1);
    class procedure Insert(var Arr: TArray<T>; Index: Integer; const Value: T);
    class procedure Grow(var Arr: TArray<T>); inline;
    class procedure Trunc(var Arr: TArray<T>); inline;
    class procedure Add(var Arr: TArray<T>; const ArrToAdd: TArray<T>);
    class function First(const Arr: TArray<T>): T; inline;
    class function Last(const Arr: TArray<T>): T; inline;
  end;

implementation

{ DataArray<T> }

procedure JHDataArray<T>.Append(const Value: T);
begin
  SetLength(Data, length(Data) + 1);
  Data[high(Data)] := Value;
end;

function JHDataArray<T>.Count: integer;
begin
  result := length(Data);
end;

class procedure TAryHelper<T>.Add(var Arr: TArray<T>;
  const ArrToAdd: TArray<T>);
begin

end;

class procedure TAryHelper<T>.Append(var Arr: TArray<T>; const Value: T);
begin
  SetLength(Arr, Length(Arr)+1);
  Arr[High(Arr)] := Value;
end;

class procedure TAryHelper<T>.Delete(var Arr: TArray<T>; const Index: Cardinal; Count: Cardinal);
var
  ALength: Cardinal;
  i: Cardinal;
begin
  ALength := Length(Arr);
  Assert(ALength > 0);
  Assert(Count > 0);
  Assert(Count <= ALength - Index);
  Assert(Index < ALength);

  for i := Index + Count to ALength - 1 do
    Arr[i - Count] := Arr[i];

  SetLength(Arr, ALength - Count);
end;

class function TAryHelper<T>.First(const Arr: TArray<T>): T;
begin

end;

class procedure TAryHelper<T>.Grow(var Arr: TArray<T>);
begin

end;

class procedure TAryHelper<T>.Insert(var Arr: TArray<T>; Index: Integer;
  const Value: T);
begin

end;

class function TAryHelper<T>.Last(const Arr: TArray<T>): T;
begin
  Result := Arr[Length(Arr) - 1];
end;

class procedure TAryHelper<T>.Trunc(var Arr: TArray<T>);
begin

end;

end.
