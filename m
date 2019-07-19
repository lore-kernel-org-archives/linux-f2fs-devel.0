Return-Path: <SRS0=QVvM=VQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B02C76188
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jul 2019 04:01:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F4221852;
	Fri, 19 Jul 2019 04:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="buxoEGe9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ckCKXbLF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5TWs8TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F4221852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hoK5Y-000820-2Q; Fri, 19 Jul 2019 04:01:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1hoK5X-00081u-Ps
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jul 2019 04:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SP42iElbEo3iuGUkYcHUIw3X2zewvUNq3Mvsp5KMx5A=; b=buxoEGe9Cj8CBOAa3HbvmO16Ta
 z1eiEYhxIteg5brD1C9h9tJGEdOyux2p8UVEZQ0hgTWzLVbFfYIpnbL8+QS+T8zuC43/dZj8VUA7h
 EeVGzmO6WvwD11YOYV7JljO9u1c4CD8rPmUWfJEioU2Wg333FM/z+KouvaV3Ny1/YWPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SP42iElbEo3iuGUkYcHUIw3X2zewvUNq3Mvsp5KMx5A=; b=ckCKXbLFFtOZH0Ss8AzHbMC/Ia
 m/pmTvEpqklwFvpAymYnsstaxegZ2wO/BFP2G415vmsC2sH2T67Fv7DwwU4vJLWcpxqzdWR7NFpWF
 HiMw09f8Rb0HWpFqSrdr9Wf9HrUqOSBVULsGumUBlbKSP9L9bs8NKdFqZKPPEQIVjAzw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hoK5V-007kL6-TZ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jul 2019 04:01:43 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 93AE521897;
 Fri, 19 Jul 2019 04:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563508896;
 bh=YPHQWDnAjj6f0it24YzhQzQrShEq69mzDHoUQixDxp4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q5TWs8TEwQZ/mx7I1XRVurRH8pfS5GEG78r18znce9w5oWjT2HNj8GS5mr+TAEbZZ
 OqEZ8bIdN2uXJt+5Rnh08fKCqSMQNfjI7hjTdccR+I3rNnhNLGTIunVT+uvS4WlvQN
 vYeEyplUD/ej0aqV1qt4NV/g69ngtZaFtRP9Tguo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu, 18 Jul 2019 23:56:15 -0400
Message-Id: <20190719035643.14300-144-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1hoK5V-007kL6-TZ
Subject: [f2fs-dev] [PATCH AUTOSEL 5.2 144/171] f2fs: fix to avoid long
 latency during umount
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
 linux-f2fs-devel@lists.sourceforge.net, Heng Xiao <heng.xiao@unisoc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Heng Xiao <heng.xiao@unisoc.com>

[ Upstream commit 6e0cd4a9dd4df1a0afcb454f1e654b5c80685913 ]

In umount, we give an constand time to handle pending discard, previously,
in __issue_discard_cmd() we missed to check timeout condition in loop,
result in delaying long time, fix it.

Signed-off-by: Heng Xiao <heng.xiao@unisoc.com>
[Chao Yu: add commit message]
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8903b61457e7..291f7106537c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1486,6 +1486,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
+			if (dpolicy->timeout != 0 &&
+				f2fs_time_over(sbi, dpolicy->timeout))
+				break;
+
 			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
 						!is_idle(sbi, DISCARD_TIME)) {
 				io_interrupted = true;
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
