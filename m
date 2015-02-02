From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/5 v2] f2fs: introduce a batched trim
Date: Mon, 2 Feb 2015 15:29:25 -0800
Message-ID: <20150202232803.GB34575@jaegeuk-mac02.mot.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-5-git-send-email-jaegeuk@kernel.org>
 <003b01d03bc0$a5f23d20$f1d6b760$@samsung.com>
 <20150129214117.GB17521@jaegeuk-mac02>
 <006701d03c4b$a62ec0c0$f28c4240$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <006701d03c4b$a62ec0c0$f28c4240$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change long from v1:
 o add description
 o change the # of batched segments suggested by Chao
 o make consistent for # of batched segments

This patch introduces a batched trimming feature, which submits split discard
commands.

This patch introduces a batched trimming feature, which submits split discard
commands.

This is to avoid long latency due to huge trim commands.
If fstrim was triggered ranging from 0 to the end of device, we should lock
all the checkpoint-related mutexes, resulting in very long latency.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8231a59..ec5e66f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -105,6 +105,8 @@ enum {
 	CP_DISCARD,
 };
 
+#define BATCHED_TRIM_SEGMENTS(sbi)	(((sbi)->segs_per_sec) << 5)
+
 struct cp_control {
 	int reason;
 	__u64 trim_start;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5ea57ec..b85bb97 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1066,14 +1066,20 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);
 	cpc.reason = CP_DISCARD;
-	cpc.trim_start = start_segno;
-	cpc.trim_end = end_segno;
 	cpc.trim_minlen = range->minlen >> sbi->log_blocksize;
 
 	/* do checkpoint to issue discard commands safely */
-	mutex_lock(&sbi->gc_mutex);
-	write_checkpoint(sbi, &cpc);
-	mutex_unlock(&sbi->gc_mutex);
+	for (; start_segno <= end_segno;
+				start_segno += BATCHED_TRIM_SEGMENTS(sbi)) {
+		cpc.trim_start = start_segno;
+		cpc.trim_end = min_t(unsigned int,
+				start_segno + BATCHED_TRIM_SEGMENTS (sbi) - 1,
+				end_segno);
+
+		mutex_lock(&sbi->gc_mutex);
+		write_checkpoint(sbi, &cpc);
+		mutex_unlock(&sbi->gc_mutex);
+	}
 out:
 	range->len = cpc.trimmed << sbi->log_blocksize;
 	return 0;
-- 
2.1.1

