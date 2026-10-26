Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA39606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=URJIsRRv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ChqpfIaS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZGJxMwek;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tBkpmOf7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=NG4ipWIBbyAibNonC3yOJQECxSZ+KmvdDfQ90LTc4Z4=; b=URJIsRRv8zLFxfhjn6XbkQQNDk
	HQrX5ZMllOAPQdPXZqWoLITxuYLpJ3FScYbSLPkoaRs3BLSjNE/lR//di/JyuCJpr9N4rZ7wu9GBs
	SUR1x/Q0Nrf4ZFtnjKVQVrq7GqnrMaatljSCwRAJYGmPUyE8THH5xr7BTRTdgaKkLN8k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBYQ-000000004pZ-0TYD;
	Mon, 26 Oct 2026 03:39:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBYP-000000004pS-0Tyx
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:39:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jpgh9dYKrbdOId0WvbDJGaczFPlU/X/b0Ot3e0dT6O4=; b=ChqpfIaSeMajHgwcR4G0bmbwAF
 DwiK0AzBbfYnm3t389AiDij9iUYi74rV+6PjMFk+kj26vGdIHcj/0Vf7ytHfQ52b6EfvnSXLwRgMV
 fZPYz4vNUZVPccOWyn3rYLge5tJuMZXxhaSmhsvENXejGoFQtlFUF3axlBGvRZUYTxv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jpgh9dYKrbdOId0WvbDJGaczFPlU/X/b0Ot3e0dT6O4=; b=ZGJxMwekPFTVZb61L6LgK0cm7G
 YZMW7dkX+vMq52M7kp5UDcyaE1j2iByFW09TD76o0CUVgX09EgcKIgiMl/I5IJAKvOoCRvt0ZKmFx
 5nFpeU3Q85FJKydICJTDfgxKX3SDmEGKUAFt2diplQjQvJdBf7AWro1tpiL/ao+yG6To=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBYC-000000002cF-0Xdv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:39:21 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-3ae08d3dd4fso788917a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985942; x=1793590742; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jpgh9dYKrbdOId0WvbDJGaczFPlU/X/b0Ot3e0dT6O4=;
 b=tBkpmOf7GghI+pRl/7DwDEZ+HVyzMHfWYfgiZ5ay4GRMdRqBRgdcqq0oS3CFL2+tG8
 leklzAlUA4IG3+qqKnJPvjV+8a+gG9g2nbFZiKzJ/3FkFdBFRwrhfrGKmr2umhm2n+fI
 muTv6P1AK+dRwz389fMRxK/5g5oWpNrWSj7K+rRarhr3SKp6GJqfeXnmOWlixpDfYjEx
 /zsBDT5zexkb/6Z5zMpaWm4i1PkXkS69Yl7vIj6vl9eIbG5Lj2s3XWppHojMlrWkj+bu
 ZEeE5fnPHxAhQQqfZmkzd61IAeBxmCkqzZihz67I0NDLjWnKQeviDSZ3eE6pXrEZKB6r
 jIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985942; x=1793590742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jpgh9dYKrbdOId0WvbDJGaczFPlU/X/b0Ot3e0dT6O4=;
 b=ZZpNuTWBgsd4NBP38UEqYoXCORQvIypy8is6lvXb9I+kbFez3XP+oQAuKDXpeO6nwi
 AXQKEoPER0Usq4r1o1pGA3PY5aViuGMwYJ6uDA1A2o+8fbSt5Cw9ekCmxbmciZd1d37O
 CGgoieWjjWidKFQ8E5/dW9uK4K/m5GfQcbGV7eGxhmKK1C5x3qdGegh0lJWpq/ZGDW3Q
 RY3RhF4G8SYIS83t1NxQx1HVYZJL+bDrVCAecsOS4oljtkPnxtHhKrTGONP2k96ml6go
 MhKgxZbgJ5llNpKTql1nrlpJ+MCwVCX9PRnksAHqo0jFH2x6T36vzadoBPoigSktRRfD
 bh7g==
X-Gm-Message-State: AFq9FYLWEIh3ojqMq3vKHqhhgh6m3ifWlT9RNwFEmfnV5JAQSeBKUaoQ
 asf5Ko2yop+b/P89N3+szQpWn3j/U6QKIPgQqXmcRFwXlWDGViporTzDRQ1T70rm
X-Gm-Gg: AYBFou36KGQLQBw5gZl8S5Pg6KVVOBS/Ujb4wiNBqtTL7SYRrHqyAIVhAIiF2gBRL/S
 XTkhlvdWwF5fXaaP7gC2SxnuURPaYph30ExBhV4iTuNV2FNrJ8s9NRjfSrCZ2ulwrCr7x+JOAF9
 U2HRkyVn31xUtuCTKMH2S/dFwpP4omHvO07Dg8acFbgUoE02EJOVJUsP1XFpILn9F8MIRNvSbB5
 FchF46PD4zdU49aAjd85qpv6v8Vs8ppGf7uNdXzCFXu/QNJTfSc8KJMhHKwBH1wrP267X/eaN0a
 6+3gCVqaBcY3PcX0rnFoT4oZq8VoxS/QUeL+yXv94Jbn1/2kKDoLDjmBW2o7eHURCny8scYWpwg
 axSlnEpqKSqbf7a95RLAd+gcPKZJcksxaOk6ljqG1r5FRQgG3XIE8/5aQ65nJ/jMniJwmANS6jk
 i7xTbk+2OCfr47USN79v9ZNLpV2bGnyhiVO1vcXaavEKCjZ9+VR2nupYhYcntUrrAttS7aOhuWz
 lgPc+5N7bzaR18XwybrvuaVFZEiZpZ4ByeQv3K7ieRu/tAx60bjH57UgMOoWpF2nAI9UerneS3V
 pc/jOuZkMNGyIZ2TvQ==
X-Received: by 2002:a17:90b:1c8e:b0:3a8:9b79:e6ea with SMTP id
 98e67ed59e1d1-3adeb122e89mr4984006a91.59.1792985942393; 
 Sun, 25 Oct 2026 20:39:02 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:39:02 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:45 +0800
Message-ID: <20261026033745.784107-16-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBYC-000000002cF-0Xdv
Subject: [f2fs-dev] [PATCH v7 15/15] f2fs: make compressed files compatible
 with large folio
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 55798421f2c4..b79bb67ee78e 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -942,6 +942,16 @@ Compression implementation
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
index 162bd8ef822a..721b01dd0d24 100644
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
index 4db92c85ea99..f0d2fcf10062 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3282,12 +3282,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -5313,7 +5307,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode) &&
+	    !mapping_large_folio_support(inode->i_mapping)) {
 		int ret;
 		struct page *page;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3d621a20766d..e61c80ae7537 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5021,6 +5021,13 @@ static int f2fs_ioc_compress_file(struct file *filp)
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
