account='account'
password='password'

siteurl='http://example.com/'

db_suffix=`pwgen -An 5 1`
db_password=`pwgen -sn 8 1`

admin_password=`pwgen -sn 8 1`
admin_email='test@example.com'

curl "https://api.beget.ru/api/mysql/addDb?login=$account&passwd=$password&input_format=json&output_format=json&input_data={\"suffix\":\"$db_suffix\",\"password\":\"$db_password\"}"

beget_wpcli core download --path=. --locale=ru_RU --version=4.6.1 --force
beget_wpcli core config --dbname=${account}_${db_suffix} --dbuser=${account}_${db_suffix} --dbpass=${db_password} --dbhost=localhost --dbcharset=utf8 --dbcollate=utf8_general_ci --locale=ru_RU
beget_wpcli core install --url=${siteurl} --title='' --admin_user=${account} --admin_password=${admin_password} --admin_email=${admin_email}

echo $admin_password
