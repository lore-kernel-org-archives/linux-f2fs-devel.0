Return-Path: <SRS0=Ub2H=66=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091DCC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 16 May 2020 01:04:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD9620671;
	Sat, 16 May 2020 01:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bQPg+EGJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cEdU8lU5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zzTXUDS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD9620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jZlFf-0006aV-Ks; Sat, 16 May 2020 01:04:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jZlFe-0006aI-1g
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 May 2020 01:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CpOoxys/ZN+Cpt1dwiPQ375eB2mOVKnFdQkSJKM/VYU=; b=bQPg+EGJuu/ASNRKobERQ93nsg
 9tw0DkAQIKvgEE5Kyhq95xJZnXlL8l3RwfNYW3cNQ7SKUW5ND7+i2C8PVLac/ECap4OljhQL+nZL2
 53vpZrqIIJvJbyk/yrJRm+uEnRg5WHCfUKWXQI1fztkfTe17M7oCY/fcFI6qgZxE6HR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CpOoxys/ZN+Cpt1dwiPQ375eB2mOVKnFdQkSJKM/VYU=; b=c
 EdU8lU5YSMugQOyNzpVvsq+wlnhXgfUD+6K5+t/IPboHx5zH21VxNN9tF7i62VrVn3Msf4dSKZ0ib
 TvUGB01dVSUllFmPH0ChVQuGgHtu1tPsrU6VP004qbouxRMqEAxKUM2QFzZvNQ0xxrF8giCUvuMR2
 WWGoJDTMhEqPHH3Q=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jZlFY-00CUHq-W7
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 May 2020 01:04:30 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 810FA20671;
 Sat, 16 May 2020 01:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589591059;
 bh=YxpuI17mMTnCsgPgr4+idWQJpE0CThxM8O7KvpRZj9o=;
 h=From:To:Cc:Subject:Date:From;
 b=zzTXUDS0VoiW9kPvGtDXz+emZ5aDm3SUE+Jo9Q9VFtrWok1oDDY6ZtOsTliuYBKcG
 +FiZZYoV/lqQiq3c+M/Q/PjLiHTxmMtfSEP9q/eQxFdgtoP5X98fxQorwIFn1b6UAx
 OsMpjAcVdB8qovjQHw8TYuJZoWYm8G2SydZIYRS8=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 15 May 2020 18:04:16 -0700
Message-Id: <20200516010416.116281-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
X-Headers-End: 1jZlFY-00CUHq-W7
Subject: [f2fs-dev] [PATCH] f2fs: fix checkpoint=disable:%u%%
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When parsing the mount option, we don't have sbi->user_block_count.
Should do it after getting it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 51863e4f5d4e0..fb180020e175c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -139,6 +139,7 @@ struct f2fs_mount_info {
 	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
 	int bggc_mode;			/* bggc mode: off, on or sync */
 	bool test_dummy_encryption;	/* test dummy encryption */
+	block_t unusable_cap_perc;	/* percentage for cap */
 	block_t unusable_cap;		/* Amount of space allowed to be
 					 * unusable when disabling checkpoint
 					 */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 441eaaf9739c4..a71da699cb2d5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -284,6 +284,22 @@ static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 					   F2FS_OPTION(sbi).s_resgid));
 }
 
+static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
+{
+	if (!F2FS_OPTION(sbi).unusable_cap_perc)
+		return;
+
+	if (F2FS_OPTION(sbi).unusable_cap_perc == 100)
+		F2FS_OPTION(sbi).unusable_cap = sbi->user_block_count;
+	else
+		F2FS_OPTION(sbi).unusable_cap = (sbi->user_block_count / 100) *
+					F2FS_OPTION(sbi).unusable_cap_perc;
+
+	f2fs_info(sbi, "Adjust unusable cap for checkpoint=disable = %u / %u%%",
+			F2FS_OPTION(sbi).unusable_cap,
+			F2FS_OPTION(sbi).unusable_cap_perc);
+}
+
 static void init_once(void *foo)
 {
 	struct f2fs_inode_info *fi = (struct f2fs_inode_info *) foo;
@@ -785,12 +801,7 @@ static int parse_options(struct super_block *sb, char *options)
 				return -EINVAL;
 			if (arg < 0 || arg > 100)
 				return -EINVAL;
-			if (arg == 100)
-				F2FS_OPTION(sbi).unusable_cap =
-					sbi->user_block_count;
-			else
-				F2FS_OPTION(sbi).unusable_cap =
-					(sbi->user_block_count / 100) *	arg;
+			F2FS_OPTION(sbi).unusable_cap_perc = arg;
 			set_opt(sbi, DISABLE_CHECKPOINT);
 			break;
 		case Opt_checkpoint_disable_cap:
@@ -1840,6 +1851,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
 	limit_reserve_root(sbi);
+	adjust_unusable_cap_perc(sbi);
 	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	return 0;
 restore_gc:
@@ -3516,6 +3528,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->reserved_blocks = 0;
 	sbi->current_reserved_blocks = 0;
 	limit_reserve_root(sbi);
+	adjust_unusable_cap_perc(sbi);
 
 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
-- 
2.26.2.761.g0e0b3e54be-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
