From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/7] f2fs: don't wake up too frequently,
 if there is lots of IOs
Date: Tue, 29 Jan 2019 07:47:14 +0800
Message-ID: <20190128234717.77225-4-jaegeuk@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1goGcq-00040A-IP
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 23:47:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1goGcp-004lmw-2A
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 23:47:36 +0000
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Otherwise, it wakes up discard thread which will sleep again by busy IOs
in a loop.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index a77f76f528b6..5c7ed0442d6e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -865,7 +865,7 @@ static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
 		}
 	}
 	mutex_unlock(&dcc->cmd_lock);
-	if (!wakeup)
+	if (!wakeup || !is_idle(sbi, DISCARD_TIME))
 		return;
 wake_up:
 	dcc->discard_wake = 1;
-- 
2.19.0.605.g01d371f741-goog
