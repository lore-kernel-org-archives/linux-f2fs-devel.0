From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: remove unneeded code in punch_hole
Date: Fri, 22 Nov 2013 16:52:50 +0800
Message-ID: <000201cee760$58df9f10$0a9edd30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VjmUs-0008QQ-AA
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 08:53:54 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VjmUp-0008Bg-1Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 08:53:54 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MWN00518Q1IYCP0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Nov 2013 17:53:43 +0900 (KST)
References: 
In-reply-to: 
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Because FALLOC_FL_PUNCH_HOLE flag must be ORed with FALLOC_FL_KEEP_SIZE 
in fallocate, so we could remove the useless 'keep size' branch code which 
will never be excuted in punch_hole.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Fan Li <fanofcode.li@samsung.com>
---
 fs/f2fs/file.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7d714f4..0087d2a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -499,12 +499,6 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len, int mode)
 		}
 	}
 
-	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-		i_size_read(inode) <= (offset + len)) {
-		i_size_write(inode, offset);
-		mark_inode_dirty(inode);
-	}
-
 	return ret;
 }
 
-- 
1.7.9.5


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
