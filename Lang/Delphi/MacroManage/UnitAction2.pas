(*
  * Copyright (c) 2013-2016 Thundax Macro Actions
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are
  * met:
  *
  * * Redistributions of source code must retain the above copyright
  *   notice, this list of conditions and the following disclaimer.
  *
  * * Redistributions in binary form must reproduce the above copyright
  *   notice, this list of conditions and the following disclaimer in the
  *   documentation and/or other materials provided with the distribution.
  *
  * * Neither the name of 'Thundax Macro Actions' nor the names of its contributors
  *   may be used to endorse or promote products derived from this software
  *   without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
  * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
  * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

unit UnitAction2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, StdCtrls, thundax.lib.actions_pjh, ExtCtrls,
  Vcl.Samples.Spin, Vcl.Menus, UnitMacroListClass2;

type
  TfrmActions = class(TForm)
    btnAddAction: TButton;
    ActionTypeCombo: TComboBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btnSequence: TSpeedButton;
    edtX: TEdit;
    edtY: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    cmbStrokes: TComboBox;
    Label5: TLabel;
    edtFreeText: TEdit;
    Label6: TLabel;
    ActionEditLB: TListBox;
    Timer1: TTimer;
    btnDelete: TSpeedButton;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    Label7: TLabel;
    TabSheet3: TTabSheet;
    Label8: TLabel;
    edtTime: TSpinEdit;
    Label9: TLabel;
    btnStop: TSpeedButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Load1: TMenuItem;
    Save1: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label10: TLabel;
    edtIndex: TEdit;
    Label11: TLabel;
    CustomDescEdit: TEdit;
    Label12: TLabel;
    ExecModeRG: TRadioGroup;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSequenceClick(Sender: TObject);
    procedure btnAddActionClick(Sender: TObject);
    procedure ActionEditLBDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure ActionTypeComboChange(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure edtXKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionEditLBDblClick(Sender: TObject);
  private
    pos,
    FSelectedActionIdx: Integer;

    function GetIndexFromLBSelected: integer;
    procedure SetSelectedActionData2Form;
    procedure SetSelectedActionDataFromForm;
    function GetActionsFromIdx: TActions;
    procedure AddOrChangeActionFromForm(AIsAdd: Boolean);
  public
    FBreak : Boolean;
    FActionCollection: TActionCollection;
    FActionlist: TActionList;
    FCurrentActionType: TActionType;
    FIsUpdateMousePos: Boolean;

    procedure CopyActionList(ADest: TActionList);
  end;

var
  frmActions: TfrmActions;

implementation

uses sndkey32, UnitListBoxUtil;

{$R *.dfm}

procedure TfrmActions.btnSequenceClick(Sender: TObject);
var
  i, j: Integer;
  action: IAction;
  numTimes: Integer;
begin
  numTimes := StrToInt(Edit3.Text);
  if numTimes > 0 then
  begin
    for j := 0 to numTimes - 1 do
    begin
      for i := 0 to ActionEditLB.Items.Count - 1 do
      begin
        pos := i;
        action := FActionList[i];
        action.Execute();
        Sleep(200);
        ActionEditLB.SetFocus;
        Application.ProcessMessages;
        if FBreak then
          break;
      end;
      if FBreak then
        break;
    end;
  end
  else
  begin
    i := 0;
    while not FBreak do
    begin
      pos := i;
      action := FActionList[i];
      action.Execute();
      Sleep(200);
      ActionEditLB.SetFocus;
      Application.ProcessMessages;
      Sleep(200);
      inc(i);
      if (i > (ActionEditLB.Items.Count - 1)) then
        i := 0;
    end;
  end;
end;

procedure TfrmActions.btnStopClick(Sender: TObject);
begin
  FBreak := true;
end;

//class function TfrmActions.AddAction2List(var AList: TActionList;
//  AItem: TActionItem; ADesc: string): IAction;
//var
//  action: IAction;
//  actionType: TActionType;
//  x, y: Integer;
//begin
//  actionType := GetActionType(AItem.ActionCode);
//
//  case actionType of
//    atMousePos:
//      begin
//        if (AItem.XPos < 0) or (AItem.YPos < 0) then
//          raise Exception.Create('Fields must contain valid coordinates');
//
//        action := TAction<Integer>.Create(actionType, TParameters<Integer>.Create(AItem.XPos, AItem.YPos), AItem.CustomDesc);
//      end;
//    atMouseLClick, atMouseLDClick, atMouseRClick, atMouseRDClick:
//      action := TAction<String>.Create(actionType, TParameters<String>.Create('', ''), AItem.CustomDesc);
//    atKey:
//      begin
//        if (AItem.InputText = '') then
//          raise Exception.Create('Fields must contain valid key');
//        action := TAction<String>.Create(actionType, TParameters<String>.Create(AItem.InputText, ''), AItem.CustomDesc);
//      end;
//    atMessage:
//      begin
//        if (AItem.InputText = '') then
//          raise Exception.Create('Fields must contain valid message');
//        action := TAction<String>.Create(actionType, TParameters<String>.Create(AItem.InputText, ''), AItem.CustomDesc);
//      end;
//    atWait:
//      begin
//        if (AItem.WaitSec = 0) then
//          raise Exception.Create('Field must contain time greater than zero');
//        action := TAction<Integer>.Create(actionType, TParameters<Integer>.Create(AItem.WaitSec, 0), AItem.CustomDesc);
//      end;
//    atMessage_Dyn:
//      begin
//        if (AItem.GridIndex <= 0) then
//          raise Exception.Create('Fields must contain valid Grid Index');
//        action := TAction<Integer>.Create(actionType, TParameters<Integer>.Create(AItem.GridIndex, 0), AItem.CustomDesc);
//      end;
//    atExecuteFunc:
//      begin
//        if (AItem.InputText = '') then
//          raise Exception.Create('Fields must contain valid function name');
//        action := TAction<String>.Create(actionType, TParameters<String>.Create(AItem.InputText, ''), AItem.CustomDesc);
//      end;
//  end;
//
//  if not Assigned(AList) then
//    AList := TActionList.Create;
//
//  AList.Add(action);
//  Result := action;
//end;

procedure TfrmActions.btnAddActionClick(Sender: TObject);
//var
//  action: IAction;
//  LStr: string;
////  actionType: TActionType;
//  x, y: Integer;
//  LItem: TActionItem;
//  LActions: TActions;
begin
  AddOrChangeActionFromForm(True);
//  if ComboBox1.Text = '' then
//    Exit;
//
//  LItem := TActionItem.Create;
//  try
//    LItem.ActionCode := ComboBox1.Text;
//
//    LItem.ActionType := TActionTypeHelper.GetActionTypeFromDesc(LItem.ActionCode);
//
//    case LItem.ActionType of
//      atMousePos:
//        begin
//          x := StrToIntDef(edtX.Text, -1);
//          y := StrToIntDef(edtY.Text, -1);
//          LItem.XPos := x;
//          LItem.YPos := y;
//        end;
//      atMouseLClick, atMouseLDClick, atMouseRClick, atMouseRDClick:
//        begin
//
//        end;
//      atMouseLDown, atMouseLUp, atMouseRDown, atMouseRUp, atMouseMDown, atMouseMUp:
//        begin
//
//        end;
//      atKey, atMessage:
//        begin
//          if cmbStrokes.Text <> '' then
//            LStr := GetKeyStr4SendKey2(cmbStrokes.Text)
//          else
//          if edtFreeText.Text <> '' then
//            LStr := edtFreeText.Text;
//
//          LItem.InputText := LStr;
//        end;
//      atWait:
//        begin
//          if edtTime.Value <> 0 then
//            LItem.WaitSec := edtTime.Value;
//        end;
//      atMessage_Dyn:
//        begin
//          LItem.GridIndex := StrToIntDef(edtIndex.Text, -1);
//        end;
//      atExecuteFunc:
//        begin
//          LItem.InputText := edtFreeText.Text;
//        end;
//    end;
//
//    LItem.CustomDesc := CustomDescEdit.Text;
//    LItem.ExecMode := TExecuteMode(ExecModeRG.ItemIndex);
//
//    action := TActionItem.AddActionItem2List(FActionList, LItem);
//    LItem.ActionDesc := action.toString;
//    LActions := FActionCollection.Add;
//    LActions.ActionItem.Assign(LItem);
//  finally
//    LItem.Free;
//  end;
//
//  ActionEditLB.Items.AddObject(action.toString, LActions);
end;

procedure TfrmActions.FormCreate(Sender: TObject);
begin
  FActionList := TActionList.Create;
  FActionCollection := TActionCollection.Create;

  g_ActionType.SetType2List(ActionTypeCombo.Items);
end;

procedure TfrmActions.FormDestroy(Sender: TObject);
var
  i: integer;
begin
//  for i := 0 to FActionCollection.Count - 1 do
//  begin
//    TActions(FActionCollection.Item[i]).ActionItem.Free;
//    TActions(FActionCollection.Item[i]).Free;
//  end;

  for i := 0 to FActionList.Count - 1 do
  begin
    TActionItem(FActionList[i]).Free;
  end;

  FActionCollection.Free;
  FreeAndNil(FActionList);
end;

function TfrmActions.GetActionsFromIdx: TActions;
begin
  Result := TActions(ActionEditLB.Items.Objects[FSelectedActionIdx])
end;

function TfrmActions.GetIndexFromLBSelected: integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to ActionEditLB.Count - 1 do
  begin
    if ActionEditLB.Selected[i] then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TfrmActions.SetSelectedActionData2Form;
var
  LDesc: string;
  LActions: TActions;
begin
  LActions := GetActionsFromIdx;

  if not Assigned(LActions) then
    exit;

  LDesc := LActions.ActionItem.ActionDesc;
  FCurrentActionType := TActionTypeHelper.GetActionTypeFromDesc(LDesc);

  ActionTypeCombo.ItemIndex := Ord(FCurrentActionType);
  ExecModeRG.ItemIndex := Ord(LActions.ActionItem.ExecMode);
  CustomDescEdit.Text := LActions.ActionItem.CustomDesc;
  edtX.Text := IntToStr(LActions.ActionItem.XPos);
  edtY.Text := IntToStr(LActions.ActionItem.YPos);
  cmbStrokes.ItemIndex := LActions.ActionItem.VKExtendKey;
  edtFreeText.Text := LActions.ActionItem.InputText;
  edtIndex.Text := IntToStr(LActions.ActionItem.GridIndex);
  edtTime.Value := LActions.ActionItem.WaitSec;
end;

procedure TfrmActions.SetSelectedActionDataFromForm;
begin
  AddOrChangeActionFromForm(False);
end;

procedure TfrmActions.ActionEditLBDblClick(Sender: TObject);
begin
  FSelectedActionIdx := GetIndexFromLBSelected;
  SetSelectedActionData2Form();
end;

procedure TfrmActions.ActionEditLBDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with (Control as TListBox).Canvas do
  begin
    if pos = Index then
    begin
      Brush.Color := cllime;
      DrawFocusRect(Rect);
    end;

    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, (Control as TListBox).Items[Index]);
  end;
end;

procedure TfrmActions.AddOrChangeActionFromForm(AIsAdd: Boolean);
var
  action: IAction;
  LStr: string;
//  actionType: TActionType;
  x, y: Integer;
  LItem: TActionItem;
  LActions: TActions;
begin
  if ActionTypeCombo.Text = '' then
    Exit;

  if AIsAdd then
  begin
    LItem := TActionItem.Create;
  end
  else
  begin
    LActions := GetActionsFromIdx;
    LItem := LActions.ActionItem;
  end;

  try
    LItem.ActionCode := ActionTypeCombo.Text;
    LItem.ActionType := TActionTypeHelper.GetActionTypeFromDesc(LItem.ActionCode);

    case LItem.ActionType of
      atMousePos:
        begin
          x := StrToIntDef(edtX.Text, -1);
          y := StrToIntDef(edtY.Text, -1);
          LItem.XPos := x;
          LItem.YPos := y;
        end;
      atMouseLClick, atMouseLDClick, atMouseRClick, atMouseRDClick:
        begin

        end;
      atMouseLDown, atMouseLUp, atMouseRDown, atMouseRUp, atMouseMDown, atMouseMUp:
        begin

        end;
      atKey, atMessage:
        begin
          if cmbStrokes.Text <> '' then
            LStr := GetKeyStr4SendKey2(cmbStrokes.Text)
          else
          if edtFreeText.Text <> '' then
            LStr := edtFreeText.Text;

          LItem.InputText := LStr;
        end;
      atWait:
        begin
          if edtTime.Value <> 0 then
            LItem.WaitSec := edtTime.Value;
        end;
      atMessage_Dyn:
        begin
          LItem.GridIndex := StrToIntDef(edtIndex.Text, -1);
        end;
      atExecuteFunc:
        begin
          LItem.InputText := edtFreeText.Text;
        end;
    end;

    LItem.CustomDesc := CustomDescEdit.Text;
    LItem.ExecMode := TExecuteMode(ExecModeRG.ItemIndex);

    if AIsAdd then
    begin
      action := TActionItem.AddActionItem2List(FActionList, LItem);
      LItem.ActionDesc := action.toString;
      LActions := FActionCollection.Add;
      LActions.ActionItem.Assign(LItem);
    end
    else
    begin

    end;

  finally
    LItem.Free;
  end;

  ActionEditLB.Items.AddObject(action.toString, LActions);
end;

procedure TfrmActions.btnDeleteClick(Sender: TObject);
var
  i: integer;
  LAryInt: TArray<integer>;
begin
  LAryInt := GetSelectedIndexs(ActionEditLB);
  ActionEditLB.Items.BeginUpdate;
  try
    for i := Length(LAryInt) - 1 downto 0 do
    begin
      if LAryInt[i] < ActionEditLB.Count then
      begin
        FActionList.Remove(FActionList.Items[LAryInt[i]]);
        FActionCollection.Delete(LAryInt[i]);
        ActionEditLB.Items.Delete(LAryInt[i]);
      end;
    end;
  finally
    ActionEditLB.Items.EndUpdate;
  end;
end;

procedure TfrmActions.btnUpClick(Sender: TObject);
//var
//  CurrIndex: Integer;
//  i: integer;
//  LAryInt: TArray<integer>;
begin
  MoveUpSelectedItemsFromListBox(ActionEditLB);
//  LAryInt := GetSelectedIndexs(ActionEditLB);
//  ActionEditLB.Items.BeginUpdate;
//  try
//    with ActionEditLB do
//    begin
//      for i := 0 to Length(LAryInt) - 1 do
//      begin
//        if LAryInt[i] > 0 then
//        begin
//          CurrIndex := LAryInt[i];
//          FActionList.Move(LAryInt[i], (CurrIndex - 1));
//          FActionCollection.Item[CurrIndex].Index := CurrIndex - 1;
//          Items.Move(LAryInt[i], (CurrIndex - 1));
////          ItemIndex := CurrIndex - 1;
//        end;
//      end;//for
//    end;//with
//  finally
//    ActionEditLB.Items.EndUpdate;
//  end;
end;

procedure TfrmActions.ActionTypeComboChange(Sender: TObject);
var
  descAction: string;
begin
  descAction := ActionTypeCombo.Text;
  FCurrentActionType := TActionTypeHelper.GetActionTypeFromDesc(descAction);

  edtX.Enabled := True;
  edtY.Enabled := True;
  cmbStrokes.Enabled := True;
  edtFreeText.Enabled := True;
  edtTime.Enabled := True;
  btnAddAction.Enabled := True;

  case FCurrentActionType of
    atMousePos:
      begin
        cmbStrokes.Enabled := false;
        edtFreeText.Enabled := false;
        edtIndex.Enabled := false;
        edtTime.Enabled := false;
        FIsUpdateMousePos := True;
        PageControl1.ActivePageIndex := 0;
      end;
    atMouseLClick, atMouseLDClick, atMouseRClick, atMouseRDClick,
    atMouseLDown, atMouseLUp, atMouseRDown, atMouseRUp, atMouseMDown, atMouseMUp:
      begin
        edtX.Enabled := false;
        edtY.Enabled := false;
        cmbStrokes.Enabled := false;
        edtFreeText.Enabled := false;
        edtIndex.Enabled := false;
        edtTime.Enabled := false;
        FIsUpdateMousePos := False;
        PageControl1.ActivePageIndex := 0;
      end;
    atKey:
      begin
        edtX.Enabled := false;
        edtY.Enabled := false;
        edtFreeText.Enabled := false;
        edtIndex.Enabled := false;
        edtTime.Enabled := false;
        FIsUpdateMousePos := False;
        PageControl1.ActivePageIndex := 1;
      end;
    atMessage:
      begin
        edtX.Enabled := false;
        edtY.Enabled := false;
        edtIndex.Enabled := false;
        cmbStrokes.Enabled := false;
        edtTime.Enabled := false;
        FIsUpdateMousePos := False;
        PageControl1.ActivePageIndex := 1;
      end;
    atWait:
      begin
        edtX.Enabled := false;
        edtY.Enabled := false;
        edtIndex.Enabled := false;
        cmbStrokes.Enabled := false;
        edtTime.Enabled := true;
        FIsUpdateMousePos := False;
        PageControl1.ActivePageIndex := 2;
      end;
    atMessage_Dyn:
      begin
        cmbStrokes.Enabled := false;
        edtFreeText.Enabled := false;
        edtIndex.Enabled := true;
        edtTime.Enabled := false;
        edtX.Enabled := false;
        edtY.Enabled := false;
        FIsUpdateMousePos := False;
        PageControl1.ActivePageIndex := 1;
      end;
    atExecuteFunc:
      begin
        edtX.Enabled := false;
        edtY.Enabled := false;
        edtIndex.Enabled := false;
        cmbStrokes.Enabled := false;
        edtTime.Enabled := false;
        FIsUpdateMousePos := False;
        PageControl1.ActivePageIndex := 1;
      end;
  end;
end;

procedure TfrmActions.CopyActionList(ADest: TActionList);
begin
  ADest.Clear;
  ADest.InsertRange(0, FActionList);
end;

procedure TfrmActions.edtXKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  pt: TPoint;
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('c')) or (Key = Ord('C'))) then
  begin
    GetCursorPos(pt);

    if FCurrentActionType = atMousePos then
    begin
      edtX.Text := IntToStr(pt.x);
      edtY.Text := IntToStr(pt.y);
    end;
  end;
