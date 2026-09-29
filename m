Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56837CA5FA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8fJA/nfTzMsJ78QEAQHmE6CPz6W+XHakUa2dOoeWBaY=; b=M/cB9LOoch50y/jHZqi5/g/nYO
	sFakMm++M/1H8x6EXw6fovYNlBZsNWl3aEouh4yaLpzilAA3SiP2wP/yaUXg/TUnclJ4lGubszzkO
	HzTMj2kiqGHoaMHQU4DRgvgO3bwqMzln9iEs/bUUtZiAYzhTHeLRM6xfSpThVpBItw20=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBSHg-0006XA-CM;
	Tue, 29 Sep 2026 07:29:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xBSHf-0006X4-8B
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RPAQIg6jjARiLgLMiPFuuJDqfS+9cwBZUol2ydi87Jk=; b=GakASLYWp0EVmmU8WsVJwbbLGr
 dwck1OMm43/s8IXgfbCIVErCpCGhZWqS0STNclb33BrAQwRcz057UHVsU+/F8qb5CUK2yx73QR0+s
 w1u4lr65hifpfcsT5u8AzWqaf7eJRhIM5IgdBDo+X/59oy7SqAwg6MwJiezBoC33xdgI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RPAQIg6jjARiLgLMiPFuuJDqfS+9cwBZUol2ydi87Jk=; b=fP/zB4dI4SDnR//pCV3A0gcAoC
 2sFj8zT0bxB6B11CQ2SGtJMmRe8AJKAEPUp9BXUMVJbQmiUsE1uYwzVu5ttvBPfIAmVQKNtSwDMUp
 d7lTW1djo0gGTybR2WwLLEbVjKu8pvy7OB6dJ1d4gGKp3sOYoGxNDI+56uCxNstx4WrQ=;
