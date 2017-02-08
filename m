From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: enable inline_xattr by default
Date: Wed, 8 Feb 2017 17:39:44 +0800
Message-ID: <20170208093945.24681-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cbOjn-0007gm-3u
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Feb 2017 09:40:31 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cbOjj-0007yl-AZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Feb 2017 09:40:31 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In android, since SElinux is enable, security policy will be appliedd for
each file, it stores in inode as an xattr entry, so it will take one 4k
size node block additionally for each file.

Let's enable inline_xattr by default in order to save storage space.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 68a555b014cf..e2f919d3096a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1026,6 +1026,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	sbi->active_logs = NR_CURSEG_TYPE;
 
 	set_opt(sbi, BG_GC);
+	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
 	set_opt(sbi, EXTENT_CACHE);
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
