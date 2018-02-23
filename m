From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 1/7] fsck.f2fs: fix typo
Date: Fri, 23 Feb 2018 11:17:55 +0800
Message-ID: <20180223031801.231805-2-shengyong1@huawei.com>
References: <20180223031801.231805-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ep3sU-00042c-5p
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:18:30 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ep3sS-0004Ow-6n
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:18:30 +0000
In-Reply-To: <20180223031801.231805-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: hyojun@google.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 804f71a..bbf82c3 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -137,7 +137,7 @@ static void error_out(char *prog)
 	else if (!strcmp("sload.f2fs", prog))
 		sload_usage();
 	else
-		MSG(0, "\nWrong progam.\n");
+		MSG(0, "\nWrong program.\n");
 }
 
 void f2fs_parse_options(int argc, char *argv[])
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
