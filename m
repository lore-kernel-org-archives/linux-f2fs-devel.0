From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/6] f2fs: enable inline_dentry by default
Date: Mon, 9 May 2016 19:56:34 +0800
Message-ID: <20160509115635.123946-5-yuchao0@huawei.com>
References: <20160509115635.123946-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1azjob-0001rr-KB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 May 2016 11:57:33 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1azjoV-000160-F8
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 May 2016 11:57:33 +0000
In-Reply-To: <20160509115635.123946-1-yuchao0@huawei.com>
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

Make inline_dentry as default mount option to improve space usage and
IO performance in scenario of numerous small directory.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 28c8992..4a4f4bd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -824,6 +824,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_DATA);
+	set_opt(sbi, INLINE_DENTRY);
 	set_opt(sbi, EXTENT_CACHE);
 
 #ifdef CONFIG_F2FS_FS_XATTR
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
