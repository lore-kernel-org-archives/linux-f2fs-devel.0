Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9509CCA487
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jun 2022 20:18:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1vwh-0000Yv-3l; Thu, 16 Jun 2022 20:18:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1o1vwg-0000Yp-6z
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 20:18:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PDIZqzl/idQMig9q8LMn5o42c1Rx/QHxWuYhKYT1tfc=; b=efjjC7wyJqSwO+FmKSdHAGuMaP
 ZbE1g8HSKbP3BZKQqIjmyL43aEzS4QN0S26fZhYje5+Fu95C+BCzoVt49bn4mEQldHmCli9d0Gy3/
 cVxGC7l/Wqo6tfgS4aYDJ8fyZ05Y4oc9alT3F0dyBDF1UbKDNDobCIxwjLAOiQgTG1w0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PDIZqzl/idQMig9q8LMn5o42c1Rx/QHxWuYhKYT1tfc=; b=E8n90TT5PHFoWehJvwuDLoUpMj
 YUwrcJ8oBOhbKPYqF0Cp7kl+wL0JMkupNTLwaLOaYYhVSFAUvfJ+dlWNlTotaMr/5HlwRfz8D4EBE
 yxfiXsU6v9QDteBMKuGqHgDsVYT37pnybFarEU5jF5O8h1uOjLuK4fTx3QXr+aOP5aJk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o1vwb-0005ak-Fu
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 20:18:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 71A5B61DBE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jun 2022 20:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07399C341C5;
 Thu, 16 Jun 2022 20:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655410697;
 bh=URKy9Zt/QltsQ+h+W4mrYiZ/kVoFvBb5ZeUzGoPXZow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lFLzcJUofwsKTex6o428Z6VolGjmZN1oveS+3HiSv0NuCZ66QZ+5AW0m65muyZYen
 J2B4OfaiGJu0DhFxGwPPYE6dQWHqW6ZvyHK3azfYVO6XQGwdbCUx8SXalZOiI2w4TE
 WMRZfHuP2By2chQ47aDs8mrTpNRZxcDP/dmV7Npc+1deAUj7YkR4WWsOWuGizA/lCC
 DBF5JF8RlRB9WLSCbypGxvte96vrRF1JlT2LfxMY7PtUVPvSMJkfdxtNmtQMp+CTtk
 8h0oHhngArgkswPusD0kX120GHhPBMgz5FPxFq3Cq/Q6I7BEEH7EVq4Pur02Xbwanh
 Jmt7Yx/qiV43w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Thu, 16 Jun 2022 13:15:03 -0700
Message-Id: <20220616201506.124209-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616201506.124209-1-ebiggers@kernel.org>
References: <20220616201506.124209-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1o1vwb-0005ak-Fu
Subject: [f2fs-dev] [PATCH v3 5/8] f2fs: move f2fs_force_buffered_io() into
 file.c
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

f2fs_force_buffered_io() is only used in file.c, so move it into there.
No behavior change.  This makes it easier to review later patches.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/f2fs.h | 45 ---------------------------------------------
 fs/f2fs/file.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7869e749700fc..d187b7d7ed243 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4426,17 +4426,6 @@ static inline void f2fs_i_compr_blocks_update(struct inode *inode,
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
-static inline int block_unaligned_IO(struct inode *inode,
-				struct kiocb *iocb, struct iov_iter *iter)
-{
-	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
-	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
-	loff_t offset = iocb->ki_pos;
-	unsigned long align = offset | iov_iter_alignment(iter);
-
-	return align & blocksize_mask;
-}
-
 static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
 								int flag)
 {
@@ -4447,40 +4436,6 @@ static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
 	return sbi->aligned_blksize;
 }
 
-static inline bool f2fs_force_buffered_io(struct inode *inode,
-				struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int rw = iov_iter_rw(iter);
-
-	if (!fscrypt_dio_supported(inode))
-		return true;
-	if (fsverity_active(inode))
-		return true;
-	if (f2fs_compressed_file(inode))
-		return true;
-
-	/* disallow direct IO if any of devices has unaligned blksize */
-	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
-		return true;
-	/*
-	 * for blkzoned device, fallback direct IO to buffered IO, so
-	 * all IOs can be serialized by log-structured write.
-	 */
-	if (f2fs_sb_has_blkzoned(sbi))
-		return true;
-	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
-		if (block_unaligned_IO(inode, iocb, iter))
-			return true;
-		if (F2FS_IO_ALIGNED(sbi))
-			return true;
-	}
-	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
-		return true;
-
-	return false;
-}
-
 static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
 {
 	return fsverity_active(inode) &&
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bd14cef1b08fd..5e5c97fccfb4e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -808,6 +808,51 @@ int f2fs_truncate(struct inode *inode)
 	return 0;
 }
 
+static int block_unaligned_IO(struct inode *inode, struct kiocb *iocb,
+			      struct iov_iter *iter)
+{
+	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
+	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
+	loff_t offset = iocb->ki_pos;
+	unsigned long align = offset | iov_iter_alignment(iter);
+
+	return align & blocksize_mask;
+}
+
+static inline bool f2fs_force_buffered_io(struct inode *inode,
+				struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int rw = iov_iter_rw(iter);
+
+	if (!fscrypt_dio_supported(inode))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
+		return true;
+
+	/* disallow direct IO if any of devices has unaligned blksize */
+	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
+		return true;
+	/*
+	 * for blkzoned device, fallback direct IO to buffered IO, so
+	 * all IOs can be serialized by log-structured write.
+	 */
+	if (f2fs_sb_has_blkzoned(sbi))
+		return true;
+	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
+		if (block_unaligned_IO(inode, iocb, iter))
+			return true;
+		if (F2FS_IO_ALIGNED(sbi))
+			return true;
+	}
+	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
+		return true;
+
+	return false;
+}
+
 int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
