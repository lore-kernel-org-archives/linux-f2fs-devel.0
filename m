From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: fix incorrect document of
 batched_trim_sections
Date: Mon, 12 Jun 2017 09:44:26 +0800
Message-ID: <20170612014427.40692-3-yuchao0@huawei.com>
References: <20170612014427.40692-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dKEPa-0004k9-0u
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Jun 2017 01:44:58 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dKEPY-0003dT-J4
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Jun 2017 01:44:58 +0000
In-Reply-To: <20170612014427.40692-1-yuchao0@huawei.com>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index ae59451865a6..ffe97abd080a 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -75,7 +75,7 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
 Description:
 		 Controls the memory footprint used by f2fs.
 
-What:		/sys/fs/f2fs/<disk>/trim_sections
+What:		/sys/fs/f2fs/<disk>/batched_trim_sections
 Date:		February 2015
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
