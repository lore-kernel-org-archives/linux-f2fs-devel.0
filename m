From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 5/7] mkfs.f2fs: Reset sequential zones on device
	discard
Date: Fri, 28 Oct 2016 16:57:02 +0900
Message-ID: <1477641424-12367-7-git-send-email-damien.lemoal@wdc.com>
References: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02Go-0006Pb-W9
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:11 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02Go-0007AL-4X
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:10 +0000
In-Reply-To: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
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
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-f2fs-devel@lists.sourceforge.net

For a zoned blocks device, trim must reset all sequential zones
of the device.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 mkfs/f2fs_format_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index d469ce5..654c22b 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -61,6 +61,8 @@ int f2fs_trim_device()
 #endif
 		return 0;
 	} else if (S_ISBLK(stat_buf.st_mode)) {
+		if (config.zoned_mode)
+			return f2fs_reset_zones(&config);
 #ifdef BLKSECDISCARD
 		if (ioctl(config.fd, BLKSECDISCARD, &range) < 0) {
 			MSG(0, "Info: This device doesn't support BLKSECDISCARD\n");
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
