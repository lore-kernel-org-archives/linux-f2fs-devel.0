From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] Revert "f2fs: move i_size_write in
	f2fs_write_end"
Date: Sat,  6 Aug 2016 21:09:41 +0800
Message-ID: <1470488981-2469-2-git-send-email-chao@kernel.org>
References: <1470488981-2469-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bW1OS-00044L-EI
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Aug 2016 13:12:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bW1OR-00069n-MB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Aug 2016 13:12:00 +0000
In-Reply-To: <1470488981-2469-1-git-send-email-chao@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This reverts commit a2ee0a300344a6da76186129b078113354fe13d2.

When testing with generic/032 of xfstest suit, failure message will be
reported as below:

generic/032 8s ... [failed, exit status 1] - output mismatch (see results/generic/032.out.bad)
    --- tests/generic/032.out	2015-01-11 16:52:27.643681072 +0800
    +++ results/generic/032.out.bad	2016-08-06 13:44:43.861330500 +0800
    @@ -1,5 +1,5 @@
     QA output created by 032
    -100 iterations
    -0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
    -*
    -0100000
    +1: [768..775]: unwritten
    +Unwritten extents found!
    ...
    (Run 'diff -u tests/generic/032.out results/generic/032.out.bad'  to see the entire diff)
Ran: generic/032
Failures: generic/032
Failed 1 of 1 tests

In write_end(), we should update i_size of inode before unlock page,
otherwise, we will lose newly updated data in following race condition.

Thread A			Thread B
- write_end
 - unlock page
				- writepages
				 - lock_page
				  - writepage
				  if page is out-of-range of file size,
				  we will skip writting the page.
 - update i_size

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e262427..5bb0bd2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1700,11 +1700,11 @@ static int f2fs_write_end(struct file *file,
 	trace_f2fs_write_end(inode, pos, len, copied);
 
 	set_page_dirty(page);
-	f2fs_put_page(page, 1);
 
 	if (pos + copied > i_size_read(inode))
 		f2fs_i_size_write(inode, pos + copied);
 
+	f2fs_put_page(page, 1);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return copied;
 }
-- 
2.7.2


------------------------------------------------------------------------------
