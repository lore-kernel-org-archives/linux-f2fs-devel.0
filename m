From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: move i_size_write in f2fs_write_end
Date: Fri,  8 Jul 2016 10:32:34 -0700
Message-ID: <20160708173235.98362-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bLZdt-0002pE-EA
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 08 Jul 2016 17:32:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bLZdr-0006Ao-Lc
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 08 Jul 2016 17:32:45 +0000
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

We don't need to do i_size_write under page lock.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b6fd5bd..20b3016 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1685,11 +1685,11 @@ static int f2fs_write_end(struct file *file,
 	trace_f2fs_write_end(inode, pos, len, copied);
 
 	set_page_dirty(page);
+	f2fs_put_page(page, 1);
 
 	if (pos + copied > i_size_read(inode))
 		f2fs_i_size_write(inode, pos + copied);
 
-	f2fs_put_page(page, 1);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return copied;
 }
-- 
2.8.3


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
