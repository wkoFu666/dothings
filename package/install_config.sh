#安装配置，如从globe.common.conf中将配置的值替换到某个业务的配置中
#$GLOBE_COMMON_CONF为全局的配置文件对象
#WORK_DIR为当前工作目录，即与globe.common.conf平级的目录

##读取业务的properties中的值，放入变量中
#spring_datasource_url=`cat $GLOBE_COMMON_CONF  | grep '^spring.datasource.url' | cut -d= -f2`
#spring_datasource_username=`cat $GLOBE_COMMON_CONF  | grep '^spring.datasource.username' | cut -d= -f2`
#spring_datasource_password=`cat $GLOBE_COMMON_CONF  | grep '^spring.datasource.password' | cut -d= -f2`

##替换业务的properties中的值
#sed -i "s#spring.datasource.url.*#spring.datasource.url=${spring_datasource_url}#g" $springConf
#sed -i "s#spring.datasource.username.*#spring.datasource.username=${spring_datasource_username}#g" $springConf
#sed -i "s#spring.datasource.password.*#spring.datasource.password=${spring_datasource_password}#g" $springConf