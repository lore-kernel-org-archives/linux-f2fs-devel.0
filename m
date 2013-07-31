From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] f2fs: remove an unneeded kfree(NULL)
Date: Wed, 31 Jul 2013 11:44:13 +0300
Message-ID: <20130731084413.GA8210@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1V4S1L-00075X-R4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 31 Jul 2013 08:44:35 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V4S1K-0008Py-47
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 31 Jul 2013 08:44:35 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>, Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This kfree() is no longer needed after a79dc083d7 "f2fs: move
bio_private allocation out of f2fs_bio_alloc()".  The "bio->bi_private"
is NULL here so it's a no-op.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Only needed in linux-next.

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 19cd7c6..027341c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -390,7 +390,6 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct page *page,
 	bio->bi_end_io = read_end_io;
 
 	if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
-		kfree(bio->bi_private);
 		bio_put(bio);
 		up_read(&sbi->bio_sem);
 		f2fs_put_page(page, 1);

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
