---
# Fix: PostgreSQL "SSL error: Read timed out" on Jio 5G with VPN

If you're using a **Jio 5G hotspot** with a **Pritunl VPN** and can't connect to an PostgreSQL database, but it works fine on Airtel or other networks — this is for you.

---

## 🔍 Problem

- VPN connects successfully (Pritunl shows "Connected")
- DB connection fails with:
```

SSL error: Read timed out

````

✅ Works fine on other networks  
❌ Fails only on Jio

---

## 💡 Root Cause

Jio’s mobile network often **drops fragmented packets**.  
PostgreSQL's SSL handshake uses large packets, which fail if **MTU is too high**.

---

## ✅ Solution: Lower VPN MTU

### 1. Identify VPN interface

Run:

```bash
ip addr
````

Look for the VPN interface (e.g. `tun1`, `pritunl0`, etc.)

### 2. Set MTU to 1300

```bash
sudo ip link set dev tun1 mtu 1300
```

(Replace `tun1` with your actual interface.)

---

## 🧪 Optional: MTU Test

Find max working MTU (inside VPN):

```bash
ping -M do -s 1300 <db-host>
```

If needed, lower until no "Frag needed" error.

---

## 🛠 Tip: Helper Script

```bash
echo "sudo ip link set dev tun1 mtu 1300" > ~/fix_mtu.sh
chmod +x ~/fix_mtu.sh
./fix_mtu.sh
```

---

## ✅ Result

You can now connect to your PostgreSQL DB over Pritunl VPN on Jio 5G without SSL timeouts.

---

