From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] f2fs: fix features filename in sysfs
 documentation
Date: Mon, 23 Apr 2018 10:26:30 -0700
Message-ID: <20180423172630.201062-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers3@gmail.com>) id 1fAfFF-0000Yg-M3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 17:27:17 +0000
Received: from mail-pf0-f194.google.com ([209.85.192.194])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fAfFD-0061RI-SI
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 17:27:17 +0000
Received: by mail-pf0-f194.google.com with SMTP id j5so9874705pfh.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Apr 2018 10:27:15 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

The file is called "features", not "feature".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 540553c933b6..50a34bacb1ab 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -140,7 +140,7 @@ Contact:	"Shuoran Liu" <liushuoran@huawei.com>
 Description:
 		 Shows total written kbytes issued to disk.
 
-What:		/sys/fs/f2fs/<disk>/feature
+What:		/sys/fs/f2fs/<disk>/features
 Date:		July 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
