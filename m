From: Zhikang Zhang <zhangzhikang1@huawei.com>
Subject: [PATCH] f2fs: fix compile warnings: 'struct *' declared
 inside parameter list
Date: Thu, 3 Jan 2019 20:06:38 +0800
Message-ID: <1546517198-9555-1-git-send-email-zhangzhikang1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhangzhikang1@huawei.com>) id 1gf1lw-0004vx-EA
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jan 2019 12:06:48 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gf1lu-00CWL9-69
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jan 2019 12:06:48 +0000
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

We meet these compile warnings below, which caused by missing declare structs:
struct f2fs_io_info, struct extent, struct f2fs_sb_info.

warning: 'struct f2fs_io_info' declared inside parameter list
warning: 'struct extent_info' declared inside parameter list
warning: 'struct f2fs_sb_info' declared inside parameter list

Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>
---
 include/trace/events/f2fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 3ec73f1..8a28a2b 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -149,6 +149,9 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
 		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
 		{ CP_RECOVER_DIR,	"dir needs recovery" })
 
+struct f2fs_sb_info;
+struct f2fs_io_info;
+struct extent_info;
 struct victim_sel_policy;
 struct f2fs_map_blocks;
 
-- 
2.7.4
