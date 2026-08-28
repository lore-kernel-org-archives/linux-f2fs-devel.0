Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D455C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fsVnWN8tAXYEYbEuTp2oW046mWEItX5MtsvEsEyeemY=; b=GZdDZ96fitEeVYtwkfsNNpc6yq
	TIL1Mt5Y0HMRbmmeIzaJ+Qiao/+I0vXG/ur1Q7FcFs7172EwSLSvRvMnPcu4i2o6Zpvn7k5PWyqLE
	F0MCzvmsPHeG9AIhr8vUnL5XxLbK/ZaKgOsKPaSq4nj3Bh1cHXG9WKHk7pU2C2+8JNIA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzqtH-0003Ma-9y;
	Fri, 28 Aug 2026 07:20:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jeuk20.kim@gmail.com>) id 1wzqtF-0003MN-8e
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G6Ag/tYf1DhNwpo/YB9MI3UoakQSnyJqri54EN1XefQ=; b=dEve2tVHxspouui0m+xQkuGd4M
 po94s3SFGyLqYAFKZOBB2ZOQ7bzrtPNd9bLTW/fy6xGG5wQAD59k0ReULB8M50h6chYfB+0CeOKiD
 hHQPCXa7WtKxOsqI2/35qujUNpPIOSm548psBRR5Mbx/FaFi+cmc2AgfW9LNvnae+Lk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G6Ag/tYf1DhNwpo/YB9MI3UoakQSnyJqri54EN1XefQ=; b=QjzT+kPwXjakLvHYlLNSCiInXs
 MiJTb3h3497iGsDKpgmeWfoBw8kyWL+IvJadPPvD9No6j/us5LSJ/9dh25oa0ojLXEMhc0/4pHDM+
 o67Tw46T/MCq88mC1TMuEf0xFShx8kQP8sZyRabgZ38qHkgDVekSKLWW90ohiqDMZIw8=;
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzqtF-0001SG-Fm for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:20:41 +0000
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc1cc97b84bso699619a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787901635; x=1788506435; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G6Ag/tYf1DhNwpo/YB9MI3UoakQSnyJqri54EN1XefQ=;
 b=S8SdIM4woXtyEcocOq1lRDoyHfrnRfwZvA3xVOPJUNG3oGO55RJ1igp5vpfP23+WdM
 TZdbhlWxZoTrRw2mQKIA3y+crZBdU5H0W5w4jktwlrVX4pmik/5viqK0gUvaMJV3CA5B
 kdz0TtHS92a+je06ktWeneYpXpA3rXUiDQdAod7sgjyv9dGYCRx29Y8YHi4G4W0PZGvq
 UrwjK3+p2b3+3RjWPUNeYbT2b8LzR6cwYF9cXDaHESKEzLvzM2IOdco8dSwvDgOSdZeI
 WP8mUF9kBuf0KSa9bkdn3uAd6OSoLfuvActBUa975W+9cfQeZoZYPf3DAclmZlTwg+Zi
 dcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787901635; x=1788506435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G6Ag/tYf1DhNwpo/YB9MI3UoakQSnyJqri54EN1XefQ=;
 b=TXczGLfgffQjGH7GjV3FEj6l9/2oAH378xAnsmlFoLKRyv8SXeNq8Lx305BACfS206
 Zi6pNjre+xf4kQRpNs+S8YBwiAcad2OP0LHtzPgRP1eGazeXKrL02f8475tMmTNqa8EG
 9j6VdtocZEUsAG8oPJZxqh0ADnsGwW2mZRCuPtXc9UKSRZTih4z/EHUAbJiUgIr1YE89
 m2NQaD8syYw5kvzXYzraEus9JP2Yv7s/MhEMrrCLr5oPPP3RsVsroiHGD+zcf9wycdFD
 aZJBTvIt/n2nIcJaFi56u5p2POSS5hvX6KVlbibfEiYrin+dwsOdKShC8hIMePJGdt4T
 2llg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYGeGt+3KPLv9sHXq/eaNGutT2xSiDJjchsyEBaNymBv3T6chuiqp1R/BUW/252FQayH+jg1mWYHEWGIT71R0h@lists.sourceforge.net
