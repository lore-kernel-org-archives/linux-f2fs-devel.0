From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: fix to enable readahead last NAT block
Date: Fri, 18 Apr 2014 14:58:31 +0900
Message-ID: <1397800711.7727.34.camel@kjgkr>
References: <000101cf5a1e$5c051770$140f4650$@samsung.com>
	<1397787344.7727.32.camel@kjgkr>
	<000901cf5ab4$d64171a0$82c454e0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Wb1qw-0003vH-7c
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Apr 2014 06:00:46 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wb1qs-00050K-Nw
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Apr 2014 06:00:46 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4700J3WQ0YT960@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Apr 2014 15:00:34 +0900 (KST)
In-reply-to: <000901cf5ab4$d64171a0$82c454e0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Got it.
The patch is like this.
Thanks,

>From 5f7a3bcf0df10bbb47a6e4409cc92ba8e6090674 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Fri, 18 Apr 2014 11:14:37 +0900
Subject: [PATCH] f2fs: add available_nids to fix handling max_nid
correctly

This patch introduces available_nids for alloc_nids() and fixes max_nid
for
build_free_nids() and scan_nat_pages().

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Reviewed-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/node.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 55152de..556d06b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -244,6 +244,7 @@ static inline void set_raw_extent(struct extent_info
*ext,
 struct f2fs_nm_info {
 	block_t nat_blkaddr;		/* base disk address of NAT */
 	nid_t max_nid;			/* maximum possible node ids */
+	nid_t available_nids;		/* maximum available node ids */
 	nid_t next_scan_nid;		/* the next nid to be scanned */
 	unsigned int ram_thresh;	/* control the memory footprint */
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 837f5fd..6ebdba1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1447,7 +1447,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t
*nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i = NULL;
 retry:
-	if (unlikely(sbi->total_valid_node_count + 1 >= nm_i->max_nid))
+	if (unlikely(sbi->total_valid_node_count + 1 > nm_i->available_nids))
 		return false;
 
 	spin_lock(&nm_i->free_nid_list_lock);
@@ -1859,8 +1859,10 @@ static int init_node_manager(struct f2fs_sb_info
*sbi)
 	nat_segs = le32_to_cpu(sb_raw->segment_count_nat) >> 1;
 	nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
 
+	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
+
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
-	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks - 3;
+	nm_i->available_nids = nm_i->max_nid - 3;
 	nm_i->fcnt = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
-- 
1.8.4.474.g128a96c




-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
