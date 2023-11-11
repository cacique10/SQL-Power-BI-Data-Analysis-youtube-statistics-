

use [SQL + Power BI Data Analysis Portfolio Project (youtube statistics)];



-- base query
 --select Country from dbo.[Global YouTube Statistics - convertida 1] order by Country;



 
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------




-- Top "continents" in the Youtube space; Uploads, views, earnings ans Subs
			

select
Country,
 case
     when Country in ('Algeria','Angola','Benin','Botswana','Burkina Faso','Burundi','Cabo Verde','Cameroon','Central African Republic',
          'Chad','Comoros','Congo, Dem. Rep', 'Congo, Rep.','Cote d´Ivoire','Djibouti','Egypt','Equatorial Guinea','Eritrea',
          'Eswatini (formerly Swaziland)','Ethiopia','Gabon','Gambia','Ghana','Guinea','Guinea-Bissau','Kenya', 'Lesotho',
          'Liberia','Libya','Madagascar','Malawi','Mali','Mauritania','Mauritius','Morocco','Mozambique','Namibia',
          'Niger','Nigeria','Rwanda','Sao Tome and Principe','Senegal','Seychelles','Sierra Leone','Somalia','South Africa',
          'South Sudan','Sudan','Tanzania''Togo','Tunisia','Uganda','Zambia','Zimbabwe') then 'Africa'

     when Country in ('Albania','Andorra', 'Armenia','Austria','Azerbaijan','Belarus','Belgium','Bosnia and Herzegovina',
          'Bulgaria','Croatia','Cyprus','Czechia','Denmark','Estonia','Finland','France','Georgia','Germany',
          'Greece','Hungary','Iceland','Ireland','Italy','Kazakhstan','Kosovo','Latvia','Liechtenstein','Lithuania',
          'Luxembourg','Malta','Moldova','Monaco','Montenegro','Netherlands','Macedonia, FYR','Norway','Poland','Portugal',
          'Romania','Russia','San Marino','Serbia','Slovakia','Slovenia','Spain','Sweden','Switzerland','Turkey',
         'Ukraine','United Kingdom','Vatican City') then 'Europe'

     when Country in ('Afghanistan','Armenia','Azerbaijan','Bahrain','Bangladesh', 'Bhutan','Brunei','Cambodia','China','Cyprus',
        'Georgia','India','Indonesia','Iran','Iraq','Israel','Japan','Jordan','Kazakhstan','Kuwait','Kyrgyzstan','Laos',
        'Lebanon','Malaysia','Maldives','Mongolia','Myanmar','Nepal','North Korea','Oman','Pakistan','Palestine','Philippines',
        'Qatar','Russia','Saudi Arabia','Singapore','South Korea','Sri Lanka','Syria','Taiwan','Tajikistan','Thailand',
        'Timor-Leste','Turkey','Turkmenistan','United Arab Emirates','Uzbekistan','Vietnam','Yemen') then 'Asia'

     when Country in ('Antigua and Barbuda','Bahamas','Barbados','Belize','Canada','Costa Rica','Cuba','Dominica',
         'Dominican Republic','El Salvador','Grenada','Guatemala','Haiti','Honduras','Jamaica','Mexico',
        'Nicaragua','Panama','Saint Vincent and the Grenadines','United States', 'Argentina','Bolivia','Brazil','Chile','Colombia','Ecuador','Guyana','Paraguay','Peru','Suriname',
         'Uruguay','Venezuela') then 'America'

     when Country in ('Australia','Fiji','Kiribati','Marshall Islands','Micronesia','Nauru','New Zealand','Palau',
         'Papua New Guinea','Samoa','Solomon Islands','Tonga','Tuvalu','Vanuatu') then 'Oceania'

	end as continents,

sum(dbo.[Global YouTube Statistics - convertida 1].subscribers) as total_subs,
sum(dbo.[Global YouTube Statistics - convertida 1].uploads) as total_uploads,
sum(dbo.[Global YouTube Statistics - convertida 1].video_views) as total_views,
round(sum(dbo.[Global YouTube Statistics - convertida 1].highest_yearly_earnings),0) as total_earnings,
count(dbo.[Global YouTube Statistics - convertida 1].Youtuber) as num_of_youtubers

from dbo.[Global YouTube Statistics - convertida 1]
group by country
order by 6 desc;




------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------




-- Percentage of pay per continent
		

