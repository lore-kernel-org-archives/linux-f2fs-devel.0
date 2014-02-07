From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs: f2fs unmount hangs if f2fs_init_acl() fails
 during mkdir syscall
Date: Fri, 07 Feb 2014 14:12:13 +0900
Message-ID: <1391749933.25542.83.camel@kjgkr>
References: <52F320FC.50803@ispras.ru> <1391666564.25542.78.camel@kjgkr>
	<52F37D67.208@ispras.ru> <1391734185.25542.80.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WBdl9-000415-7b
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Feb 2014 05:13:51 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WBdl7-0004wY-8O
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Feb 2014 05:13:51 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0M009VX16T8H70@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Feb 2014 14:13:41 +0900 (KST)
In-reply-to: <1391734185.25542.80.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Andrey Tsyvarev <tsyvarev@ispras.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi,

It turns out that make_bad_inode prior to iput sets i_mode to a regular
file, so that f2fs_evict_inode -> truncate_inode_pages ->
f2fs_invalidate_data_page doesn't decrement dirty_dents.
This patch should resolve the bug.
Thank you :)

----
When a new directory is allocated, if an error is occurred, we should
truncate
preallocated dentry pages too.

This bug was reported by Andrey Tsyvarev after a while as follows.

mkdir()->
 f2fs_add_link()->
  init_inode_metadata()->
    f2fs_init_acl()->
      f2fs_get_acl()->
        f2fs_getxattr()->
          read_all_xattrs() fails.

Also there was a BUG_ON triggered after the fault in
mkdir()->
 f2fs_add_link()->
   init_inode_metadata()->
    remove_inode_page() ->
      f2fs_bug_on(inode->i_blocks != 0 && inode->i_blocks != 1);

But, previous patch wasn't perfect to resolve that bug, so the following
bug
report was also submitted.

kernel BUG at fs/f2fs/inode.c:274!
Call Trace:
 [<ffffffff811fde03>] evict+0xa3/0x1a0
 [<ffffffff811fe615>] iput+0xf5/0x180
 [<ffffffffa01c7f63>] f2fs_mkdir+0xf3/0x150 [f2fs]
 [<ffffffff811f2a77>] vfs_mkdir+0xb7/0x160
 [<ffffffff811f36bf>] SyS_mkdir+0x5f/0xc0
 [<ffffffff81680769>] system_call_fastpath+0x16/0x1b

Finally, this patch resolves all the issues like below.

If an error is occurred after make_empty_dir(),
 1. truncate_inode_pages()
   The make_bad_inode() prior to iput() will change i_mode to S_IFREG,
which
   means that f2fs will not decrement fi->dirty_dents during
f2fs_evict_inode.
   But, by calling it here, we can do that.

 2. truncate_blocks()
   Preallocated dentry pages are trucated here to sync i_blocks.

Reported-by: Andrey Tsyvarev <tsyvarev@ispras.ru>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index bfcb4ae..92ce1db 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -372,6 +372,9 @@ static struct page *init_inode_metadata(struct inode
*inode,
 
 put_error:
 	f2fs_put_page(page, 1);
+	/* once the failed inode becomes a bad inode, i_mode is S_IFREG */
+	truncate_inode_pages(&inode->i_data, 0);
+	truncate_blocks(inode, 0);
 error:
 	remove_inode_page(inode);
 	return ERR_PTR(err);
-- 
1.8.4.474.g128a96c



-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
