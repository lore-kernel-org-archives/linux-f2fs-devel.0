From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: fix missing unlock(sbi->gc_mutex)
Date: Tue, 18 Dec 2018 15:22:28 -0800
Message-ID: <20181218232228.GE31062@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181218021530.78323-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218021530.78323-1-jaegeuk@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This fixes missing unlock call.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

v1 -> v2:
 - clean up

 fs/f2fs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b79677639108..cec7ef27b389 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1457,19 +1457,16 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	sbi->sb->s_flags |= SB_ACTIVE;
 
-	mutex_lock(&sbi->gc_mutex);
 	f2fs_update_time(sbi, DISABLE_TIME);
 
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
+		mutex_lock(&sbi->gc_mutex);
 		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
 		if (err == -ENODATA)
 			break;
-		if (err && err != -EAGAIN) {
-			mutex_unlock(&sbi->gc_mutex);
+		if (err && err != -EAGAIN)
 			return err;
-		}
 	}
-	mutex_unlock(&sbi->gc_mutex);
 
 	err = sync_filesystem(sbi->sb);
 	if (err)
-- 
2.19.0.605.g01d371f741-goog
