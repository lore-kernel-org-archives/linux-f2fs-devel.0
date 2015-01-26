From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: clean up {in,de}create_sleep_time
Date: Mon, 26 Jan 2015 20:24:21 +0800
Message-ID: <008801d03963$1d637ff0$582a7fd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YFijB-00078S-HI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jan 2015 12:25:13 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YFij9-0007nr-Iv
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jan 2015 12:25:13 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NIS00KW9AHT9170@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jan 2015 21:25:05 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Use pointer parameter @wait to pass result in {in,de}create_sleep_time for
cleanup.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c |  8 ++++----
 fs/f2fs/gc.h | 28 ++++++++++++++--------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 67860b6..ba89e27 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -44,7 +44,7 @@ static int gc_thread_func(void *data)
 			break;
 
 		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
-			wait_ms = increase_sleep_time(gc_th, wait_ms);
+			increase_sleep_time(gc_th, &wait_ms);
 			continue;
 		}
 
@@ -65,15 +65,15 @@ static int gc_thread_func(void *data)
 			continue;
 
 		if (!is_idle(sbi)) {
-			wait_ms = increase_sleep_time(gc_th, wait_ms);
+			increase_sleep_time(gc_th, &wait_ms);
 			mutex_unlock(&sbi->gc_mutex);
 			continue;
 		}
 
 		if (has_enough_invalid_blocks(sbi))
-			wait_ms = decrease_sleep_time(gc_th, wait_ms);
+			decrease_sleep_time(gc_th, &wait_ms);
 		else
-			wait_ms = increase_sleep_time(gc_th, wait_ms);
+			increase_sleep_time(gc_th, &wait_ms);
 
 		stat_inc_bggc_count(sbi);
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 524543a..d5ff97c 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -66,26 +66,26 @@ static inline block_t limit_free_user_blocks(struct f2fs_sb_info *sbi)
 	return (long)(reclaimable_user_blocks * LIMIT_FREE_BLOCK) / 100;
 }
 
-static inline long increase_sleep_time(struct f2fs_gc_kthread *gc_th, long wait)
+static inline void increase_sleep_time(struct f2fs_gc_kthread *gc_th,
+								long *wait)
 {
-	if (wait == gc_th->no_gc_sleep_time)
-		return wait;
+	if (*wait == gc_th->no_gc_sleep_time)
+		return;
 
-	wait += gc_th->min_sleep_time;
-	if (wait > gc_th->max_sleep_time)
-		wait = gc_th->max_sleep_time;
-	return wait;
+	*wait += gc_th->min_sleep_time;
+	if (*wait > gc_th->max_sleep_time)
+		*wait = gc_th->max_sleep_time;
 }
 
-static inline long decrease_sleep_time(struct f2fs_gc_kthread *gc_th, long wait)
+static inline void decrease_sleep_time(struct f2fs_gc_kthread *gc_th,
+								long *wait)
 {
-	if (wait == gc_th->no_gc_sleep_time)
-		wait = gc_th->max_sleep_time;
+	if (*wait == gc_th->no_gc_sleep_time)
+		*wait = gc_th->max_sleep_time;
 
-	wait -= gc_th->min_sleep_time;
-	if (wait <= gc_th->min_sleep_time)
-		wait = gc_th->min_sleep_time;
-	return wait;
+	*wait -= gc_th->min_sleep_time;
+	if (*wait <= gc_th->min_sleep_time)
+		*wait = gc_th->min_sleep_time;
 }
 
 static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
-- 
2.2.2



------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
