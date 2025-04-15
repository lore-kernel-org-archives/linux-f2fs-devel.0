Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBCAC369AB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:18:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u4cRV-00037u-9d;
	Tue, 15 Apr 2025 09:18:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1u4cRT-00037l-N3
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Apr 2025 09:18:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5ZvU4y3e1bhKyckotjab2sXY/WwL5o4Yid5/5fCjieQ=; b=aG/boI5OZy1mgDulQHBtg6oocA
 zHWj5uOpNi0N8XwICQOk+Y9h29t3fu48oIq03qCxBHJ3o0UzgwL8EHKXf34kJg+Erp++b+SrPSpt0
 oTphcU1YS1ilG6FAhNA6xJh6+kV2clOL8BeNcZsWWkbPvTnv2F4lAoGZ4QxpxS3su/XI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5ZvU4y3e1bhKyckotjab2sXY/WwL5o4Yid5/5fCjieQ=; b=L
 zw+vkQfo5ZNsntjelm+ytyFN64K8y8JsW4l1cIYnncvlbekfFESWWruXSVYmQr9juE5OFJVnfLhgj
 g2u1LTb/tiRZE7s40Ep/XUGCq6PimZXh1Qo+bf9WTcAt8X33aLiM/nyz3fHadJ3fxFTLiN96qrntb
 oFk6ycH4m/3GjPuQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u4cRE-0003gb-GL for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Apr 2025 09:18:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 47EEE6115F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Apr 2025 09:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A47C4CEDD;
 Tue, 15 Apr 2025 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744708709;
 bh=gt99NFWM+KKqSB7aDigB71T7lijBczFKrzmQpgfDM4E=;
 h=From:To:Cc:Subject:Date:From;
 b=WQUh1cmPpirOXFiK2KD6/qOWcDHGYSN17gxDSuSTkmYTNkAeW0b1j55HY2kvprGH0
 osuQqS28hbwHL/5IfFFy7VE0mJ4s//20h47dSamiUryCcVbx5uKACS/QwSVJyNIPGv
 7P0qqfihXJeXepOAFQmmyrD/YVZeAEcTpSp9Q4rd6rJ7cCjj5KHh29HiM1Mi/0RUpX
 HIQUCSELUxz1fbySeFC+96AiSFqfkEOh4hINKDT14lF68QJhEDcwDaDPrJX2AEHIYg
 K1mVeWguHttyCTMpsDHmBdpMYBsgDj3xnCe70lLL9QXHNrcxenmR6G6+EZdBbnwTMs
 qXPwj+vzUCVww==
To: jaegeuk@kernel.org
Date: Tue, 15 Apr 2025 17:18:22 +0800
Message-ID: <20250415091822.1093050-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
MIME-Version: 1.0
X-Headers-End: 1u4cRE-0003gb-GL
Subject: [f2fs-dev] [PATCH v2] dump.f2fs: support dump version_bitmap and
 chksum in checkpoint
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

dump.f2fs -d 1 img

...
checksum                      		[0x829fb462 : 2191504482]
nat_version_bitmap[0]         		[0x       0 : 0]
nat_version_bitmap[1]         		[0x       0 : 0]
nat_version_bitmap[2]         		[0x       0 : 0]
...
nat_version_bitmap[463]       		[0x       0 : 0]
sit_version_bitmap[0]         		[0x       0 : 0]
sit_version_bitmap[1]         		[0x       0 : 0]
sit_version_bitmap[2]         		[0x       0 : 0]
sit_version_bitmap[3]         		[0x       0 : 0]
...
sit_version_bitmap[47]        		[0x       0 : 0]

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix overflow & truncate issue
 fsck/mount.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index e7c4069..4fd26a6 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -563,6 +563,33 @@ printout:
 	printf("\n");
 }
 
+void print_chksum(struct f2fs_checkpoint *cp)
+{
+	unsigned int crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp +
+						get_cp(checksum_offset)));
+
+	printf("%-30s" "\t\t[0x%8x : %u]\n", "checksum", crc, crc);
+}
+
+void print_version_bitmap(struct f2fs_sb_info *sbi)
+{
+	char str[41];
+	int i, j;
+
+	for (i = NAT_BITMAP; i <= SIT_BITMAP; i++) {
+		unsigned int *bitmap = __bitmap_ptr(sbi, i);
+		unsigned int size = round_up(__bitmap_size(sbi, i), 4);
+
+		for (j = 0; j < size; j++) {
+			snprintf(str, 40, "%s[%d]", i == NAT_BITMAP ?
+						"nat_version_bitmap" :
+						"sit_version_bitmap", j);
+			printf("%-30s" "\t\t[0x%8x : %u]\n", str,
+						bitmap[i], bitmap[i]);
+		}
+	}
+}
+
 void print_ckpt_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
@@ -618,7 +645,9 @@ printout:
 	DISP_u32(cp, checksum_offset);
 	DISP_u64(cp, elapsed_time);
 
-	DISP_u32(cp, sit_nat_version_bitmap[0]);
+	print_chksum(cp);
+	print_version_bitmap(sbi);
+
 	printf("\n\n");
 }
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
