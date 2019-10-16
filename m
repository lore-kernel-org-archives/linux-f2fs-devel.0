Return-Path: <SRS0=Bnpk=YJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A048FA372C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Oct 2019 10:04:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3003420650;
	Wed, 16 Oct 2019 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="OnJozTRQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fKfZRSaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3003420650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iKgAZ-0002fl-I5; Wed, 16 Oct 2019 10:04:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <koulihong@huawei.com>) id 1iKgAW-0002fS-VS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Oct 2019 10:04:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xXvI3oVy5/2t93ENMp2oZ8uyxXEzeRqOYki4vySd2I8=; b=OnJozTRQhNFZJ/M64dp3WDa/0a
 8bxku0PE55Bse3d7SMQuYGlEjpd4r9K6/D4AMTYu48ovm0bkJxkekwg7uYI3WEi5PcOyQXvwcFw4B
 d1F9+OnwbLpaKqa3QWFZpkSfUHc0KtNl7Yg0zI2lxXIbTx4rfDeqEzN9MqVbOaOcHgL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xXvI3oVy5/2t93ENMp2oZ8uyxXEzeRqOYki4vySd2I8=; b=f
 KfZRSawNGMO9Hw36Z5wa8IqX53bWBi1VS0VwYNPI0BfiTBbZMF+cVC0eiSnHWWAl4oJC8dDPZtQ8U
 zBnuNAygOUphoHuigIYflIqLjeNUWGLdYn62qdYj7ibxoyBC7myDykpNvaps8wmtYA4WFVd0Hv3w8
 cJWmWkQV5AgIkL/E=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iKgAU-00BGVE-Tn
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Oct 2019 10:04:36 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 281FDBC2D665011A076B;
 Wed, 16 Oct 2019 18:04:28 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 18:04:18 +0800
From: Lihong Kou <koulihong@huawei.com>
To: <yuchao0@huawei.com>, <jaegeuk@kernel.org>
Date: Wed, 16 Oct 2019 18:11:27 +0800
Message-ID: <1571220689-95274-1-git-send-email-koulihong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Headers-End: 1iKgAU-00BGVE-Tn
Subject: [f2fs-dev] [PATCH v2 0/2] add a new fio cache for IPU.
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
Cc: zengguangyue@hisilicon.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Introdce a new fio cache for IPU.
After commit 8648de2c581(f2fs: add bio cache for IPU)
in the mainline, we still have the problem in SQLite. So I
reuse the fio data structs to cache the mergeale write IO in
wirtepages().

Lihong Kou (1):
  Revert "f2fs: add bio cache for IPU"

Lihong Kou (1):
  f2fs: introduce a new fio cache for IPU.

 fs/f2fs/checkpoint.c |  1 +
 fs/f2fs/data.c       | 93 ++++++++--------------------------------------------
 fs/f2fs/f2fs.h       |  4 +--
 fs/f2fs/segment.c    | 22 ++++++-------
 fs/f2fs/super.c      |  2 ++
 5 files changed, 29 insertions(+), 93 deletions(-)

-- 
2.7.4



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
