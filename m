From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: support revoking atomic written
	pages
Date: Tue, 29 Dec 2015 16:05:13 -0800
Message-ID: <20151230000513.GA13809@jaegeuk.local>
References: <00a901d141e6$e42ec950$ac8c5bf0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aE4GY-0002YS-Da
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 00:05:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aE4GX-0003gH-0y for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 00:05:22 +0000
Content-Disposition: inline
In-Reply-To: <00a901d141e6$e42ec950$ac8c5bf0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Tue, Dec 29, 2015 at 11:12:36AM +0800, Chao Yu wrote:
> f2fs support atomic write with following semantics:
> 1. open db file
> 2. ioctl start atomic write
> 3. (write db file) * n
> 4. ioctl commit atomic write
> 5. close db file
> 
> With this flow we can avoid file becoming corrupted when abnormal power
> cut, because we hold data of transaction in referenced pages linked in
> inmem_pages list of inode, but without setting them dirty, so these data
> won't be persisted unless we commit them in step 4.
> 
> But we should still hold journal db file in memory by using volatile write,
> because our semantics of 'atomic write support' is not full, in step 4, we
> could be fail to submit all dirty data of transaction, once partial dirty
> data was committed in storage, db file should be corrupted, in this case,
> we should use journal db to recover the original data in db file.

Originally, IOC_ABORT_VOLATILE_WRITE was supposed to handle commit failures,
since database should get its error literally.

So, the only thing that we need to do is keeping journal data for further db
recovery. But, unfortunately, it seems that something is missing in the
current implementation.

So simply how about this?

A possible flow would be:
1. write journal data to volatile space
2. write db data to atomic space
3. in the error case, call ioc_abort_volatile_writes for both journal and db
 - flush/fsync journal data to disk
 - drop atomic data, and will be recovered by database with journal

>From cb33fc8bc30981c370ec70fe68871130109793ec Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 29 Dec 2015 15:46:33 -0800
Subject: [PATCH] f2fs: fix f2fs_ioc_abort_volatile_write

There are two rules to handle aborting volatile or atomic writes.

1. drop atomic writes
 - we don't need to keep any stale db data.

2. write journal data
 - we should keep the journal data with fsync for db recovery.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 91f576a..d16438a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1433,9 +1433,16 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	if (ret)
 		return ret;
 
-	clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
-	clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
-	commit_inmem_pages(inode, true);
+	if (f2fs_is_atomic_file(inode)) {
+		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+		commit_inmem_pages(inode, true);
+	}
+	if (f2fs_is_volatile_file(inode)) {
+		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
+		ret = commit_inmem_pages(inode, false);
+		if (!ret)
+			ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
+	}
 
 	mnt_drop_write_file(filp);
 	return ret;
-- 
2.6.3


------------------------------------------------------------------------------
