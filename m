Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118B6CD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 May 2026 01:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OowkbvNspl8h8uLDrByxdpJlW23t8ceDFw0AtB0llEg=; b=E6slSRtATbsPKHPxRu6om9HS7r
	Xa6XZ6k2MdpM0OwcJUtq1zs6w4J0I+GGwg8RJlJNTcwIjkMTucGX0WWYjEMkBYduV3TeH+QGrtdhm
	WjI95R3Q8j1bFvlMMS6T0q951k6wBmm4lfp6WlZOQ7UMthwQIEFLx9uwHxXEJ8crvEvo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKQjb-00056Y-Vh;
	Wed, 06 May 2026 01:07:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zzzccc427@gmail.com>) id 1wKQja-00056S-Vv
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 May 2026 01:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JmQJ/jxjLCff+AyiCXjjhkQKUDK/bWKghKi+SOGgMdQ=; b=WNDfCBuL5UfeJ4mUfg9JlOsVKR
 5xjRHvlh2FnXu24HdR3J/BY9nMA+VUWQg26nK3r/BuLvDYjoaKjzIk2QvZj9h23LWnpvjqXQKTIf6
 dblSAwn2ih5MioiadlYcCvcumu76DUjMwogajrY/sglVQZ1b18ilrbZ6x9qpmvqGhs0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JmQJ/jxjLCff+AyiCXjjhkQKUDK/bWKghKi+SOGgMdQ=; b=E
 rN+IiF2E3uR8lX5rIsfQRLxXpDXNTpnwMKMhq68OxbyJLlnZkfaEDMZOi1pw3g34KRen83UAoMcK8
 TajBAzjAHgEaeDh8I2U4NuuQH+cW+jQ5KD6V8x5z5rGGSl1WXxlvvdW62svqu74NgRnrw/snZRNgx
 Yk4aruOvdy0QwkiU=;
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wKQjZ-0003yM-Kp for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 May 2026 01:07:30 +0000
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-82f8b60e54dso4507884b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 05 May 2026 18:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778029644; x=1778634444; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JmQJ/jxjLCff+AyiCXjjhkQKUDK/bWKghKi+SOGgMdQ=;
 b=heTe3RGH8BlQD6F5QOFnhCWSjRj78rFayUXKt4MTJ5KUrzcKnY166LZ8E5Wbn6OrA1
 3xY9ffY7vL3sPcDhQoG9Qz4lEODIWOdcTwU+i5oYZALSneZLj4UCfSkupZ7Z8gZQccRj
 OkkmXX/8NQxcXxQVhwgofcT4k1BwBMtLz0HQCxouxqFn/z3usgwvKlZticLtMQPZk2Cj
 97+oDQRjiN0y+LhOKsux0A3dOhrCuVN4mwWXG91vTloxhCmvppbgK8D/Jblumr3fJmFP
 d0Rsgw/A4TkSWKYvVpJ8b/9PTIWr1WdEfFKiicoa5UDGhJHQnUv6VLTqXq8m2UJJVAPE
 F5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778029644; x=1778634444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmQJ/jxjLCff+AyiCXjjhkQKUDK/bWKghKi+SOGgMdQ=;
 b=jTBLABCotiqQOEeleYch+/Y+cJBhFYV3TdX6R2ko95GNYpDUsu4yUYSmqej8P2OGN2
 /YRX9j6QNX+EjEs0ZR1+FWDUzf1fZD61/iMEfhFRQ9nYggEggitPY60BlXzOl3o5kdtB
 0bOv1ws3z7Bgt+MFe/11sFD/qBtguyorBCBBO88GhO94a5rAoA/YNpxhMqLBpm5kD3YH
 2wDeZtx+1l32FpR41h1UagKqU+tBRE4KiCEip9RD9HyrIE73r5donUJu7gWQrlYxaReG
 7cEhMdxNOt+A3gGcwAc3RmWn2GaE088iXBVhQDm7NWYFzFvPdHytcz8o3YmlFd2YL/sn
 uCjA==
X-Gm-Message-State: AOJu0YwB5iutJiOBqeb1Z/oArqy8VJKyPHFsBH5eija6KHx9sRElGQoG
 F8g/Xja6sioNUpT5ytOLQQwwViBqCn+5yOKNvaGX2KIGKcZGxmsMh2uv
