declare namespace ns1 = "http://feed.elasticstats.com/schema/nascar/series-v2.0.xsd";
declare namespace ns2 = "http://feed.elasticstats.com/schema/nascar/standings-v2.0.xsd";


let $drivers_list := doc("drivers_list.xml")
let $drivers_standings := doc("drivers_standings.xml")


return
<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">
  
  <year>{data($drivers_list//ns1:season/@year)}</year>
  <serie_type>{data($drivers_list/ns1:series/@name)}</serie_type> 
  <drivers> 
  {
  for $driver in $drivers_list//ns1:driver
  let $details := $drivers_standings//ns2:driver[@id = $driver/@id]

  return

    <driver> 
      <full_name>{data($driver/@full_name)}</full_name>
      <country>{data($driver/@country)}</country> 
      <birth_date>{data($driver/@birthday)}</birth_date> 
      <birth_place>{data($driver/@birth_place)}</birth_place> 
      <rank>{data($details/@rank)}</rank>
      <car>{data($driver//ns1:manufacturer/@name)}</car> 
      <statistics> 

        <season_points>{data($details/@points)}</season_points> 
        <wins>{data($details/@wins)}</wins> 
        <poles>{data($details/@poles)}</poles> 
        <races_not_finished>{data($details/@dnf)}</races_not_finished> 
        <laps_completed>{data($details/@laps_completed)}</laps_completed> 

      </statistics> 

    </driver>
  }
  </drivers>
  
</nascar_data>
