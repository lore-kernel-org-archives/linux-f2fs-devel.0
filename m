Return-Path: <SRS0=YOv7=3E=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB0BC33C9E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:55:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E35214AF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Z6NEtVn/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="S9niiuAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E35214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1irXuB-0004kx-BN; Wed, 15 Jan 2020 01:55:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhangxiaoxu5@huawei.com>) id 1irXu9-0004kZ-M8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jan 2020 01:55:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pINNsJLgeANaTDYfI9ocWwH/UPhecvpG3ynSd4b74ug=; b=Z6NEtVn/VAo6mHVK9k21tGnx/w
 l1Gx8Z27M8iZwh9wKZMj6xycsTSGgwuDziZFWuxQnXU6z+Z2dNzT3rHwqVfSg9vkRX0TqRpqTmgCe
 Yo0ADfk6OZZr0pXUp7e70VgJ6ek8u1EI/MfGqNytqRBMxauAG7E7W+4bQcFnkVsbRQb4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pINNsJLgeANaTDYfI9ocWwH/UPhecvpG3ynSd4b74ug=; b=S
 9niiuAnBqxIGhYasjr60grMaClYRx3UZFkjdRq4SQHVm5j+qVQ6E0yuPFksTxya9kspnB6OcjPLgi
 54j1dhyQs4usEHlPPl5WaRCGgDUYCrA2MpysWEP+SzVwB34YlTwEVo5bqSZwDJNqzA+u1kn4UzWi0
 JfOV7f1XcE3Vyh18=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1irXu7-003mtc-MW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jan 2020 01:55:33 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B17A099DC1C796F2F1AC;
 Wed, 15 Jan 2020 09:55:22 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 09:55:13 +0800
From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <zhangxiaoxu5@huawei.com>
Date: Wed, 15 Jan 2020 09:54:24 +0800
Message-ID: <20200115015424.41496-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Headers-End: 1irXu7-003mtc-MW
Subject: [f2fs-dev] [PATCH] f2fs: Make f2fs_verify_pages static
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Fix sparse warning:

fs/f2fs/data.c:187:6: warning:
  symbol 'f2fs_verify_pages' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2576d7dd047d..b27b72107911 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -184,7 +184,7 @@ static void f2fs_decompress_work(struct bio_post_read_ctx *ctx)
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
+static void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
 {
 	f2fs_decompress_end_io(rpages, cluster_size, false, true);
 }
-- 
2.17.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
