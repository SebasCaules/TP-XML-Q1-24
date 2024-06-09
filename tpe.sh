
api_key="28FpvzoP5yhkV9N9gHEK1UrhFxpPkE72FEg3e3L4"
type=$1
year=$2

curl ‘https://api.sportradar.com/nascar-ot3/${type}/${year}/drivers/list.xml?api_key=${api_key}’ -o drivers_list.xml
curl 'https://api.sportradar.com/nascar-ot3/${type}/${year}/standings/drivers.xml?api_key=${api_key}' -o drivers_standings.xml
java net.sf.saxon.Transform -s:drivers_list.xml -xsl:remove_namespace.xsl -o:drivers_list.xml
java net.sf.saxon.Transform -s:drivers_standings.xml -xsl:remove_namespace.xsl -o:drivers_standings.xml

java net.sf.saxon.Query -q:extract_nascar_data.xq -o:nascar_data.xml
java net.sf.saxon.Transform -s:nascar_data.xml -xsl:generate_fo.xsl -o:nascar_page.fo
./fop-2.9/fop/fop -fo nascar_page.fo -pdf nascar_report.pdf

