From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: avoid writing node/metapages during
	writes
Date: Fri, 17 Jun 2016 18:03:45 -0700
Message-ID: <20160618010346.17794-2-jaegeuk@kernel.org>
References: <20160618010346.17794-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bE4g1-0005mX-UK
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Jun 2016 01:03:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bE4g0-0003j8-3a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Jun 2016 01:03:57 +0000
In-Reply-To: <20160618010346.17794-1-jaegeuk@kernel.org>
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

Let's keep more node/meta pages in run time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index d74cc33..57d450f 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -715,9 +715,9 @@ static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 	if (type == DATA)
 		return sbi->blocks_per_seg;
 	else if (type == NODE)
-		return 3 * sbi->blocks_per_seg;
+		return 8 * sbi->blocks_per_seg;
 	else if (type == META)
-		return MAX_BIO_BLOCKS(sbi);
+		return 8 * MAX_BIO_BLOCKS(sbi);
 	else
 		return 0;
 }
@@ -736,7 +736,7 @@ static inline long nr_pages_to_write(struct f2fs_sb_info *sbi, int type,
 	nr_to_write = wbc->nr_to_write;
 
 	if (type == NODE)
-		desired = 3 * max_hw_blocks(sbi);
+		desired = 2 * max_hw_blocks(sbi);
 	else
 		desired = MAX_BIO_BLOCKS(sbi);
 
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports. http://sdm.link/zohomanageengine
