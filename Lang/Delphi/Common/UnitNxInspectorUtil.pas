unit UnitNxInspectorUtil;

interface

uses
  NxPropertyItems, NxPropertyItemClasses,
  NxScrollControl, NxInspector;

function AddItemsToInspector(AInspector: TNextInspector; ANxItemClass: TNxItemClass;
            AParentNode: TNxPropertyItem; AName, ACaption, AValue: string):TNxPropertyItem;overload;
function AddItemsToInspector(AInspector: TNextInspector; ANxItemClass: TNxItemClass;
            ABaseIndex: integer; AName, ACaption, AValue: string):TNxPropertyItem;overload;

implementation

//AName: ANxItemClass name
//ACaption: ���� Text
//AValue: ������ Text
function AddItemsToInspector(AInspector: TNextInspector; ANxItemClass: TNxItemClass;
            AParentNode: TNxPropertyItem; AName, ACaption, AValue: string):TNxPropertyItem;
begin
  Result := nil;
  Result := AInspector.Items.AddChild(AParentNode, ANxItemClass);

  if Result <> nil then
  begin
    if AName <> '' then
      Result.Name := AName;

    if ACaption <> '' then
      Result.Caption := ACaption;

    if AValue <> '' then
      Result.AsString := AValue;
  end;

  AInspector.Invalidate;
end;

//ABaseIndex: Level Index = 0�̸� Root Node�� �߰���
function AddItemsToInspector(AInspector: TNextInspector; ANxItemClass: TNxItemClass;
  ABaseIndex: integer; AName, ACaption, AValue: string):TNxPropertyItem;overload;
begin
  Result := nil;
  Result := AInspector.Items.AddChild(AInspector.Items[ABaseIndex], ANxItemClass);

  if Result <> nil then
  begin
    if AName <> '' then
      Result.Name := AName;

    if ACaption <> '' then
      Result.Caption := ACaption;

    if AValue <> '' then
      Result.AsString := AValue;
  end;

  AInspector.Invalidate;
end;

end.
