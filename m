Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19830C5AE49
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2EG/8LEqLwclGLQ+CnISnS5Scs+X/kplUQUtMTKc7mQ=; b=VAeFyaBJOE1ttikqQNgsvOW+Gc
	X1JzAMJ/HADmSd9Ufr9PYcjGbYl6JuiDbsam7Vf1GIVi2VKZX9jhriThP5bUOUks/HS0rRX5EAQK1
	Nm6Qb/6Yj79Utzz85Yi6Km2taGcZMIK1e6MMU9PraxRRuC9Y86JWFygaA9JdtWU/D02E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtQDK-00024I-9M;
	Mon, 10 Aug 2026 13:38:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wtQDG-00024A-AT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fJp0RS2rFbYkW5aZcn85LfnPX0NVVRI/dLOcgjhJTg0=; b=c6CZVQbPldsKqPU/OFqGmLTvit
 6iYVs7QH4inFPgOo8ncTb2S8hEmkL0sj6Nb1qt3Eo+I6DXrsdgmRBXKtHdqTgyRPeyfmMXXdXiwbH
 YndhshHUJFcz4Kc7aWmt72y6HzYqcpwL7+w3PnEf+PVqJz/9Tw2ViLu0qk5FQ1zSLSJw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fJp0RS2rFbYkW5aZcn85LfnPX0NVVRI/dLOcgjhJTg0=; b=W
 itfHJKSinoVrth+VjqZkVPZqDQBqCU0d4OP3pSwPIG0ICciE8eF20VyehN6/Vfhrlaic0EuYcVt9t
 7GMnQvl/qk+PrhibY1OW0FL3+q2Ora6sVf4EzUTZaU0+/xtn3evE0AOF4b7WMF/17yBNZlZQL9Hnk
 0PI8xQmCvEdkW6s8=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtQDG-0005xf-JR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:38:46 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso15810775ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786369121; x=1786973921; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJp0RS2rFbYkW5aZcn85LfnPX0NVVRI/dLOcgjhJTg0=;
 b=eb97YLyPwTMbC55kzQaiLvwky6vE4pjWIRBcU6jkXr7ZGDKafW/HJ3mwy1jsWBHqHg
 S9npWY0AjRN/n7kezCxkdRON0Rkh3+unQSKM5/cfyvoINcDWLbEJ0FsSU67M1XPAl0lk
 3niMboNZRYu/tMPC86MAHaJuWiA0dgcJsZgTBJUvUIIjj38tMg+s/fjqJOJMinGYmsxW
 4+5SHEtCqXwm+iih6RghZ+rt+Lwxv4JD/GoMCoUPNMru68wnDa2uIIu8ezsu7Xu87eSU
 wY70liwhvsOpuZJsYiAwu1XBYibUq+aSt5dJCx7qWRpGS8F0r70S9i2+N8FV/ZHmlm6t
 C3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786369121; x=1786973921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJp0RS2rFbYkW5aZcn85LfnPX0NVVRI/dLOcgjhJTg0=;
 b=Pmdyl+fqdFb/XPvd0U17D4GYn8jdny8pH8T1U7Fo7s6Gz5/VlSPaZOrheYJlUjIopM
 AYXdiWHvIjs/qfNF5caHxYN02ksU4sRrXc1mG6noXNVj0a+hEmD1jz82jl4OH6jAbLRC
 T35U9fJLRmczI6sKoY8UuNoWldz8yoB8qEQQM3rqYML0mP8pFvS1E7bELfoHKhvQ0qFk
 oWG7QVjE8ClSkcEQpc8m5gOUjmt4lxJ0EDCJtJ9IJtp4TQdS1xT5X0Pl/mvVzIYMrcoG
 I/OJkgVk3rVKUji3YlTHiWCB8gx4fC5Fi3b8QlhVNlJqnbDNRuVpNszl/1OS0RkRqgAM
 vFhg==
