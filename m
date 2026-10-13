Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25CBCA9ED2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gRYy7ZpXc5RNuD7sZseb6tFFBZ95xD/lg3ARLRQSrfM=; b=dq2Lf9GgXeozJKqZxgI7I0djHL
	5Elv0z2TX2uVIlECsDhgPnMaHM9dsBrysXnLpYOGMRXpUsvO8d8YBnvbUlqdyMK+Tj1aU33HliXkF
	AOTRMhUiRo3vn8mIC8APlyNojRJzwr6GB8j4pe6dv7GtRCj21h1HAWkTyp/U5rKagC3M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb8v-0000sP-Pw;
	Tue, 13 Oct 2026 11:58:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb8t-0000s7-Qc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rEuvSE9QQ+v1bO5qTe3vxnOsinVCD9JZyeyKZPpujCg=; b=bWDjtOCERagvxqQb7lpsUyTUfT
 8ae5kgrcApWxcSaqO4/cqut6t6Y/6MaxQwD5yHgTr6h3+xrAqPe3Ey51mmFnV4mW1q6ril5KLMjaR
 IgVDlvfgf8uesaFYgS4CLAtyiHqVUajFxaUjGAfd9bbLjTPvGKj0GGgMKxtDNGBk6q4o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rEuvSE9QQ+v1bO5qTe3vxnOsinVCD9JZyeyKZPpujCg=; b=HIjrb+jvbbZHs/lq4qfsW4vr9H
 n24MwpCr4s2DHxplRORUL6Mt8FOYPDFddgQsIY4vN83czgu6XnkzjoAh0xU3IuR2O9C4oyBS/T/0L
 6ZmVhAO9VeN5qEe46aD41ZoCu8SRAvE2o19pZeF+TVhjeWbKRH5JuxBWuKhuFwQas/5A=;
Received: from mail-pj2-f7.google.com ([74.125.227.135])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb8t-0005TR-8h for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:58:04 +0000
Received: by mail-pj2-f7.google.com with SMTP id
 98e67ed59e1d1-3ac43bafd5fso69528a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892677; x=1792497477; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rEuvSE9QQ+v1bO5qTe3vxnOsinVCD9JZyeyKZPpujCg=;
 b=qhn6DHkeeiKd5gp/aTturoi3KE3eC0oqQdwLFLDZrQwW+YoC4qwfkn16HgGcz4Bsjf
 K9To96QlZjjHwRe/TS/zSgVD+h4lt5w+IWc85HkGKU07yOgW9MBBt4OsQw5sqwytY5ZW
 L/CT9Z6xGVeeKP+Dw/HwJVNiYIbullmtzYiOeMNDPxudCjWdV1qWYPuGP6Qw6Cw9MBFR
 qz4ViaUNftw+WtI+SV06Dck1FopHTrwUYqL62BBlWs1HAlQr8gjwYPAvw96c4Y9a0rKv
 lzr9L+uQF+KFCYMYFNUXi1T3hJ5a0P5zGRQ1bSJlI1899/KqlEF1EYe6MAo5VehjosLE
 cq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892677; x=1792497477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rEuvSE9QQ+v1bO5qTe3vxnOsinVCD9JZyeyKZPpujCg=;
 b=jsT5unBbQIMyP649WkKKug8ZVT7EjaFH2HlzZgVMyGnDl5p5VybF75QIX7MgDBw2Xn
 BI1NKsyodDbK8YQEpIRBVeOi+SShQ16tbiQQAfbZ2lFRMx+f/8B9mYmavGJLWBQ6JlXt
 bX4NJtcjjnLJOahL9jKQlt9Y1sLhoL0y9UaNQbli9bMfXX+RAK9ZenwZ/ECaCRaHeAh7
 EdaCyY4PhjjCsIcS9eyAcUC5JC5hff8JTYh0FPo9lQZt8YMcYNKx02BBRZJ5H5di+sxN
 iJaljYWXsRy+Np7sjY8rkOI2oMiULDsv/WT7Uk6XY/nRkFjRZYhs7GLG3alE8C9grqKG
 gzZQ==
X-Gm-Message-State: AFq9FYI8dhL//ZqA07AIheDGhd4c0KgM3CywYKoWoaFVcUY3g0TAwmZ/
 DJr+hH1OAjAPtX7N4UJ+duuACNGMNHcP90NMJbVgGPl5HWCWSXpUmRL7qwIPytgciTQ=
