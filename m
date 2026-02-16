Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBA3E7BD92
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BwYYd17rxbR12vI/VFewqc5z0cednB5TfpaOsYkixOw=; b=QN5D64OETd6ic0vY63Pb0EI3Us
	UjP9xNbEy+wN7RDPsoodmpuS+7DrzFguOBxlCc7n89VwtBRKOIQbPs21Jzz68VLrvwecBVAoLG52U
	2jJoNNdBY36paNNxD4ulmpH+fxHvR1ouCHDdkzB6DRX07sraqt3K53oKMkkwFZ5ymioY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vrwll-0004qa-46;
	Mon, 16 Feb 2026 11:28:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1vrwlj-0004qL-7Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Feb 2026 11:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NucI4rUIfP0ilWQf8Mxv4+Yxofb3SiNAoBRPZ+0xg0k=; b=Gn4TnjiwmnZcQp4oH8CfKloWOA
 SJmIiL164Ll8QWA1a04KkLegOu7UZnitbXIPcZ2OmAZ9mqhvTWZDiuUNc9ZEmHpyiDSkX/ULK3NoG
 pjVG3h+Lgbg4kHK3QrVFiu7N0pLFDO50kOBYbBLI4Azk2dQI7DzEROKXsCGF+Pco4TjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NucI4rUIfP0ilWQf8Mxv4+Yxofb3SiNAoBRPZ+0xg0k=; b=I
 uPOyCly7tplfJOTX8u9mSHljvgSEPzDeGgNEdwjXi5uzKvJXRE0Sq++Y/of/mKCvkKFzMxHNB+cFj
 TXum4JhMxKZJMK0bheIZHQZZen6EQGGaP08YQRy1SW1590pGO6sVSlSIFH19oqxHUS2tkKMSJhHkX
 7dW/Kut0ENpBHWDk=;
Received: from smtp153-141.sina.com.cn ([61.135.153.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vrwli-0005ct-1l for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Feb 2026 11:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1771241278; bh=NucI4rUIfP0ilWQf8Mxv4+Yxofb3SiNAoBRPZ+0xg0k=;
 h=From:Subject:Date:Message-ID;
 b=ahJ6K30M2n6CGdbfIU1ADq2dnkrmWAtbJJbhELk9L/8J0RZ3Dr7XmWEzLW5yRtEN6
 KoaepOrVIxdrzmgRqS12IT8aydjcfBfqClMvZ+ltofh8UL4RXu0u6EGGjUMKfKT2hc
 kKhU/E0mO41JumLjMjUVCCHUaHonUl9w7kThCP1E=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([111.18.125.202])
 by sina.com (10.54.253.31) with ESMTP
 id 6992FF2E0000432C; Mon, 16 Feb 2026 19:27:44 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 8961806816289
X-SMAIL-UIID: 2355BAFADDFD42359CFB302DC35EC6ED-20260216-192744-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 16 Feb 2026 19:27:37 +0800
Message-ID: <20260216112737.67408-1-monty_pavel@sina.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Headers-End: 1vrwli-0005ct-1l
Subject: [f2fs-dev] [PATCH] f2fs: invalidate block device page cache on
 umount
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

Neither F2FS nor VFS invalidates the block device page cache, which
results in reading stale metadata. An example scenario is shown below:

Terminal A                  Terminal B
mount /dev/vdb /mnt/f2fs
touch mx // ino = 4
sync
dump.f2fs -i 4 /dev/vdb// block on "[Y/N]"
                            touch mx2 // ino = 5
                            sync
                            umount /mnt/f2fs
                            dump.f2fs -i 5 /dev/vdb // block addr is 0

After umount, the block device page cache is not purged, causing
`dump.f2fs -i 5 /dev/vdb` to read stale metadata and see inode 5 with
block address 0.

This patch calls invalidate_bdev during umount to invalidate the block
device page cache, preventing stale metadata from being read.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1a755997aff5..39d3b52ceac1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2091,6 +2091,12 @@ static void f2fs_put_super(struct super_block *sb)
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
+	sync_blockdev(sb->s_bdev);
+	invalidate_bdev(sb->s_bdev);
+	for (i = 1; i < sbi->s_ndevs; i++) {
+		sync_blockdev(FDEV(i).bdev);
+		invalidate_bdev(FDEV(i).bdev);
+	}
 }
 
 int f2fs_sync_fs(struct super_block *sb, int sync)
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