X-Gm-Message-State: AOJu0YwSIeL320KJCnizf74SlYnsrFkoIUh6SZtnJAcG2PIWtN2cACiC
 MHBuE12suzUrOuwp7BJx0UVmOhOaystnD4Yy+UHnyavOhibHh2Qxu28v
X-Gm-Gg: AR+sD126JVXYOePIGhJx/lADncVuREjLYG9I8XbI5Ls7QT2TW7Mm8jnhugUeaaLqaYQ
 eloagxeI4KKCXXtCSZdlXa3pAAq7tPtba9m+heVX6iQxlCRMYb/D3XrYGOqPlPNmeGuTjCRx26V
 7pskffCA2bH0R4A24SFZqEdr1KsYTKyWgbZpY4qkk7DVsLdi/FXKcI2uQUAtv/yQ6/gM3acB9l2
 MKWsslk0Idorx70tH/tJm1zPecwhuP6mW+bXPk/DSzkTqS7V+ZUjOio/cG+0QDYP/AzETTM+KlY
 m63uaZKQGtZ1FYjDqADF4yOa2JifJwqyWSbOl1d/fM7uYyIvMSZyvqN+VaOrGTQ3eWhdy7FdecY
 f0QKXU+B8B6k9SQpfkLQzuYiMsBmorzuxtMMUQReodecNRI7OIKUvoqMC07xAbe7zqdHUum2nOx
 DT9C39kZig/drUDK4xj2950mKXoYCX/vxilsmsIVRtHEujggxH/fQ8YPFzRWi6iSYkLHBVDYp3V
 JJR4HoO5z1HMkzkgJnjBsRY79UeQoWYuNA=
X-Received: by 2002:a17:903:32c5:b0:2ca:ed57:8586 with SMTP id
 d9443c01a7336-2d2a8fd38b5mr232240785ad.23.1786369120819; 
 Mon, 10 Aug 2026 06:38:40 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d16c4fc743sm36278955ad.80.2026.08.10.06.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 06:38:39 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 10 Aug 2026 21:38:32 +0800
Message-ID: <20260810133832.3530016-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wtQDG-0005xf-JR
Subject: [f2fs-dev] [PATCH v2] f2fs: return symlink writeback errors
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
Cc: qwjhust@gmail.com, stable@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS writes long symlink data with page_symlink() and then flushes the
symlink mapping to reduce the chance of exposing a broken symlink.

That flush result is currently ignored. If the writeback fails, symlink()
still returns success even though the symlink is not durable and the same
operation can already surface -EIO through syncfs().

Return the writeback error to userspace and skip the dirsync flush once the
symlink data flush has failed.

Fixes: d0cae97cb600 ("f2fs: flush symlink path to avoid broken symlink after POR")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v1:
- fix the Fixes tag to point to the real introducing commit

Reproducer:
- enable FAULT_WRITE_IO on the mounted F2FS filesystem
- create a long symlink so the target is written through page_symlink()
- old kernel: symlink() returns 0, syncfs() returns -EIO, and the symlink is
  absent after remount
- new kernel: symlink() returns -EIO

 fs/f2fs/namei.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 7ffdf23cea5e..a8db3928c8b5 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -707,15 +707,16 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	 * performance regression.
 	 */
 	if (!err) {
-		filemap_write_and_wait_range(inode->i_mapping, 0,
-							disk_link.len - 1);
+		err = filemap_write_and_wait_range(inode->i_mapping, 0,
+						   disk_link.len - 1);
 
-		if (IS_DIRSYNC(dir))
+		if (!err && IS_DIRSYNC(dir))
 			f2fs_sync_fs(sbi->sb, 1);
-	} else {
-		f2fs_unlink(dir, dentry);
 	}
 
+	if (err)
+		f2fs_unlink(dir, dentry);
+
 	f2fs_balance_fs(sbi, true);
 	goto out_free_encrypted_link;
 
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
