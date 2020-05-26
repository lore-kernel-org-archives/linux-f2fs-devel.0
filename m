Return-Path: <SRS0=7Dm8=7I=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBADC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2020 01:55:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2402068D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2020 01:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ci9TSfrG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BmQqj8bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2402068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jdOoR-0000Qj-1k; Tue, 26 May 2020 01:55:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jdOoP-0000Qb-4q
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 May 2020 01:55:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=frdMz4HNH3VQTov/Z+WbHuWdMXrThJhCaGkBmw8vHJo=; b=ci9TSfrGiNVd96qMLtlBQjFOS5
 U9ju5crtR2b9euIMU18K4DrP6QP6cFZywFOUx9+qKNOSZniUyB+sVLRl4dVNSUYn6X5mD2F9QXdG0
 Rw0Bo7xX+SX11/4w4yVksy9YHsmf2YTSJgRmPKHaXAEPiFbjv1fCsR+5mpmt/aUvuvvY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=frdMz4HNH3VQTov/Z+WbHuWdMXrThJhCaGkBmw8vHJo=; b=B
 mQqj8bX8DvW/rvdFoIiTzGDPIxMWlQBFj0KIhjyzsUxqimNAPANYB+4yYea2RihoA1SKJnsqBi42O
 QTJvqCKHBm1jbyhEks1MDl8ywei/b5/ncN3nAV4H+a3JAapgMn2isEsevMpDlP6s9Po+3MhgsnqTq
 V7RnISsqVz1yEm10=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jdOoN-0071bQ-63
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 May 2020 01:55:25 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2467D6357BB032DF03EB;
 Tue, 26 May 2020 09:55:13 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 26 May 2020 09:55:05 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Tue, 26 May 2020 09:55:02 +0800
Message-ID: <20200526015502.22313-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jdOoN-0071bQ-63
Subject: [f2fs-dev] [PATCH] f2fs: compress: don't compress any datas after
 cp stop
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

While compressed data writeback, we need to drop dirty pages like we did
for non-compressed pages if cp stops, however it's not needed to compress
any data in such case, so let's detect cp stop condition in
cluster_may_compress() to avoid redundant compressing and let following
f2fs_write_raw_pages() drops dirty pages correctly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index bf152c0d79fe..a53578a89211 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -849,6 +849,8 @@ static bool cluster_may_compress(struct compress_ctx *cc)
 		return false;
 	if (!f2fs_cluster_is_full(cc))
 		return false;
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(cc->inode))))
+		return false;
 	return __cluster_may_compress(cc);
 }
 
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
