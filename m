From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to update F2FS_{CP_}WB_DATA count
	correctly
Date: Mon, 27 Feb 2017 17:10:45 +0800
Message-ID: <20170227091045.20724-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciHKy-0001qx-3Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 09:11:20 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciHKv-0006c3-Ea
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 09:11:20 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We should only account F2FS_{CP_}WB_DATA IOs for write path, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0a2e3faabb2..1375fef11146 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -398,7 +398,8 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 		if ((fio->type == DATA || fio->type == NODE) &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
 			err = -EAGAIN;
-			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
+			if (!is_read)
+				dec_page_count(sbi, WB_DATA_TYPE(bio_page));
 			goto out_fail;
 		}
 		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
