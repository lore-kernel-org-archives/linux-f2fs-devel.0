From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] configure: uclinux is also linux
Date: Wed, 13 Jun 2018 20:48:34 +0300
Message-ID: <67629fd736a8a4295a9f2acb96563953be22a3ae.1528912114.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <baruch@tkos.co.il>) id 1fTAHZ-0005SE-F6
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Jun 2018 18:14:09 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fTAHV-008Cu6-2C
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Jun 2018 18:14:09 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Baruch Siach <baruch@tkos.co.il>, linux-f2fs-devel@lists.sourceforge.net

Linux systems on no-MMU platforms identify as uclinux. They are
otherwise identical to plain Linux.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a3ff12bf3de9..2b13be5b09f9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -166,7 +166,7 @@ build_mac=no
 
 # Detect the target system
 case "${host_os}" in
-linux*)
+linux*|uclinux*)
 	build_linux=yes
 	;;
 cygwin*|mingw*)
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
