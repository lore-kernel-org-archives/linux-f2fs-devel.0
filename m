From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] resize.f2fs: fix a resize fail for sector size
	mismatch
Date: Wed, 8 Mar 2017 20:20:54 +0800
Message-ID: <20170308122054.2496-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1claWs-0000SU-W9
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:17:19 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1claWr-0007eH-IS
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:17:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch fix a resize faill for sector size mismatch.
The initial fs comes from an image file, with sector size
512KB, and the block device sector size is equal to block
size.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 8bf5cd9..c61eb84 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -537,8 +537,9 @@ static int do_resize(struct f2fs_sb_info *sbi)
 		return -1;
 	}
 
-	if (c.target_sectors <=
-			(get_sb(block_count) << get_sb(log_sectors_per_block))) {
+	/* may different sector size */
+	if ((c.target_sectors * c.sector_size >>
+			get_sb(log_blocksize)) <= get_sb(block_count)) {
 		ASSERT_MSG("Nothing to resize, now only support resize to expand\n");
 		return -1;
 	}
-- 
2.10.1


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
