From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: restrict inline_xattr_size
 configuration
Date: Sat, 27 Jan 2018 17:29:48 +0800
Message-ID: <20180127092949.26616-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1efMoL-0003e0-2T
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:30:09 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1efMoJ-00045o-GT
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:30:09 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch limits to enable inline_xattr_size mount option only if
both extra_attr and flexible_inline_xattr feature is on in current
image.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8173ae688814..a859372457eb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -699,6 +699,13 @@ static int parse_options(struct super_block *sb, char *options)
 	}
 
 	if (test_opt(sbi, INLINE_XATTR_SIZE)) {
+		if (!f2fs_sb_has_extra_attr(sb) ||
+			!f2fs_sb_has_flexible_inline_xattr(sb)) {
+			f2fs_msg(sb, KERN_ERR,
+					"extra_attr or flexible_inline_xattr "
+					"feature is off");
+			return -EINVAL;
+		}
 		if (!test_opt(sbi, INLINE_XATTR)) {
 			f2fs_msg(sb, KERN_ERR,
 					"inline_xattr_size option should be "
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
