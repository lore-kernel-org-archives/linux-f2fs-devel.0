From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: introduce a batched trim
Date: Tue, 27 Jan 2015 15:31:43 -0800
Message-ID: <1422401503-4769-5-git-send-email-jaegeuk@kernel.org>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YGFcB-0003qI-Nd
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Jan 2015 23:32:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YGFcA-0007RT-VN for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Jan 2015 23:32:11 +0000
In-Reply-To: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch introduces a batched trimming feature, which submits split discard
commands.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c0b83d6..ec4d16b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -104,6 +104,7 @@ enum {
 	CP_DISCARD,
 };
 
+#define BATCHED_TRIM_SEGMENTS	10
 struct cp_control {
 	int reason;
 	__u64 trim_start;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 31c4e57..6c9c784 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1066,14 +1066,19 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
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
+				start_segno += BATCHED_TRIM_SEGMENTS + 1) {
+		cpc.trim_start = start_segno;
+		cpc.trim_end = min_t(unsigned int,
+				start_segno + BATCHED_TRIM_SEGMENTS, end_segno);
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


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
