Return-Path: <SRS0=DU7W=ZU=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434D7C432C3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Nov 2019 08:00:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1261821770;
	Thu, 28 Nov 2019 08:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VuliK5Dr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Z4jlwvGR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DvfcSASK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1261821770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iaEir-0003Nn-MN; Thu, 28 Nov 2019 08:00:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=2285f8a38=shinichiro.kawasaki@wdc.com>)
 id 1iaEil-0003MX-1Y
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Nov 2019 08:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ujB46cskWhCl2T/HMSkG+1UsHh4mv17gs7jjaGkE04c=; b=VuliK5Dro+fNHleIsxCzfhaLVi
 0ktkkj9LasrwX0uao6oPTZ0EtXBa0nlpiw/Zzwy6B4DVFUKqOvbe+Edk0JDygsIsqazewbtf8EXAz
 o6ovSQq7IvxChx31180RlSAMPnuA2k+3g4Xl6A0ciF3sDlHXriu2zLadJln+A381XMok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ujB46cskWhCl2T/HMSkG+1UsHh4mv17gs7jjaGkE04c=; b=Z4jlwvGRpJLIrMZsL0lSnu5Wb/
 L6iVKQhLYKUGVu4J9clH9J2hMaTkp3UrOzBAc1Y5NpGe1Ju0wilpPMeFzPNn3JKk5WzgXUET9sG/E
 EeXOR2ekg9zJvYx9zePElLN+kEMhMC5UBozltHsl3SL9iudHzwhqp/f7WuxhVo76uxxo=;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iaEie-00Fq7V-FJ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Nov 2019 08:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574928065; x=1606464065;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GFDk8qg5ZvVcrqS3dbu4XLLbXid2AikV1IrRv2cpbcc=;
 b=DvfcSASKgEoqLc2v1OsVTBOm0FSMNHP816Vta8K+QRnseDTDNeDrtg6E
 v9/X2B4AZYlJzElhf+js+rwt1HHPMh23xhicMtvenW5T4BSB6cejdrGGc
 LYAPowXIuluabZdYI0pGlaWiY+TmL0gXZ4Wjxp73IC29qoXO/VTrsL2kH
 twVkCkqScKyAWq/QdzWTajfi7IFovjQQpWrjSuGggUCZcllTk/yTkWx/5
 B69j59guz35Y5HrAszBozHcvnupqe0lX51yTE6IIjMhD6uNsZYtEZqL7D
 qUkDwihtY1buQX3U2Y23zo2Gv6ciVBMdAfqPRIyIk95Fi9qkKUKVQJbKJ g==;
IronPort-SDR: K9BPszumjPO9eQgn4tcRgaVVgZ81c0wVMJSwzlwo+GTYM8cdfFiLM4tejqhTWQYCGI4fLD2iQ/
 Hwb10CaQJUFuljHIf9ZPyqnmewuctL6k4O6/8M/o4JpMJ6uhlmhvxSHkxTsu3YdoheiQ1lp5V8
 tIn7pXc6TF39EbG93UAl1+KVpA7LhJ+j21RtCS2VoZM1Zs/OX2aQ3S0HqcjGZzUmPdWyOXf2mV
 sWw0dieJeSHIx4uO2MVWGbkAGirXuLuueM1JpKIFzw0FC4VcuMlXlC8BEsn2sicsvxoQGGWSqy
 txo=
X-IronPort-AV: E=Sophos;i="5.69,252,1571673600"; d="scan'208";a="225597357"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2019 16:00:43 +0800
IronPort-SDR: /YvV40l00WCyuwQFoATcDGaIAGD1uab5cV6MMluLRL3NahW2EjPQeFoHnZhsy+5Oa0VzngYEft
 tIFUbMXeX7D+TkhorLiTgQ6wrH1L4c7SO18djujcMf4zu+9IvWXLkuCuSiTUwbOlB2y/cvUDym
 WscPGdNC7bJbPyn+aiWX4gwd8bm2cnNdFwzmWGWFE2mOlmdfzXPQqrmoYitHJDe9HyyX23NYdq
 Lta7sIrzL1sujtwN7SqJzZazKn5NA2Ilckt5Yb4uV3R8qKWq73uP9Hf2z8edtVG8DC02t/albi
 EnkakXUDkSIkdeX7fkUsahU8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 23:54:29 -0800
