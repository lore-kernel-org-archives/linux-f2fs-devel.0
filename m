From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] fsck.f2fs: treat xattr node block as warm type
	node
Date: Tue, 06 Jan 2015 14:30:35 +0800
Message-ID: <009501d0297a$5fa8c7b0$1efa5710$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Y8Nfp-00054B-6R
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 06:31:25 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Y8Nfn-0008JK-MC
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 06:31:25 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NHQ008R2SS3V670@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 15:31:15 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Treat xattr node block as warm type node in fsck.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fsck/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 09bb26f..7f03281 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -303,7 +303,7 @@ static int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
 	}
 
 	*blk_cnt = *blk_cnt + 1;
-	f2fs_set_main_bitmap(sbi, ni.blk_addr, CURSEG_COLD_NODE);
+	f2fs_set_main_bitmap(sbi, ni.blk_addr, CURSEG_WARM_NODE);
 	DBG(2, "ino[0x%x] x_nid[0x%x]\n", ino, x_nid);
 out:
 	free(node_blk);
-- 
2.2.1



------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
