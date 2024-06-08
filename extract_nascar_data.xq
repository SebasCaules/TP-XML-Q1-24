xquery version "1.0";

declare variable $drivers_list := doc("drivers_list.xml");
declare variable $drivers_standings := doc("drivers_standings.xml");

<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">
  
  <year>{data($drivers_list/season/@year)}</year> (:~ tipo int ~:)
  <series_type>{data($drivers_list/season/@name)}</series_type> (:~ tipo string  ~:)
  <drivers>
  (:~ for los drivers ~:)
  (:~ buscamos el std por id ~:)
  (:~ declare variable tagStandings = ... ~:)
    

    <driver> (:~ tipo driverT ~:)
      <full_name>{data($drivers_list/season/driver/@full_name)}</full_name> (:~ tipo string ~:)
      <country>{data($drivers_list/season/driver/@country)}</country> (:~ tipo string ~:)
      <birth_date>{data($drivers_list/season/driver/@birth_date)}</birth_date> (:~ tipo string ~:)
      <birth_place>{data($drivers_list/season/driver/@birth_place)}</birth_place> (:~ tipo string ~:)
      <rank>standing desordenado</rank>(:~ tipo string ~:)
      <car>{data($drivers_list/season/driver/car/manufacturer/@name)}</car> (:~ tipo string, minOccurs=0 ~:)
      <statistics> (:~ tipo statisticsT ~:)

        <season_points>std</season_points> (:~ tipo string ~:)
        <wins>std</wins> (:~ tipo string ~:)
        <poles>std</poles> (:~ tipo string ~:)
        <races_not_finished>dnf</races_not_finished> (:~ tipo string ~:)
        <laps_completed>std</laps_completed> (:~ tipo string ~:)

      </statistics> 

    </driver>

  </drivers>
</nascar_data>
