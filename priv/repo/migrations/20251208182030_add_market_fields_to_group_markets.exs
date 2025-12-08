defmodule Mario.Repo.Migrations.AddMarketFieldsToGroupMarkets do
  use Ecto.Migration


  def change do
    alter table(:group_markets) do
      add :OpenTimeFrom, :time
      add :OpenTimeTo, :time
      add :CloseTimeFrom, :time
      add :CloseTimeTo, :time
      add :OpenSingleJodiEndTime, :time
      add :CloseSingleEndTime, :time

      add :OpenSingleLowerLimit, :decimal
      add :OpenJodiLowerLimit, :decimal
      add :CloseSingleLowerLimit, :decimal
      add :OpenPanaLowerLimit, :decimal
      add :ClosePanaLowerLimit, :decimal

      add :Single_Khula, :decimal
      add :Jodi_Khula, :decimal
      add :Jodi_Family, :decimal
      add :Jodi_Cycle, :decimal

      add :SpPana_Khula, :decimal
      add :SpPana_Family, :decimal
      add :SpPana_SP, :decimal
      add :SpPana_CP, :decimal
      add :SpPana_Common, :decimal
      add :SpPana_Motor, :decimal
      add :SpPana_Chat, :decimal
      add :SpPana_AbrCut, :decimal
      add :SpPana_Other, :decimal

      add :DpPana_Khula, :decimal
      add :DpPana_Family, :decimal
      add :DpPana_DP, :decimal
      add :DpPana_CP, :decimal
      add :DpPana_Common, :decimal
      add :DpPana_Motor, :decimal
      add :DpPana_Other, :decimal

      add :TpPana_Khula, :decimal
      add :TpPana_Family, :decimal
      add :TpPana_TP, :decimal
      add :TpPana_CP, :decimal
      add :TpPana_Other, :decimal

      add :HalfSangam_Khula, :decimal
      add :HalfSangam_Family, :decimal
      add :HalfSangam_SP, :decimal
      add :HalfSangam_DP, :decimal
      add :HalfSangam_TP, :decimal
      add :HalfSangam_CP, :decimal
      add :HalfSangam_Common, :decimal
      add :HalfSangam_Motor, :decimal
      add :HalfSangam_Chat, :decimal
      add :HalfSangam_AbrCut, :decimal
      add :HalfSangam_Other, :decimal

      add :FullSangam_Khula, :decimal
      add :FullSangam_Family, :decimal
      add :FullSangam_SP, :decimal
      add :FullSangam_DP, :decimal
      add :FullSangam_TP, :decimal
      add :FullSangam_CP, :decimal
      add :FullSangam_Common, :decimal
      add :FullSangam_Motor, :decimal
      add :FullSangam_Chat, :decimal
      add :FullSangam_AbrCut, :decimal
      add :FullSangam_Other, :decimal
    end
  end
end
