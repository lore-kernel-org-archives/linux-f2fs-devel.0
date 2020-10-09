Return-Path: <SRS0=0BeM=DQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799F3C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:41:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CCD206F7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="YSfGhvyZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mN73ztY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CCD206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kQiLV-0002V8-PN; Fri, 09 Oct 2020 02:41:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kQiLU-0002Ux-SN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Oct 2020 02:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98+EjAj+wXLEg6N5MEb+rOg7/7RA3218XEL5GRQNkfg=; b=YSfGhvyZZpQRd7tIdkAFN7tOO/
 fKG+95Twpwinlyd24rmmYZaVlBGXFVYW84P6eZpKEQF2TxPK9HFxqIb1FOGNB5zTsG2nTKKxFVcoX
 u88tQTrISY8g9eOC2XidIrAYnX0FEoS5bRpUlaE6NVzgHvbsHQ/b/MWpHgoVkaRlZET4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=98+EjAj+wXLEg6N5MEb+rOg7/7RA3218XEL5GRQNkfg=; b=m
 N73ztY6AHYZTf8Uxz6OeNoohrJWeefyKOqT8bsq1wWPdObdbPs1bFRMVnISDstm0tpTfAfgaBQN5e
 KPCfaSyfDgrSAAUegMtQ+r1qDdH33FAr7x39V63wcVofrobsNghEGuNFkJ0SZdg8ROgFuptMpHsO8
 yCBxl4tO2FC83THU=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kQiLR-007rzP-JV
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Oct 2020 02:41:24 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D15DD647429D0F77E087;
 Fri,  9 Oct 2020 10:41:14 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 9 Oct 2020 10:41:09 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Fri, 9 Oct 2020 10:40:48 +0800
Message-ID: <20201009024048.50089-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1kQiLR-007rzP-JV
Subject: [f2fs-dev] [PATCH] f2fs: fix to set SBI_NEED_FSCK flag for
 inconsistent inode
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

If compressed inode has inconsistent fields on i_compress_algorithm,
i_compr_blocks and i_log_cluster_size, we missed to set SBI_NEED_FSCK
to notice fsck to repair the inode, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d5664bc7d6c6..657db2fb6739 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -299,6 +299,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
 						i_log_cluster_size)) {
 		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
 				"compress algorithm: %u, run fsck to fix",
 				  __func__, inode->i_ino,
@@ -307,6 +308,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 		if (le64_to_cpu(ri->i_compr_blocks) >
 				SECTOR_TO_BLOCK(inode->i_blocks)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) has inconsistent "
 				"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
 				  __func__, inode->i_ino,
@@ -316,6 +318,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 		if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
 			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
 				"log cluster size: %u, run fsck to fix",
 				  __func__, inode->i_ino,
-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
