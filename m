From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: skip read if page has been uptodate
Date: Tue, 27 Dec 2016 12:05:48 +0800
Message-ID: <20161227040548.21541-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cLixH-0007ts-Ep
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Dec 2016 04:01:39 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cLixE-0000Xw-S7
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Dec 2016 04:01:39 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

This patch add a judgement before read, if the page has been
uptodate, move the block directly.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 88bfc3d..40776b4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -602,6 +602,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 		goto recover_block;
 	}
 
+	if (PageUptodate(fio.encrypted_page))
+		goto skip_read;
+
 	err = f2fs_submit_page_bio(&fio);
 	if (err)
 		goto put_page_out;
@@ -613,11 +616,13 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 		err = -EIO;
 		goto put_page_out;
 	}
+
 	if (unlikely(!PageUptodate(fio.encrypted_page))) {
 		err = -EIO;
 		goto put_page_out;
 	}
 
+skip_read:
 	set_page_dirty(fio.encrypted_page);
 	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
