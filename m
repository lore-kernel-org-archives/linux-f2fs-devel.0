From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: don't stop GC if GC is contended
Date: Mon, 26 Feb 2018 09:47:31 -0800
Message-ID: <20180226174731.26679-5-jaegeuk@kernel.org>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226174731.26679-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Let's do GC as much as possible, while gc_urgent is set.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b9d93fd532a9..bc9420ce2275 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -76,14 +76,15 @@ static int gc_thread_func(void *data)
 		 * invalidated soon after by user update or deletion.
 		 * So, I'd like to wait some time to collect dirty segments.
 		 */
-		if (!mutex_trylock(&sbi->gc_mutex))
-			goto next;
-
 		if (gc_th->gc_urgent) {
 			wait_ms = gc_th->urgent_sleep_time;
+			mutex_lock(&sbi->gc_mutex);
 			goto do_gc;
 		}
 
+		if (!mutex_trylock(&sbi->gc_mutex))
+			goto next;
+
 		if (!is_idle(sbi)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			mutex_unlock(&sbi->gc_mutex);
-- 
2.15.0.531.g2ccb3012c9-goog
