unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, IntervalArithmetic32and64;


type

  { TForm1 }

  TForm1 = class(TForm)
    Akceptuj: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    CheckBox1: TCheckBox;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StringGrid1: TStringGrid;
    Zatwierdz: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;

    procedure AkceptujClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ZatwierdzClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  liczbaRow,i,j,ai,aj,bi,bj,ci,cj,symW,sT: Integer;
   tabWsk: array of array of interval;
   tabWW: array of interval;
   tabWskE: array of array of Extended;
   tabWWE: array of Extended;
   vecWynikow: array of interval;
   vecWynikowE: array of Extended;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.AkceptujClick(Sender: TObject);

begin
      if  RadioButton1.Checked=True then
      begin
     Label1.Visible:=True;
     Label2.Visible:=True;
     Label3.Visible:=True;
     Label4.Visible:=True;
     Label5.Visible:=True;
     Label9.Visible:=True;
     Label28.Visible:=True;
     Label29.Visible:=True;
     Label30.Visible:=True;
     Label31.Visible:=True;
     Edit2.Visible:=True;
     Edit6.Visible:=True;
     Zatwierdz.Visible:=True;
     Button5.Visible:=True;
     end;
       if  RadioButton2.Checked=True then
      begin
     Label10.Visible:=True;
     Label11.Visible:=True;
     Label12.Visible:=True;
     Label13.Visible:=True;
     Label14.Visible:=True;
     Label15.Visible:=True;
     Label16.Visible:=True;
     Label17.Visible:=True;
     Label18.Visible:=True;
     Label19.Visible:=True;
     Label20.Visible:=True;
     Label21.Visible:=True;
     Label22.Visible:=True;
     Label23.Visible:=True;
     Label24.Visible:=True;
     Label25.Visible:=True;
     Label26.Visible:=True;
     Label27.Visible:=True;
     Label32.Visible:=True;
     Label33.Visible:=True;
     Label34.Visible:=True;
     Label35.Visible:=True;
     Edit3.Visible:=True;
     Edit4.Visible:=True;
     Edit5.Visible:=True;
     Edit7.Visible:=True;
     Button2.Visible:=True;
     Button3.Visible:=True;
     Button4.Visible:=True;
     Button6.Visible:=True;
     end;
     liczbaRow:=StrToInt(Edit1.Text);
     SetLength(tabWsk, liczbaRow+1, liczbaRow+1);
     SetLength(tabWskE, liczbaRow+1, liczbaRow+1);
     SetLength(tabWW, liczbaRow+1);
     SetLength(tabWWE, liczbaRow+1);
     SetLength(vecWynikow, liczbaRow+1);
     SetLength(vecWynikowE, liczbaRow+1);

end;

type
  MatrixInt = array of array of interval;


procedure symmatrixInterval(n : Integer;
                     var a  : MatrixInt;
                     b      : array of interval;
                     var x  : array of interval;
                     var st : Integer);

var
     i,j,k: Integer;
    u,v,z,c : interval;
begin
  st:=0;
  if n<1
    then st:=1;
  for i:=1 to n-1 do
    for j:=0 to i-2 do
      if int_width(a[i,j])<>int_width(a[j,i])
        then st:=2;
  if st=0
    then begin
           i:=0;
           repeat
             i:=i+1;
             for j:=1 to i do
               begin
                 z:=a[j,i];
                 if i=j
                   then begin
                          for k:=j-1 downto 1 do
                            begin
                              u:=a[i,k];
                              v:=imul(u,a[k,k]);
                              a[i,k]:=v;
                              z:=isub(z,imul(u,v));
                            end;
                          c:= int_read(IntToStr(0)) ;
                          if int_width(z)=int_width(c)
                            then st:=3
                            else a[i,i]:=idiv(int_read(IntToStr(1)),z)
                        end
                   else begin
                          for k:=j-1 downto 1 do
                            z:=isub(z,imul(a[i,k],a[j,k]));
                          a[i,j]:=z
                        end
               end
           until (i=n-1) or (st=3);
           if st=0
             then begin
                    for i:=0 to n-1 do
                      begin
                        z:=b[i];
                        for j:=i-2 downto 0 do
                          z:=isub(z,imul(a[i,j],x[j]));
                        x[i]:=z
                      end;
                    for i:=n-1 downto 0 do
                      begin
                        z:=imul(x[i],a[i,i]);
                        for j:=i to n-1 do
                          z:=isub(z,imul(a[j,i],x[j]));
                        x[i]:=z
                      end
                  end
         end
end;

type
Matrix = array of array of Extended;

procedure symmatrix (n      : Integer;
                     var a  : Matrix;
                     b      : array of Extended;
                     var x  : array of Extended;
                     var st : Integer);
var i,j,k : Integer;
    u,v,z : Extended;
