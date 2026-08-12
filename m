Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A258C5AD5A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LvzNBjM5/vTdlh2iNcE8AyiD/VlrTndWhN5doA/zlo4=; b=TomY0QpnCcdHTR4uES70n78X2u
	NsOXS46fLytzra1iH6ORagYIi1ljrrFAe1reXO91fQgHx82kqhElUbgkC3NEnTnRmeik73YWyz5ju
	SFXLxlZ5NnUO1NVR7bht6jH/lVtkIHIm8fDICiHaR4sh8M6Nhhu+/891SNCeVf+usgVU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wu7wk-0003Oj-2V;
	Wed, 12 Aug 2026 12:20:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wu7wT-0003OI-KR
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:20:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OB1LgUDO6q+Z1e27+rQDO3GVOn3HYn1EGE7refovvZI=; b=l9aj9mt2rjqhzOoI/cVTUhJCHW
 FK+3A8WfRQOzBp4EIGzfiI5NDlfkMf+qznvMETcUX4II82J1HY+NM7YvOUhRYzQVE27gMe8ucpxNg
 bvyHFHygm3MMbhCgAlOKEuWz7gtIcArvYbEfe72/TXOZAlGqgoLJ5PtUSc7fJQ3uCqjw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OB1LgUDO6q+Z1e27+rQDO3GVOn3HYn1EGE7refovvZI=; b=M1t7V2tvOfK0pVzteMY1JyQKcZ
 w3BZiDndJxUr/u7lHKStAuDdOabg/WxtsnrPIlVUauJ56L8VU4Hr/vOFhvUzHvbdVhjNfYtWEi3Hj
 P3Wx3UWVQTP6TJt2vu4M43/f0roCAg9QO9rby2I1kmaEo6Mb06kJnyuVSumFjk/82MVo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wu7wW-0000xq-Hx for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:20:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ABA1C40406
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 12:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AB51F00A3E;
 Wed, 12 Aug 2026 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786537215;
 bh=OB1LgUDO6q+Z1e27+rQDO3GVOn3HYn1EGE7refovvZI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n+6DiXwFDXDlspjMb/a4ZIZH4dtZrBtvFnvq8QdN+aNZiINm7FiGk6CMa7OShnfXu
 4DFvPdUYfPrpeXcDRuPUjZM1LZDNd36Sov2I3J2NabFsnShPoLcaLARNmkIkfeZUHW
 fxOoqZ+aO+rr8Nj9bWAeld/dP2/+jR7ZlhJmbOwm2XGZccjl2hnz8X5PrcfcAB9VCc
 0Tj2VxHZ1Uxik5CaSbBPx/qnAUQTKzYTZaB/XMVI+0XL7rlDF74YRSyns9OwHFh6zy
 QcPDcyDWdDuJNtLEBEzM3F5aaT+J/QrCbmirg7gbzXHfJwZ0SAf9RfyWa+T6yKEoHY
 pAr0TM5wejkoQ==
To: jaegeuk@kernel.org
Date: Wed, 12 Aug 2026 12:20:08 +0000
Message-ID: <20260812122008.281434-2-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260812122008.281434-1-chao@kernel.org>
References: <20260812122008.281434-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wu7wW-0000xq-Hx
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to avoid pinfile fragment on
 fragment:{block, segment} mode
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

pinfile fallocate() conflicts w/ mode=fragment:{block,segment} mount option,
result in fragment blocks in pinfile, it violate semantics of pinfile
introduced in commit f5a53edcf01e ("f2fs: support aligned pinned file").

mkfs.f2fs -f /dev/vdb
mount -t f2fs -o mode=fragment:block /dev/vdb /mnt/f2fs/
dd if=/dev/zero of=/mnt/f2fs/file bs=1M count=3900
sync
touch /mnt/f2fs/pinfile
f2fs_io pinfile set /mnt/f2fs/pinfile
f2fs_io fallocate 0 0 $((1024*1024*16)) /mnt/f2fs/pinfile
sync
f2fs_io fiemap 0 $((1024*1024*16)) /mnt/f2fs/pinfile

[Before]
fallocate failed: No space left on device
Fiemap: offset = 0 len = 16777216
        logical addr.    physical addr.   length           flags
0       0000000000000000 00000000d7200000 0000000000004000 00001000
1       0000000000004000 00000000d7207000 0000000000001000 00001000
2       0000000000005000 00000000d720c000 0000000000002000 00001000
3       0000000000007000 00000000d7211000 0000000000001000 00001000
4       0000000000008000 00000000d7214000 0000000000001000 00001000
5       0000000000009000 00000000d7218000 0000000000001000 00001000
6       000000000000a000 00000000d721d000 0000000000001000 00001000
7       000000000000b000 00000000d721f000 0000000000004000 00001000
...
96      00000000000f1000 00000000d73e9000 0000000000004000 00001000
97      00000000000f5000 00000000d73f1000 0000000000003000 00001000
98      00000000000f8000 00000000d73f5000 0000000000004000 00001000
99      00000000000fc000 00000000d73fa000 0000000000001000 00001000
100     00000000000fd000 00000000d73ff000 0000000000001000 00001001

