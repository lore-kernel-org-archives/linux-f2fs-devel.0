Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F0FCA6012
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S5cGKlZu5l7slgKwVeGMFNYTdNCcGD/8rjr12Ew4X1Y=; b=NeV49gZ1qBzWgeJ1KYECSYrhML
	i8lywjnT5QZrEjDmOes3pKG0cWJUnrLeautFJnpTKMAq4R7VhrC1leHHpJDhX/Q4rA/3o5wF60BbO
	VZ/XUGN3q23uPEzGG/AqjVFiwyPlmTWMuyY3IWpjCz4+x076LiXpnlRa0ae+xWzqzNlc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF8Ju-0004Ib-1g;
	Fri, 09 Oct 2026 10:59:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF8Js-0004IM-Cb
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cYLHh2vFEwwzSjDjxFQIW0PW1qi9Pe60h75NQH/ba/s=; b=hb12RL8OwkhKfGQ0zsNp3UauoK
 +cfCDFVRLzTFDTAX0acODb/oxbQZrcFTnHTpOGw1pjxxvnPCUMJzjUtiEPwwcP1tTUCfyVzVZ77lK
 pHkeirlr1GaXqvY0pMq55H2nGuiN7WVzP1wF1gqcnGPzNbyiVLehMf9iSjXkiYBAukx4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cYLHh2vFEwwzSjDjxFQIW0PW1qi9Pe60h75NQH/ba/s=; b=l+HX30Ibs7Jh84KR2ZmPKxa//A
 KGJfDu/kSvnmSkU/PGUC5yOlWe3s+QEf6x3hxezhvQNoEQ5QelWl/YDGRAUOCYfWY27twDw5G61Nt
 J/mSxRm0QknZyaJyu4Rt0X7zlwR5++i1bzO8MBL6VB8XJ0HVowcx2gobCodhYeE+qFhw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF8Jr-0006nX-Nf for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:59:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6ED9141949;
 Fri,  9 Oct 2026 10:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8DF1F00899;
 Fri,  9 Oct 2026 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791543554;
 bh=cYLHh2vFEwwzSjDjxFQIW0PW1qi9Pe60h75NQH/ba/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hf7NaMwgkzvM+wVfmNb5AX3r7m+qpkLCgW/2QfdlsUphk+4tiViDrn2Os160O5Iqz
 V2NWZHEza9iGLkzvmr0ptgfuWPGKy8Lpp8WF+Fl6aL2p0HlK9J8vHVBKSy2uara/fR
 64KmDSSNwexrH7QC+CgMvVJdfZd1UUnxF1XzYtkjKDgBb2aqSMHr3sL8xMcWj1nPUc
 AdXoeDG1J/jKAoYU3mQWMiJL0SCcgJPesDxtKDZO4p2m7dMXSsTdT62W4X2iwGGAsT
 M3yBR+enxzDFQFgW3oly2JeUCGZ7qw6T5tQrakLpzGIpexCjiDo+Tkg/k+MLbg+yUe
 NnSjVG0LGRHNQ==
To: jaegeuk@kernel.org
Date: Fri,  9 Oct 2026 10:59:05 +0000
Message-ID: <20261009105906.1861478-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009105906.1861478-1-chao@kernel.org>
References: <20261009105906.1861478-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xF8Jr-0006nX-Nf
Subject: [f2fs-dev] [PATCH 6.12.y 2/3] f2fs: fix to shrink gc_lock coverage
 in f2fs_gc_range()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 5d49025a4e596c4c9ac0c519ef9f9a2c91396856 ]

In f2fs_allocate_pinning_section(), we will hold gc_lock before calling
f2fs_gc_range() to migrate section in conventional zone, we may suffer
worse case because we may need to traverse and migrate multiple sections
if we failed to move blocks in section due to lot of reasons: ENOMEM,
fail to migrate block of pinfile, racing on i_gc_rwsem.

To avoid hold gc_lock for long time to block checkpoint, let's hold
the lock and only try to migrate one section.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Chao Yu: backport to 6.12.y:
  - drop file.c changes as f2fs_ioc_reserve_dev_alias() is not present in 6.12
  - use f2fs_{down,up}_write(&sbi->gc_lock) as 6.12 lacks lock tracing
  - use IS_CURSEC() in gc.c as cursec pinning is not present in 6.12 ]
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/gc.c      | 33 ++++++++++++++++++++++++---------
 fs/f2fs/segment.c |  4 +---
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 053c8630d6ef..12ca7ba9d6dc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4028,7 +4028,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections);
+		bool dry_run, unsigned int dry_run_sections, bool lock);
 int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4f9fa45ebbac..664260807072 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2100,7 +2100,7 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections)
+		bool dry_run, unsigned int dry_run_sections, bool lock)
 {
 	unsigned int segno;
 	unsigned int gc_secs = dry_run_sections;
@@ -2114,28 +2114,43 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.ilist = LIST_HEAD_INIT(gc_list.ilist),
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
+		int err = 0;
+
+		if (lock)
+			f2fs_down_write(&sbi->gc_lock);
 
 		/*
 		 * avoid migrating empty section, as it can be allocated by
 		 * log in parallel.
 		 */
 		if (!get_valid_blocks(sbi, segno, true))
-			continue;
+			goto next;
 
 		if (IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, segno)))
-			continue;
+			goto next;
 
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
-		if (!dry_run && get_valid_blocks(sbi, segno, true))
-			return -EAGAIN;
+		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
+			err = -EAGAIN;
+			goto next;
+		}
 		if (dry_run && dry_run_sections &&
-		    !get_valid_blocks(sbi, segno, true) && --gc_secs == 0)
-			break;
+			!get_valid_blocks(sbi, segno, true)) {
+			--gc_secs;
+			goto next;
+		}
 
 		if (fatal_signal_pending(current))
-			return -ERESTARTSYS;
+			err = -ERESTARTSYS;
+next:
+		if (lock)
+			f2fs_up_write(&sbi->gc_lock);
+		if (err)
+			return err;
+		if (dry_run && dry_run_sections && !gc_secs)
+			return 0;
 	}
 
 	return 0;
@@ -2183,7 +2198,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	}
 
 	/* do GC to move out valid blocks in the range */
-	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
+	err = f2fs_gc_range(sbi, start, end, dry_run, 0, false);
 	if (err || dry_run)
 		goto out;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 328799ec670d..1ec43e1537fb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3263,10 +3263,8 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 	f2fs_unlock_op(sbi);
 
 	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
-		f2fs_down_write(&sbi->gc_lock);
 		err = f2fs_gc_range(sbi, 0, sbi->first_seq_zone_segno - 1,
-				true, ZONED_PIN_SEC_REQUIRED_COUNT);
-		f2fs_up_write(&sbi->gc_lock);
+				true, ZONED_PIN_SEC_REQUIRED_COUNT, true);
 		if (err)
 			return err;
 		err = f2fs_sync_fs(sbi->sb, 1);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
