Return-Path: <SRS0=yhtL=Z3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1AAC43603
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:23:20 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BF12073B;
	Thu,  5 Dec 2019 03:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JlSbHkqk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="a55y7PAy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EJ8fUWl7";
	dkim=neutral (0-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="c+vcvVcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BF12073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ichja-0005Bv-SX; Thu, 05 Dec 2019 03:23:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <0101016ed414fd37-c3f603b4-8fce-456c-8d31-46aea4f7b1f9-000000@us-west-2.amazonses.com>)
 id 1ichjY-0005Bd-Qs
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Dec 2019 03:23:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vik3Lko93QX3DkVKqxve7umg/mlBSvmQWw2its36hbI=; b=JlSbHkqkbP/APJBLylr30jHeza
 4PkAvbffMkEmS2aDH+LL0aSTJQBwgiYlx7O8HzIFRIbGYcJ8krEitrwJxFXU4Q3A+Om24NhpG3tO3
 ODyNvuJ/OV0DHUlmLVMIDsDmOlshYxZ4zYh2c2QsA3BWrTVB0nh7kypGXV0Loumyh1X0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vik3Lko93QX3DkVKqxve7umg/mlBSvmQWw2its36hbI=; b=a55y7PAyrDepSTATuQXaS3Nm+H
 U/YjJ8Arrd07zCYajtdYUTOnjbxqMv7KYCJplKdrUjHTmMwjAk8YcWYvGWGVonJ3ulzL3l9O49vzK
 kPvmbGMHXg2kRMYV8HXPVL8stVAiOHi6SqpjLYQAg4y09vjshwfdguzkQlEO74qI2AWc=;
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-SHA256:128) (Exim 4.92.2)
 id 1ichjP-00ABJm-CV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Dec 2019 03:23:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575516175;
 h=From:To:Cc:Subject:Date:Message-Id;
 bh=ZxfkLmFazMJpiu9m+ih76+k+ybK4xc+/rzCa3efKykg=;
 b=EJ8fUWl7JHw8CMnTDw2QWsOjm3vM0EUEbc5oQwnJ1ahKZW93/zg2wbaI6FN1vxo4
 sWj9IxeTWdcVkz97RU8uxK+xhyALH6QpdRWLq7ls/duHZcG1SBQhqhDrdWytrJGWL98
 d+igbm8x0SL60GhjM0qW4OnnosokBWIAAkDma2QY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575516175;
 h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
 bh=ZxfkLmFazMJpiu9m+ih76+k+ybK4xc+/rzCa3efKykg=;
 b=c+vcvVcp4rY4qHS1flos1Bkhl1+5R5qPLGRtVcrIuEQhA4lJTYISzAGoE4EmGIz/
 4IsuCmCM8Bs9Wm0gn5MaYEdtMNy41Mb7iDaOeQ3faUomA9MD+O6rzEOLNWbxGXU/Mnq
 XhjDySsZgQBWcsCSUgqDm6ZOp9r4Dt1jrDe5UfiE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C940EC447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=stummala@codeaurora.org
From: Sahitya Tummala <stummala@codeaurora.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 5 Dec 2019 03:22:55 +0000
Message-ID: <0101016ed414fd37-c3f603b4-8fce-456c-8d31-46aea4f7b1f9-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
X-SES-Outgoing: 2019.12.05-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
X-Headers-End: 1ichjP-00ABJm-CV
Subject: [f2fs-dev] [PATCH] f2fs: cleanup duplicate stats for atomic files
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
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Remove duplicate sbi->aw_cnt stats counter that tracks
the number of atomic files currently opened (it also shows
incorrect value sometimes). Use more reliable sbi->atomic_files
to show in the stats.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/debug.c   | 3 +--
 fs/f2fs/f2fs.h    | 7 +------
 fs/f2fs/file.c    | 1 -
 fs/f2fs/segment.c | 1 -
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 9b0bedd..0e87813 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -56,7 +56,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->nquota_files = sbi->nquota_files;
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
-	si->aw_cnt = atomic_read(&sbi->aw_cnt);
+	si->aw_cnt = sbi->atomic_files;
 	si->vw_cnt = atomic_read(&sbi->vw_cnt);
 	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
 	si->max_vw_cnt = atomic_read(&sbi->max_vw_cnt);
@@ -495,7 +495,6 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	for (i = META_CP; i < META_MAX; i++)
 		atomic_set(&sbi->meta_count[i], 0);
 
-	atomic_set(&sbi->aw_cnt, 0);
 	atomic_set(&sbi->vw_cnt, 0);
 	atomic_set(&sbi->max_aw_cnt, 0);
 	atomic_set(&sbi->max_vw_cnt, 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a888a0..26a61e8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1327,7 +1327,6 @@ struct f2fs_sb_info {
 	atomic_t inline_xattr;			/* # of inline_xattr inodes */
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
-	atomic_t aw_cnt;			/* # of atomic writes */
 	atomic_t vw_cnt;			/* # of volatile writes */
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
 	atomic_t max_vw_cnt;			/* max # of volatile writes */
@@ -3386,13 +3385,9 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		((sbi)->block_count[(curseg)->alloc_type]++)
 #define stat_inc_inplace_blocks(sbi)					\
 		(atomic_inc(&(sbi)->inplace_count))
-#define stat_inc_atomic_write(inode)					\
-		(atomic_inc(&F2FS_I_SB(inode)->aw_cnt))
-#define stat_dec_atomic_write(inode)					\
-		(atomic_dec(&F2FS_I_SB(inode)->aw_cnt))
 #define stat_update_max_atomic_write(inode)				\
 	do {								\
-		int cur = atomic_read(&F2FS_I_SB(inode)->aw_cnt);	\
+		int cur = F2FS_I_SB(inode)->atomic_files;	\
 		int max = atomic_read(&F2FS_I_SB(inode)->max_aw_cnt);	\
 		if (cur > max)						\
 			atomic_set(&F2FS_I_SB(inode)->max_aw_cnt, cur);	\
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 85af112..dfe6efe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1935,7 +1935,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	F2FS_I(inode)->inmem_task = current;
-	stat_inc_atomic_write(inode);
 	stat_update_max_atomic_write(inode);
 out:
 	inode_unlock(inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 56e8144..c0917d5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -334,7 +334,6 @@ void f2fs_drop_inmem_pages(struct inode *inode)
 	}
 
 	fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
-	stat_dec_atomic_write(inode);
 
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (!list_empty(&fi->inmem_ilist))
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
