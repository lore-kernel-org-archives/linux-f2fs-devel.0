Return-Path: <SRS0=lp92=77=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE14C433E3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:18:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFAD21D90;
	Thu, 18 Jun 2020 01:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="TJbtgsHs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="E3KQGnRr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhcikRJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFAD21D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jljCE-0004uo-GC; Thu, 18 Jun 2020 01:18:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1jljCD-0004uY-8O
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 01:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gcYDArAl02t7K7NGt1bs4qeERFyVWb0MQRhXz/ZDzdM=; b=TJbtgsHsVskClv+CGNeRlyaI/c
 xHZjXc/eaxT5UChgRd2gj7DhbQar+vJaGQ8YP836INn5aMtH47JSst1cXZGSc5ApEhDnx22WMzcRk
 cPL+afpVN/w+/J5RiQhMC55ne1gW+SJFfvjxQ25ozobv4h+KNrQfzUBuh8JCM471q8hg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gcYDArAl02t7K7NGt1bs4qeERFyVWb0MQRhXz/ZDzdM=; b=E3KQGnRrbGHYNglVxtli2aom2Z
 fg8Vo+eutF6a2cpy2xW7tj4OGslLsamfq+OVO9KNdGf1tLFY7CAE0IeFUimfEuFLdEjFoDkUX+4Ab
 RNUeJxUZNq1jjUzNN1Zpv+oXYSc4I9SyBcEB05cx2ck/XLYw2esEfzxNeWO2/GhXhOLw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jljCC-007ei7-6T
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 01:18:25 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2384B206F1;
 Thu, 18 Jun 2020 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592443098;
 bh=GjNpput/gcM8jX7KUPi8n1vW83BRAOzjo5dxH0l7Gb0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hhcikRJ2+6C9hEM4B+3IuLVa85jcyZKnZSvwN98Nj7JDQ5tsHC2Layzo4n/WcF3ce
 cOIaokg/NTEChvf45T3JUgTYDymGdG6Tku9YdsDkOghJ+d3jd/kLBIchFX2jhDR3rX
 W08KgGKUFNXAINDdrg1b2lMaomNhJt66MiW+6frs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed, 17 Jun 2020 21:13:23 -0400
Message-Id: <20200618011631.604574-78-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1jljCC-007ei7-6T
Subject: [f2fs-dev] [PATCH AUTOSEL 5.4 078/266] f2fs: handle readonly
 filesystem in f2fs_ioc_shutdown()
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 8626441f05dc45a2f4693ee6863d02456ce39e60 ]

If mountpoint is readonly, we should allow shutdowning filesystem
successfully, this fixes issue found by generic/599 testcase of
xfstest.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c3a9da79ac99..5d94abe467a4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2056,8 +2056,15 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	if (in != F2FS_GOING_DOWN_FULLSYNC) {
 		ret = mnt_want_write_file(filp);
-		if (ret)
+		if (ret) {
+			if (ret == -EROFS) {
+				ret = 0;
+				f2fs_stop_checkpoint(sbi, false);
+				set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
+				trace_f2fs_shutdown(sbi, in, ret);
+			}
 			return ret;
+		}
 	}
 
 	switch (in) {
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
