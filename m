From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: declare static function
Date: Wed, 23 Dec 2015 18:15:20 -0800
Message-ID: <1450923320-41113-4-git-send-email-jaegeuk@kernel.org>
References: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBvRG-0001xc-Mj
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:15:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBvRG-0006qv-1D for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:15:34 +0000
In-Reply-To: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
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

The __f2fs_commit_super is static.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 597b533..75704d9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1195,7 +1195,7 @@ next:
 	return 0;
 }
 
-int __f2fs_commit_super(struct f2fs_sb_info *sbi, int block)
+static int __f2fs_commit_super(struct f2fs_sb_info *sbi, int block)
 {
 	struct f2fs_super_block *super = F2FS_RAW_SUPER(sbi);
 	struct buffer_head *bh;
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
