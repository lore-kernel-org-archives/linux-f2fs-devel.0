From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to enable readahead last NAT block
Date: Fri, 18 Apr 2014 11:15:44 +0900
Message-ID: <1397787344.7727.32.camel@kjgkr>
References: <000101cf5a1e$5c051770$140f4650$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <000101cf5a1e$5c051770$140f4650$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

How about this?

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
index 837f5fd..5fb484c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1447,7 +1447,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t
*nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i = NULL;
 retry:
-	if (unlikely(sbi->total_valid_node_count + 1 >= nm_i->max_nid))
+	if (unlikely(sbi->total_valid_node_count + 1 >= nm_i->available_nids))
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

