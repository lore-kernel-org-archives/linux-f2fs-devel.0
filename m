Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11708C61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 06:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gLIx83f4QB3rWR+wEX3Hi4oVpUl7BxbmzOXFuC5I164=; b=XpfuOUQJeMbsT3lQPdevv1HHkd
	itKdo0hm3XZiv4zmpPCPWhrgAApGBDUSTIukKKGKXReKUFhZqAsxNvDKa1u/WeD6/NZC0YvQLmXo8
	ElSZSnk83jLzkI8zr0hv1JXlYjwPXsB1dcAc2RjlVsiKYp8PAZ5gWxviySb2ErgikLDo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0CCK-0005OS-0A;
	Sat, 29 Aug 2026 06:05:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x0CCI-0005OL-WA
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 06:05:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I5So2O3euKFFg61wXFy7xjMLgdHoSVBr97j8orXpOWw=; b=H9AxHSsdpLxIz6OC/5EVCI0rWH
 FAYPDX2E47qPOEAOp0EmyI+pmpWaAKJy6IPfekdxcCTVYcMcmYRIo5WbPcgfNJIJxM8Vuy96Vx5BT
 sXy7vUw9oAOFBlNxD4DOCjRwU8lpu7SlFhifFde/FDUyVjJv6K6aeZCd5CEO5qyzo7vc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I5So2O3euKFFg61wXFy7xjMLgdHoSVBr97j8orXpOWw=; b=DjbBduGfoCTepuMNHOf+9JKS8z
 7xCYgYxACyyvF7wY8VAfq89TLMw28r24G1FhNAYUXGM3HGVvG0o5GScbq+W8mWe3rMLz6etj9nbrj
 uq/sFEoHMp/rDZcORSaWt0j66RdBRLnC6V3HOWSvyhdRfh6Cg2MpJlLjGLJd4wcf9vxU=;
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0CCJ-0002HJ-3R for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 06:05:47 +0000
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so997128a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 23:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787983541; x=1788588341; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I5So2O3euKFFg61wXFy7xjMLgdHoSVBr97j8orXpOWw=;
 b=oAjR3rFhGhXIN5D+IieuNzeu0dMZlYE7rMhFHcvFaDJjBigoCxH6WSu7zQJwUf67P6
 Sy3u7y3DWc/N8xBRgQKsiAnP/Y6CvetFblv/UziNrKQLaU3Iz2rSxWe6zyiCSz1gkDyX
 MyYjpaEaQJXPL5b3TABY5g19/j3/3MsuOy25Jxcr3x5XBMJqRv+xmSXtdJpZAFK16oti
 /k+k1LYknbYwvn7YPMhbY2np3zt/8Za2I0RfvytNuB5Vx35yizMTnM6dAWaV5RolgUEA
 26rR28y/X7PU7/NPilA2Hdmohs/XJRrridzi2OLjTRj/sjgrDUJ1b0CLkq2KYXjmysMN
 Fc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787983541; x=1788588341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I5So2O3euKFFg61wXFy7xjMLgdHoSVBr97j8orXpOWw=;
 b=FXOq9y0wTf1Q+IYsI8tEMeXz5Wy3VZyJbfYM9L7qX1qc4gFvhbKe6hFuNT1A8HuaaY
 ZNF1MRxdDNQtJoM7Bj6qV6IFVsat7RP5LRwTXQ9bouvHwST7biEqRrEd42lOI/POq/xp
 DVELhjNXTP7nOSU/magwBoiOL6TkNOyT9WZwmcgwZajxz0wh9Sy3JxLhbAt6Yh+HhQXF
 PBi3yBZ6P4KFXm1S9LdFhZBcYiopWE1CRfQxxvYtO2UNb+Z9b0UGrYM51rO8XqisTBAq
 YWSwHcbjgESvEmkFo3RQHqVF2zhrQ0kYLZBwLoQKxfyOuoU3j1Yvs1j7URaOOtYLsXCN
 A7Pw==
