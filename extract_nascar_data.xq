
let $drivers_list := doc("drivers_list.xml")
let $drivers_standings := doc("drivers_standings.xml")

return
<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">
  
  <year>{data($drivers_standings//season/@year)}</year>
  <serie_type>{data($drivers_standings/series/@name)}</serie_type> 
  <drivers> 
  {
  for $driver in $drivers_standings//driver
  let $details := $drivers_list//driver[@id = $driver/@id]
  order by xs:integer($driver/@rank)

  return
    <driver> 
      <full_name>{data($driver/@full_name)}</full_name>
      <country>{data($details/@country)}</country> 
      <birth_date>{data($details/@birthday)}</birth_date> 
      <birth_place>{data($details/@birth_place)}</birth_place> 
      <rank>{data($driver/@rank)}</rank>
      <car>{data($details//manufacturer/@name)}</car> 
      <statistics> 

        <season_points>{data($driver/@points)}</season_points> 
        <wins>{data($driver/@wins)}</wins> 
        <poles>{data($driver/@poles)}</poles> 
        <races_not_finished>{data($driver/@dnf)}</races_not_finished> 

        <laps_completed>{data($driver/@laps_completed)}</laps_completed> 
      </statistics> 

    </driver>
  }
  </drivers>
  
</nascar_data>