begin
  st:=0;
  if n<1
    then st:=1;
  for i:=2 to n do
    for j:=1 to i-1 do
      if a[i,j]<>a[j,i]
        then st:=2;
  if st=0
    then begin
           i:=0;
           repeat
             i:=i+1;
             for j:=1 to i do
               begin
                 z:=a[j,i];
                 if i=j
                   then begin
                          for k:=j-1 downto 1 do
                            begin
                              u:=a[i,k];
                              v:=u*a[k,k];
                              a[i,k]:=v;
                              z:=z-u*v
                            end;
                          if z=0
                            then st:=3
                            else a[i,i]:=1/z
                        end
                   else begin
                          for k:=j-1 downto 1 do
                            z:=z-a[i,k]*a[j,k];
                          a[i,j]:=z
                        end
               end
           until (i=n) or (st=3);
           if st=0
             then begin
                    for i:=1 to n do
                      begin
                        z:=b[i];
                        for j:=i-1 downto 1 do
                          z:=z-a[i,j]*x[j];
                        x[i]:=z
                      end;
                    for i:=n downto 1 do
                      begin
                        z:=x[i]*a[i,i];
                        for j:=i+1 to n do
                          z:=z-a[j,i]*x[j];
                        x[i]:=z
                      end
                  end
         end
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    liczbaRow:=0;
    i:=0;
    j:=0;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     tabWsk[ai,aj]:=int_read(Edit3.Text);   {moze zamienic na wektor}
      tabWskE[ai,aj]:=StrToFloat(Edit3.Text);
  if (ai+1=liczbaRow) and (aj+1=liczbaRow) then
      begin
      ai:=0;
      aj:=1;
      Label13.Caption:=IntToStr(0);
      Label15.Caption:=IntToStr(1);
      ShowMessage('Wszystkie wpisano');
      end ;
      ai:=ai+1;
      aj:=aj+1;
      Label13.Caption:=IntToStr(ai);
      Label15.Caption:=IntToStr(aj);

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
      tabWsk[bi,bj]:=int_read(Edit4.Text); {moze zamienic na wektor}
      tabWskE[bi,bj]:=StrToFloat(Edit4.Text);
  if (bi+1=liczbaRow-1) and (bj+1=liczbaRow-0) then
      begin
      bi:=0;
      bj:=1;
      Label18.Caption:=IntToStr(0);
      Label20.Caption:=IntToStr(1);
      ShowMessage('Wszystkie wpisano');
      end ;
      bi:=bi+1;
      bj:=bj+1;
      Label18.Caption:=IntToStr(bi);
      Label20.Caption:=IntToStr(bj);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
     tabWsk[ci,cj]:=int_read(Edit5.Text); {moze zamienic na wektor}
      tabWskE[ci,cj]:=StrToFloat(Edit5.Text);
  if (ci+1=liczbaRow) and (cj+1=liczbaRow-1) then
      begin
      ci:=0;
      cj:=1;
      Label23.Caption:=IntToStr(0);
      Label25.Caption:=IntToStr(1);
      ShowMessage('Wszystkie wpisano');
      end ;
      ci:=ci+1;
      cj:=cj+1;
      Label23.Caption:=IntToStr(ci);
      Label25.Caption:=IntToStr(cj);

end;

procedure TForm1.Button5Click(Sender: TObject);
begin

      if symW=liczbaRow+1 then
      begin
      symW:=1;
      Label30.Caption:=IntToStr(1);
      ShowMessage('Wystarczajaca ilosc');
      Exit;
      end;
      tabWW[symW]:=int_read(Edit6.Text);
      tabWWE[symW]:=StrToFloat(Edit6.Text);
      symW:=symW+1;
     Label30.Caption:=IntToStr(symW);

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
      tabWW[symW]:=int_read(Edit7.Text);
      tabWWE[symW]:=StrToFloat(Edit7.Text);
      if symW=liczbaRow-1 then
      begin
      symW:=0;
      symW:=0;
      Label34.Caption:=IntToStr(1);
      ShowMessage('Wystarczajaca ilosc');
      Exit;
      end;
      symW:=symW+1;
     Label34.Caption:=IntToStr(symW);

end;

procedure TForm1.Button7Click(Sender: TObject);
var
    test: Integer;
begin
  if  (CheckBox1.Checked=True) and (RadioButton1.Checked=True) then
  {funkcja dla arytmetyki przedzialowej i macierzy symetrycznej}
    begin
        symmatrixInterval(liczbaRow,tabWsk,tabWW,vecWynikow,sT);

  end;
  if (CheckBox1.Checked=False) and (RadioButton1.Checked=True) then
  {funkcja dla arytmetyki normalnej i macierzy symetrycznej }
  begin
       symmatrix(liczbaRow,tabWskE,tabWWE,vecWynikowE,sT);
          StringGrid1.ColCount:=liczbaRow+1;
          StringGrid1.Cells[0,0]:='x' ;
        for test:=1 to liczbaRow do
          begin
               StringGrid1.Cells[test,0]:=IntToStr(test);
              StringGrid1.Cells[test,1]:=FloatToStr(vecWynikowE[test]);
          end;
  end;
  if  (CheckBox1.Checked=True) and (RadioButton2.Checked=True) then
  {funkcja dla arytmetyki przedzialowej i macierzy trojdiagonalnej}
  begin

  end;
  if (CheckBox1.Checked=False) and (RadioButton2.Checked=True) then
  {funkcja dla arytmetyki normalnej i macierzy trojdiagonalnej }
  begin

  end;
end;




procedure TForm1.ZatwierdzClick(Sender: TObject);
begin
     if (i=liczbaRow+1) and (j=1) then
      begin
      i:=1;
      j:=1;
      Label1.Caption:=IntToStr(1);
      Label3.Caption:=IntToStr(1);
      ShowMessage('Wystarczajaca ilosc');
      Exit;
      end;
      tabWsk[i,j]:=int_read(Edit2.Text);
      tabWskE[i,j]:=StrToFloat(Edit2.Text);
      if j=liczbaRow then
      begin
      i:=i+1;
      Label1.Caption:=IntToStr(i);
      j:=1;
      Label3.Caption:=IntToStr(j);
      end
      else
      begin
        j:=j+1;
       Label3.Caption:=IntToStr(j);
       end;


end;

begin
    liczbaRow:=0;
    i:=1;
    ai:=1;
    aj:=1;
     bi:=1;
    bj:=2;
    ci:=2;
    cj:=1;
    j:=1;
    symW:=1;
     sT:=0;

end.