IronPort-SDR: PWjsUQ3A2cqgGm+L/exkc9zNh6jwWxaLaNwJycza+hHRvBuvFZYkrcf3kjQr5J7w3OHIbsZlp3
 q9mnwWkc135KbzUjwlq6qDq3DlkpLCUDzBQc/O57kM7iEJsS8/xhOf3yhL1w2URcSAigTq3hnp
 E1hFn9Y3MQLItPkbhwD8NQKz8R9aXdA3zD0af/UTm8IuQNtov0VOT73v48/wi0+A92nAKbCmPM
 YELOVvkytE9PDIlqyz4vJPVM9tIXlA3KZCNJVsXoIf9N+tQmKsSx/VoelT//AgZXTCOzDR24kh
 OQI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com)
 ([10.149.53.87])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Nov 2019 23:59:54 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 28 Nov 2019 16:59:25 +0900
Message-Id: <20191128075930.467833-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128075930.467833-1-shinichiro.kawasaki@wdc.com>
References: <20191128075930.467833-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
X-Headers-End: 1iaEie-00Fq7V-FJ
Subject: [f2fs-dev] [PATCH v8 3/8] libf2fs_zoned: Introduce
 f2fs_reset_zone() helper function
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

To prepare for write pointer consistency fix by fsck, add
f2fs_reset_zone() helper function which calls RESET ZONE command. The
function is added to lib/libf2fs_zoned which gathers zoned block device
related functions.

When f2fs-tools are built without blkzoned.h kernel header, the helper
function f2fs_reset_zone() prints an error message as other helper
functions in lib/libf2fs_zoned print. To make the message consistent
through the all helper functions, modify message strings in
f2fs_check_zones() and f2fs_reset_zones().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h   |  1 +
 lib/libf2fs_zoned.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index d6ea688..9c26314 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1323,6 +1323,7 @@ extern int f2fs_report_zone(int, u_int64_t, void *);
 typedef int (report_zones_cb_t)(int i, void *, void *);
 extern int f2fs_report_zones(int, report_zones_cb_t *, void *);
 extern int f2fs_check_zones(int);
+int f2fs_reset_zone(int, void *);
 extern int f2fs_reset_zones(int);
 
 #define SIZE_ALIGN(val, size)	((val) + (size) - 1) / (size)
diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 5328c56..8b88fe9 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -388,6 +388,28 @@ out:
 	return ret;
 }
 
+int f2fs_reset_zone(int i, void *blkzone)
+{
+	struct blk_zone *blkz = (struct blk_zone *)blkzone;
+	struct device_info *dev = c.devices + i;
+	struct blk_zone_range range;
+	int ret;
+
+	if (!blk_zone_seq(blkz) || blk_zone_empty(blkz))
+		return 0;
+
+	/* Non empty sequential zone: reset */
+	range.sector = blk_zone_sector(blkz);
+	range.nr_sectors = blk_zone_length(blkz);
+	ret = ioctl(dev->fd, BLKRESETZONE, &range);
+	if (ret != 0) {
+		ret = -errno;
+		ERR_MSG("ioctl BLKRESETZONE failed: errno=%d\n", errno);
+	}
+
+	return ret;
+}
+
 int f2fs_reset_zones(int j)
 {
 	struct device_info *dev = c.devices + j;
@@ -487,13 +509,19 @@ int f2fs_get_zone_blocks(int i)
 
 int f2fs_check_zones(int i)
 {
-	ERR_MSG("%d: Zoned block devices are not supported\n", i);
+	ERR_MSG("%d: Unsupported zoned block device\n", i);
+	return -1;
+}
+
+int f2fs_reset_zone(int i, void *blkzone)
+{
+	ERR_MSG("%d: Unsupported zoned block device\n", i);
 	return -1;
 }
 
 int f2fs_reset_zones(int i)
 {
-	ERR_MSG("%d: Zoned block devices are not supported\n", i);
+	ERR_MSG("%d: Unsupported zoned block device\n", i);
 	return -1;
 }
 
-- 
2.23.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
