From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 1/9] f2fs: Add missing break in switch-case
Date: Fri, 28 Oct 2016 17:44:59 +0900
Message-ID: <1477644307-30115-2-git-send-email-damien.lemoal@wdc.com>
References: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6132b4c..f6379f5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -420,6 +420,7 @@ static int parse_options(struct super_block *sb, char *options)
 			break;
 		case Opt_nodiscard:
 			clear_opt(sbi, DISCARD);
+			break;
 		case Opt_noheap:
 			set_opt(sbi, NOHEAP);
 			break;
-- 
2.7.4

