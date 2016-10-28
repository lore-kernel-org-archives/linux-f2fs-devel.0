From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 9/9] f2fs: Trace reset zone events
Date: Fri, 28 Oct 2016 16:55:37 +0900
Message-ID: <1477641337-12321-10-git-send-email-damien.lemoal@wdc.com>
References: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Similarly to the regular discard, trace zone reset events.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/segment.c           |  1 +
 include/trace/events/f2fs.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bce79e2..064a78b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -688,6 +688,7 @@ static int f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
+		trace_f2fs_issue_reset_zone(sbi->sb, blkstart);
 		return blkdev_reset_zones(bdev, sector,
 					  nr_sects, GFP_NOFS);
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 903a091..a2193e3 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1113,6 +1113,27 @@ TRACE_EVENT(f2fs_issue_discard,
 		(unsigned long long)__entry->blklen)
 );
 
+TRACE_EVENT(f2fs_issue_reset_zone,
+
+	TP_PROTO(struct super_block *sb, block_t blkstart),
+
+	TP_ARGS(sb, blkstart),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(block_t, blkstart)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->blkstart = blkstart;
+	),
+
+	TP_printk("dev = (%d,%d), reset zone at block = 0x%llx",
+		show_dev(__entry),
+		(unsigned long long)__entry->blkstart)
+);
+
 TRACE_EVENT(f2fs_issue_flush,
 
 	TP_PROTO(struct super_block *sb, unsigned int nobarrier,
-- 
2.7.4

