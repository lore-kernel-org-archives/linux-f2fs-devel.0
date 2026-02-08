Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE78BEF06E2
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  8 Feb 2026 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OL/deZQN1RKbEPCz4i244bxCq73wvgPMIf1cBtsXBEU=; b=fHxDx3ppHEA2HvOv/w7x7DAoyR
	/EmaO8QwB1PnW8/d6ApA8neZNCcLXP6m4wvmYCXul+x5hhP+olUH59QAWjwbZZwGsS+yb8NmZtvx+
	F82Irn/W0x6dD+vruB7jfSb6oCVEzbj1d7mlyT56wJP/XHnoNCO9ycuV/OEymBWQEUnk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vozwO-00068o-A5;
	Sun, 08 Feb 2026 08:14:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1vozwL-00067X-2L
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 08 Feb 2026 08:14:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PLgiF7W5o7QjB6OH5P194673hC3iRmqLC9D7hEgFdzk=; b=H7T5MyhTdCAhf0CnGAMXScCG7g
 XELUR6x1WjoYit0nr6n/JS+bZAGNxU0NZqgYOjMohI59dOUWTD7G35IFBGODk00M2Q/n7Y7VPXdZM
 FaJ8pdR3pTku4hh5N12nnkzTRqQGXKxQ6jQUaFfCtZR9XbU3Dtg5LBBTG5VqGme1KSpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PLgiF7W5o7QjB6OH5P194673hC3iRmqLC9D7hEgFdzk=; b=E
 aqzee5fAcQzGO/rw8aZ95mEmBeuyOiEmb1BckyCtnoSvttrtj3TqiGgQSoIKAsDjqnshs7v4qxvtt
 P7qfF3N4QCk31jzTqCVI20ZqwcagmGCia38tk1CRzt1DrYowFZ5QoRmnmG8ZX5hqsHK2H/uONHbxi
 VhxP4p8KnMaMlgW0=;
Received: from r3-18.sinamail.sina.com.cn ([202.108.3.18])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vozwJ-0004bH-Us for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 08 Feb 2026 08:14:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1770538484; bh=PLgiF7W5o7QjB6OH5P194673hC3iRmqLC9D7hEgFdzk=;
 h=From:Subject:Date:Message-ID;
 b=U7O8k28stnYmg2erxcSJhbKUi6c1Al8u2K6Ri6v+aw3N0fI3PuiuKsNTdKlNIZq7M
 3oeykGs8Vxgix0eixAgNx9Zi6EjfNbqXZSNI4hPoh13momdbWqnUOweyKfWAS7LoZv
 NkUN0/ph9AeuuMQbSu3EyX3XVOZm/R+4XEDtols4=
X-SMAIL-HELO: monty-fedora-test
Received: from unknown (HELO monty-fedora-test)([120.245.115.151])
 by sina.com (10.54.253.32) with ESMTP
 id 698845E200002B9B; Sun, 8 Feb 2026 16:14:30 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 5839644456889
X-SMAIL-UIID: C112D0B665B74EBBBE639076D9CD20D6-20260208-161430-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sun,  8 Feb 2026 03:12:53 -0500
Message-ID: <20260208081252.32664-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Headers-End: 1vozwJ-0004bH-Us
Subject: [f2fs-dev] [PATCH] f2fs-tools: fix division-by-zero exception
 during formatting of undersized devices
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When formatting a device that is too small , the error handling in
f2fs_prepare_super_block() is flawed, leading to a division-by-zero
exception.

Reproducer:
root@vm:~/f2fs-tools# dd if=/dev/zero of=data.6M bs=1M count=6
root@vm:~/f2fs-tools# losetup -f data.6M
root@vm:~/f2fs-tools# mkfs.f2fs /dev/loop0

This patch adds a check to verify if the device has enough capacity to
store the metadata area. If not, it immediately returns an error to
prevent the subsequent division-by-zero exception from being triggered.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 mkfs/f2fs_format.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index b3dccd0..df68b23 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -268,6 +268,7 @@ static int f2fs_prepare_super_block(void)
 	uint32_t segment_size_bytes, zone_size_bytes;
 	uint32_t alignment_bytes;
 	uint32_t sit_segments, nat_segments;
+	uint32_t segment_count_meta;
 	uint32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
 	uint32_t total_valid_blks_available;
 	uint64_t zone_align_start_offset, diff;
@@ -423,9 +424,14 @@ static int f2fs_prepare_super_block(void)
 	set_sb(nat_blkaddr, get_sb(sit_blkaddr) + get_sb(segment_count_sit) *
 			c.blks_per_seg);
 
+	segment_count_meta = get_sb(segment_count_ckpt) + get_sb(segment_count_sit);
+	if (get_sb(segment_count) <= segment_count_meta) {
+		MSG(0, "\tError: segment_count: %u too small, segment_count_meta: %u\n",
+				get_sb(segment_count), segment_count_meta);
+		goto too_small;
+	}
 	total_valid_blks_available = (get_sb(segment_count) -
-			(get_sb(segment_count_ckpt) +
-			get_sb(segment_count_sit))) * c.blks_per_seg;
+			segment_count_meta) * c.blks_per_seg;
 
 	blocks_for_nat = SIZE_ALIGN(total_valid_blks_available,
 			NAT_ENTRY_PER_BLOCK);
@@ -491,11 +497,16 @@ static int f2fs_prepare_super_block(void)
 	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) + get_sb(segment_count_nat) *
 			c.blks_per_seg);
 
-	total_valid_blks_available = (get_sb(segment_count) -
-			(get_sb(segment_count_ckpt) +
+	segment_count_meta = get_sb(segment_count_ckpt) +
 			get_sb(segment_count_sit) +
-			get_sb(segment_count_nat))) *
-			c.blks_per_seg;
+			get_sb(segment_count_nat);
+	if (get_sb(segment_count) <= segment_count_meta) {
+		MSG(0, "\tError: segment_count: %u too small, segment_count_meta(with nat): %u\n",
+				get_sb(segment_count), segment_count_meta);
+		goto too_small;
+	}
+	total_valid_blks_available = (get_sb(segment_count) -
+			segment_count_meta) * c.blks_per_seg;
 
 	if (c.feature & F2FS_FEATURE_RO) {
 		blocks_for_ssa = 0;
@@ -560,10 +571,13 @@ static int f2fs_prepare_super_block(void)
 		}
 	}
 
-	total_zones = get_sb(segment_count) / (c.segs_per_zone) -
-							total_meta_zones;
-	if (total_zones == 0)
+	total_zones = get_sb(segment_count) / (c.segs_per_zone);
+	if (total_zones <= total_meta_zones) {
+		MSG(0, "\tError: total_zones:%u too small, total_meta_zones: %lu\n",
+				total_zones, total_meta_zones);
 		goto too_small;
+	}
+	total_zones -= total_meta_zones;
 	set_sb(section_count, total_zones * c.secs_per_zone);
 
 	set_sb(segment_count_main, get_sb(section_count) * c.segs_per_sec);
-- 
2.47.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
