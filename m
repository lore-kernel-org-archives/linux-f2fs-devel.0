From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 6/9] f2fs: Do not allow adaptive mode for
	host-managed zoned block devices
Date: Fri, 28 Oct 2016 17:45:04 +0900
Message-ID: <1477644307-30115-7-git-send-email-damien.lemoal@wdc.com>
References: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02oF-0007ki-No
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:46:43 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02oE-0003iL-OQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:46:43 +0000
In-Reply-To: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Le Moal <damien.lemoal@wdc.com>, Damien, linux-f2fs-devel@lists.sourceforge.net, Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-fsdevel@vger.kernel.org

The LFS mode is mandatory for host-managed zoned block devices as
update in place optimizations are not possible for segments in
sequential zones.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2c8a12e..58fd69d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -518,6 +518,13 @@ static int parse_options(struct super_block *sb, char *options)
 				return -ENOMEM;
 			if (strlen(name) == 8 &&
 					!strncmp(name, "adaptive", 8)) {
+				if (f2fs_sb_mounted_blkzoned(sb)) {
+					f2fs_msg(sb, KERN_WARNING,
+						 "adaptive mode is not allowed with "
+						 "zoned block device feature");
+					kfree(name);
+					return -EINVAL;
+				}
 				set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
 			} else if (strlen(name) == 3 &&
 					!strncmp(name, "lfs", 3)) {
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.


------------------------------------------------------------------------------
The Command Line: Reinvented for Modern Developers
Did the resurgence of CLI tooling catch you by surprise?
Reconnect with the command line and become more productive. 
Learn the new .NET and ASP.NET CLI. Get your free copy!
http://sdm.link/telerik
