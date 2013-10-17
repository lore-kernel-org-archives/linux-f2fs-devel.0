From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs tools for arm
Date: Thu, 17 Oct 2013 15:32:10 +0900
Message-ID: <1381991530.992.46.camel@kjgkr>
References: <525EA51E.6040609@codeaurora.org>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VWh8b-0006qL-Io
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Oct 2013 06:32:49 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VWh8Z-0004NE-2V for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Oct 2013 06:32:48 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MUS003VWVIFXJ20@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Oct 2013 15:32:40 +0900 (KST)
In-reply-to: <525EA51E.6040609@codeaurora.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

This will help you.

>From 050e8712a60c7d982a7be8c076fb72452364dae4 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Thu, 17 Oct 2013 15:15:54 +0900
Subject: [PATCH] README: add description how to cross-compile
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
linux-f2fs-devel@lists.sourceforge.net

This patch adds description for the cross-compilation.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 README | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/README b/README
index cbb492e..bf374fb 100644
--- a/README
+++ b/README
@@ -25,6 +25,20 @@ How to compile
  # ./configure
  # make
 
+How to cross-compile (e.g., for ARM)
+------------------------------------
+
+ 1. Add the below line into mkfs/Makefile.am:
+ mkfs_f2fs_LDFLAGS = -all-static
+
+ 2. Add the below line into fsck/Makefile.am:
+ fsck_f2fs_LDFLAGS = -all-static
+
+ 3. then, do:
+ # LDFLAGS=--static ./configure \
+	--host=arm-none-linux-gnueabi --target=arm-none-linux-gnueabi
+ # make
+
 How to run by default
 ---------------------
 
-- 
1.8.4.474.g128a96c

-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
