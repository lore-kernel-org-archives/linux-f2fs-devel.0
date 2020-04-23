Return-Path: <SRS0=NCuU=6H=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0835BC2BA19
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:58:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B389220776
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="N+W27Qal";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dTFNRJ1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B389220776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jRYcJ-0001tx-J1; Thu, 23 Apr 2020 09:57:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jRYcF-0001t5-CY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 09:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rBawrbrQfoxIfyi0uKQJcgcEWHJ6bqFm+RmnZmxVuXk=; b=N+W27QalwisFLStsqZI1rktglh
 kY3O9e++nSnuXeSwmSH7Yrl9yMhPhuJrl0X9OQ4RK5rRmA7cOs6CeYFhabiMC6RsG20lc+ITSjUO4
 ewEscazAZ8gAWmiAMf/m9WtW+8nXl+Qe46pXgd9jlHQPvqddCXIfYzM06e6mqKpCVLsM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rBawrbrQfoxIfyi0uKQJcgcEWHJ6bqFm+RmnZmxVuXk=; b=d
 TFNRJ1SlIfjNQw0FPhO7rWlq5D9pPIpjIb/9kYz/jxc9btA5mVuwTQBq8FtB7HoQCrtVtZGEzcMy/
 fPaQKhVK8GPOVzebSunKj/g4aOM7MdX2FaWKPqOEdfRj5WlfUpJJKEVevXYa0AArG/ABig4QWSwMW
 kOcVkjT9jd3dWUVM=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jRYc9-00B4AW-DY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 09:57:55 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EFD916E0DFCF0956272C;
 Thu, 23 Apr 2020 17:57:41 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 17:57:34 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Thu, 23 Apr 2020 17:57:33 +0800
Message-ID: <20200423095733.7733-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jRYc9-00B4AW-DY
Subject: [f2fs-dev] [PATCH] f2fs: fix potential use-after-free issue
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

In error path of f2fs_read_multi_pages(), it should let last referrer
release decompress io context memory, otherwise, other referrer will
cause use-after-free issue.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4adf28bdd022..48a622b95b76 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2208,16 +2208,16 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 					page->index, for_write);
 			if (IS_ERR(bio)) {
 				ret = PTR_ERR(bio);
-				bio = NULL;
 				dic->failed = true;
 				if (refcount_sub_and_test(dic->nr_cpages - i,
-							&dic->ref))
+							&dic->ref)) {
 					f2fs_decompress_end_io(dic->rpages,
 							cc->cluster_size, true,
 							false);
-				f2fs_free_dic(dic);
+					f2fs_free_dic(dic);
+				}
 				f2fs_put_dnode(&dn);
-				*bio_ret = bio;
+				*bio_ret = NULL;
 				return ret;
 			}
 		}
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
