From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 2/2 v2] f2fs: fix the location of tracepoint
Date: Wed, 11 Dec 2013 16:10:56 +0900
Message-ID: <1386745856.2101.153.camel@kjgkr>
References: <1386741927-6007-1-git-send-email-jaegeuk.kim@samsung.com>
	<1386741927-6007-2-git-send-email-jaegeuk.kim@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vqdxo-00042H-9A
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 Dec 2013 07:12:08 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Vqdxm-0003Kg-Dh
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 Dec 2013 07:12:08 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MXM004VQRZZYY90@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 Dec 2013 16:11:59 +0900 (KST)
In-reply-to: <1386741927-6007-2-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Change log from v1:
 o fix a mistake

>From 59df095b83e601b1b317ce97a5f767a8c3303902 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Wed, 11 Dec 2013 14:29:39 +0900
Subject: [PATCH] f2fs: fix the location of tracepoint
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
linux-f2fs-devel@lists.sourceforge.net

We need to get a trace before submit_bio, since its bi_sector is
remapped during
the submit_bio.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ebc9177..15956fa 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -104,11 +104,12 @@ static void __submit_merged_bio(struct
f2fs_bio_info *io)
 	rw = fio->rw | fio->rw_flag;
 
 	if (is_read_io(rw)) {
-		submit_bio(rw, io->bio);
 		trace_f2fs_submit_read_bio(io->sbi->sb, rw, fio->type, io->bio);
+		submit_bio(rw, io->bio);
 		io->bio = NULL;
 		return;
 	}
+	trace_f2fs_submit_write_bio(io->sbi->sb, rw, fio->type, io->bio);
 
 	/*
 	 * META_FLUSH is only from the checkpoint procedure, and we should
wait
@@ -122,7 +123,6 @@ static void __submit_merged_bio(struct f2fs_bio_info
*io)
 	} else {
 		submit_bio(rw, io->bio);
 	}
-	trace_f2fs_submit_write_bio(io->sbi->sb, rw, fio->type, io->bio);
 	io->bio = NULL;
 }
 
-- 
1.8.4.474.g128a96c


-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
