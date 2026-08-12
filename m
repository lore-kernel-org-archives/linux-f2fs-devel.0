Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71744C5B56A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=edOJc6gtRao8pF9vj9TQYc2URrDj4tOKwLdGBzMZv6g=; b=b5OH0gcQXngIfN3aDUhG4Br+Dg
	Nuz6CUOTLKh5y7qejFB8kL7HCqPWSmx3I4cyThMtaqtZPCZ/9faFGoj3UcZtLqw173t46LdjK9ra/
	b9Ji9WHVLmz69Sl22asw/VOpUw75gK+qNrf1M0Bpo3bZOXtO7zB5N3kqS+tiWwNfnnww=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wu7wl-0006Tf-Aj;
	Wed, 12 Aug 2026 12:20:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wu7wW-0006TO-5b
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:20:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kBvtiGkOJWWQsGUHGWeWsAhMq9zLGNVvWwsNlkdT6+Y=; b=En+RRwbzq6ajIgjxkOn58f5jyn
 FPFSHVem1y3+Eewe84hopbc/Ouch/tn/ixncNjkR/RdIbfcG8Ir48HpSNZ7eWhO/wzVypL1Bd8HbH
 MXsC5PS1JAbNfEg6YQXuiwdul+m5OZhrU+6tORTBtXk32MW0gzwk5E6hqh354l/dmn2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kBvtiGkOJWWQsGUHGWeWsAhMq9zLGNVvWwsNlkdT6+Y=; b=k
 TopDZpkhjDAAYIKcvS021pch/53XQqK0XBhFKURrZ0Cp+TewAO0D/YX5c89HRCgJP2yaGRQ7S1C3s
 kkPRR/bZ1ppZw5T8e/QYJ/U+Xa2rLjJucxGsaXYd19WGRItMDycvIX2qumrMTZO4zstq06/Dvnocd
 WRlS9cTiabyG8dMA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wu7wS-0004fw-8B for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:20:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3C846136F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 12:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E1B1F000E9;
 Wed, 12 Aug 2026 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786537214;
 bh=kBvtiGkOJWWQsGUHGWeWsAhMq9zLGNVvWwsNlkdT6+Y=;
 h=From:To:Cc:Subject:Date;
 b=Vl6MVA8V4rP5BNPA6BSnX4PUSVXEA2ZH/pEYHkZvAWh4F/dHuFLZhw7SBZ0oEdHma
 cTE2dGzm+B/Wt92LqAqLwUv+fyjHHjC28/hjLdTrNz8d9zrXVNV8u4pR1IZs88xRJn
 GwAx22UevfMeHMwhyEnqrfhDdOBwnswWqNaBC6FVFs8qx3f9ZK8TDaXOKcnL70o2rs
 dXEJYi5NUdnSIAcFd//A9bnfRn6YlpFD6TIBUOZqq0Mhog21ULWYD0Cm1IE6uWLAH4
 osxaJBOrnRyKCOvDfSjev+TqIpGoTIaaih9ZBXHbsB3NuQOJnVVzFf76nCjUoa5vci
 KNnZoZt7YeMOQ==
To: jaegeuk@kernel.org
Date: Wed, 12 Aug 2026 12:20:07 +0000
Message-ID: <20260812122008.281434-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
MIME-Version: 1.0
X-Headers-End: 1wu7wS-0004fw-8B
Subject: [f2fs-dev] [PATCH 1/2] f2fs: cleanup w/ f2fs_need_rand_{blk, seg,
 seg_blk}
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

No logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    | 13 +++++++++++--
 fs/f2fs/gc.c      |  2 +-
 fs/f2fs/segment.c |  8 ++++----
 fs/f2fs/super.c   |  4 ++--
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5e4242e37238..069fe6537160 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4146,10 +4146,19 @@ static inline struct inode *fio_inode(struct f2fs_io_info *fio)
 #define MIN_FRAGMENT_SIZE	1
 #define MAX_FRAGMENT_SIZE	512
 
+static inline bool f2fs_need_rand_blk(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK;
+}
+
 static inline bool f2fs_need_rand_seg(struct f2fs_sb_info *sbi)
 {
-	return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG ||
-		F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK;
+	return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG;
+}
+
+static inline bool f2fs_need_rand_seg_blk(struct f2fs_sb_info *sbi)
+{
+	return f2fs_need_rand_blk(sbi) || f2fs_need_rand_seg(sbi);
 }
 
 /*
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2f97a7a98517..e6758adc5da1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -310,7 +310,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 		p->max_search = sbi->max_victim_search;
 
 	/* let's select beginning hot/small space first. */
-	if (f2fs_need_rand_seg(sbi)) {
+	if (f2fs_need_rand_seg_blk(sbi)) {
 		p->offset = get_random_u32_below(MAIN_SECS(sbi) *
 						SEGS_PER_SEC(sbi));
 		SIT_I(sbi)->last_victim[p->gc_mode] = p->offset;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e202b583a5db..9e0b6776341c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3055,7 +3055,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 
 	sanity_check_seg_type(sbi, seg_type);
 	if (__is_large_section(sbi)) {
-		if (f2fs_need_rand_seg(sbi)) {
+		if (f2fs_need_rand_seg_blk(sbi)) {
 			unsigned int hint = GET_SEC_FROM_SEG(sbi, curseg->segno);
 
 			if (GET_SEC_FROM_SEG(sbi, curseg->segno + 1) != hint)
@@ -3064,7 +3064,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 					GET_SEG_FROM_SEC(sbi, hint + 1) - 1);
 		}
 		return curseg->segno;
-	} else if (f2fs_need_rand_seg(sbi)) {
+	} else if (f2fs_need_rand_seg_blk(sbi)) {
 		return get_random_u32_below(MAIN_SECS(sbi) * SEGS_PER_SEC(sbi));
 	}
 
@@ -3120,7 +3120,7 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 1);
 	curseg->alloc_type = LFS;
-	if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
+	if (f2fs_need_rand_blk(sbi))
 		curseg->fragment_remained_chunk =
 				get_random_u32_inclusive(1, sbi->max_fragment_chunk);
 	return 0;
@@ -3939,7 +3939,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 		curseg->next_blkoff = f2fs_find_next_ssr_block(sbi, curseg);
 	} else {
 		curseg->next_blkoff++;
-		if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
+		if (f2fs_need_rand_blk(sbi))
 			f2fs_randomize_chunk(sbi, curseg);
 	}
 	if (curseg->next_blkoff >= f2fs_usable_blks_in_seg(sbi, curseg->segno))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fa4a7a7288d5..8dd656a7d3dc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2457,9 +2457,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, "adaptive");
 	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)
 		seq_puts(seq, "lfs");
-	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG)
+	else if (f2fs_need_rand_seg(sbi))
 		seq_puts(seq, "fragment:segment");
-	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
+	else if (f2fs_need_rand_blk(sbi))
 		seq_puts(seq, "fragment:block");
 	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
 	if (test_opt(sbi, RESERVE_ROOT) || test_opt(sbi, RESERVE_NODE))
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
