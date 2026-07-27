Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9235BC53219
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3nag+fId/rPRwVjVZDXunObiOnay6p1sEN7tjJoUabg=; b=N4VxWaYNDjgY3Rphm6mijIyQSI
	u0kKLsKq2OnLd8qu5p70/HAZkhWaQ7opiYoxCloWrgNLKTdPzqUORcea4mi8ARmZBpDg0up0Su0ui
	xsJIKIT6tixehvsa/YqTg5pVTTewXwc17t7crkvRJEh6hflqH7aJbi0VJwEBZ9sXpgpM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woG63-00069y-5x;
	Mon, 27 Jul 2026 07:49:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1woG5Y-00069Z-QQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 07:49:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z2/oOWpo9tJP12CLTvUgY6rH53vcLF4vAH40BI1TML0=; b=VGCUV9gcDPo8kzV49VErx5TycW
 UTwb3DF9FvWMnajO2yfykIr1+QnK7tUdYSptoxjFB2nioxhxf4oGt8k6pTMGi3gBzK/z5x1xWWNnb
 r9hud+rWRZ7Q7nglKa73OcenQPAk4K7/7a5QomPovqVFItbd6qo6bZLFjsZDVNvdGoXY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Z2/oOWpo9tJP12CLTvUgY6rH53vcLF4vAH40BI1TML0=; b=k
 Zrsv4/5fVRFSCSsia6qE7g7FEaYvMYCeS8a9yibXgzoQ1wRNouUvFoNa3gLYXviaxC9vO0PBCgtr6
 NvoR9AYuPf5epgkRTq+6Hl1CjZ7epCFNk0boZRuhHx0yk8vbQpPkYzsZ5THgl7BT6R2ueIqhKbJY9
 9hBbiRqAjtWnaA8g=;
Received: from mail-qk1-f181.google.com ([209.85.222.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woG5W-0003wx-P3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 07:49:29 +0000
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-92e6391b114so171235885a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785138561; x=1785743361; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z2/oOWpo9tJP12CLTvUgY6rH53vcLF4vAH40BI1TML0=;
 b=Q4LdFg6SG6MzbPL0Hyu5kf452z+WnxHU0S1pM7IneeiT92p8X3Ep+awwohX1i5dcIP
 trZl4CpcILjCToZ+v/VpXEKmfTjLlWRLqFSUDYQNYQuD1nwWKzjGUmEatNPUkhgTVQtX
 mo1TXKEwkjE64juIO6Za7nid2SerqySFjlzaa/qRRP10zqijWq/jvUWLkwxreFCX+U3Z
 wYC8Gz7oWVYZrX4irCs2DG/twtP5SI28a6oPatXTisOGKZKynjQher7XsTM7Pk12F9Q3
 mrfuDMd+aCXiCM2i516Pye/wrtbk3BWdG17Dg4Frbi3G1s7/x3Cfug+LamcXvyeKbWvD
 voDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785138561; x=1785743361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z2/oOWpo9tJP12CLTvUgY6rH53vcLF4vAH40BI1TML0=;
 b=ZoMI9MhhuGMBztCh6PnsSmycynVSR9zBw6yIn9buq1jpfKjItg45Rni/KkEozUFVTT
 xcajxmhuCByP2ntQhW+kJgMtyPleiTCSLh2vAaOyuiklkXMODnNBlexN+KgDalfldoki
 tRAVqLg/l3kBsVNLdpDOPlKrQJ7pUjn49g0q0Dx8qTqrS2iLtiomunW9RFUgoJAvChdL
 RzGvcx/JGzMSdP+Y999uQNhmJAuBY7r+hiD/kG9DYnkH8vgBsPOWc5ieTF04Cutjd1cj
 wGAHtvVMtXQdjqQV+6aBTAxLrOqY0i9HH7pd6bHDSdJGrFSTmdhKvY/tqfzXTed6H7lb
 ShyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqVTzeCqKTp3Wtlew2XQ5nfN6BKfxUcJWQAfUqMlUTTeMauOR+JFPEU0ptKRefLrhbpoCSKCV7RNjq+c7j3caL@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy7wTR/6yyij9mNu3tUmyAndfeQvpTe2+dzM/ZKGDvsBxls4U7m
 ZqZJWtys//NOtQBCNTihacTbgeg6uwjGRV4fkTvgEN0I+k2cjzpRgaRJwTRSW/6r
X-Gm-Gg: AR+sD10Ggtgv1RiMbme+BMbTG3TjEQiHAI5gyHE8s38GSfq0alIRHzYs+PyUBoyFNSw
 cnLchyR4+QtvW4L3peeNSGsKGJx2bjHn+cg/wWAAFwIJl8OjpxL3sFI0RfVkaHA7d9oiivPcZ9x
 RKCn3a2fxB5b7tONQrfb9aH4wW7TB2bARPQ+8y0+TgZA0thSW30ZhnIIm8Cu0FoUjQS72J7xii4
 gkyEVhsAdi8cYHBN55N11yrLpR6eB1clrHNRWIjMxbJbBXYagpRtNRFH/Bqed9NgkwfBgnup5KE
 HKDjmWiRq86lcL2QvuqMfgKk4XjoJ0rC+rH42/1olOKGQHkQkBx4yVFcVZdZ2xtKRq1EJZfPQac
 27olYsq1sLrv5iiQPdrPxsPSc8BjkaxpqboVs0DuKiWf6jZCIETJNPEuLfA/SR0DnRHPac3LB8g
 b7/eBmAuGROx0XKAbswBIZQTOXUk1NIrRqxmn00obgCpFlq0FG
X-Received: by 2002:a05:620a:3f85:b0:92e:c28c:9dff with SMTP id
 af79cd13be357-932df67a819mr728196985a.6.1785138560805; 
 Mon, 27 Jul 2026 00:49:20 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de54e09esm572480685a.17.2026.07.27.00.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 00:49:20 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 27 Jul 2026 15:49:10 +0800
Message-ID: <20260727074910.1965988-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1woG5W-0003wx-P3
Subject: [f2fs-dev] [PATCH] f2fs: return writeback error from collapse range
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com,
 stable@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_collapse_range() writes back pages moved by f2fs_do_collapse(),
but ignores the return value. If writeback fails, the ioctl can still
truncate page cache, shrink blocks, and report success.

Return the error before truncating page cache or updating the file size.

Fixes: b4ace3370324 ("f2fs: support FALLOC_FL_COLLAPSE_RANGE")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
QEMU fault injection:
- baseline: FAULT_WRITE_IO made fallocate(COLLAPSE_RANGE) return 0.
- patched: the same trigger returned -1/EIO.
- no-fault collapse returned 0 and fsck.f2fs core checks were Ok.

 fs/f2fs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c54897a25981..4bbd89320b00 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1623,11 +1623,14 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* write out all moved pages, if possible */
 	filemap_invalidate_lock(inode->i_mapping);
-	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	if (ret)
+		goto out_unlock;
 	truncate_pagecache(inode, offset);
 
 	new_size = i_size_read(inode) - len;
 	ret = f2fs_truncate_blocks(inode, new_size, true);
+out_unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
