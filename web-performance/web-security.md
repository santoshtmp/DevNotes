# Web Header Security

```
header('X-FRAME-OPTIONS: SAMEORIGIN');
header('Referrer-Policy: strict-origin-when-cross-origin');
header('X-Content-Type-Options: nosniff');
header('X-XSS-Protection: 1; mode=block');
header("Content-Security-Policy: frame-ancestors 'self';");
header('Strict-Transport-Security: max-age=31536000; includeSubDomains');
header("Permissions-Policy: geolocation=(self), microphone=(), camera=(), payment=(), fullscreen=*");
header("X-Permitted-Cross-Domain-Policies: none");
```

