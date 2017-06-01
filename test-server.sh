if [ ! -f test-server/server.jar ]; then
    echo "Server not found!"
    cd test-server
    mc setup spigot
    cd ..
fi

mkdir -p test-server/plugins

./gradlew assemble

cp build/libs/PanelPlugin*.jar test-server/plugins/

echo "# Generated via test-server.sh on $(date)" > test-server/eula.txt
echo "eula=true" >> test-server/eula.txt

cat << EOF > test-server/plugins/JPanel/config.yml
http-port: 4567
debug-mode: true
use-ssl: false
keystore-name: ''
keystore-password: ''
users:
  test:
    password: 1000:426437b6592bebe91855fccac195cf48:be1496b0a2757d7f0c89529ff21a2efe951424a4777aadf4775c99f513014d08997bb5a8a1de4cd7e0faa76a3c074b27f2131872f0cae9013517d0e0dad74356
    canEditFiles: false
    canChangeGroups: false
    canSendCommands: false
EOF

echo -e "\nJPanel User: test"
echo -e "JPanel Password: test\n"
sleep 5

cd test-server
java -Xmx1024M -Xms1024M -jar server.jar
