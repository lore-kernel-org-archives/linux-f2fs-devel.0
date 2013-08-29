From: Joe Perches <joe@perches.com>
Subject: [PATCH 6/6] f2fs: Convert kmem_cache_alloc(...GFP_ZERO)
	to kmem_cache_zalloc
Date: Thu, 29 Aug 2013 13:11:10 -0700
Message-ID: <075e5f4b42ddc2d3192a59f8b31e52fd3f220804.1377806578.git.joe@perches.com>
References: <cover.1377806578.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joe@perches.com>) id 1VF8Zk-0004xy-CD
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Aug 2013 20:12:16 +0000
Received: from perches-mx.perches.com ([206.117.179.246] helo=labridge.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps
	(SSLv3:DES-CBC3-SHA:168) (Exim 4.76) id 1VF8Zj-0000br-LS
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Aug 2013 20:12:16 +0000
In-Reply-To: <cover.1377806578.git.joe@perches.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

The helper exists, might as well use it instead of __GFP_ZERO.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 13d0a0f..d43709a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -286,7 +286,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 {
 	struct f2fs_inode_info *fi;
 
-	fi = kmem_cache_alloc(f2fs_inode_cachep, GFP_NOFS | __GFP_ZERO);
+	fi = kmem_cache_zalloc(f2fs_inode_cachep, GFP_NOFS);
 	if (!fi)
 		return NULL;
 
-- 
1.8.1.2.459.gbcd45b4.dirty


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
