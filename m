From: Jonggyu <i9mpossible@gmail.com>
Subject: [PATCH] In fs/f2fs/data.c, there is a typo.
Date: Wed, 10 Aug 2016 20:25:36 +0900
Message-ID: <1470828336-26120-1-git-send-email-i9mpossible@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <i9mpossible@gmail.com>) id 1bXRdi-0005N9-J7
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 Aug 2016 11:25:38 +0000
Received: from mail-pf0-f193.google.com ([209.85.192.193])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bXRdh-0001TZ-T2
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 Aug 2016 11:25:38 +0000
Received: by mail-pf0-f193.google.com with SMTP id y134so2716191pfg.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 10 Aug 2016 04:25:37 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, cm224.lee@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

I fixed write_cche_pages to write_cache_pages

Signed-off-by: Jonggyu <i9mpossible@gmail.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d64d2a5..9549ff0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1326,7 +1326,7 @@ redirty_out:
 }
 
 /*
- * This function was copied from write_cche_pages from mm/page-writeback.c.
+ * This function was copied from write_cache_pages from mm/page-writeback.c.
  * The major change is making write step of cold data page separately from
  * warm/hot data page.
  */
-- 
1.9.1


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. http://sdm.link/zohodev2dev