with percent_pay as(
select
Country,
 case
     when Country in ('Algeria','Angola','Benin','Botswana','Burkina Faso','Burundi','Cabo Verde','Cameroon','Central African Republic',
          'Chad','Comoros','Congo, Dem. Rep', 'Congo, Rep.','Cote d´Ivoire','Djibouti','Egypt','Equatorial Guinea','Eritrea',
          'Eswatini (formerly Swaziland)','Ethiopia','Gabon','Gambia','Ghana','Guinea','Guinea-Bissau','Kenya', 'Lesotho',
          'Liberia','Libya','Madagascar','Malawi','Mali','Mauritania','Mauritius','Morocco','Mozambique','Namibia',
          'Niger','Nigeria','Rwanda','Sao Tome and Principe','Senegal','Seychelles','Sierra Leone','Somalia','South Africa',
          'South Sudan','Sudan','Tanzania''Togo','Tunisia','Uganda','Zambia','Zimbabwe') then 'Africa'

     when Country in ('Albania','Andorra', 'Armenia','Austria','Azerbaijan','Belarus','Belgium','Bosnia and Herzegovina',
          'Bulgaria','Croatia','Cyprus','Czechia','Denmark','Estonia','Finland','France','Georgia','Germany',
          'Greece','Hungary','Iceland','Ireland','Italy','Kazakhstan','Kosovo','Latvia','Liechtenstein','Lithuania',
          'Luxembourg','Malta','Moldova','Monaco','Montenegro','Netherlands','Macedonia, FYR','Norway','Poland','Portugal',
          'Romania','Russia','San Marino','Serbia','Slovakia','Slovenia','Spain','Sweden','Switzerland','Turkey',
         'Ukraine','United Kingdom','Vatican City') then 'Europe'

     when Country in ('Afghanistan','Armenia','Azerbaijan','Bahrain','Bangladesh', 'Bhutan','Brunei','Cambodia','China','Cyprus',
        'Georgia','India','Indonesia','Iran','Iraq','Israel','Japan','Jordan','Kazakhstan','Kuwait','Kyrgyzstan','Laos',
        'Lebanon','Malaysia','Maldives','Mongolia','Myanmar','Nepal','North Korea','Oman','Pakistan','Palestine','Philippines',
        'Qatar','Russia','Saudi Arabia','Singapore','South Korea','Sri Lanka','Syria','Taiwan','Tajikistan','Thailand',
        'Timor-Leste','Turkey','Turkmenistan','United Arab Emirates','Uzbekistan','Vietnam','Yemen') then 'Asia'

     when Country in ('Antigua and Barbuda','Bahamas','Barbados','Belize','Canada','Costa Rica','Cuba','Dominica',
         'Dominican Republic','El Salvador','Grenada','Guatemala','Haiti','Honduras','Jamaica','Mexico',
        'Nicaragua','Panama','Saint Vincent and the Grenadines','United States', 'Argentina','Bolivia','Brazil','Chile','Colombia','Ecuador','Guyana','Paraguay','Peru','Suriname',
         'Uruguay','Venezuela') then 'America'

     when Country in ('Australia','Fiji','Kiribati','Marshall Islands','Micronesia','Nauru','New Zealand','Palau',
         'Papua New Guinea','Samoa','Solomon Islands','Tonga','Tuvalu','Vanuatu') then 'Oceania'

	end as continents,

round(sum(dbo.[Global YouTube Statistics - convertida 1].highest_yearly_earnings),0) as total_earnings

from dbo.[Global YouTube Statistics - convertida 1]
group by country
)

Select

sum(total_earnings) as total_earnings,

round(1.0 * 
sum(case when continents = 
'Africa' then total_earnings else 0 end)/ nullif(sum(total_earnings),0) *100,2) as pct_earnings_africa,

round(1.0 * sum(case when continents = 'Asia' then total_earnings else 0 end)/ nullif(sum(total_earnings),0) *100,2) as pct_earnings_Asia,

round(1.0 * sum(case when continents = 'America' then total_earnings else 0 end)/ nullif(sum(total_earnings),0) *100,2) as pct_earnings_America,

round(1.0 * sum(case when continents = 'Europe' then total_earnings else 0 end)/ nullif(sum(total_earnings),0) *100,2) as pct_earnings_Europe,

round(1.0 * sum(case when continents = 'Oceania' then total_earnings else 0 end)/ nullif(sum(total_earnings),0) *100,2) as pct_earnings_Oceania


from percent_pay;

;




------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------


-- Top 8 Countries, % pay
		

select top 8 country,
sum(highest_yearly_earnings) as total_earnings


from dbo.[Global YouTube Statistics - convertida 1]
group by country
order by 2 desc;




------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------



-- Top 8 channel types, sum views




select top 8
channel_type,
sum(video_views) as total_views


from dbo.[Global YouTube Statistics - convertida 1]
group by channel_type
order by 2 desc;



------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

