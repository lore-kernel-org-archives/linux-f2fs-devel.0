Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC23FC02185
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jan 2025 11:20:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tZppG-0002ik-3v;
	Mon, 20 Jan 2025 11:20:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tZppB-0002iZ-Hd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jan 2025 11:20:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o57NA2OL/GjZkPVPhhcZ+bapgZspTvrupOeNQv5yrPg=; b=GkPMoSrNi/564XRKeQC0WIcwkp
 P3MVJeMC5hDs8Y9irxc7YgR77w0tV6Y1WRH3IhTkWOsmALY64X72yUdBbXE8+A7uX7sQzKEr+46El
 C/dOjmpNfDJFTcRSPjlF2jsuA+NQ3buXfw/0e3Ue/BRCXm62EITy9ITH+hSDfdK1xhCc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o57NA2OL/GjZkPVPhhcZ+bapgZspTvrupOeNQv5yrPg=; b=BtG00LuqlhU8nwB+eJ5ztFRGyv
 RAkfZ61lO2ZItI8Wb738KHZHMTkMOrd74odvtqgbSeeSzu7npg/oewakXlXQEZYr3LzyRBnqFuELW
 VkpP6oooCFaBkA3YC/8tl7yib9G68EQp98uA2lCUrCkfpm4ZhbZ8tE6wMSXRlO/EK04c=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tZppA-000608-5z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jan 2025 11:20:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C7E04A40E01
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 Jan 2025 11:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A393C4CEE3;
 Mon, 20 Jan 2025 11:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737371997;
 bh=oSHk3cSqjy4pIYcib0WLfuNmwU7o2+oVafI0R0Xv/5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gZHQ6vzAW320IQbPCjHow6MpdSvFcDtgNE85wrSfSGJGKCdLvOV60Mn6Z6fsxg9TZ
 qT6+q+/qacU/q+1ZETniavlaWBtcBU8Mk5BA+2wwJW4KwkZ3myLbKGuFx1hDUw1pPW
 hGJVcH0J6CT4mpR0AggFTt1CsVhn9DeZ5UJRRwffjvYxZFCkJ7X9lPANFhVpCMbnQa
 e9L2W+SNma1BT3DCzBuGBAwNBt+cPdz4cuu8iIavEGjyPbH50q1IvbcGAUMh1m+3wr
 2zCyFwhzx5q2H7ndAvQ497LFBDG/zTPSR4YcXjATNGx7jKnDFSWi1UrTxmCpqZ3L2K
 vYnZfa9035/3Q==
To: jaegeuk@kernel.org
Date: Mon, 20 Jan 2025 19:19:41 +0800
Message-ID: <20250120111941.191621-2-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
In-Reply-To: <20250120111941.191621-1-chao@kernel.org>
References: <20250120111941.191621-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tZppA-000608-5z
Subject: [f2fs-dev] [PATCH 2/2] f2fs: procfs: show mtime in segment_bits
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Show mtime in segment_bits for debug.

cat /proc/fs//f2fs/loop0/segment_bits
format: segment_type|valid_blocks|bitmaps|mtime
segment_type(0:HD, 1:WD, 2:CD, 3:HN, 4:WN, 5:CN)
0         3|1  | 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00| ffffffffffffffff
1         4|3  | 00 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00| ffffffffffffffff
2         5|0  | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00| ffffffffffffffff
3         0|1  | 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00| ffffffffffffffff

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f81190fabdd3..b01c5984cf22 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1480,7 +1480,7 @@ static int __maybe_unused segment_bits_seq_show(struct seq_file *seq,
 			le32_to_cpu(sbi->raw_super->segment_count_main);
 	int i, j;
 
-	seq_puts(seq, "format: segment_type|valid_blocks|bitmaps\n"
+	seq_puts(seq, "format: segment_type|valid_blocks|bitmaps|mtime\n"
 		"segment_type(0:HD, 1:WD, 2:CD, 3:HN, 4:WN, 5:CN)\n");
 
 	for (i = 0; i < total_segs; i++) {
@@ -1490,6 +1490,7 @@ static int __maybe_unused segment_bits_seq_show(struct seq_file *seq,
 		seq_printf(seq, "%d|%-3u|", se->type, se->valid_blocks);
 		for (j = 0; j < SIT_VBLOCK_MAP_SIZE; j++)
 			seq_printf(seq, " %.2x", se->cur_valid_map[j]);
+		seq_printf(seq, "| %llx", se->mtime);
 		seq_putc(seq, '\n');
 	}
 	return 0;
-- 
2.48.1.262.g85cc9f2d1e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
