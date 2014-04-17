From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: fix wrong number of max_nid when init
Date: Thu, 17 Apr 2014 14:27:55 +0800
Message-ID: <000c01cf5a06$46b1ba30$d4152e90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Since max_nid value was minus three in previous commit:
'b63da15e8b475245026bdf2096853683f189706b', Our last three nids could not be
used ever, but 0/node nid/meta nid is still occupied.
And also our ra_meta_pages() could not readahead the last block of NAT.
Let's fix the wrong calculation of this value, and left the reserved nids there.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 84f9b7b..3f0bb50 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1860,7 +1860,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
-	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks - 3;
+	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
 	nm_i->fcnt = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
-- 
1.7.9.5
