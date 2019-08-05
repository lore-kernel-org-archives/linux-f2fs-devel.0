Return-Path: <SRS0=Urpw=WB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF80DC0650F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:08:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA8620B1F;
	Mon,  5 Aug 2019 11:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MZ+U61NJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="DLAr1+jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA8620B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1huaqe-0004iw-VX; Mon, 05 Aug 2019 11:08:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <koulihong@huawei.com>) id 1huaqd-0004im-5Z
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Aug 2019 11:08:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mA49eW2uyfPySHf1E3xvLW1Mi5cc3QVWg4aBZjJM3V8=; b=MZ+U61NJMHboIxK+gacNWrAhMM
 eA3xg4OXYbe9Nbf2oJfqIcOZ6qZOv/38EV99Fwgcf9zVOsrPVsmJjHzSA0DfRjUnU0qG3xkc1i3GH
 VFXE2CBwydnJaDtspJmBtVxT3ocEMaWG/nVF1FQonPs820ih4zFm9zLYuqMUrr0WPiKQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mA49eW2uyfPySHf1E3xvLW1Mi5cc3QVWg4aBZjJM3V8=; b=D
 LAr1+jQuEAc79Iu6z0jzZt+dzDUkBngJqcuNuek6edmvEn/hCaUhvmyPsOcIowdhWqoC6sa9pW9Ei
 irzqnDMO0w8WWC2R0Tuvj5fo7FAAOO+pJDY7sfuv5K6O1au8YSRBNMUb3HMWLQKzIZCFyd7RJ6+xS
 cd538Nb/do52Mq7Q=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1huaqa-00B7vJ-U7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Aug 2019 11:08:15 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C7DDA31F5163EDD1028C;
 Mon,  5 Aug 2019 19:08:04 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 19:07:55 +0800
From: Lihong Kou <koulihong@huawei.com>
To: <yuchao0@huawei.com>, <jaegeuk@kernel.org>
Date: Mon, 5 Aug 2019 19:13:52 +0800
Message-ID: <1565003632-124792-1-git-send-email-koulihong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Headers-End: 1huaqa-00B7vJ-U7
Subject: [f2fs-dev] [PATCH] f2fs: cleanup the code in build_sit_entries.
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
Cc: linux-kernel@vger.kernel.org, fangwei1@huawei.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

We do not need to set the SBI_NEED_FSCK flag in the error paths, if we
return error here, we will not update the checkpoint flag, so the code
is useless, just remove it.

Signed-off-by: Lihong Kou <koulihong@huawei.com>
---
 fs/f2fs/segment.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a661ac3..90e2579 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4161,7 +4161,6 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 		if (start >= MAIN_SEGS(sbi)) {
 			f2fs_err(sbi, "Wrong journal entry on segno %u",
 				 start);
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -4201,7 +4200,6 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 	if (!err && total_node_blocks != valid_node_count(sbi)) {
 		f2fs_err(sbi, "SIT is corrupted node# %u vs %u",
 			 total_node_blocks, valid_node_count(sbi));
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		err = -EFSCORRUPTED;
 	}
 
-- 
2.7.4



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