X-Forwarded-Encrypted: i=1;
 AKwUvByiZ1cfPEQWe4zTx/nBzwkd4klY+UdbT8fs7r6YysruZmnX+sPVAjtKHMjk33HexPMD2Zczm9kJSpyeR/RDor+O@lists.sourceforge.net
X-Gm-Message-State: AFuF++lHmCIDAUqw1ajpNIG1G0s1mpH8MGNDiCKvBlFghae7an73wRfl
 gNw5EaACcTTkCi/mXtwiu/E+QDJUMzAH1Bls1Lec7YUpJoMGmrthmc/f
X-Gm-Gg: AYBFou2XJVTcQNLC8RxHkzesllZrSh3yH7nb3yNVO8Ro3QWEQks/DqBKmZj7QoO1CfR
 yack+YK+W+h2LE22no/PVWbdgWq0tk64qTClNQxzSYJ0hM1YJPYfUsGWjiUmnKMCH+yBHSEDMiN
 S1ie3O/DSxyFCSgxlC0SQTtqy+5q5yEEFlIqioQheoAL0lFiWZvXBHAF4nxexHlnxMRnqq6tkzP
 5vo6ZOdsu+FtRZPYrWp4Uy8pEUCuzukLkESnhb36xgc+RzgF0NG9yBly9CzpKeQU1XBt+OuRJ3v
 9npbB2zEf3SPopZzOpEspbTQNxwi33SBHpyqIEh4qDXco9D7f2N0uyQI+jOl3nQUyOvJbjLXQxn
 1UNO+AQGfz51gqpV3DoyAdUhscLI9hz6WksxCL2KAy8ZeIZMk+cqwzUT/tevk54TRMmHaYdQPNM
 MwPbGy4Egh2/PFzmSjUu8APHGdPahVpmVcZzKWZrO8EZgfdtTIu3dDf/xHgODBj4cmEVvBFBNp0
 zZenNlPWKnIUaut/MoZWEzHfe+bY7wBluai
X-Received: by 2002:a17:90b:37cc:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-396d0d92d0amr22678953a91.1.1787983541205; 
 Fri, 28 Aug 2026 23:05:41 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396dda36ed6sm5609411a91.2.2026.08.28.23.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 23:05:40 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat, 29 Aug 2026 14:05:24 +0800
Message-ID: <20260829060524.2656620-3-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
References: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x0CCJ-0002HJ-3R
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: refresh pinned allocation boundary
 after resize
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 sunqiuyang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

pinned_area_max_secno is derived from MAIN_SECS(), the zoned device
boundary, and resizable_tail_secno. It is currently recalculated only
at mount and remount, so online resize leaves the pre-resize value
active after MAIN_SECS() changes.

A stale value can allow pinned allocations in sections outside the
new main-area boundary.

Move the calculation to segment.h and call it whenever
update_fs_metadata() changes MAIN_SECS(). This also restores the
previous boundary when a final checkpoint error rolls the resize
metadata back.

Mount option validation compares the tail count with the pre-resize
section count. Recalculating after a shrink below that tail would make
the unsigned subtraction wrap. Reject such a shrink with -EINVAL and
report the geometry before acquiring a mount write reference.

A concurrent remount can change the tail after that early check.
Recheck it after freezing the filesystem and taking the resize locks,
before changing block counts or filesystem geometry.

Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v1:
- Simplify the incompatible-tail condition.
- Log the main, shrink, and tail section counts on rejection.
- Validate before acquiring the mount write reference.
- Restore compact formatting in the shared boundary helper.
- Recheck after freeze to cover a concurrent remount option change.

 fs/f2fs/gc.c      | 27 ++++++++++++++++++++++++---
 fs/f2fs/segment.h | 13 +++++++++++++
 fs/f2fs/super.c   | 15 ++-------------
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0a00180c21dc..3c61bf675afa 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2326,6 +2326,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
 	MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
 	MAIN_SECS(sbi) += secs;
+	f2fs_adjust_pinned_area_boundary(sbi);
 	if (sbi->allocate_section_hint > MAIN_SECS(sbi))
 		sbi->allocate_section_hint = MAIN_SECS(sbi);
 	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
