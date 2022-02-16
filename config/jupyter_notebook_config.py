
c.ServerProxy.servers = {
  'neurodesktop': {
    'command': ['/home/jovyan/.neurodesktop.sh'],
    'port': 8080,
    'timeout': 60,
      'request_headers_override': {
          'Authorization': 'Basic am92eWFuOnBhc3N3b3Jk',
      },
      'launcher_entry': {
        'path_info' : 'neurodesktop/#/?username=jovyan&password=password'
      }
    }
}