X-Gm-Message-State: AFuF++l4GqI3ORDbNALN04JjUVzkaIQsn++nIM3XwqTGevCyKSilTSNY
 XcVZ8G+AJN0RlmMrV4iCMDZ3v+JfVvxb39s4jwe3CcL/XM9eYUK8J6gFh/aWcw==
X-Gm-Gg: AR+sD138aheX7uDyxaIhisjusj2E6bbt1xBYHS6JzjKNuZEhZYnT+6QVXJBYwYiNgr4
 WIrxF0epHxlV7UGy86TVG9f+2W//84vO4jfOgzYAYZkUOKfR6lIV/z8ZHI8DILmjXBElSibQ1Ab
 97HpRDS/U3LSb9+XsSLJA5GQiEJh0hz0BmxfHBQwjl4T4FBp2Am+MwEIbNQ3GS6zgbtvQtgjEFl
 dZY02p+PHlVxrRAslfThlT8lSqOTHdrlxaAFBbcFtc5hwwVsrw9udHWX14Xmw8ccps3sXSe+coC
 ZXvRI0Fd7x+G17g7aiZUsbF0Gg68b7+UxK+PsDJhBIB5HmXs6k7JiZhGPHU8Wv0VoiWJQbkD1M6
 XGt0DqlkAOx7gv5y5rJpDCT/1uLA9wWDWajhoxLYmDW5pQAtJcwQM0D+ajtgsROwW2QDh/owOj2
 L8Nk7nK8q55TWMA3UjiUP60kJJmzwA9mYZ9v6axKtKdJ7kkuDh3WiWWgrmFiXLRa5eOVk=
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-396d0f6f8bfmr10437037a91.10.1787901635511; 
 Fri, 28 Aug 2026 00:20:35 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm6123731a91.4.2026.08.28.00.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 00:20:35 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri, 28 Aug 2026 16:20:16 +0900
Message-ID: <20260828072017.44569-3-jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828072017.44569-1-jeuk20.kim@samsung.com>
References: <20260828072017.44569-1-jeuk20.kim@samsung.com>
MIME-Version: 1.0
X-Headers-End: 1wzqtF-0001SG-Fm
Subject: [f2fs-dev] [PATCH 2/3] f2fs: fix in-place direct I/O overwrites in
 LFS mode
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
Cc: yunjae00.jo@samsung.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Yohan Joung <jyh429@gmail.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Commit 351bc761338d ("f2fs: optimize f2fs DIO overwrites") stopped
setting m_may_create for direct I/O overwrites of allocated blocks. In
LFS mode, this causes the existing physical blocks to be reused instead
of allocating new ones.

The physical block address of logical block 0 after each overwrite was:

                         initial   buffered   O_DIRECT
  mode=lfs      pre-fix  6596096      88066      88066
                post-fix 6596096      88066    6596352
  mode=adaptive pre-fix  6596096    6596096    6596096
                post-fix 6596096    6596096    6596096

Set m_may_create when a direct I/O write must use OPU. Since allocation
may sleep, reject NOWAIT writes with -EAGAIN. Keep pinned files on the
IPU path because their block addresses must not change.

Add f2fs_should_opu() to keep these decisions consistent.

Fixes: 351bc761338d ("f2fs: optimize f2fs DIO overwrites")
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 fs/f2fs/data.c | 17 ++++++++++-------
 fs/f2fs/f2fs.h |  9 +++++++++
 fs/f2fs/file.c | 11 +++--------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dad5c2bd5888..618e6fc2da0c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1644,7 +1644,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	if (!maxblocks)
 		return 0;
 
