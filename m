Return-Path: <SRS0=0FbH=IY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA504C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Mar 2021 14:42:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14DA61A10;
	Fri, 26 Mar 2021 14:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14DA61A10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lPnf3-0007M8-Rs; Fri, 26 Mar 2021 14:42:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1lPnf3-0007M2-Cp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Mar 2021 14:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8ot4W41OjRbU65V7ro1fL0pzChFuex0Fk/hk/7x6Hzo=; b=ifHTKWICgtMl8PQyiEqTS7g4iW
 h+BO56Uu6K3LFta2a7sjoSNarMsjZ0rFLrmx7Osl7qlsxbS5t7M3NyUUfWZkNdn/lSn8hhuW1aplF
 eb3OiUfpL6YRKvsgE3TGPTZCznkVZVwdtQN1TEfC+JdiiTJmoDazNMnX9wf2SdNwIJyE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8ot4W41OjRbU65V7ro1fL0pzChFuex0Fk/hk/7x6Hzo=; b=l
 whmr/gz4Oa/fJo6zf7c1b0mTXuqu03oMc1BaHU0/58ENQmgvSLBm/kbdkNMxkSjqpVLHD/uAnmKfY
 L67kLu9yFm0g3c8ONyNwTejjn2qf+VAh3mobYWqMMqdGK1ap/H8HQLWT5Npo+2zvq44HUAIa4/c8+
 BOoaxkp2wvGkXimc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lPnez-00EEac-12
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Mar 2021 14:42:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63B3861A05;
 Fri, 26 Mar 2021 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616769715;
 bh=Ub6j1ADUPloP6U9Fcg9w8Y53uDIZ1oVcMBI4XxirdVg=;
 h=From:To:Cc:Subject:Date:From;
 b=bWtJboigcqM+Lq+lBvRhBiIJ61S9hI5EHboXwrW5tQTiIUBzuYH299yz/i3tn0VhQ
 H8D5TceAmlJz159qz+f6YnDq9JZUQ7pQSMLIsZUY2e1Hr0W9Q+wPF6hxYzo/Imm3yT
 wdWHlOB+k/ZXOuvQJ4fAlO0CBCzBkQ/XwtCkwDUMN2GjQ7+pTlrsTvQQmhoeOxTQGd
 MzMbhcT5Mt6yBblE4/qfpL+FLlp5pohwQLgJA7dmJjUCAXp4C93PGrw704nBCubtSf
 fBc5aGwY6PmFaGF8pSG/MHLVX0gAZJi9eerkIRGxi7BR774xnxq1sfhADbPHF4/TGe
 H7sqvWDaKAQTw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 26 Mar 2021 22:41:43 +0800
Message-Id: <20210326144143.2313-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-Headers-End: 1lPnez-00EEac-12
Subject: [f2fs-dev] [PATCH] f2fs: delete empty compress.h
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

From: Chao Yu <yuchao0@huawei.com>

Commit 75e91c888989 ("f2fs: compress: fix compression chksum")
wrongly introduced empty compress.h, delete it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 fs/f2fs/compress.h

diff --git a/fs/f2fs/compress.h b/fs/f2fs/compress.h
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.22.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