X-Gm-Gg: AYBFou1X7S629J1V+isoNKcjyV60+eWmc7dUL3L5giveh3k0QJ8pzNZjRdK39zpjiTe
 +Lj/V/tWFPzFTp8k2dx9axKpDdVEaFSHzGvotW1J35EXAF4IgQdUaUEs7kGukN/X+qyGfLTo/r2
 w9SNJLTHKImOmIoWq6FM+MkEr4whvJab/W8z/BzF1CqiYo6WuyiJSqIfGsI4wazwMF2oSmJJJwE
 4nKdemu5T9l/Us2A8k04r07JqDu2T0QoVBn8DOQ95JsMVdT4rPs9nQ6okN2dJ63ETUIM3ofIovT
 6XLmHdD0aH9+LGNDL/B5XELPexJVg7PUN0rrJwbSBTlFUnePR1/BxchSf4qhAiNSJUcsVviwf9J
 3DDynRSw+Un/eHRCx7++AHYE1bN4JT6y5DQoCh5xWI9nACzOHbKvsnpbgz7rciTWHwUbwKeDnl/
 eXxTtzGNw5xdKAquwwEs2w1tJ3a8jEF5qi8Ef0taC/nKaP7sM5mNwNaZPZ8PKiKJKCdon/a9fDi
 XjqfGSrVWxjtq+XRYF+mmrY/VVn61BboH4K
X-Received: by 2002:a17:90b:2886:b0:3a6:fec5:c186 with SMTP id
 98e67ed59e1d1-3ab3acf7535mr9649908a91.46.1791892677450; 
 Tue, 13 Oct 2026 04:57:57 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:56 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:21 +0800
Message-ID: <20261013115621.968742-19-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb8t-0005TR-8h
Subject: [f2fs-dev] [PATCH v4 18/18] f2fs: make compressed files compatible
 with large folio
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

The compression flag is the hint indicates that the inode can be
compressed, when the inode is using large folio, we expected it keeps
using the large folio read/write paths and its data stays uncompressed
on disk until the inode is evicted and re-read

Let f2fs_write_begin() skip the compression overwrite preparation for
such inodes and remove the compressed-file gate in
f2fs_read_data_large_folio() so the data is simply read/written as
regular blocks.

For the same reason, reject F2FS_IOC_COMPRESS_FILE with -EOPNOTSUPP
once the inode mapping is switched to large folios.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 Documentation/filesystems/f2fs.rst | 10 ++++++++++
 fs/f2fs/compress.c                 |  2 ++
 fs/f2fs/data.c                     |  9 ++-------
 fs/f2fs/file.c                     |  7 +++++++
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 771216f45..b4f436ffd 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -941,6 +941,16 @@ Compression implementation
   reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the file size is
   truncated to zero.
 
+- Compression and large folios are not effective at the same time on a file:
+  a compressed inode does not use large folios, while an inode which is
+  using large folios keeps its data uncompressed on disk.  If the compression
+  flag is set on an inode that is already using large folios, the flag works
+  as a hint until the inode is evicted: the inode keeps using the large folio
+  read/write paths, f2fs_write_begin() skips the compression overwrite
+  preparation, and ioctl(F2FS_IOC_COMPRESS_FILE) fails with -EOPNOTSUPP.
+  Once the inode is evicted and read back, it uses order-0 folios again and
+  compression is applied as usual.
+
 Compress metadata layout::
 
 				[Dnode Structure]
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3d26bdd4d..f9839e2e0 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -78,6 +78,8 @@ bool f2fs_is_compressed_page(struct folio *folio)
 		return false;
 	if (folio_test_f2fs_nonpointer(folio))
 		return false;
+	if (f2fs_folio_has_ffs(folio))
+		return false;
 
 	f2fs_bug_on(F2FS_F_SB(folio),
 		*((u32 *)folio->private) != F2FS_COMPRESSED_PAGE_MAGIC);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0e139b4ca..3647d5e97 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3243,12 +3243,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (f2fs_compressed_file(inode)) {
-		if (folio)
-			folio_unlock(folio);
-		return -EOPNOTSUPP;
-	}
-
 	map.m_seg_type = NO_CHECK_TYPE;
 
 	if (rac)
@@ -5202,7 +5196,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode) &&
+	    !mapping_large_folio_support(inode->i_mapping)) {
 		int ret;
 		struct page *page;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9cee36258..6cd8df7a4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5024,6 +5024,13 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
+	/*
+	 * The mapping is already using large folios, where the data is kept
+	 * uncompressed, so refuse to start compressing the file.
+	 */
+	if (mapping_large_folio_support(inode->i_mapping))
+		return -EOPNOTSUPP;
+
 	f2fs_balance_fs(sbi, true);
 
 	ret = mnt_want_write_file(filp);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
