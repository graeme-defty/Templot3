
(*
    This file is part of OpenTemplot, a computer program for the design of
    model railway track.

    Copyright (C) 2018  Martin Wynne.  email: martin@templot.com
    Copyright (C) 2019  OpenTemplot project contributors

    This program is free software: you may redistribute it and/or modify
    it under the terms of the GNU General Public Licence as published by
    the Free Software Foundation, either version 3 of the Licence, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU General Public Licence for more details.

    You should have received a copy of the GNU General Public Licence
    along with this program. See the files: licence.txt or opentemplot.lpr

    Or if not, refer to the web site: https://www.gnu.org/licenses/

                >>>     NOTE TO DEVELOPERS     <<<
                     DO NOT EDIT THIS COMMENT
              It is inserted in this file by running
                  'python3 scripts/addComment.py'
         The original text lives in scripts/addComment.py.

====================================================================================
*)

unit print_settings_form;

{$MODE Delphi}

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Buttons, Menus,
  print_settings;

type

  { TprintSettingsForm }

  TprintSettingsForm = class(TForm)
    top_label: TLabel;
    blue_corner_panel: TPanel;
    size_updown: TUpDown;
    datestamp_label: TLabel;
    spacer_label: TLabel;
    close_panel: TPanel;
    close_button: TButton;
    output_rails_checkbox: TCheckBox;
    output_centrelines_checkbox: TCheckBox;
    output_timbering_checkbox: TCheckBox;
    output_radial_centres_checkbox: TCheckBox;
    output_bgnd_shapes_checkbox: TCheckBox;
    output_fb_foot_lines_checkbox: TCheckBox;
    output_radial_ends_checkbox: TCheckBox;
    Label1: TLabel;
    output_switch_labels_checkbox: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    output_sketchboard_items_checkbox: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    output_xing_labels_checkbox: TCheckBox;
    output_chairs_checkbox: TCheckBox;
    output_timber_centres_checkbox: TCheckBox;
    output_timber_numbers_checkbox: TCheckBox;
    output_timber_extensions_checkbox: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    output_rail_joints_checkbox: TCheckBox;
    output_guide_marks_checkbox: TCheckBox;
    output_switch_drive_checkbox: TCheckBox;
    output_timb_id_prefix_checkbox: TCheckBox;
    output_platforms_checkbox: TCheckBox;
    output_trackbed_edges_checkbox: TCheckBox;
    Shape2: TShape;
    //procedure rails_indicator_shapeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    //procedure rails_indicator_shapeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure output_bgnd_shapes_checkboxChange(Sender: TObject);
    procedure output_centrelines_checkboxChange(Sender: TObject);
    procedure output_chairs_checkboxChange(Sender: TObject);
    procedure output_fb_foot_lines_checkboxChange(Sender: TObject);
    procedure output_guide_marks_checkboxChange(Sender: TObject);
    procedure output_platforms_checkboxChange(Sender: TObject);
    procedure output_radial_centres_checkboxChange(Sender: TObject);
    procedure output_radial_ends_checkboxChange(Sender: TObject);
    procedure output_rails_checkboxChange(Sender: TObject);
    procedure output_rail_joints_checkboxChange(Sender: TObject);
    procedure output_sketchboard_items_checkboxChange(Sender: TObject);
    procedure output_switch_drive_checkboxChange(Sender: TObject);
    procedure output_switch_labels_checkboxChange(Sender: TObject);
    procedure output_timbering_checkboxChange(Sender: TObject);
    procedure output_timber_centres_checkboxChange(Sender: TObject);
    procedure output_timber_extensions_checkboxChange(Sender: TObject);
    procedure output_timber_numbers_checkboxChange(Sender: TObject);
    procedure output_timb_id_prefix_checkboxChange(Sender: TObject);
    procedure output_trackbed_edges_checkboxChange(Sender: TObject);
    procedure output_xing_labels_checkboxChange(Sender: TObject);
    procedure size_updownClick(Sender: TObject; Button: TUDBtnType);
    procedure FormCreate(Sender: TObject);
    procedure close_buttonClick(Sender: TObject);
    procedure output_timbering_checkboxClick(Sender: TObject);
    procedure output_timber_numbers_checkboxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  printSettingsForm: TprintSettingsForm;


implementation

{$R *.lfm}

uses control_room, pad_unit, math_unit, keep_select, help_sheet, shove_timber, wait_message,
  shoved_timber, template;

//______________________________________________________________________________

procedure TprintSettingsForm.size_updownClick(Sender: TObject; Button: TUDBtnType);

begin
  if size_updown.Position > size_updown.Tag
  // ! position goes up, size goes down.
  then
    ScaleBy(9, 10);                                           // scale the form contents down.

  if size_updown.Position < size_updown.Tag then
    ScaleBy(10, 9);                                           // scale the form contents up.

  ClientHeight := VertScrollBar.Range;                               // allow 4 pixel right margin.
  ClientWidth := HorzScrollBar.Range + 4;
  // don't need bottom margin - datestamp label provides this.
  ClientHeight := VertScrollBar.Range;
  // do this twice, as each affects the other.

  size_updown.Tag := size_updown.Position;
  // and save for the next click.
