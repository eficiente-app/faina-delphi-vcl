// Daniel Araujo - 18/01/2021
unit base_form_dropdown;

interface

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  base_form,
  Faina.Shadow;

const
  WM_PopupFormCloseUp = WM_USER + 89;

type
  TBaseFormDropDown = class(TBaseForm)
  private
    FOnCloseUp: TNotifyEvent;
    FPopupParent: TCustomForm;
    FResizable: Boolean;
    function GetDroppedDown: Boolean;
    procedure SetPopupParent(const Value: TCustomForm);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure DoCloseup; virtual;
    procedure WMPopupFormCloseUp(var Msg: TMessage); message WM_PopupFormCloseUp;
    property PopupParent: TCustomForm read FPopupParent write SetPopupParent;
  public
    const AnimationDuration = 30; // ms
    constructor Create(AOwner: TComponent); override;

    procedure ShowDropdown(OwnerForm: TCustomForm; PopupPosition: TPoint);
    property DroppedDown: Boolean read GetDroppedDown;
    property Resizable: Boolean read FResizable write FResizable;

    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
  end;

implementation

{$R *.dfm}

{ TFormularioDropDownBase }

constructor TBaseFormDropDown.Create(AOwner: TComponent);
begin
  inherited;

  Self.BorderStyle := bsNone; //get rid of our border right away, so the creator can measure us accurately
  FResizable := True;
end;

procedure TBaseFormDropDown.CreateParams(var Params: TCreateParams);
const
  SPI_GETDROPSHADOW = $1024;
  CS_DROPSHADOW = $00020000;
var
  dropShadow: BOOL;
begin
  inherited CreateParams({var}Params);

  // It's no longer documented (because Windows 2000 is no longer supported)
  // but use of CS_DROPSHADOW and SPI_GETDROPSHADOW are only supported on XP (5.1) or newer
  if (Win32MajorVersion > 5) or ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1)) then
  begin
    //Use of a drop-shadow is controlled by a system preference
    if not SystemParametersInfo(SPI_GETDROPSHADOW, 0, @dropShadow, 0) then
      dropShadow := False;

    if dropShadow then
      Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
  end;

  if FPopupParent <> nil then
    Params.WndParent := FPopupParent.Handle;
end;

procedure TBaseFormDropDown.DoCloseup;
begin
  if Assigned(FOnCloseUp) then
    FOnCloseUp(Self);
end;

function TBaseFormDropDown.GetDroppedDown: Boolean;
begin
  Result := (Self.Visible);
end;

procedure TBaseFormDropDown.SetPopupParent(const Value: TCustomForm);
begin
  FPopupParent := Value;
end;

procedure TBaseFormDropDown.ShowDropdown(OwnerForm: TCustomForm; PopupPosition: TPoint);
var
  comboBoxAnimation: BOOL;
  i: Integer;
begin
  // We want the dropdown form "owned" by (i.e. not "parented" to) the OwnerForm
  Self.Parent := nil; //the default anyway; but just to reinforce the idea
  Self.PopupParent := OwnerForm; //Owner means the Win32 concept of owner (i.e. always on top of, cf Parent, which means clipped child of)
  Self.PopupMode := pmExplicit; //explicitely owned by the owner

  // Show the form just under, and right aligned, to this button
  // Self.BorderStyle := bsNone; moved to during FormCreate; so can creator can know our width for measurements
  Self.Position := poDesigned;
  Self.Left := PopupPosition.X;
  Self.Top := PopupPosition.Y;

  //Use of drop-down animation is controlled by preference
  if not SystemParametersInfo(SPI_GETCOMBOBOXANIMATION, 0, @comboBoxAnimation, 0) then
    comboBoxAnimation := False;

  if comboBoxAnimation then
  begin
    //Delphi doesn't react well to having a form show behind its back (e.g. ShowWindow, AnimateWindow).
    //Force Delphi to create all the WinControls so that they will exist when the form is shown.
    for i := 0 to ControlCount - 1 do
    begin
      if Controls[i] is TWinControl and Controls[i].Visible and not TWinControl(Controls[i]).HandleAllocated then
      begin
        TWinControl(Controls[i]).HandleNeeded;
        SetWindowPos(TWinControl(Controls[i]).Handle, 0, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      end;
    end;
    AnimateWindow(Self.Handle, AnimationDuration, AW_VER_POSITIVE or AW_SLIDE or AW_ACTIVATE);
    Visible := True; // synch VCL
  end
  else
    inherited Show;
end;

procedure TBaseFormDropDown.WMActivate(var Msg: TWMActivate);
begin
  //If we are being activated, then give pretend activation state back to our owner
  if (Msg.Active <> WA_INACTIVE) then
    SendMessage(Self.PopupParent.Handle, WM_NCACTIVATE, WPARAM(True), -1);

  inherited;

  //If we're being deactivated, then we need to rollup
  if Msg.Active = WA_INACTIVE then
  begin
    {
      Post a message (not Send a message) to oursleves that we're closing up.
      This gives a chance for the mouse/keyboard event that triggered the closeup
      to believe the drop-down is still dropped down.
      This is intentional, so that the person dropping it down knows not to drop it down again.
      They want clicking the button while is was dropped to hide it.
      But in order to hide it, it must still be dropped down.
    }
    PostMessage(Self.Handle, WM_PopupFormCloseUp, WPARAM(Self), LPARAM(0));
  end;
end;

procedure TBaseFormDropDown.WMNCHitTest(var Message: TWMNCHitTest);
var
  deltaRect: TRect; //not really used as a rect, just a convenient structure
  cx, cy: Integer;
begin
  inherited;

  if not Self.Resizable then
    Exit;

  //The sizable border is a preference
  cx := GetSystemMetrics(SM_CXSIZEFRAME);
  cy := GetSystemMetrics(SM_CYSIZEFRAME);

  with Message, deltaRect do
  begin
    Left := XPos - BoundsRect.Left;
    Right := BoundsRect.Right - XPos;
    Top := YPos - BoundsRect.Top;
    Bottom := BoundsRect.Bottom - YPos;

    if (Top < cy) and (Left < cx) then
      Result := HTTOPLEFT
    else if (Top < cy) and (Right < cx) then
      Result := HTTOPRIGHT
    else if (Bottom < cy) and (Left < cx) then
      Result := HTBOTTOMLEFT
    else if (Bottom < cy) and (Right < cx) then
      Result := HTBOTTOMRIGHT
    else if (Top < cy) then
      Result := HTTOP
    else if (Left < cx) then
      Result := HTLEFT
    else if (Bottom < cy) then
      Result := HTBOTTOM
    else if (Right < cx) then
      Result := HTRIGHT;
  end;
end;

procedure TBaseFormDropDown.WMPopupFormCloseUp(var Msg: TMessage);
begin
  // This message gets posted to us.
  // Now it's time to actually closeup.
  Self.Hide;

  DoCloseup; //raise the OnCloseup event *after* we're actually hidden
end;

end.
