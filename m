Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D012CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdRF+Jw7086LO1xgzcIDsvJdg1GImOMs4GlyNT0YmgM=; b=jCf6yczya29XfSFbH3mokQxuXu
	qvuZFfcf59pbg3TQGqab70BopsS7qpzAH1KbkZrd73BsAabH36F38OrsL1FmFSHCBEQTl60JaY2Jo
	MFIwYHiEBdg2KV81VfFAGIv8C7rnlxRBKyy78jrEBQL9Qk2Xf9wvK0SOncbZgDUfsug4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGsl5-0002sZ-MF;
	Wed, 14 Oct 2026 06:46:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGsl3-0002sE-IR
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ur+YE4EinDlUJK4OpPyj0bI4FZo3c/8XiooTF3N5tKM=; b=XDRgxkk9kKRvlOloOSv9ZJ0tWr
 GD2mOsI/44ZnVRBlNkVjS3h1ZSsSuw+shtyQn4Y+uwYj1W1dTOsr6YXBKa4+WDQLzCC/vXPic/FiU
 cbWbGbs8GSc1V61hzR1xwkvpRd0tx5juwWSJZyNxoa9hogpOXsRxtGvCD1SiJSbU3e3E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ur+YE4EinDlUJK4OpPyj0bI4FZo3c/8XiooTF3N5tKM=; b=UGBvBRxjh8va2pcEx4kj4mt54B
 c0Fy0ml44hWaz2FoxHSH3UjduU6Gy7ORVNgYjLMrCvGgMrFg61ExnH2je8/4hhtV5Mi0knOcmCUYn
 12PJoRUEqlhES3uHIi2dae1cLYlBd6k8/UReowIyQ9kvG7H82mf7Ywuj0bS76t+ln55A=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGsky-00010s-5h for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:35 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3ac144119e4so1005770a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960386; x=1792565186; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ur+YE4EinDlUJK4OpPyj0bI4FZo3c/8XiooTF3N5tKM=;
 b=eSYoiAuBHHVKDn8slJ+1lNQRL8hYwEH8FfZFCfKLgNaaXn0uAxOk3XnaGNq7/GebqI
 h1/Tt3942f3ueoUNvvYP1El3gwQg7Fy/ldWh2Su7lIB8GKMiAiu2XVnIJz8SYJIaQVCm
 08pj+QVQfQeEmaTODcRZBov36eTBNowtZC7veOVvB14fBviK6Vq+puqbRBzCFc4ItUIj
 BqVJbaASaHyeF28N/C2UShnfFvdFJRW+yZiLpiMnX5I+bdJid8ldtpBg7tIp+u9/jecT
 OY4DTsRjsoCyQ2LU+949Wqxa62oPF1vvoYZWcPdudCjba9d8PRfd1WEhoYet1Q6t1fUh
 TKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960386; x=1792565186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ur+YE4EinDlUJK4OpPyj0bI4FZo3c/8XiooTF3N5tKM=;
 b=Y0Pt0yfGKQuHHH1l1taPgt/ZRkrAf0WmtZdyVJVIgDDi0ljRjSC8ENWfWvgpnhb++j
 XyWF/7f9ctDuLcLW69BZzGjku035Krx/iEf+PZ82HFP9ftmTMhGYmLIWXWZTmOtwzw9O
 dOqTsBgmFNA5L+5mRT70X1wwP+SaNmxrbnQNiY3lIuWFHO/Xg2NBj2xzRlzKG2fFXkU2
 k2BkPxKHeS24lC37m1ac89Aj8BNpzdIOHMAXHqYVc0kP/cQJuW11xRSHGdiuNOrXjgDs
 ShgEx4NYyLfEp8vUkktMqcjqTfzQ0/lptT7xjIeSvURGgagiR8ygkipk6Rkbrkh69WLF
 19lQ==
X-Gm-Message-State: AFq9FYJAQP7jp3lnZfBJ8IOuNMqcnlC0XZhvvyHw89fOIpk7tYmTwMxt
 s4TqPV5mHohdC/BP/2gQBbMNCvcc8jIWo048J5cDxEY/xY/uDQ3sVQahbSl3DBUv/Ug=
X-Gm-Gg: AYBFou1YCgkpUXLTXltK+2syuhHlHo+pPMGVjkvMfeiNxavRB5Hl01Yt6d9LQvb8Sug
 fxW39rRLp6mH1NDqfBOVMIsm2Gq+3OpeYkDfpfhnQo0VdF1YzSP0G+EcaOhpOu8+AHMXN3i/flg
 5+TYoyKpr2LxgO1oFLVLG6+ooneXm69HPNFovxDP9l7zZTn/5/6V3IXPkRcU1W2ox7EZARo20Ku
 VUY2EiNB9Hp7LMN8/eTljutl6HRMoMk+e/D4PbyBMLqR1p1mcCXLvDmrupUP7/n+3xO/ebHDfWb
 NLu6iqCKwsGYTKxnr2irpxEgINR0TljqGVj+uQ5Esi1bxsFOFJYCdBCecA7kA80sFEPF1k56ywB
 9wvKptAbvjQ+9ZN9UPlZPO2gQipV/34uXPazZMtAZdM37nexBFXX6qjKJycjAHwJFNgF78NKQQ8
 0y7sTxxzdYShO3UCa6oTZw6BSSraMdTACs7BjWzZAv7S2F2pZivbnocR2WS70Mjoaa3CEjHtqoz
 OumStttBKpXo74NgCXLiy0On/qiQi98eeQ3q4Pfr1VxeLY=
X-Received: by 2002:a17:90a:1582:b0:3ab:9c73:130 with SMTP id
 98e67ed59e1d1-3ab9c730935mr5606186a91.33.1791960386450; 
 Tue, 13 Oct 2026 23:46:26 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:46:25 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:45 +0800
Message-ID: <20261014064445.2835813-17-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGsky-00010s-5h
Subject: [f2fs-dev] [PATCH v5 16/16] f2fs: make compressed files compatible
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
index 771216f45207..b4f436ffd9ac 100644
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
index a476464b856c..f6be297f9f59 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3242,12 +3242,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -5245,7 +5239,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode) &&
+	    !mapping_large_folio_support(inode->i_mapping)) {
 		int ret;
 		struct page *page;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 803e2b9900d1..9282b16fc222 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5025,6 +5025,13 @@ static int f2fs_ioc_compress_file(struct file *filp)
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
