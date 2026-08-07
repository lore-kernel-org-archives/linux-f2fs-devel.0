Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A85C5AC7A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3WAsR12GQfyzOo+DCbUg8yZmvtHb+VKjar8+xEEV2iY=; b=SV0lfxD3rkX2EKeVnenllWTcD5
	EO43Ig7y8hZh+zZrG5XQL47nbztdUyk3G3j+eHqSbpYSJTphCtils8RocwydQGP46v2hRFGm3OJDX
	0OPD9vq6cj/I4SDFHq6jadpv1pMU3qYdMe0hXlhk4bwPkciewXs4EHsWKNZHcpJN55hI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wsMhk-0000KX-3U;
	Fri, 07 Aug 2026 15:41:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wsMhi-0000KK-Pw
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:41:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nGoCM2e9Adogn0qG20upMZxxQT2t9+y0kQxqYwkOIoc=; b=bYONezUrwlBjrAN2MyEoXfy24t
 2bnzhgoWyuXwPSWgAyEhGrh13tKCt5Du90EFj+rQHPs46LfQR63gQ2r5xhimQcI9R5HsCLwWcAzzd
 lDaOycO3EkSVNGVNqKPiDyY4g2YhGBO0folajDF4M/jTxzocosy8vgjMFC2od8lHDV8U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nGoCM2e9Adogn0qG20upMZxxQT2t9+y0kQxqYwkOIoc=; b=G
 2yMQwcmydnqL7CwDjgz0YBqxp1YeQYkcFNvCS+HQbrj91KJGpcdvAJfH8dZG7OmY1A86ktzi9X6gF
 0+4QorLkGg1SgLjdbcAUPHyk2b6gYcimwDfB6+8XqGnDZYfkF52/wV0Cer09QnV5IqeQEnpwRbbVm
 aOeveuBlRGIKOBEE=;
Received: from mail-yx1-f51.google.com ([74.125.224.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMhl-0004Za-PJ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:41:51 +0000
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-66807ba2f0fso5396174d50.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786117304; x=1786722104; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nGoCM2e9Adogn0qG20upMZxxQT2t9+y0kQxqYwkOIoc=;
 b=FBXqbVZSPQv7jWvoyc+dn1gY/88Mr8eokXssjARWxa8nhvqoSZOsFsCgPsPMcpoYsn
 M2AVNdF3/nFm7+5qYUOxsIBiGkxwpbSvCFHH5tO538Dt+azztPQ87VSbBEA0t6Tl4Cai
 GzVO6jA1nUujxwtO61naIYZIUQrXDh4xmzTtceKWM1F5Jcx2Pu7nhWonj4NJmacw/MUH
 WyOqQMeLlW5uTDbJD4RGC5VpRlRHiYdfsq81nzXk6uIKUJ9iacT4Sls+r3zt52hItpOT
 geXVtDo4VjNIZiBmHPmwnhYqJ7GKp022kOj7SATyrQRqahSE9xQ4HkZzsBrQJv8tUg9o
 IXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786117304; x=1786722104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nGoCM2e9Adogn0qG20upMZxxQT2t9+y0kQxqYwkOIoc=;
 b=qYmGjp/2HcoTWvE6JstnM7zl8N8agzLbPxRD1/qdhXL9D0m4NUk6LzYWE8f0MmTDUs
 B9+v8+isWRgvBPBv71ua9WwiOfHQLwkr+zKg22mTuaQmCdGVNZL4b3lkgNNe1BLslCzO
 6q+dKCYjPMsqDn2H0IumQYfkacTurCaHdW1hdYfyphgsQ7mF3grLVKPGgtMGE94rSq6n
 HgJ6/yTZAycRKUgXAJc+wHXgo3+lNRoXJC7e5Q6voQ+M5M9JswIagDr2t6Jm8BSifhkc
 sWdjaMvSS1gGPIHHtrByB2alCnkfCZSH2JvqmxLJN7Wf+cpCZEEf9b3tKPwPAoJVBmep
 Z+sA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLjtUkDYo+bujvG6kCf3nsCdorYio4aa1FQt39AntvlyOzsXBFkmHm9DZxEYe6YeFBeIs1Bm8gB61OvgPZLPTe@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyjIY03Nkg6YSgXk6IeJtN7AWX74Y4IFk9ecdFRCGkTRlvA5B8S
 YSrjWGKzG8ChqpUHMdZU9wWkUvZaTVuf7apKlKdvA39EJhJba1+67BB8iSSxBwCc
X-Gm-Gg: AR+sD13Lq3SfvSAxeLYb44MFWpFS+4YE3/l71zLIZNdbETb900DrG+Q02l3sQ7izfcU
 cCa+O2p64zlyHPXCxWBmifBn2b6EBYG/QTInowtFmxDl3tEgMt3NuJjAN7dBSQCKzmR968lCiXl
 IOSSBOM3OkRCnChaNV6xPCCtWG3c9cRbP3izFEhaJzYjixIMoQgauP0O4j9FwVOUAGMjsfIftLb
 MIkIqnDq8PabvRXEChxu9u/L3W2iPd+kEvMAEAoinHydnS6wfRYUcCEVUATVCDwVxe+yfDHhkxk
 EkM+1oYDGy9JJJ1/X/n/72solfEwDkt2LViGwrDcKN2tJkUCCzpSnzDFs7OPyDVjIrHLeObNZZ8
 oXdGHxeTkZax+l5PafU/Y1c88rWOvJP6R//hJZEtz9CDkA/Na4nGt0Rsm42ePgUMRQlZSg8UE49
 PZqdGbNTOYqZVyvEFr8/eF8OOtkTIL2S6mpR3MRSSYwdCCFNw4FhroB6pkLHrY74/6UsRzjJBZP
 9jcPftXOrOJm796M801DHMnnm4g2GwexQw=
X-Received: by 2002:a05:6a00:4fd0:b0:845:2ff5:b66d with SMTP id
 d2e1a72fcca58-84f2e152632mr25564158b3a.35.1786107892131; 
 Fri, 07 Aug 2026 06:04:52 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a3a20c2sm1029019b3a.6.2026.08.07.06.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:04:51 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri,  7 Aug 2026 21:04:45 +0800
Message-ID: <20260807130445.465203-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wsMhl-0004Za-PJ
Subject: [f2fs-dev] [PATCH] f2fs: return symlink writeback errors
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com, stable@kernel.org
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

Fixes: 424fd5d831e1 ("f2fs: Remove f2fs_get_node_page()")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
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