Received: from mail-pj2-f41.google.com ([74.125.227.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBSHe-0006PZ-87 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:51 +0000
Received: by mail-pj2-f41.google.com with SMTP id
 98e67ed59e1d1-3a0bcdf41a3so2032774a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790666984; x=1791271784; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RPAQIg6jjARiLgLMiPFuuJDqfS+9cwBZUol2ydi87Jk=;
 b=RYkqKf/+G83FFLIXFse5OMPzYmH1bnpeO1XCmN0U4XklxJmfhd60E1l+OT42SH1vGH
 JeXki+flYafaU799MKwOJq7w7cN+2255d1HNz5IZmOXS7GpFOrGoRA0KDWoRgjKmXyus
 pXOeY4Pd7ZbhssroGnqjSjsxOrtgMlvQ8jOxVnKO0rHfqGfRT/pk22WjbQA+qL4iYPgv
 7kh3S+HVszhKAFF3vvyDjxBz2GthjjKDC165lghtsQNUelJqRSOBKSm/znNphlNbbJ7p
 G+MJUOqU/2tiRoX6dPpktCJ9FZ8sLnyXU7N4fzPB9EddHrDGQf/tO0wCbPyO39s7cyAu
 6yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666984; x=1791271784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RPAQIg6jjARiLgLMiPFuuJDqfS+9cwBZUol2ydi87Jk=;
 b=W3jHlapOn/lyeb+Wk2UCL2OiiuJs2iuXOZ5E7/FwAFhAXdD2ibCNi8ZuSZBBDiuiN/
 DGLCdwOz/ZMk7ocLAoCUHUiDSVtvHkBujJEE8+ZJUo4iPUehc/MeOjskXtc6RAmgReBB
 a6wGrZNsrpMmaxHjodClDElZhxCmN3JwSU/DOLXZCz8HJlO2YULvqF86+4G82Q7cAcKF
 Zs7cMdTyvWVYCBXsBW5UA7qTYJYoe+/NLgab7Gp5OzIzMes7biNSkTadqCAJKjGgemCF
 d0ctH4lH/iXSaYNJsZ5QHF51nVp8iYMV67s//c53UQy5Nw+P6CqqCrZvTZNeTPDcYg4u
 5jKg==
X-Forwarded-Encrypted: i=1;
 AKwUvByUEB6i7DILP9FoMhQrLy3d6O5uvAbyyOmwM7Q7S8hJHZvYzDUDtMjRLihRpt2vTVTZPRXnFBavyJJ0uHBWayXo@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKKuxAvpWUL9o8Akc0BWVWBwhvwYMAMCKi4y27/n4I0uEUMxfsX
 X35ZTHzOIpSYAr2QE9BKILvfggur9KI6uRuW94sGR3bMO2MBuHL/9wfq
X-Gm-Gg: AYBFou2ZPZSKk8yPuzq2oNPlZ7J+PLvh80ZOgLW1VjUvAEeSrFZlv91X+cXEXkiGAK7
 U9jlh8cJr0vDXWl04FXqWflIDuPu17KYraW1l0xF//HLw4mIE5L7MrCWGONfNujEnmx1VY4uhBx
 5SIAA12/kfQzYEn/Nly5mV+waVIGip4IbMYoe3lhSm68fQu9jXI5tudnvMPxi4xryHSsKy7xKUw
 5ktXkZ6uPE10hPHEmqehL/2+cDsSCVMh2PZReEoizVbilzu4W5poryHmXTLkIg0uaRPICdTKu5/
 uYZFQuOhIlhg0PX37tmVs1dj48ZDyozMsl2gPyPlIe4LH/Nt6cN8NtzVeyIqC751a7/T+nRY99U
 yemOC94ZHteQ1yZ9TfeE1fRXyNlwT1klPTz3HXcykb178uEEoGP8hJTfIZ7zCkz6/3/4tIjWQ4E
 WifqilMarh2i4o8fRJcc1mgNPSuuunMZNYrC7HA4iIJ2VV2j8sYeXeDvkmyG7TcpMTP4uT7zLZN
 gmJnMHItcPAbvlpqy2CDiAIwPCrFY0a/Xo=
X-Received: by 2002:a17:90a:b81:b0:3a0:abc3:afb5 with SMTP id
 98e67ed59e1d1-3a0abc3c2a8mr7657309a91.34.1790666984396; 
 Tue, 29 Sep 2026 00:29:44 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a49804220fsm3900170a91.12.2026.09.29.00.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:29:43 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 29 Sep 2026 15:29:17 +0800
Message-ID: <5172cd03c44dde8c47ba88f92bef03ed37723d07.1790665952.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790665952.git.qiwenjie@xiaomi.com>
References: <cover.1790665952.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xBSHe-0006PZ-87
Subject: [f2fs-dev] [RFC PATCH 4/6] f2fs: restore compressed node cache
 entries before access
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
Cc: Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 Wenjie Qi <qiwenjie@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

A node-cache lookup may find a compressed entry, but existing callers
expect ordinary node bytes. Restore the raw block before returning the
entry to those callers.

Perform the restore under the entry lock. Validate the allocation size,
compressed length, LZ4 output size and raw-block CRC before publishing the
raw representation. Move a successful restore to the raw LRU tail, and
keep RESTORED set until the existing footer, inode-checksum and node-type
validation has completed.

A raw-buffer allocation failure leaves the compressed entry intact for a
later retry. Invalid compressed data is discarded and the lookup falls
back to the normal disk-read path. The entry never owns raw and compressed
storage at the same time.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/cache.c               |  12 ++++
 fs/f2fs/cache.h               |  20 ++++++
 fs/f2fs/data.c                |   5 +-
 fs/f2fs/f2fs.h                |  10 +++
 fs/f2fs/inode.c               |  20 +++++-
 fs/f2fs/node.c                |  55 ++++++++++++---
 fs/f2fs/node_cache_compress.c | 129 ++++++++++++++++++++++++++++++++++
 fs/f2fs/node_cache_compress.h |  13 ++++
 8 files changed, 251 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 480412f6c729..9cb541dd5cea 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -64,6 +64,7 @@ bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
 {
 	struct f2fs_cached_block_list *cache = entry->cache;
 
+	f2fs_nc_content_changed(entry);
 	f2fs_cache_set_uptodate(entry);
 
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -94,6 +95,8 @@ void f2fs_drop_cache_dirty(struct f2fs_cached_block *entry)
 				F2FS_DIRTY_META : F2FS_DIRTY_NODES;
 
 	f2fs_cache_clear_uptodate(entry);
+	if (!f2fs_cache_test_compressed(entry))
+		f2fs_nc_content_changed(entry);
 
 	if (!f2fs_cache_test_and_clear_dirty(entry))
 		return;
@@ -286,7 +289,16 @@ struct f2fs_cached_block *f2fs_grab_cache(
 	entry = f2fs_insert_cache(cache, index, new);
 found:
 	if (lock) {
+		int ret;
+
 		f2fs_lock_cache(entry);
+		if (entry->cache == cache) {
+			ret = f2fs_nc_restore(entry);
+			if (ret) {
+				f2fs_put_cache(entry, true);
+				return ERR_PTR(ret);
+			}
+		}
 		/* has been truncated */
 		if (entry->cache != cache) {
 			f2fs_put_cache(entry, true);
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 8a1eab71b1ae..603c5f7203b7 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -66,6 +66,7 @@ enum f2fs_cached_state {
 	F2FS_BLOCK_INLINE_DATA,		/* indicate inline data */
 #ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
 	F2FS_BLOCK_COMPRESSED,
+	F2FS_BLOCK_RESTORED,
 #endif
 };
 
@@ -151,6 +152,25 @@ F2FS_CACHE_FLAG_TEST_AND_CLEAR_FUNC(referenced, REFERENCED);
 F2FS_CACHE_FLAG_TEST_FUNC(compressed, COMPRESSED);
 F2FS_CACHE_FLAG_SET_FUNC(compressed, COMPRESSED);
 F2FS_CACHE_FLAG_CLEAR_FUNC(compressed, COMPRESSED);
+F2FS_CACHE_FLAG_TEST_FUNC(restored, RESTORED);
+F2FS_CACHE_FLAG_SET_FUNC(restored, RESTORED);
+F2FS_CACHE_FLAG_CLEAR_FUNC(restored, RESTORED);
+#else
+static inline bool f2fs_cache_test_compressed(const struct f2fs_cached_block *entry)
+{
+	return false;
+}
+
+static inline void f2fs_cache_set_compressed(struct f2fs_cached_block *entry) { }
+static inline void f2fs_cache_clear_compressed(struct f2fs_cached_block *entry) { }
+
+static inline bool f2fs_cache_test_restored(const struct f2fs_cached_block *entry)
+{
+	return false;
+}
+
+static inline void f2fs_cache_set_restored(struct f2fs_cached_block *entry) { }
+static inline void f2fs_cache_clear_restored(struct f2fs_cached_block *entry) { }
 #endif
 
 static inline void *cache_address(const struct f2fs_cached_block *entry)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d4ba5e77906..3c07fdecbd32 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -26,6 +26,7 @@
 #include "node.h"
 #include "segment.h"
 #include "iostat.h"
+#include "node_cache_compress.h"
 #include <trace/events/f2fs.h>
 
 #define NUM_PREALLOC_POST_READ_CTXS	128
@@ -393,8 +394,10 @@ static void f2fs_cache_read_end_io(struct bio *bio)
 				entry->index, NODE_TYPE_REGULAR, true))
 			bio->bi_status = BLK_STS_IOERR;
 
-		if (bio->bi_status == BLK_STS_OK)
+		if (bio->bi_status == BLK_STS_OK) {
+			f2fs_nc_content_changed(entry);
 			f2fs_cache_set_uptodate(entry);
+		}
 
 		dec_cache_count(sbi, io_type);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 16cc050124dd..a5d8ab041aa8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4001,6 +4001,16 @@ int f2fs_pin_file_control(struct inode *inode, bool inc);
  */
 void f2fs_set_inode_flags(struct inode *inode);
 bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+bool f2fs_inode_chksum_valid(struct f2fs_sb_info *sbi,
+			     struct f2fs_cached_block *entry);
+#else
+static inline bool
+f2fs_inode_chksum_valid(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
+{
+	return true;
+}
+#endif
 void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9164a2b5d9f0..bd4a46dd7a9e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -168,7 +168,9 @@ static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi, struct f2fs_cached_bloc
 	return chksum;
 }
 
-bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
+static bool __f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi,
+				       struct f2fs_cached_block *entry,
+					bool report)
 {
 	struct f2fs_inode *ri;
 	__u32 provided, calculated;
@@ -187,7 +189,7 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct f2fs_cached_block
 	provided = le32_to_cpu(ri->i_inode_checksum);
 	calculated = f2fs_inode_chksum(sbi, entry);
 
-	if (provided != calculated)
+	if (provided != calculated && report)
 		f2fs_warn(sbi, "checksum invalid, nid = %lu, ino_of_node = %u, %x vs. %x",
 			  entry->index, ino_of_node(sbi, entry),
 			  provided, calculated);
@@ -195,6 +197,20 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct f2fs_cached_block
 	return provided == calculated;
 }
 
+bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi,
+			      struct f2fs_cached_block *entry)
+{
+	return __f2fs_inode_chksum_verify(sbi, entry, true);
+}
+
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+bool f2fs_inode_chksum_valid(struct f2fs_sb_info *sbi,
+			     struct f2fs_cached_block *entry)
+{
+	return __f2fs_inode_chksum_verify(sbi, entry, false);
+}
+#endif
+
 void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
 {
 	struct f2fs_inode *ri = F2FS_INODE(entry);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index be14dfa31e53..2cf8ebf0c114 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -19,6 +19,7 @@
 #include "segment.h"
 #include "xattr.h"
 #include "iostat.h"
+#include "node_cache_compress.h"
 #include <trace/events/f2fs.h>
 
 #define on_f2fs_build_free_nids(nm_i) mutex_is_locked(&(nm_i)->build_lock)
@@ -1467,7 +1468,15 @@ static int read_node_cache(struct f2fs_cached_block *entry, blk_opf_t op_flags)
 	};
 	int err;
 
+	if (WARN_ON_ONCE(f2fs_cache_test_compressed(entry) || !entry->data))
+		return -EFSCORRUPTED;
+
 	if (f2fs_cache_test_uptodate(entry)) {
+		if (f2fs_cache_test_restored(entry) &&
+		    !f2fs_inode_chksum_valid(sbi, entry)) {
+			f2fs_nc_validation_failed(entry);
+			goto read_disk;
+		}
 		if (!f2fs_inode_chksum_verify(sbi, entry)) {
 			f2fs_cache_clear_uptodate(entry);
 			return -EFSBADCRC;
@@ -1475,6 +1484,7 @@ static int read_node_cache(struct f2fs_cached_block *entry, blk_opf_t op_flags)
 		return LOCKED_CACHE;
 	}
 
+read_disk:
 	err = f2fs_get_node_info(sbi, entry->index, &ni, false);
 	if (err)
 		return err;
@@ -1520,14 +1530,14 @@ void f2fs_ra_node_cache(struct f2fs_sb_info *sbi, nid_t nid)
 	f2fs_put_cache(entry, err ? true : false);
 }
 
-int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
-					struct f2fs_cached_block *entry, pgoff_t nid,
-					enum node_type ntype, bool in_irq)
+static bool f2fs_node_footer_valid(struct f2fs_sb_info *sbi,
+				   struct f2fs_cached_block *entry, pgoff_t nid,
+				   enum node_type ntype)
 {
 	bool is_inode, is_xnode;
 
 	if (unlikely(nid != nid_of_node(sbi, entry)))
-		goto out_err;
+		return false;
 
 	is_inode = IS_INODE(sbi, entry);
 	is_xnode = f2fs_has_xattr_block(ofs_of_node(sbi, entry));
@@ -1535,27 +1545,46 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 	switch (ntype) {
 	case NODE_TYPE_REGULAR:
 		if (is_inode && is_xnode)
-			goto out_err;
+			return false;
 		break;
 	case NODE_TYPE_INODE:
 		if (!is_inode || is_xnode)
-			goto out_err;
+			return false;
 		break;
 	case NODE_TYPE_XATTR:
 		if (is_inode || !is_xnode)
-			goto out_err;
+			return false;
 		break;
 	case NODE_TYPE_NON_INODE:
 		if (is_inode)
-			goto out_err;
+			return false;
 		break;
 	case NODE_TYPE_NON_IXNODE:
 		if (is_inode || is_xnode)
-			goto out_err;
+			return false;
 		break;
 	default:
 		break;
 	}
+	return true;
+}
+
+static bool f2fs_restored_footer_valid(struct f2fs_sb_info *sbi,
+				       struct f2fs_cached_block *entry,
+				       pgoff_t nid, enum node_type ntype)
+{
+	if (f2fs_node_footer_valid(sbi, entry, nid, ntype))
+		return true;
+	f2fs_nc_validation_failed(entry);
+	return false;
+}
+
+int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
+				  struct f2fs_cached_block *entry, pgoff_t nid,
+				  enum node_type ntype, bool in_irq)
+{
+	if (!f2fs_node_footer_valid(sbi, entry, nid, ntype))
+		goto out_err;
 	if (time_to_inject(sbi, FAULT_INCONSISTENT_FOOTER))
 		goto out_err;
 	return 0;
@@ -1588,6 +1617,7 @@ static struct f2fs_cached_block *__get_node_cache(struct f2fs_sb_info *sbi, pgof
 	if (IS_ERR(entry))
 		return entry;
 
+read_cache:
 	err = read_node_cache(entry, 0);
 	if (err < 0)
 		goto out_put_err;
@@ -1614,9 +1644,14 @@ static struct f2fs_cached_block *__get_node_cache(struct f2fs_sb_info *sbi, pgof
 		goto out_err;
 	}
 entry_hit:
+	if (f2fs_cache_test_restored(entry) &&
+	    !f2fs_restored_footer_valid(sbi, entry, nid, ntype))
+		goto read_cache;
 	err = f2fs_sanity_check_node_footer(sbi, entry, nid, ntype, false);
-	if (!err)
+	if (!err) {
+		f2fs_nc_validation_succeeded(entry);
 		return entry;
+	}
 out_err:
 	f2fs_drop_cache_dirty(entry);
 out_put_err:
diff --git a/fs/f2fs/node_cache_compress.c b/fs/f2fs/node_cache_compress.c
index 50e9c820eb81..9c2d19e5e821 100644
--- a/fs/f2fs/node_cache_compress.c
+++ b/fs/f2fs/node_cache_compress.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/atomic.h>
 #include <linux/f2fs_fs.h>
+#include <linux/lz4.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
 
@@ -99,6 +100,10 @@ struct f2fs_nc_ctx {
 	atomic64_t shrink_scanned[F2FS_NC_NR_QUEUES];
 	atomic64_t shrink_freed[F2FS_NC_NR_QUEUES];
 	atomic64_t detached[F2FS_NC_NR_QUEUES];
+	/* Cumulative restore statistics since mount. */
+	atomic64_t compressed_to_raw;
+	atomic64_t restored_hits;
+	atomic64_t restore_failures;
 	/* Signed quota history carried between shrinker calls. */
 	s64 shrink_credit[F2FS_NC_NR_QUEUES];
 	/* Mount reference plus references held by compressed objects. */
@@ -280,6 +285,130 @@ void f2fs_nc_free_data(struct f2fs_cached_block *entry)
 	f2fs_nc_ctx_put(ctx);
 }
 
+static int
+f2fs_nc_publish_raw(struct f2fs_cached_block *entry,
+		    struct f2fs_node_cached_block *node,
+		    struct f2fs_nc_ctx *ctx, void *raw, bool restored)
+{
+	struct f2fs_cached_block_list *cache = entry->cache;
+	void *object = entry->data;
+	u32 len = node->compressed_len;
+	u32 alloc_size = node->compressed_alloc_size;
+	unsigned int queue = f2fs_nc_entry_queue(entry);
+
+	spin_lock(&cache->list_lock);
+	entry->data = raw;
+	f2fs_cache_clear_compressed(entry);
+	node->owner = NULL;
+	node->compressed_len = 0;
+	node->compressed_alloc_size = 0;
+	node->compressed_crc = 0;
+	if (restored) {
+		f2fs_cache_set_restored(entry);
+		f2fs_cache_set_uptodate(entry);
+	} else {
+		f2fs_cache_clear_restored(entry);
+		f2fs_cache_clear_uptodate(entry);
+	}
+	list_move_tail(&entry->list, &cache->lru_list);
+	f2fs_nc_account_del(ctx, queue, len, alloc_size);
+	f2fs_nc_account_add(ctx, F2FS_NC_RAW, 0, 0);
+	atomic64_inc(&ctx->compressed_to_raw);
+	spin_unlock(&cache->list_lock);
+
+	f2fs_nc_store_free(ctx->store, object, alloc_size);
+	f2fs_nc_ctx_put(ctx);
+	return 0;
+}
+
+static int
+f2fs_nc_restore_fallback(struct f2fs_cached_block *entry,
+			 struct f2fs_node_cached_block *node,
+			 struct f2fs_nc_ctx *ctx)
+{
+	void *raw;
+
+	raw = f2fs_kmalloc(ctx->sbi, ctx->sbi->blocksize, GFP_NOFS);
+	if (!raw)
+		return -ENOMEM;
+	atomic64_inc(&ctx->restore_failures);
+	return f2fs_nc_publish_raw(entry, node, ctx, raw, false);
+}
+
+int f2fs_nc_restore(struct f2fs_cached_block *entry)
+{
+	struct f2fs_node_cached_block *node;
+	struct f2fs_nc_ctx *ctx;
+	struct f2fs_sb_info *sbi;
+	void *raw;
+	int ret;
+
+	if (!entry || !entry->cache || !IS_NODE_CACHE(entry->cache) ||
+	    !f2fs_cache_test_compressed(entry))
+		return 0;
+	if (WARN_ON_ONCE(!f2fs_cache_test_locked(entry)))
+		return -EFSCORRUPTED;
+	if (WARN_ON_ONCE(f2fs_cache_test_dirty(entry) ||
+			 f2fs_cache_test_writeback(entry)))
+		return -EFSCORRUPTED;
+
+	node = f2fs_nc_node_entry(entry);
+	ctx = node->owner;
+	if (!ctx || ctx != entry->cache->sbi->node_compress || !entry->data)
+		return -EFSCORRUPTED;
+	sbi = ctx->sbi;
+	if (f2fs_nc_store_bucket_from_size(node->compressed_alloc_size) < 0)
+		return -EFSCORRUPTED;
+	if (!node->compressed_len ||
+	    node->compressed_len > node->compressed_alloc_size)
+		return f2fs_nc_restore_fallback(entry, node, ctx);
+
+	raw = f2fs_kmalloc(sbi, sbi->blocksize, GFP_NOFS);
+	if (!raw)
+		return -ENOMEM;
+	ret = LZ4_decompress_safe(entry->data, raw, node->compressed_len,
+				  sbi->blocksize);
+	if (ret != sbi->blocksize ||
+	    f2fs_crc32(raw, sbi->blocksize) != node->compressed_crc) {
+		atomic64_inc(&ctx->restore_failures);
+		return f2fs_nc_publish_raw(entry, node, ctx, raw, false);
+	}
+	return f2fs_nc_publish_raw(entry, node, ctx, raw, true);
+}
+
+void f2fs_nc_validation_failed(struct f2fs_cached_block *entry)
+{
+	struct f2fs_nc_ctx *ctx;
+
+	if (f2fs_cache_test_restored(entry) && entry->cache) {
+		ctx = entry->cache->sbi->node_compress;
+		if (ctx)
+			atomic64_inc(&ctx->restore_failures);
+	}
+	f2fs_cache_clear_restored(entry);
+	f2fs_cache_clear_uptodate(entry);
+}
+
+void f2fs_nc_validation_succeeded(struct f2fs_cached_block *entry)
+{
+	struct f2fs_nc_ctx *ctx;
+
+	if (f2fs_cache_test_restored(entry) && entry->cache) {
+		ctx = entry->cache->sbi->node_compress;
+		if (ctx)
+			atomic64_inc(&ctx->restored_hits);
+	}
+	f2fs_cache_clear_restored(entry);
+}
+
+void f2fs_nc_content_changed(struct f2fs_cached_block *entry)
+{
+	if (!entry || !entry->cache || !IS_NODE_CACHE(entry->cache))
+		return;
+	WARN_ON_ONCE(f2fs_cache_test_compressed(entry));
+	f2fs_cache_clear_restored(entry);
+}
+
 static void f2fs_nc_population_snapshot(struct f2fs_nc_ctx *ctx,
 					unsigned long nr[F2FS_NC_NR_QUEUES])
 {
diff --git a/fs/f2fs/node_cache_compress.h b/fs/f2fs/node_cache_compress.h
index e7d6b07c1c98..faeb342b9cc3 100644
--- a/fs/f2fs/node_cache_compress.h
+++ b/fs/f2fs/node_cache_compress.h
@@ -29,6 +29,10 @@ size_t f2fs_nc_entry_alloc_size(struct f2fs_cached_block_list *cache);
 void f2fs_nc_init(struct f2fs_sb_info *sbi);
 void f2fs_nc_destroy(struct f2fs_sb_info *sbi);
 void f2fs_nc_free_data(struct f2fs_cached_block *entry);
+int f2fs_nc_restore(struct f2fs_cached_block *entry);
+void f2fs_nc_validation_failed(struct f2fs_cached_block *entry);
+void f2fs_nc_validation_succeeded(struct f2fs_cached_block *entry);
+void f2fs_nc_content_changed(struct f2fs_cached_block *entry);
 struct list_head *f2fs_nc_queue_head(struct f2fs_cached_block_list *cache,
 				     unsigned int queue);
 unsigned int f2fs_nc_entry_queue(const struct f2fs_cached_block *entry);
@@ -54,6 +58,15 @@ static inline void f2fs_nc_free_data(struct f2fs_cached_block *entry)
 	kfree(entry->data);
 }
 
+static inline int f2fs_nc_restore(struct f2fs_cached_block *entry)
+{
+	return 0;
+}
+
+static inline void f2fs_nc_validation_failed(struct f2fs_cached_block *entry) { }
+static inline void f2fs_nc_validation_succeeded(struct f2fs_cached_block *entry) { }
+static inline void f2fs_nc_content_changed(struct f2fs_cached_block *entry) { }
+
 static inline struct list_head *f2fs_nc_queue_head(struct f2fs_cached_block_list *cache,
 						   unsigned int queue)
 {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
