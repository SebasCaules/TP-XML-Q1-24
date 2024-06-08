xquery version "1.0";

declare variable $drivers_list := doc("drivers_list.xml");
declare variable $drivers_standings := doc("drivers_standings.xml");

<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:noNamespaceSchemaLocation="nascar_data.xsd">
  <year>{data($drivers_standings//season/@year)}</year>
  <series_type>{data($drivers_standings//series/@name)}</series_type>
  <drivers>
    {
      for $driver in $drivers_list//driver
      let $standing := $drivers_standings//driver[@id=$driver/@id]
      return
        <driver>
          <name>{data($driver/first_name)} {data($driver/last_name)}</name>
          <points>{data($standing/@points)}</points>
          <rank>{data($standing/@rank)}</rank>
          <wins>{data($standing/@wins)}</wins>
          <top_5>{data($standing/@top_5)}</top_5>
          <top_10>{data($standing/@top_10)}</top_10>
        </driver>
    }
  </drivers>
</nascar_data>
