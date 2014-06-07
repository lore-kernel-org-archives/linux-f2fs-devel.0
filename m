From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: recover fallocated space
Date: Sun,  8 Jun 2014 01:44:31 +0900
Message-ID: <1402159472-61137-2-git-send-email-jaegeuk@kernel.org>
References: <1402159472-61137-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1WtJju-0003Wo-M2
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jun 2014 16:45:06 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WtJjt-0003Z7-Vc for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jun 2014 16:45:06 +0000
In-Reply-To: <1402159472-61137-1-git-send-email-jaegeuk@kernel.org>
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

If a fallocated file is fsynced, we should recover the i_size after sudden
power cut.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d97e5c4..78110da 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -682,6 +682,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		i_size_read(inode) < new_size) {
 		i_size_write(inode, new_size);
 		mark_inode_dirty(inode);
+		f2fs_write_inode(inode, NULL);
 	}
 
 	return ret;
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
