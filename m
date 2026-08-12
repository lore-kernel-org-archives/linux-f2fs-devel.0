Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FBAC5AD5A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=78Pjools1MZesP4rcVjB359uAVoYKSS83TKraQQj+7c=; b=CzGeVJ5UbRW8pqMlqYUVfEjBba
	HqrYZWaqhya+vMVfa6D+h4BVGVnJ5qfEcqNLNjD4xcoLCNmPo9dqZEUui6MKHPguFOpSnvv5YGtxs
	aKB7G44mg+PdJL5OwY373CKGGun60s6EvmPiaLTjdDsd3pqtHO16mDH03LdgzQJEyTqs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wu7uP-0003Bt-SD;
	Wed, 12 Aug 2026 12:18:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wu7uO-0003Bg-NH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Wamfj7h/QelIyB3xdkGRiWXyqiW/hi6CtHSchltNQc=; b=acv2iDDQCe+9NetzryLbxjpjgi
 SYqCXW8UT/3779++ND9AHtqbUeHkJMXyRn+qWN+5dIlj0UhlhRbpW1uThO33S+f+NNS5z9ZBoZsSt
 Q8QU2B/3P9rtDupDQjkbK7/xy9opOoH015981lNJCxmnfPCnSC80/5V69sX03pW/k8tM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5Wamfj7h/QelIyB3xdkGRiWXyqiW/hi6CtHSchltNQc=; b=lFFr3YgKBf2cvyiaodt/eXCA77
 +UaOHDpzipw0AJVV+Pj5ZOuVY+KCucE2mEe8JUQEBX5iw3j+3k2x8qPUpJ4mJ/o6tcUVmPoHua23/
 f5SjNyNLFFTOwsK67+IIZJGB6mp25qGyy4BhXcjeK7vaVlYba9bjOFxWHq52flmP6X+g=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wu7uM-0004cv-RH for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:18:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36B4760AA9;
 Wed, 12 Aug 2026 12:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B021F00A3D;
 Wed, 12 Aug 2026 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786537084;
 bh=5Wamfj7h/QelIyB3xdkGRiWXyqiW/hi6CtHSchltNQc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GnAM2PlS8zpXlmqgf3LZf2YL2LiERjux3tb8yk6KxoHivEVwFux0mDpSwm5Aeb+30
 FZJPzK7IZietRGhT7aywtIVI0v7Dm7c3tIT5QKMW6Y4noqujyEClmdWPbv1SrYq3X2
 3JqCFz7VcV0qBYpOanTOmdTAUbNtyrgHCo1LJpf0D+cKR8MaJJpxx4Iqzpsle0/r68
 GDLMAXhagjMQUe/FAs7WF8VZo1WEPYWN4dKm2Er8BhrIzidFR1DQ7JYMEH3kv8I6s6
 oCZlBbSWqNIxcnzlW1YuEIcY6szb/0C2UzBHtUy800XkCe4mGTTYtR/xXixganIu2W
 Bjt8DNkgNdaIw==
To: jaegeuk@kernel.org
Date: Wed, 12 Aug 2026 12:17:55 +0000
Message-ID: <20260812121756.278690-2-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260812121756.278690-1-chao@kernel.org>
References: <20260812121756.278690-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wu7uM-0004cv-RH
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to shrink gc_lock coverage in
 f2fs_gc_range()
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_allocate_pinning_section(), we will hold gc_lock before calling
f2fs_gc_range() to migrate section in conventional zone, we may suffer
worse case because we may need to traverse and migrate multiple sections
if we failed to move blocks in section due to lot of reasons: ENOMEM,
fail to migrate block of pinfile, racing on i_gc_rwsem.

To avoid hold gc_lock for long time to block checkpoint, let's hold
the lock and only try to migrate one section.

Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/gc.c      | 34 +++++++++++++++++++++++++---------
 fs/f2fs/segment.c |  4 +---
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index edc9ae7f5a67..5e4242e37238 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4278,7 +4278,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections);
+		bool dry_run, unsigned int dry_run_sections, bool lock);
 void f2fs_reset_gc_victim_resource(struct f2fs_sb_info *sbi,
 		unsigned int start, unsigned int end);
 int f2fs_resize_fs(struct file *filp, __u64 block_count);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 76316e537f65..a54b3ab52f1a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3828,7 +3828,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	}
 
 	/* do GC to move out valid blocks in the range all at once! */
-	err = f2fs_gc_range(sbi, start, end, false, 0);
+	err = f2fs_gc_range(sbi, start, end, false, 0, false);
 	if (err) {
 		f2fs_unlock_op(sbi, &lc);
 		goto out_gc_unlock;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 51fc8c69eb25..2f97a7a98517 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2150,8 +2150,9 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections)
+		bool dry_run, unsigned int dry_run_sections, bool lock)
 {
+	struct f2fs_lock_context lc;
 	unsigned int segno;
 	unsigned int gc_secs = dry_run_sections;
 
@@ -2164,28 +2165,43 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.ilist = LIST_HEAD_INIT(gc_list.ilist),
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
+		int err = 0;
+
+		if (lock)
+			f2fs_down_write_trace(&sbi->gc_lock, &lc);
 
 		/*
 		 * avoid migrating empty section, as it can be allocated by
 		 * log in parallel.
 		 */
 		if (!get_valid_blocks(sbi, segno, true))
-			continue;
+			goto next;
 
 		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno)))
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
+			f2fs_up_write_trace(&sbi->gc_lock, &lc);
+		if (err)
+			return err;
+		if (dry_run && dry_run_sections && !gc_secs)
+			return 0;
 	}
 
 	return 0;
@@ -2231,7 +2247,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	}
 
 	/* do GC to move out valid blocks in the range */
-	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
+	err = f2fs_gc_range(sbi, start, end, dry_run, 0, false);
 	if (err || dry_run)
 		goto out;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0b3b2fe40847..e202b583a5db 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3476,10 +3476,8 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 	f2fs_unlock_op(sbi, &lc);
 
 	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
-		f2fs_down_write_trace(&sbi->gc_lock, &lc);
 		err = f2fs_gc_range(sbi, 0, sbi->first_seq_zone_segno - 1,
-				true, ZONED_PIN_SEC_REQUIRED_COUNT);
-		f2fs_up_write_trace(&sbi->gc_lock, &lc);
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
