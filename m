From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/4 v2] f2fs-tools: Add f2fs_io to .gitignore
Date: Wed, 27 Mar 2019 16:54:08 +0900
Message-ID: <20190327075410.15784-3-damien.lemoal@wdc.com>
References: <20190327075410.15784-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=9824208ba=damien.lemoal@wdc.com>)
 id 1h93O9-0007OR-2N
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 07:54:21 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h93O7-00F4ud-U8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 07:54:20 +0000
In-Reply-To: <20190327075410.15784-1-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

GIT ignore compiled executable tools/f2fs_io/f2fs_io.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 3f04e85..c1341da 100644
--- a/.gitignore
+++ b/.gitignore
@@ -50,6 +50,7 @@ stamp-h1
 /tools/fibmap.f2fs
 /tools/parse.f2fs
 /tools/f2fscrypt
+/tools/f2fs_io/f2fs_io
 /tools/sg_write_buffer/sg_write_buffer
 
 # cscope files
-- 
2.20.1
