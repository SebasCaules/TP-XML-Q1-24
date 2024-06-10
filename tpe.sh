# Para definir la api key primero se tiene que hacer el siguiente comando en la terminal que se va a utilizar
# export SPORTRADAR_API=apikey

api_key=$SPORTRADAR_API
type=$1
year=$2

errors=0


if [ -z $api_key ]; then
    echo "There is no API key set as environment variable"
    printf '<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">\n\t<error>API key missing.</error>\n' >> nascar_data.xml
    errors=1
fi

if [ $# -ne 2 ]; then
    echo "Invalid number of parameters"
    if [ $errors -eq 1 ]; then
        printf '\t<error>Invalid number of parameters</error>\n' >> nascar_data.xml
    else
        printf '<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">\n\t<error>Invalid number of parameters</error>\n' >nascar_data.xml
        errors=1
    fi
fi

type_test="^(sc|xf|cw|go|mc)$"
year_test="^(201[3-9]|202[0-4])$"

echo "$type" | egrep -q "$type_test" > /dev/null 
if [ $? -eq 1 ]; then
    echo "Type must be sc, xf, cw, go, mc"
    if [ $errors -eq 1 ]; then
        printf '\t<error>Invalid type</error>\n' >> nascar_data.xml
    else
        printf '<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">\n\t<error>Invalid type</error>\n' >> nascar_data.xml
        errors=1
    fi
fi

echo "$year" | egrep -q "$year_test" > /dev/null 
if [ $? -eq 1 ]; then
    echo "Year must be in the range [2013 - 2024]"
    if [ $errors -eq 1 ]; then
        printf '\t<error>Invalid year</error>\n' >> nascar_data.xml
    else
        printf '<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">\n\t<error>Invalid year</error>\n' >> nascar_data.xml
        errors=1
    fi
fi

curl "https://api.sportradar.com/nascar-ot3/${type}/${year}/drivers/list.xml?api_key=${api_key}" -o drivers_list.xml

if [ $? -ne 0 ]; then
    echo "API call failed in drivers list"
    if [ $errors -eq 1 ]; then
        printf '\t<error>API call failed in drivers list</error>\n' >> nascar_data.xml
    else
        printf '<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">\n\t<error>API call failed in drivers list</error>\n' >> nascar_data.xml
        errors=1
    fi
fi

sleep 2

curl "https://api.sportradar.com/nascar-ot3/${type}/${year}/standings/drivers.xml?api_key=${api_key}" -o drivers_standings.xml

if [ $? -ne 0 ]; then
    echo "API call failed in drivers standings"
    if [ $errors -eq 1 ]; then
        printf '\t<error>API call failed in drivers standings</error>\n' >> nascar_data.xml
    else
        printf '<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">\n\t<error>API call failed in drivers standings</error>\n' >> nascar_data.xml
        errors=1
    fi
fi

if [ $errors -eq 1 ]; then
    printf '</nascar_data>' >> nascar_data.xml
    java net.sf.saxon.Transform -s:nascar_data.xml -xsl:generate_fo.xsl -o:nascar_page.fo
    ./fop-2.9/fop/fop -fo nascar_page.fo -pdf nascar_report.pdf
    exit 1
fi

java net.sf.saxon.Transform -s:drivers_list.xml -xsl:remove_namespace.xsl -o:drivers_list.xml
java net.sf.saxon.Transform -s:drivers_standings.xml -xsl:remove_namespace.xsl -o:drivers_standings.xml

java net.sf.saxon.Query -q:extract_nascar_data.xq -o:nascar_data.xml
java net.sf.saxon.Transform -s:nascar_data.xml -xsl:generate_fo.xsl -o:nascar_page.fo
./fop-2.9/fop/fop -fo nascar_page.fo -pdf nascar_report.pdf

rm nascar_page.fo
rm nascar_data.xml
