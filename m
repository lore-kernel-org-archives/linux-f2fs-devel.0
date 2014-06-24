From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix error path in init_inode_metadata
Date: Tue, 24 Jun 2014 10:34:00 +0800
Message-ID: <001401cf8f54$dedfafa0$9c9f0ee0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WzGZa-00045N-HD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jun 2014 02:35:02 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WzGZV-0003tw-Ae
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jun 2014 02:35:00 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N7N00F4VJ61MN70@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jun 2014 11:34:50 +0900 (KST)
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If we fail in this path:
->init_inode_metadata
  ->make_empty_dir
    ->get_new_data_page
      ->grab_cache_page return -ENOMEM

We will bug on in error path of init_inode_metadata when call remove_inode_page
because i_block = 2 (one inode block will be released later & one dentry block).

We should release the dentry block in init_inode_metadata to avoid this BUG_ON,
and avoid leak of dentry block resource, because we never have second chance to
release that block in ->evict_inode as in upper error path we make this inode
'bad'.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 09760d5..3677f41 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -384,11 +384,11 @@ static struct page *init_inode_metadata(struct inode *inode,
 
 put_error:
 	f2fs_put_page(page, 1);
+error:
 	/* once the failed inode becomes a bad inode, i_mode is S_IFREG */
 	truncate_inode_pages(&inode->i_data, 0);
 	truncate_blocks(inode, 0);
 	remove_dirty_dir_inode(inode);
-error:
 	remove_inode_page(inode);
 	return ERR_PTR(err);
 }
-- 
1.7.9.5



------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