-	lfs_dio_write = (flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
+	lfs_dio_write = (flag == F2FS_GET_BLOCK_DIO && f2fs_should_opu(inode) &&
 				map->m_may_create);
 
 	if (!map->m_may_create && f2fs_map_blocks_cached(inode, map, flag)) {
@@ -1717,8 +1717,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 	/* use out-place-update for direct IO under LFS mode */
 	if (map->m_may_create && (is_hole ||
-		(flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
-		!f2fs_is_pinned_file(inode) && map->m_last_pblk != blkaddr))) {
+		(flag == F2FS_GET_BLOCK_DIO && f2fs_should_opu(inode) &&
+		map->m_last_pblk != blkaddr))) {
 		if (unlikely(f2fs_cp_error(sbi))) {
 			err = -EIO;
 			goto sync_out;
@@ -1810,7 +1810,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		ofs++;
 		map->m_len++;
 	} else {
-		if (lfs_dio_write && !f2fs_is_pinned_file(inode))
+		if (lfs_dio_write)
 			map->m_last_pblk = blkaddr;
 		goto sync_out;
 	}
@@ -4513,11 +4513,14 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	}
 
 	/*
-	 * If the blocks being overwritten are already allocated,
-	 * f2fs_map_lock and f2fs_balance_fs are not necessary.
+	 * Out-place-update must not reuse the existing block, so ask for an
+	 * allocation even when the range is already mapped.  Otherwise, if the
+	 * blocks being overwritten are already allocated, f2fs_map_lock and
+	 * f2fs_balance_fs are not necessary.
 	 */
 	if ((flags & IOMAP_WRITE) &&
-		!__f2fs_overwrite_io(inode, offset, length, true))
+		(f2fs_should_opu(inode) ||
+		 !__f2fs_overwrite_io(inode, offset, length, true)))
 		map.m_may_create = true;
 
 	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8376bbe58ee3..e85d4db3a401 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4938,6 +4938,15 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
 }
 
+static inline bool f2fs_should_opu(struct inode *inode)
+{
+	/* pinned files must keep their block addresses */
+	if (f2fs_is_pinned_file(inode))
+		return false;
+
+	return f2fs_lfs_mode(F2FS_I_SB(inode));
+}
+
 static inline bool f2fs_is_sequential_zone_area(struct f2fs_sb_info *sbi,
 					  block_t blkaddr)
 {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 51518caee460..37d4e5c8dbcb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5022,7 +5022,7 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 	int ret;
 
 	/* If it will be an out-of-place direct write, don't bother. */
-	if (dio && f2fs_lfs_mode(sbi))
+	if (dio && f2fs_should_opu(inode))
 		return 0;
 	/*
 	 * Don't preallocate holes aligned to DIO_SKIP_HOLES which turns into
@@ -5166,7 +5166,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct inode *inode = file_inode(file);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	const bool do_opu = f2fs_lfs_mode(sbi) && !f2fs_is_pinned_file(inode);
+	const bool do_opu = f2fs_should_opu(inode);
 	const loff_t pos = iocb->ki_pos;
 	const ssize_t count = iov_iter_count(from);
 	unsigned int dio_flags;
@@ -5182,7 +5182,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		/* f2fs_convert_inline_inode() and block allocation can block */
-		if (f2fs_has_inline_data(inode) ||
+		if (do_opu || f2fs_has_inline_data(inode) ||
 		    !f2fs_overwrite_io(inode, pos, count)) {
 			ret = -EAGAIN;
 			goto out;
@@ -5192,11 +5192,6 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 			ret = -EAGAIN;
 			goto out;
 		}
-		if (do_opu && !f2fs_down_read_trylock(&fi->i_gc_rwsem[READ])) {
-			f2fs_up_read(&fi->i_gc_rwsem[WRITE]);
-			ret = -EAGAIN;
-			goto out;
-		}
 	} else {
 		ret = f2fs_convert_inline_inode(inode);
 		if (ret)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
