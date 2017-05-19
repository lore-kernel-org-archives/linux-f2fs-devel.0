From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: wait discard IO completion without
	cmd_lock held
Date: Fri, 19 May 2017 23:46:45 +0800
Message-ID: <20170519154645.20121-3-chao@kernel.org>
References: <20170519154645.20121-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dBk9M-0004pv-B3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 May 2017 15:49:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dBk9L-0003Kk-IB
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 May 2017 15:49:08 +0000
In-Reply-To: <20170519154645.20121-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Wait discard IO completion outside cmd_lock to avoid long latency
of holding cmd_lock in IO busy scenario.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2b11119d9071..2b926db0588b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1005,17 +1005,34 @@ static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = &(dcc->wait_list);
 	struct discard_cmd *dc, *tmp;
+	bool need_wait;
+
+next:
+	need_wait = false;
 
 	mutex_lock(&dcc->cmd_lock);
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
-		if (!wait_cond || dc->state == D_DONE) {
-			if (dc->ref)
-				continue;
+		if (!wait_cond || (dc->state == D_DONE && !dc->ref)) {
 			wait_for_completion_io(&dc->wait);
 			__remove_discard_cmd(sbi, dc);
+		} else {
+			dc->ref++;
+			need_wait = true;
+			break;
 		}
 	}
 	mutex_unlock(&dcc->cmd_lock);
+
+	if (need_wait) {
+		wait_for_completion_io(&dc->wait);
+		mutex_lock(&dcc->cmd_lock);
+		f2fs_bug_on(sbi, dc->state != D_DONE);
+		dc->ref--;
+		if (!dc->ref)
+			__remove_discard_cmd(sbi, dc);
+		mutex_unlock(&dcc->cmd_lock);
+		goto next;
+	}
 }
 
 /* This should be covered by global mutex, &sit_i->sentry_lock */
-- 
2.12.2.575.gb14f27f


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
