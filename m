From: Jeff Liu <jeff.liu@oracle.com>
Subject: [PATCH 21/24] f2fs: return actual error on init_f2fs_fs
Date: Tue, 17 Jun 2014 22:32:48 +0800
Message-ID: <53A05190.60600@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jeff.liu@oracle.com>) id 1WwuSg-0005yx-Rr
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Jun 2014 14:34:10 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WwuSd-0004bh-G4
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Jun 2014 14:34:10 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, cm224.lee@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

From: Jie Liu <jeff.liu@oracle.com>

Return the actual error code if kset_create_and_add() failed

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Jie Liu <jeff.liu@oracle.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b2b1863..74470cb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1175,8 +1175,8 @@ static int __init init_f2fs_fs(void)
 	if (err)
 		goto free_gc_caches;
 	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
-	if (!f2fs_kset) {
-		err = -ENOMEM;
+	if (IS_ERR(f2fs_kset)) {
+		err = PTR_ERR(f2fs_kset);
 		goto free_checkpoint_caches;
 	}
 	err = register_filesystem(&f2fs_fs_type);
-- 
1.8.3.2

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
