inherited FrmPais: TFrmPais
  Caption = 'FrmPais'
  ClientWidth = 597
  ExplicitWidth = 603
  ExplicitHeight = 549
  PixelsPerInch = 96
  TextHeight = 13
  inherited dxRibbon1: TdxRibbon
    Width = 597
    inherited dxRibbon1Tab1: TdxRibbonTab
      Index = 0
    end
  end
  inherited cxGridGral: TcxGrid
    Width = 591
    ExplicitLeft = 8
    ExplicitTop = 124
    ExplicitWidth = 591
    inherited cxGridDatos: TcxGridDBTableView
      object cxGridDatosColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'Codigo'
      end
      object cxGridDatosColumn2: TcxGridDBColumn
        Caption = 'Pa'#237's'
        DataBinding.FieldName = 'Pais'
      end
      object cxGridDatosColumn3: TcxGridDBColumn
        DataBinding.FieldName = 'Activo'
      end
    end
  end
  inherited pnlDatos: TPanel
    Width = 597
    inherited cxPageDatos: TcxPageControl
      Width = 593
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 593
      ClientRectRight = 591
      inherited cxTsDatos: TcxTabSheet
        inherited dxLYCDatos: TdxLayoutControl
          Width = 589
          ExplicitLeft = -2
          ExplicitTop = -3
          ExplicitWidth = 589
          object cxDBTextEdit1: TcxDBTextEdit [0]
            Left = 56
            Top = 10
            Style.HotTrack = False
            TabOrder = 0
            Width = 121
          end
          object cxDBTextEdit2: TcxDBTextEdit [1]
            Left = 56
            Top = 37
            Style.HotTrack = False
            TabOrder = 1
            Width = 321
          end
          inherited dxLyDatos: TdxLayoutGroup
            Index = -1
          end
          object dxLYCDatosItem1: TdxLayoutItem
            Parent = dxLyDatos
            CaptionOptions.Text = 'C'#243'digo'
            Control = cxDBTextEdit1
            ControlOptions.ShowBorder = False
            Index = 0
          end
          object dxLYCDatosItem2: TdxLayoutItem
            Parent = dxLyDatos
            CaptionOptions.Text = 'Pa'#237's'
            Control = cxDBTextEdit2
            ControlOptions.ShowBorder = False
            Index = 1
          end
        end
      end
    end
  end
  inherited dxBarManager1: TdxBarManager
    LookAndFeel.SkinName = ''
    DockControlHeights = (
      0
      0
      0
      0)
    inherited dxbrManager1Bar: TdxBar
      FloatClientWidth = 97
      FloatClientHeight = 366
    end
    inherited dxButtonGuardar: TdxBarLargeButton
      ImageIndex = 8
    end
  end
end