[After]
fallocated a file: i_size=16777216, i_blocks=32808
Fiemap: offset = 0 len = 16777216
        logical addr.    physical addr.   length           flags
0       0000000000000000 0000000018a00000 0000000000400000 00001000
1       0000000000400000 0000000019000000 0000000000400000 00001000
2       0000000000800000 0000000032400000 0000000000200000 00001000
3       0000000000a00000 0000000038000000 0000000000200000 00001000
4       0000000000c00000 0000000039c00000 0000000000200000 00001000
5       0000000000e00000 0000000044c00000 0000000000200000 00001001

Let's ignore mode=fragment:{block,segment} mount option while fallocate()
on pinfile.

Fixes: 6691d940b0e0 ("f2fs: introduce fragment allocation mode mount option")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    | 15 +++++++++++----
 fs/f2fs/gc.c      |  2 +-
 fs/f2fs/segment.c |  8 ++++----
 fs/f2fs/super.c   |  4 ++--
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 069fe6537160..1b96d8718c5c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4146,19 +4146,26 @@ static inline struct inode *fio_inode(struct f2fs_io_info *fio)
 #define MIN_FRAGMENT_SIZE	1
 #define MAX_FRAGMENT_SIZE	512
 
-static inline bool f2fs_need_rand_blk(struct f2fs_sb_info *sbi)
+static inline bool f2fs_need_rand_blk(struct f2fs_sb_info *sbi,
+					enum log_type type)
 {
+	if (type == CURSEG_COLD_DATA_PINNED)
+		return false;
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK;
 }
 
-static inline bool f2fs_need_rand_seg(struct f2fs_sb_info *sbi)
+static inline bool f2fs_need_rand_seg(struct f2fs_sb_info *sbi,
+					enum log_type type)
 {
+	if (type == CURSEG_COLD_DATA_PINNED)
+		return false;
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG;
 }
 
-static inline bool f2fs_need_rand_seg_blk(struct f2fs_sb_info *sbi)
+static inline bool f2fs_need_rand_seg_blk(struct f2fs_sb_info *sbi,
+					enum log_type type)
 {
-	return f2fs_need_rand_blk(sbi) || f2fs_need_rand_seg(sbi);
+	return f2fs_need_rand_blk(sbi, type) || f2fs_need_rand_seg(sbi, type);
 }
 
 /*
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e6758adc5da1..c4da2f31805b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -310,7 +310,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 		p->max_search = sbi->max_victim_search;
 
 	/* let's select beginning hot/small space first. */
-	if (f2fs_need_rand_seg_blk(sbi)) {
+	if (f2fs_need_rand_seg_blk(sbi, type)) {
 		p->offset = get_random_u32_below(MAIN_SECS(sbi) *
 						SEGS_PER_SEC(sbi));
 		SIT_I(sbi)->last_victim[p->gc_mode] = p->offset;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9e0b6776341c..f4ec1b743ccd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3055,7 +3055,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 
 	sanity_check_seg_type(sbi, seg_type);
 	if (__is_large_section(sbi)) {
-		if (f2fs_need_rand_seg_blk(sbi)) {
+		if (f2fs_need_rand_seg_blk(sbi, type)) {
 			unsigned int hint = GET_SEC_FROM_SEG(sbi, curseg->segno);
 
 			if (GET_SEC_FROM_SEG(sbi, curseg->segno + 1) != hint)
@@ -3064,7 +3064,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 					GET_SEG_FROM_SEC(sbi, hint + 1) - 1);
 		}
 		return curseg->segno;
-	} else if (f2fs_need_rand_seg_blk(sbi)) {
+	} else if (f2fs_need_rand_seg_blk(sbi, type)) {
 		return get_random_u32_below(MAIN_SECS(sbi) * SEGS_PER_SEC(sbi));
 	}
 
@@ -3120,7 +3120,7 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 1);
 	curseg->alloc_type = LFS;
-	if (f2fs_need_rand_blk(sbi))
+	if (f2fs_need_rand_blk(sbi, type))
 		curseg->fragment_remained_chunk =
 				get_random_u32_inclusive(1, sbi->max_fragment_chunk);
 	return 0;
@@ -3939,7 +3939,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 		curseg->next_blkoff = f2fs_find_next_ssr_block(sbi, curseg);
 	} else {
 		curseg->next_blkoff++;
-		if (f2fs_need_rand_blk(sbi))
+		if (f2fs_need_rand_blk(sbi, type))
 			f2fs_randomize_chunk(sbi, curseg);
 	}
 	if (curseg->next_blkoff >= f2fs_usable_blks_in_seg(sbi, curseg->segno))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8dd656a7d3dc..0c8f60b7242f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2457,9 +2457,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, "adaptive");
 	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)
 		seq_puts(seq, "lfs");
-	else if (f2fs_need_rand_seg(sbi))
+	else if (f2fs_need_rand_seg(sbi, NO_CHECK_TYPE))
 		seq_puts(seq, "fragment:segment");
-	else if (f2fs_need_rand_blk(sbi))
+	else if (f2fs_need_rand_blk(sbi, NO_CHECK_TYPE))
 		seq_puts(seq, "fragment:block");
 	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
 	if (test_opt(sbi, RESERVE_ROOT) || test_opt(sbi, RESERVE_NODE))
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
