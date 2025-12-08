defmodule Mario.Groups do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.Group

  def list_all do
    Repo.all(Group)
  end

  def get!(id), do: Repo.get!(Group, id)

  def create(attrs) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def update(group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete(group) do
    Repo.delete(group)
  end


def assign_all_markets_to_group(group_id) do
  markets = Repo.all(Mario.Models.Market)

  now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

  entries =
    Enum.map(markets, fn market ->
      %{
        "OpenTimeFrom" => market."OpenTimeFrom",
        "OpenTimeTo" => market."OpenTimeTo",
        "CloseTimeFrom" => market."CloseTimeFrom",
        "CloseTimeTo" => market."CloseTimeTo",
        "OpenSingleJodiEndTime" => market."OpenSingleJodiEndTime",
        "CloseSingleEndTime" => market."CloseSingleEndTime",
        "OpenSingleLowerLimit" => market."OpenSingleLowerLimit",
        "OpenJodiLowerLimit" => market."OpenJodiLowerLimit",
        "CloseSingleLowerLimit" => market."CloseSingleLowerLimit",
        "OpenPanaLowerLimit" => market."OpenPanaLowerLimit",
        "ClosePanaLowerLimit" => market."ClosePanaLowerLimit",
        "Single_Khula" => market."Single_Khula",
        "Jodi_Khula" => market."Jodi_Khula",
        "Jodi_Family" => market."Jodi_Family",
        "Jodi_Cycle" => market."Jodi_Cycle",
        "SpPana_Khula" => market."SpPana_Khula",
        "SpPana_Family" => market."SpPana_Family",
        "SpPana_SP" => market."SpPana_SP",
        "SpPana_CP" => market."SpPana_CP",
        "SpPana_Common" => market."SpPana_Common",
        "SpPana_Motor" => market."SpPana_Motor",
        "SpPana_Chat" => market."SpPana_Chat",
        "SpPana_AbrCut" => market."SpPana_AbrCut",
        "SpPana_Other" => market."SpPana_Other",
        "DpPana_Khula" => market."DpPana_Khula",
        "DpPana_Family" => market."DpPana_Family",
        "DpPana_DP" => market."DpPana_DP",
        "DpPana_CP" => market."DpPana_CP",
        "DpPana_Common" => market."DpPana_Common",
        "DpPana_Motor" => market."DpPana_Motor",
        "DpPana_Other" => market."DpPana_Other",
        "TpPana_Khula" => market."TpPana_Khula",
        "TpPana_Family" => market."TpPana_Family",
        "TpPana_TP" => market."TpPana_TP",
        "TpPana_CP" => market."TpPana_CP",
        "TpPana_Other" => market."TpPana_Other",
        "HalfSangam_Khula" => market."HalfSangam_Khula",
        "HalfSangam_Family" => market."HalfSangam_Family",
        "HalfSangam_SP" => market."HalfSangam_SP",
        "HalfSangam_DP" => market."HalfSangam_DP",
        "HalfSangam_TP" => market."HalfSangam_TP",
        "HalfSangam_CP" => market."HalfSangam_CP",
        "HalfSangam_Common" => market."HalfSangam_Common",
        "HalfSangam_Motor" => market."HalfSangam_Motor",
        "HalfSangam_Chat" => market."HalfSangam_Chat",
        "HalfSangam_AbrCut" => market."HalfSangam_AbrCut",
        "HalfSangam_Other" => market."HalfSangam_Other",
        "FullSangam_Khula" => market."FullSangam_Khula",
        "FullSangam_Family" => market."FullSangam_Family",
        "FullSangam_SP" => market."FullSangam_SP",
        "FullSangam_DP" => market."FullSangam_DP",
        "FullSangam_TP" => market."FullSangam_TP",
        "FullSangam_CP" => market."FullSangam_CP",
        "FullSangam_Common" => market."FullSangam_Common",
        "FullSangam_Motor" => market."FullSangam_Motor",
        "FullSangam_Chat" => market."FullSangam_Chat",
        "FullSangam_AbrCut" => market."FullSangam_AbrCut",
        "FullSangam_Other" => market."FullSangam_Other",
        group_id: group_id,
        market_id: market.id,
        inserted_at: now,
        updated_at: now
      }
    end)

  Repo.insert_all("group_markets", entries)
end


end