end;

procedure TfrmActions.btnDownClick(Sender: TObject);
//var
//  CurrIndex, LastIndex: Integer;
begin
  MoveDownSelectedItemsFromListBox(ActionEditLB);

//  with ActionEditLB do
//  begin
//    CurrIndex := ItemIndex;
//    LastIndex := Items.Count;
//    if ItemIndex <> -1 then
//    begin
//      if CurrIndex + 1 < LastIndex then
//      begin
//        FActionList.Move(ItemIndex, (CurrIndex + 1));
//        FActionCollection.Item[CurrIndex].Index := CurrIndex + 1;
//        Items.Move(ItemIndex, (CurrIndex + 1));
//        ItemIndex := CurrIndex + 1;
//      end;
//    end;
//  end;
end;

procedure TfrmActions.Timer1Timer(Sender: TObject);
var
  pt: TPoint;
begin
  Application.ProcessMessages;
  GetCursorPos(pt);
  Label7.caption := 'Mouse Position (x,y) (' + IntToStr(pt.x) + ',' + IntToStr(pt.y) + ')';

//  if FIsUpdateMousePos and (FCurrentActionType = atMousePos) then
//  begin
//    edtX.Text := IntToStr(pt.x);
//    edtY.Text := IntToStr(pt.y);
//  end;
end;

end.
