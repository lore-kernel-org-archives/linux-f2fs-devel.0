From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: handle error case with f2fs_bug_on
Date: Wed, 20 Jul 2016 20:42:05 -0700
Message-ID: <20160721034205.99473-3-jaegeuk@kernel.org>
References: <20160721034205.99473-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bQ4sM-0002T9-VR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jul 2016 03:42:18 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bQ4sM-0007Mh-7x
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jul 2016 03:42:18 +0000
In-Reply-To: <20160721034205.99473-1-jaegeuk@kernel.org>
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

It's enough to show BUG or WARN by f2fs_bug_on for error case.
Then, we don't need to remain corrupted filesystem.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 5d4461f..9e652d5 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -482,6 +482,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 #endif
 				/* We should not get -ENOSPC */
 				f2fs_bug_on(sbi, err);
+				if (err)
+					goto err;
 			}
 
 			/* Check the previous node page having this index */
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