@@ -2349,6 +2350,19 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
+static bool f2fs_resize_tail_invalid(struct f2fs_sb_info *sbi,
+				     unsigned int secs)
+{
+	if (MAIN_SECS(sbi) >
+			secs + F2FS_OPTION(sbi).resizable_tail_secno)
+		return false;
+
+	f2fs_err(sbi, "Invalid resize: main %u, shrink %u, tail %u",
+		 MAIN_SECS(sbi), secs,
+		 F2FS_OPTION(sbi).resizable_tail_secno);
+	return true;
+}
+
 int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
@@ -2392,13 +2406,15 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 		return -EINVAL;
 	}
 
+	shrunk_blocks = old_block_count - block_count;
+	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
+	if (f2fs_resize_tail_invalid(sbi, secs))
+		return -EINVAL;
+
 	err = mnt_want_write_file(filp);
 	if (err)
 		return err;
 
-	shrunk_blocks = old_block_count - block_count;
-	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
-
 	/* stop other GC */
 	if (!f2fs_down_write_trylock_trace(&sbi->gc_lock, &glc)) {
 		err = -EAGAIN;
@@ -2442,6 +2458,11 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	f2fs_down_write_trace(&sbi->gc_lock, &glc);
 	f2fs_down_write_trace(&sbi->cp_global_sem, &clc);
 
+	if (f2fs_resize_tail_invalid(sbi, secs)) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
 	spin_lock(&sbi->stat_lock);
 	if (shrunk_blocks + valid_user_blocks(sbi) +
 		sbi->current_reserved_blocks + sbi->unusable_block_count +
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5949aa5200ac..a31d3a6ca756 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -91,6 +91,19 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define GET_ZONE_FROM_SEG(sbi, segno)				\
 	GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
 
+static inline void f2fs_adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
+{
+	sbi->pinned_area_max_secno = MAIN_SECS(sbi);
+	if (f2fs_sb_has_blkzoned(sbi) &&
+	    sbi->first_seq_zone_segno != NULL_SEGNO)
+		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
+						 GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno));
+	if (F2FS_OPTION(sbi).resizable_tail_secno)
+		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
+						 MAIN_SECS(sbi) -
+						 F2FS_OPTION(sbi).resizable_tail_secno);
+}
+
 #define GET_SUM_BLOCK(sbi, segno)	\
 	(SM_I(sbi)->ssa_blkaddr + (segno / (sbi)->sums_per_block))
 #define GET_SUM_BLKOFF(sbi, segno) (segno % (sbi)->sums_per_block)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 253a579e9d5b..c8f8ecf49635 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -554,17 +554,6 @@ static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
 			F2FS_OPTION(sbi).unusable_cap_perc);
 }
 
-static inline void adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
-{
-	sbi->pinned_area_max_secno = MAIN_SECS(sbi);
-	if (f2fs_sb_has_blkzoned(sbi) && sbi->first_seq_zone_segno != NULL_SEGNO)
-		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
-				GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno));
-	if (F2FS_OPTION(sbi).resizable_tail_secno)
-		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
-				MAIN_SECS(sbi) - F2FS_OPTION(sbi).resizable_tail_secno);
-}
-
 static void init_once(void *foo)
 {
 	struct f2fs_inode_info *fi = (struct f2fs_inode_info *) foo;
@@ -3078,7 +3067,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	adjust_pinned_area_boundary(sbi);
+	f2fs_adjust_pinned_area_boundary(sbi);
 	limit_reserve_root(sbi);
 	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
@@ -5321,7 +5310,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* get segno of first zoned block device */
 	sbi->first_seq_zone_segno = get_first_seq_zone_segno(sbi);
 
-	adjust_pinned_area_boundary(sbi);
+	f2fs_adjust_pinned_area_boundary(sbi);
 
 	sbi->reserved_pin_section = f2fs_sb_has_blkzoned(sbi) ?
 			ZONED_PIN_SEC_REQUIRED_COUNT :
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
