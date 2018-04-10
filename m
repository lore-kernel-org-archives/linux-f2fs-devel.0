From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: turn down IO priority of discard from
 background
Date: Tue, 10 Apr 2018 15:43:09 +0800
Message-ID: <20180410074309.13531-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f5nw9-0003Jo-L4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 07:43:29 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5nw7-006oml-Hj
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 07:43:29 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In order to avoid interfering normal r/w IO, let's turn down IO
priority of discard issued from background.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- correct commit message.
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index aabe0d6b8307..5e708debeb9c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1723,6 +1723,7 @@ void init_discard_policy(struct discard_policy *dpolicy,
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
 		dpolicy->io_aware = true;
+		dpolicy->sync = false;
 	} else if (discard_type == DPOLICY_FORCE) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
