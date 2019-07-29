Return-Path: <SRS0=MGGM=V2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8323C433FF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:56:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB7C21655
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="IGOeNBNC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="N2fGXaTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB7C21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hs4Go-0007hI-QG; Mon, 29 Jul 2019 11:56:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hs4Gm-0007gg-Mk
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 11:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YAOJh7R/pVjhJyHwRskxPXo7i9wR0Q2DV7wyuGVlcFE=; b=IGOeNBNC03UnyHQoDw5VfMtgRo
 pVei4rQXmg2c8GOAsAfPPV3hZDy1u0JCrqzQc0Ym/l+1B8vGiUSVDCeCYTlyVRRWzxMzWIy8S32hg
 CNOBA6DfrlI4aGg2v2lbZHZyavYVix10OGyEJwax8/fd790Jp7XxLfWuPgG2k31BQnoY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YAOJh7R/pVjhJyHwRskxPXo7i9wR0Q2DV7wyuGVlcFE=; b=N
 2fGXaTT01EHs/ajEu2NVdLDvE0W0/lQUOI0P4y4UjKDAe9220mOHYGGvg+YLWp5oiF1Cw5LhJ4xmk
 0AYYoMWiNFaV7SDzrIcNPmP7XqhvB1IZQh0RHtANcHkBF9v4T51fLrguXKWZl+hkDheaWkr4u5Q/7
 g3YithtebcSlPGa8=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hs4Gk-003Kvw-HE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jul 2019 11:56:48 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5425AAF51E8B2DCB8225;
 Mon, 29 Jul 2019 19:56:36 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 29 Jul 2019 19:56:27 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <guaneryu@gmail.com>
Date: Mon, 29 Jul 2019 19:56:20 +0800
Message-ID: <20190729115620.127160-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1hs4Gk-003Kvw-HE
Subject: [f2fs-dev] [PATCH] common/quota: enable project quota correctly on
 f2fs
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
Cc: jaegeuk@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add a case for f2fs on _scratch_enable_pquota() to enable
dependent features of project quota by mkfs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/quota | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/common/quota b/common/quota
index 659c6219..38aa9470 100644
--- a/common/quota
+++ b/common/quota
@@ -111,12 +111,17 @@ _require_getnextquota()
 # prior to mount.  This is a relatively new feature ...
 _scratch_enable_pquota()
 {
-	[[ "$FSTYP" != ext[234] ]] && return
-
+    case $FSTYP in
+    ext2|ext3|ext4)
 	tune2fs -O quota,project $SCRATCH_DEV >>$seqres.full 2>&1
 	_try_scratch_mount >/dev/null 2>&1 \
 		|| _notrun "kernel doesn't support project feature on $FSTYP"
 	_scratch_unmount
+	;;
+    f2fs)
+	_scratch_mkfs "-O extra_attr -O quota -O project_quota" >> $seqres.full 2>&1
+	;;
+    esac
 }
 
 #
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
