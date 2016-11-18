From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] f2fs: drop duplicate header timer.h
Date: Fri, 18 Nov 2016 22:21:13 +0800
Message-ID: <1da64aa76ff77a5f2e7a152cfa9776417ee29743.1479458784.git.geliangtang@gmail.com>
References: <319a5803aac795e175306d4978134f0247cf87bc.1479457751.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <geliangtang@gmail.com>) id 1c7k3J-0004cM-Cq
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Nov 2016 14:22:05 +0000
Received: from mail-pg0-f67.google.com ([74.125.83.67])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1c7k3I-0002YD-Je
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Nov 2016 14:22:05 +0000
Received: by mail-pg0-f67.google.com with SMTP id e9so20450027pgc.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 18 Nov 2016 06:22:04 -0800 (PST)
In-Reply-To: <319a5803aac795e175306d4978134f0247cf87bc.1479457751.git.geliangtang@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Drop duplicate header timer.h from segment.c.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 fs/f2fs/segment.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 82c3ac4..98e5be4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -16,7 +16,6 @@
 #include <linux/kthread.h>
 #include <linux/swap.h>
 #include <linux/timer.h>
-#include <linux/timer.h>
 
 #include "f2fs.h"
 #include "segment.h"
-- 
2.9.3


------------------------------------------------------------------------------
