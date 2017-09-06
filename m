From: Helge Deller <deller@gmx.de>
Subject: [PATCH 08/14] fs/f2fs: Use %pS printk format for direct
 addresses
Date: Wed,  6 Sep 2017 22:27:55 +0200
Message-ID: <1504729681-3504-9-git-send-email-deller@gmx.de>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <deller@gmx.de>) id 1dpgvw-0003PS-EZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Sep 2017 20:28:24 +0000
Received: from mout.gmx.net ([212.227.15.19])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dpgvv-0006lV-Au
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Sep 2017 20:28:24 +0000
In-Reply-To: <1504729681-3504-1-git-send-email-deller@gmx.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, linux-f2fs-devel@lists.sourceforge.net, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Use the %pS instead of the %pF printk format specifier for printing symbols
from direct addresses. This is needed for the ia64, ppc64 and parisc64
architectures.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 94a88b2..9012a43 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1054,7 +1054,7 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 #define f2fs_show_injection_info(type)				\
-	printk("%sF2FS-fs : inject %s in %s of %pF\n",		\
+	printk("%sF2FS-fs : inject %s in %s of %pS\n",		\
 		KERN_INFO, fault_name[type],			\
 		__func__, __builtin_return_address(0))
 static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
-- 
2.1.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
