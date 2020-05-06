Return-Path: <SRS0=zUg3=6U=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E9AC28CBC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 May 2020 10:46:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751FF206B8
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 May 2020 10:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="iFRFqLFk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WxDaTHJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751FF206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jWHZI-0002nl-1x; Wed, 06 May 2020 10:46:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jWHZG-0002nZ-8V
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 May 2020 10:46:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0FFDsM5W9DnQM0SQZ7/kIO10fvdu/gXICi6d2RcOrm8=; b=iFRFqLFko8yssTPHhKRWjJwYpn
 WAXTpBvsPdw8skRyef8tUHbv3U0btjJ7Em1h8rPihkJO4QKxwv3ArnulykkftS1pLswipcLt7mv78
 ok98xb+fRKNArWeAVqIw80mchj++Wk7Yuc19ToFM3pQ5ataZw0QgHji9ekLpc0hiL3h8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0FFDsM5W9DnQM0SQZ7/kIO10fvdu/gXICi6d2RcOrm8=; b=W
 xDaTHJaCWxPbbX+l7G55CN0Cn4uo0CdPBTiYQIjb6Lw6b4hg/ncLirsNW5b+FWyEmEgWCrP8PTnUG
 OP/nOZ1MpBMft/SZDbVjht7j9ZWWgWUO7cam//nsVerZddPpBSQm9LLje7+GhTDLpHPab1XAnojfu
 QHSxr9bxiDLY5ank=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jWHZE-00Fxhi-Jn
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 May 2020 10:46:22 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BC9F388DE92295BC2E09;
 Wed,  6 May 2020 18:46:08 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 18:45:58 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Wed, 6 May 2020 18:45:42 +0800
Message-ID: <20200506104542.123575-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jWHZE-00Fxhi-Jn
Subject: [f2fs-dev] [PATCH v2] f2fs: shrink spinlock coverage
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

In f2fs_try_to_free_nids(), .nid_list_lock spinlock critical region will
increase as expected shrink number increase, to avoid spining other CPUs
for long time, it's better to implement like extent cache and nats
shrinker.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix unlock wrong spinlock.
 fs/f2fs/node.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4da0d8713df5..ad0b14f4dab8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2488,7 +2488,6 @@ void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i, *next;
 	int nr = nr_shrink;
 
 	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
@@ -2498,14 +2497,22 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 		return 0;
 
 	spin_lock(&nm_i->nid_list_lock);
-	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
-		if (nr_shrink <= 0 ||
-				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
+	while (nr_shrink) {
+		struct free_nid *i;
+
+		if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
 			break;
 
+		i = list_first_entry(&nm_i->free_nid_list,
+					struct free_nid, list);
+		list_del(&i->list);
+		spin_unlock(&nm_i->nid_list_lock);
+
 		__remove_free_nid(sbi, i, FREE_NID);
 		kmem_cache_free(free_nid_slab, i);
 		nr_shrink--;
+
+		spin_lock(&nm_i->nid_list_lock);
 	}
 	spin_unlock(&nm_i->nid_list_lock);
 	mutex_unlock(&nm_i->build_lock);
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