X-Gm-Gg: AeBDietwEaSofY8EOFSwmGWXNQS+OBKIZXBk8Vj+Rb7mwbpcSrngcFOYuL2y0ldZ/aj
 Dr4NkAFUwEYFscAPzi4uIL8r/yj5vc7c1ShiVxV8HddK1wcRrTYxY01kgJgB5gOD8LGZRH9bS/H
 5vSy3tU5BEj+3JBg9VEKEqds/kUjU0qWaKpBk0e12WQOfbgDuv7qoZsT7A8LD+/yFwmy45j7UY6
 Td7lFOHxJ0yeG2PhschBIkEY1cvtXH6BPfe+MgZcoZKnDgDnEAsJtPz/iIB7B+TEiOZB0mGnFci
 1mLoRH2Q5j0tvTOq9zojXfiA8uOz7LdR7WK4v/wZxE7KqXflNF6y6+3qCiiD6eOEKp87288Awr4
 xpCKojnH5F6nlreCMCaGEh6Shj0o43nSxrOizBRdFD1YOBXBVvdncvtmjnOUTVfCteN4FxmhvNe
 vHUn7wARmyIrHNfjOT7r1lPaVHjGWc
X-Received: by 2002:a05:6a00:1819:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-83a58924f3cmr1177827b3a.0.1778029643897; 
 Tue, 05 May 2026 18:07:23 -0700 (PDT)
Received: from localhost ([111.228.63.84]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8396563f381sm4539103b3a.6.2026.05.05.18.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 18:07:23 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed,  6 May 2026 09:07:09 +0800
Message-Id: <20260506010709.3287111-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1wKQjZ-0003yM-Kp
Subject: [f2fs-dev] [PATCH] f2fs: annotate lockless last_time[] accesses
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: baijiaju1990@gmail.com, Cen Zhang <zzzccc427@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs stores mount-wide activity timestamps in sbi->last_time[] and
samples them from background discard, GC, and balance paths without a
dedicated lock. The timestamps are used as best-effort heuristics to
decide whether background work should run now or sleep a bit longer.

The current helpers use plain loads and stores, so KCSAN can report races
between frequent foreground updates and background readers. Exact
freshness is not required here, but the intentional lockless accesses
should be marked explicitly.

Use WRITE_ONCE() in f2fs_update_time() and READ_ONCE() in
f2fs_time_over() and f2fs_time_to_wait(). This preserves the existing
heuristic behavior and avoids adding locking to hot paths.

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/f2fs/f2fs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65c0d20df3a4..f838acc2f7a0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2121,12 +2121,12 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
 {
 	unsigned long now = jiffies;
 
-	sbi->last_time[type] = now;
+	WRITE_ONCE(sbi->last_time[type], now);
 
 	/* DISCARD_TIME and GC_TIME are based on REQ_TIME */
 	if (type == REQ_TIME) {
-		sbi->last_time[DISCARD_TIME] = now;
-		sbi->last_time[GC_TIME] = now;
+		WRITE_ONCE(sbi->last_time[DISCARD_TIME], now);
+		WRITE_ONCE(sbi->last_time[GC_TIME], now);
 	}
 }
 
@@ -2134,7 +2134,7 @@ static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
 {
 	unsigned long interval = sbi->interval_time[type] * HZ;
 
-	return time_after(jiffies, sbi->last_time[type] + interval);
+	return time_after(jiffies, READ_ONCE(sbi->last_time[type]) + interval);
 }
 
 static inline unsigned int f2fs_time_to_wait(struct f2fs_sb_info *sbi,
@@ -2144,7 +2144,7 @@ static inline unsigned int f2fs_time_to_wait(struct f2fs_sb_info *sbi,
 	unsigned int wait_ms = 0;
 	long delta;
 
-	delta = (sbi->last_time[type] + interval) - jiffies;
+	delta = (READ_ONCE(sbi->last_time[type]) + interval) - jiffies;
 	if (delta > 0)
 		wait_ms = jiffies_to_msecs(delta);
 
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
