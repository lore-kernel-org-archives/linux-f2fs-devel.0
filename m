From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] f2fs: let discard thread wait a little
 longer if dev is busy
Date: Sun, 8 Apr 2018 15:11:11 +0800
Message-ID: <1523171471-538-2-git-send-email-heyunlei@huawei.com>
References: <1523171471-538-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f54hh-0000Fo-2q
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 07:25:33 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f54hc-000pn8-Nn
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 07:25:33 +0000
In-Reply-To: <1523171471-538-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch modify discard thread wait policy as below:
	issued       io_interrupted     wait time(ms)
1.        8                 0               50
2.      (0,8)               1               50
3.        0                 1              500 (dev is busy)
4.        0                 0            60000 (no candidates)

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/f2fs.h    | 2 ++
 fs/f2fs/segment.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1df7f10..0a6453b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -184,6 +184,7 @@ enum {
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
 #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
+#define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
 #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
@@ -285,6 +286,7 @@ enum {
 struct discard_policy {
 	int type;			/* type of discard */
 	unsigned int min_interval;	/* used for candidates exist */
+	unsigned int mid_interval;	/* used for device busy */
 	unsigned int max_interval;	/* used for candidates not exist */
 	unsigned int max_requests;	/* # of discards issued per round */
 	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f75f503..c7a8161e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1425,9 +1425,11 @@ static int issue_discard_thread(void *data)
 		sb_start_intwrite(sbi->sb);
 
 		issued = __issue_discard_cmd(sbi, &dpolicy);
-		if (issued) {
+		if (issued > 0) {
 			__wait_all_discard_cmd(sbi, &dpolicy);
 			wait_ms = dpolicy.min_interval;
+		} else if (issued == -1){
+			wait_ms = dpolicy.mid_interval;
 		} else {
 			wait_ms = dpolicy.max_interval;
 		}
@@ -1726,10 +1728,12 @@ void init_discard_policy(struct discard_policy *dpolicy,
 
 	if (discard_type == DPOLICY_BG) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
+		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
 		dpolicy->io_aware = true;
 	} else if (discard_type == DPOLICY_FORCE) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
+		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
 		dpolicy->io_aware = false;
 	} else if (discard_type == DPOLICY_FSTRIM) {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
