From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: clean up duplicated assignment in
 init_discard_policy
Date: Thu, 25 Jan 2018 18:57:26 +0800
Message-ID: <20180125105727.50357-2-yuchao0@huawei.com>
References: <20180125105727.50357-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eefEC-0003hk-Ir
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 10:57:56 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eefEB-0002bT-Gl
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 10:57:56 +0000
In-Reply-To: <20180125105727.50357-1-yuchao0@huawei.com>
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

Remove duplicated codes of assignment for .max_requests and .io_aware_gran.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9f7a932c60f5..34206acb883b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1715,25 +1715,20 @@ void init_discard_policy(struct discard_policy *dpolicy,
 	dpolicy->sync = true;
 	dpolicy->granularity = granularity;
 
+	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
+	dpolicy->io_aware_gran = MAX_PLIST_NUM;
+
 	if (discard_type == DPOLICY_BG) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
-		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
-		dpolicy->io_aware_gran = MAX_PLIST_NUM;
 		dpolicy->io_aware = true;
 	} else if (discard_type == DPOLICY_FORCE) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
-		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
-		dpolicy->io_aware_gran = MAX_PLIST_NUM;
 		dpolicy->io_aware = true;
 	} else if (discard_type == DPOLICY_FSTRIM) {
-		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
-		dpolicy->io_aware_gran = MAX_PLIST_NUM;
 		dpolicy->io_aware = false;
 	} else if (discard_type == DPOLICY_UMOUNT) {
-		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
-		dpolicy->io_aware_gran = MAX_PLIST_NUM;
 		dpolicy->io_aware = false;
 	}
 }
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