end;

//___________________________________________________________________________

procedure TprintSettingsForm.output_rails_checkboxChange(Sender: TObject);
begin
  printSettings.want_rails := output_rails_checkbox.Checked
end;

procedure TprintSettingsForm.output_centrelines_checkboxChange(Sender: TObject);
begin
  printSettings.want_centrelines := output_centrelines_checkbox.Checked
end;

procedure TprintSettingsForm.output_bgnd_shapes_checkboxChange(Sender: TObject);
begin
  printSettings.want_bgnd_shapes := output_bgnd_shapes_checkbox.Checked
end;

procedure TprintSettingsForm.output_chairs_checkboxChange(Sender: TObject);
begin
  printSettings.want_chairs := output_chairs_checkbox.Checked
end;

procedure TprintSettingsForm.output_fb_foot_lines_checkboxChange(Sender: TObject
  );
begin
  printSettings.want_fb_foot_lines := output_fb_foot_lines_checkbox.Checked
end;

procedure TprintSettingsForm.output_guide_marks_checkboxChange(Sender: TObject);
begin
  printSettings.want_guide_marks := output_guide_marks_checkbox.Checked
end;

procedure TprintSettingsForm.output_platforms_checkboxChange(Sender: TObject);
begin
  printSettings.want_platforms := output_platforms_checkbox.Checked
end;

procedure TprintSettingsForm.output_radial_centres_checkboxChange(
  Sender: TObject);
begin
  printSettings.want_radial_centres := output_radial_centres_checkbox.Checked
end;

procedure TprintSettingsForm.output_radial_ends_checkboxChange(Sender: TObject);
begin
  printSettings.want_radial_ends := output_radial_ends_checkbox.Checked
end;

procedure TprintSettingsForm.output_rail_joints_checkboxChange(Sender: TObject);
begin
  printSettings.want_rail_joints := output_rail_joints_checkbox.Checked
end;

procedure TprintSettingsForm.output_sketchboard_items_checkboxChange(
  Sender: TObject);
begin
  printSettings.want_sketchboard_items := output_sketchboard_items_checkbox.Checked
end;

procedure TprintSettingsForm.output_switch_drive_checkboxChange(Sender: TObject
  );
begin
  printSettings.want_switch_drive := output_switch_drive_checkbox.Checked
end;

procedure TprintSettingsForm.output_switch_labels_checkboxChange(Sender: TObject
  );
begin
  printSettings.want_switch_labels := output_switch_labels_checkbox.Checked
end;

procedure TprintSettingsForm.output_timbering_checkboxChange(Sender: TObject);
begin
  printSettings.want_timbering := output_timbering_checkbox.Checked
end;

procedure TprintSettingsForm.output_timber_centres_checkboxChange(
  Sender: TObject);
begin
  printSettings.want_timber_centres := output_timber_centres_checkbox.Checked
end;

procedure TprintSettingsForm.output_timber_extensions_checkboxChange(
  Sender: TObject);
begin
  printSettings.want_timber_extensions := output_timber_extensions_checkbox.Checked
end;

procedure TprintSettingsForm.output_timber_numbers_checkboxChange(
  Sender: TObject);
begin
  printSettings.want_timber_numbers := output_timber_numbers_checkbox.Checked
end;

procedure TprintSettingsForm.output_timb_id_prefix_checkboxChange(
  Sender: TObject);
begin
  printSettings.want_timb_id_prefix := output_timb_id_prefix_checkbox.Checked
end;

procedure TprintSettingsForm.output_trackbed_edges_checkboxChange(
  Sender: TObject);
begin
  printSettings.want_trackbed_edges := output_trackbed_edges_checkbox.Checked
end;

procedure TprintSettingsForm.output_xing_labels_checkboxChange(Sender: TObject);
begin
  printSettings.want_xing_labels := output_xing_labels_checkbox.Checked
end;

//___________________________________________________________________________

procedure TprintSettingsForm.FormCreate(Sender: TObject);

begin
  ClientWidth := 480;
  ClientHeight := 632;

  AutoScroll := False;
end;
//______________________________________________________________________________

procedure TprintSettingsForm.close_buttonClick(Sender: TObject);

begin
  Close;
end;
//______________________________________________________________________________

procedure TprintSettingsForm.output_timbering_checkboxClick(Sender: TObject);

begin
  output_timber_centres_checkbox.Enabled := output_timbering_checkbox.Checked;
  output_timber_numbers_checkbox.Enabled := output_timbering_checkbox.Checked;
  output_timber_extensions_checkbox.Enabled := output_timbering_checkbox.Checked;

  output_timb_id_prefix_checkbox.Enabled :=
    (output_timbering_checkbox.Checked) and (output_timber_numbers_checkbox.Checked);
end;
//______________________________________________________________________________

procedure TprintSettingsForm.output_timber_numbers_checkboxClick(Sender: TObject);

begin
  output_timb_id_prefix_checkbox.Enabled := output_timber_numbers_checkbox.Checked;
end;
//______________________________________________________________________________

end.
