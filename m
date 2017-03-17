From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add missing INMEM_REVOKE trace enum
	definition
Date: Fri, 17 Mar 2017 18:46:14 +0800
Message-ID: <20170317104614.90047-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1copPA-0003B6-VH
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 10:46:44 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1copP8-0000lg-Uq
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 10:46:44 +0000
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

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 include/trace/events/f2fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index d799ca7d8e71..16fcd192e257 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -15,6 +15,7 @@ TRACE_DEFINE_ENUM(META);
 TRACE_DEFINE_ENUM(META_FLUSH);
 TRACE_DEFINE_ENUM(INMEM);
 TRACE_DEFINE_ENUM(INMEM_DROP);
+TRACE_DEFINE_ENUM(INMEM_REVOKE);
 TRACE_DEFINE_ENUM(IPU);
 TRACE_DEFINE_ENUM(OPU);
 TRACE_DEFINE_ENUM(CURSEG_HOT_DATA);
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
