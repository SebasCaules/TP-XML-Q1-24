xquery version "1.0";

declare variable $drivers_list := doc("drivers_list.xml");
declare variable $drivers_standings := doc("drivers_standings.xml");

<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">
  
  <year></year> (:~ tipo int ~:)
  <series_type></series_type> (:~ tipo string  ~:)
  <drivers>
  (:~ for los drivers ~:)
    <driver> (:~ tipo driverT ~:)

      <full_name></full_name> (:~ tipo string ~:)
      <country></country> (:~ tipo string ~:)
      <birth_date></birth_date> (:~ tipo string ~:)
      <birth_place></birth_place> (:~ tipo string ~:)
      <rank></rank>(:~ tipo string ~:)
      <car></car> (:~ tipo string, minOccurs=0 ~:)
      <statistics> (:~ tipo statisticsT ~:)

        <season_points></season_points> (:~ tipo string ~:)
        <wins></wins> (:~ tipo string ~:)
        <poles></poles> (:~ tipo string ~:)
        <races_not_finished></races_not_finished> (:~ tipo string ~:)
        <laps_completed></laps_completed> (:~ tipo string ~:)

      </statistics> 

    </driver>
    
  </drivers>
</nascar_data>
