Return-Path: <SRS0=U1Xf=ZA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09C8C5DF60
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:46:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F56218AE;
	Fri,  8 Nov 2019 11:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PP6iEb02";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="myWaNBny";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3HO6ieG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F56218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iT2j3-0001ed-5J; Fri, 08 Nov 2019 11:46:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1iT2j1-0001eI-QJ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Nov 2019 11:46:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GphBjcUZJIuh3lYEUJHymE3auyuPbQblSOfahZRIbBE=; b=PP6iEb02UzvLg19UfomQiWL6XT
 Zi+8HHOWkVEHc2VBn4B0zU+8BpX0r8h99M6VbAvHWOQVEwnd+54G/Shslwupis2xCNv7aQ0mrVYhR
 z1VAx72xRXCQFA6OyJooUJHmMKTVF50T9E5LJgew60/iUWbu4+60xEufFH7xlARxYk6Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GphBjcUZJIuh3lYEUJHymE3auyuPbQblSOfahZRIbBE=; b=myWaNBnyXi/M4EwtbNsPy7wSnn
 XrS9Z1Yrt03YhLcm+6WMvOBCrNTnXU+75rvjL8OlGASCOzswOb1jAsUFqSAqJwPr19cAVaxQoSGxx
 VA8W4f7+xRhPmCTQk7FpPN1HIY1fudrejThXaeJ7OtU+q8y67wg063iJS5vwhKXbaHw4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iT2j0-004z5N-MI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Nov 2019 11:46:47 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6685F22466;
 Fri,  8 Nov 2019 11:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573213601;
 bh=sFmxPLvoOWEfl00tsENoIxTweNEQt91iXnciTX2cmDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k3HO6ieG/lQrpYLerhR7hr/CmzolNNz+Bn+stt7Jh4hCARSEIJQckzNYRs1knowQb
 Ig5zEiXQkZe3+v7R2p0dnUBDQ6BqNLsr2SrkANOHDE42vE1YeT6kI0Rvsk8B+qyk0i
 T25KXXaiYYYjSoNL2VXFEbUtHh0JC8L8uUXcpVCY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri,  8 Nov 2019 06:45:21 -0500
Message-Id: <20191108114545.15351-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1iT2j0-004z5N-MI
Subject: [f2fs-dev] [PATCH AUTOSEL 4.9 40/64] f2fs: fix memory leak of
 percpu counter in fill_super()
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

[ Upstream commit 4a70e255449c9a13eed7a6eeecc85a1ea63cef76 ]

In fill_super -> init_percpu_info, we should destroy percpu counter
in error path, otherwise memory allcoated for percpu counter will
leak.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9eff18c1f3e46..e0ac676e0a35c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1650,8 +1650,12 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 	if (err)
 		return err;
 
-	return percpu_counter_init(&sbi->total_valid_inode_count, 0,
+	err = percpu_counter_init(&sbi->total_valid_inode_count, 0,
 								GFP_KERNEL);
+	if (err)
+		percpu_counter_destroy(&sbi->alloc_valid_block_count);
+
+	return err;
 }
 
 /*
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
