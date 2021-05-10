Return-Path: <SRS0=s44c=KF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BBDC433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 May 2021 11:40:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA9D60FD7;
	Mon, 10 May 2021 11:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA9D60FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lg4H6-0003mJ-GF; Mon, 10 May 2021 11:40:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <prvs=7576b64e4=shinichiro.kawasaki@wdc.com>)
 id 1lg4H4-0003mB-Ng
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 May 2021 11:40:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p44TPm134Bs1G4ASPGO0NkvrQwTfxGTYNPkFYEkVRVQ=; b=Ia326OzxfBh0ngH4xF1UZgGtHa
 qTIYuubGfJJq2P2QtbDXbnDY8cNrB8T3ogHvsPTu4k3oQ+KXNk+MKd/l+waeykdmh/XvH+7BXY0fs
 fQ/Pdev0w2A2NdfpNi5jXd3z69f46oQIa4400RjrmBYd78GS8j/sLuJqwhKWJzp3QETY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p44TPm134Bs1G4ASPGO0NkvrQwTfxGTYNPkFYEkVRVQ=; b=Z
 XU07RXnXm+zTmo/pFqnmiMNndx8gie0CUJeWe7I6CIdQmacTag//im/lW6RfwVJHczps+JWbA/m75
 VgwnHy9BvP7CKuunpy1mJq0+kK0DpLU7NUfzZLKCq5xnr88sBAltfd/2DAzalvR3IVMrX9o8PYE1C
 eSU7FPhEY/CjHM2Y=;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lg4H1-001XH5-6n
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 May 2021 11:40:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620646831; x=1652182831;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kQ8En0kD67pqBF5F8DWzMM+UkxRAz8liH8T2xfN7b+o=;
 b=XEipZe9QBqbU5w3rsEBO8ZE+YqrOt+jHSTPqReJazxaeKMzqHb2+Gsse
 hUCXIFHwtTM68ZpKY7u7yoJbgIq8ria46v86S/y4cL8UZ1gTy6ikgr0pq
 WqsUtTES6D/0tdSl0B0DLG9h7KSfIJSwSE6Vt4bhhCOVzH3CVwHZUaQUH
 xtNiCcPiIQz0yWFW1hQxKtLDmKqzDJGt5KrepP5ltgZ1Y+7npn4BZTjwT
 N3n/z26U2Qxd+CB8TQ6vn/D0fVyHbJAXHNnv2y/cbokpSMhTvdEEbZN7O
 yJlbt8Joee/RHb0CjidrDnnY1bgtnw51OFisO607y+KKb/1s3oyxyrbDh Q==;
IronPort-SDR: ZeYoRFZ2bscPwFwqs3lsAiPJ6ONFqNuu+cs5haUGn9Z76hGqw10/Pz0X4BGtDWCdX77EXB+wRF
 XlIFaOpzk2a+kJMPCeIMwtMlH3mWk/3+tk2HZo0qw30iHT40Gp4r8086YdobRpnByTWpE1AkXE
 3Bj4rz9m4BTRVcIxSWrgKsPCV3j5eLkzQyDznmvoUEkxX2e8cZw1nQHkTE5iiuzzpE1618v5UG
 eb0pCxPchjQFCuEXLcTVHtti5WRnsAgYderhWK3zxrN3p7EZsFYsqhTTgSyXHVcQ7QY9coz5aO
 41Q=
X-IronPort-AV: E=Sophos;i="5.82,287,1613404800"; d="scan'208";a="278753224"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 19:24:46 +0800
IronPort-SDR: c6rHeh5oOoFzpsjHDqwZ2JSGD3mWAx+nlwFF/cp3LauZKxaS7owJS44Ycoutqp1hYse5QXzFnz
 E+s9Joo83qVIDKEWddqqczdb9E9nIieJMBJgNn11bHK23xhzdDkWzFf4epmCvDqnvIMI5PuCQb
 o6HQhwzzsjt031CaV2mdM3uQIsFvmVR4SenEy8cXlgTIgevgIjzlr3tggxfDKE4t/S1OQZ1aNH
 C/HsCWM1tHqcgIbsGRAXBdsb4Og6USHq2z94riY6lihDX9Fu9EHwqu2voBN0QoqKITjDWgOb9i
 2x39E7VEIDPKUDGTELjgIogw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 04:04:46 -0700
IronPort-SDR: bqvHrlxVfc3aJ8r+b9oohRRiJ2/xeY7uGiFlNIW1cf2/+2zFhVOnnX5rGeaxSF4Ax0FO5nApXB
 qrEW2NuKovqgMifA4FDRzth5vXRD3bsaF8J8PfbSIusF7PO0Fp7DzrKMhZEL8RX7sy3ull6VZ8
 afqySzwJyc7M9VSmDVzHmKnHW9Nd9qCoWOPLBCrpXwJRtmkTjNTKwdIuV+c2SV83iPLXpYEPKb
 ZMME5VNGOim6MCyECUzBbzDm4EIS2w47j8Ky0JovAwyimMEgoi2kE0s5CEUPWy1s6UWETbxBck
 jmw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com)
 ([10.149.52.173])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 May 2021 04:24:45 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 10 May 2021 20:24:44 +0900
Message-Id: <20210510112444.902964-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Headers-End: 1lg4H1-001XH5-6n
Subject: [f2fs-dev] [PATCH v2] f2fs: Prevent swap file in LFS mode
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

The kernel writes to swap files on f2fs directly without the assistance
of the filesystem. This direct write by kernel can be non-sequential
even when the f2fs is in LFS mode. Such non-sequential write conflicts
with the LFS semantics. Especially when f2fs is set up on zoned block
devices, the non-sequential write causes unaligned write command errors.

To avoid the non-sequential writes to swap files, prevent swap file
activation when the filesystem is in LFS mode.

Fixes: 4969c06a0d83 ("f2fs: support swap file w/ DIO")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org # v5.10+
---
 fs/f2fs/data.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 96f1a354f89f..285302d009aa 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4050,6 +4050,12 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
 		return -EROFS;
 
+	if (f2fs_lfs_mode(F2FS_I_SB(inode))) {
+		f2fs_err(F2FS_I_SB(inode),
+			"Swapfile not supported in LFS mode");
+		return -EINVAL;
+	}
+
 	ret = f2fs_convert_inline_inode(inode);
 	if (ret)
 		return ret;
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
