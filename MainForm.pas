unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uCalculator;

type
  TMainFm = class(TForm)
    lblOutput: TLabel;
    lblHistory: TLabel;
    btnEqual: TButton;
    btn1: TButton;
    btn4: TButton;
    btn2: TButton;
    btn5: TButton;
    btn3: TButton;
    btn6: TButton;
    btn9: TButton;
    btn7: TButton;
    btn8: TButton;
    btnMultiply: TButton;
    btnDivide: TButton;
    btnMinus: TButton;
    btnPlus: TButton;
    btn0: TButton;
    btnC: TButton;
    btnCe: TButton;
    btnDot: TButton;
    btnBackspace: TButton;
    btnMS: TButton;
    btnMPlus: TButton;
    btnMRead: TButton;
    btnMMin: TButton;
    procedure btnEqualClick(Sender: TObject);
    procedure btnNumClick(Sender: TObject);
    procedure btnActClick(Sender: TObject);
    procedure btnDotClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure btnMSClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMReadClick(Sender: TObject);
    procedure btnMActionClick(Sender: TObject);
    function CheckStr: Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainFm: TMainFm;
  vCalc: TCalculator;

implementation

{$R *.dfm}


procedure TMainFm.btnNumClick(Sender: TObject);
begin
  if (lblOutput.Caption = '0') or (lblOutput.Caption = 'Невозможно деление на 0')
  or (lblOutput.Caption = 'Некорректная запись') then
  begin
    lblOutput.Caption := '';
  end;
  lblOutput.Caption := lblOutput.Caption + (Sender as TButton).Caption;
end;

procedure TMainFm.FormCreate(Sender: TObject);
begin
  vCalc := TCalculator.Create;
end;

procedure TMainFm.btnActClick(Sender: TObject);
var
  str : string;
begin
  str := lblOutput.Caption;
  if not(lblOutput.Caption[str.Length] in ['+','-','/','*']) and
  ((lblOutput.Caption <> 'Невозможно деление на 0') and
  (lblOutput.Caption <> 'Некорректная запись')) then
    lblOutput.Caption := lblOutput.Caption + (Sender as TButton).Caption;
end;

procedure TMainFm.btnCClick(Sender: TObject);
begin
   lblOutput.Caption := '0';
   lblHistory.Caption := '';
end;

procedure TMainFm.btnDotClick(Sender: TObject);
var
  I: ShortInt;
  str: string;
begin
  str := lblOutput.Caption;
  I := str.Length;
  while (not (lblOutput.Caption[I] in ['+', '-', '*', '/'])) and (I > 1) do
  begin
    if lblOutput.Caption[I] = ',' then
      exit ;
    I := I - 1;
  end;
  lblOutput.Caption := lblOutput.Caption + (Sender as TButton).Caption;
end;

procedure TMainFm.btnEqualClick(Sender: TObject);
var
  str: string;
begin
  str := lblOutput.Caption;
  lblHistory.Caption := str + ' =';
  lblOutput.Caption:= vCalc.CalculateAll(str);
end;

procedure TMainFm.btnMActionClick(Sender: TObject);
begin
   if CheckStr then
   begin
   if (Sender as TButton).Caption = 'M+' then
      vCalc.memoryNum := vCalc.memoryNum + StrToFloat(lblOutput.Caption)
    else
      vCalc.memoryNum := vCalc.memoryNum - StrToFloat(lblOutput.Caption);
   end;
end;

procedure TMainFm.btnMReadClick(Sender: TObject);
begin
  lblOutput.Caption := FloatToStr(vCalc.memoryNum);
end;

procedure TMainFm.btnMSClick(Sender: TObject);
begin
  if CheckStr then
    vCalc.memoryNum := StrToFloat(lblOutput.Caption);
end;

function TMainFM.CheckStr: Boolean;
var
  I: ShortInt;
  str: string;
begin
  Result := True;
  str := lblOutput.Caption;
  for I := 1 to str.Length do
  begin
    if str[I] in ['*','/','+','-'] then
    begin
      lblOutput.Caption := 'Некорректная запись';
      Result:= False;
      exit;
    end;
  end;
end;
end.

