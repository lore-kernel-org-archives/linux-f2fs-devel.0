Return-Path: <SRS0=2O7d=FO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD8DC0018C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 09:21:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0526022BF5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 09:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0526022BF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1knI8P-0002lm-M3; Thu, 10 Dec 2020 09:21:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1knI8O-0002lO-De
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 09:21:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ljOGx+43D4+GhBOESTCLgih0o2QhMYHESC3eyJnO6e8=; b=C07LCRkzqkE9/4HVQ2AHHMYMp/
 LyEoO5h2mw5vJIlJBBqt68Pn3Mzcy5fxHvqNp9lBQTFcJqjK0Aeu3JlsDGH4eaDk8nhUaL0oio3Uu
 KQi59eS3xdUqquNlWB5xRzFpalQnp0cl40ssjuk+HjFd5Bnftdn4TYb2X2edzdfZdH3s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ljOGx+43D4+GhBOESTCLgih0o2QhMYHESC3eyJnO6e8=; b=A
 zmjrQl+kCykQcW4hNBIukybfNEoJwFJ9CuDsdCnsIOsE2+yxDRGAGOqS+yJXX/KalYYahg11qTeS1
 fvMo0Cm8yxy6zB+RLOduN4KcoxjY8Asud8pJJ5qE/ocRZqhdXxfgkhLu2vvc8SqJWRoTjZ3Q6u6Le
 ujsd7IZM7wcuXCgE=;
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1knI8J-008kEi-SA
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 09:21:12 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cs7g9024CzhqBR;
 Thu, 10 Dec 2020 17:20:21 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 17:20:36 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Thu, 10 Dec 2020 17:20:20 +0800
Message-ID: <20201210092020.66245-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1knI8J-008kEi-SA
Subject: [f2fs-dev] [PATCH RFC] f2fs: compress: add compress_flag in struct
 f2fs_comp_option
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

Add a extra field compress_flag to get/set more compress option from/to
compressed inode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---

Daeho, Jaegeuk,

Could you please check whether we could add this new field to struct
f2fs_comp_option? so we can expand to allow user to query/config more
options of compressed inode via new ioctl.

It needs to consider before original patches goes to merge window, let
me know you have other concerns.

 fs/f2fs/file.c            | 1 +
 include/uapi/linux/f2fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 16ea10f2bcf5..fbf06311c88d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3965,6 +3965,7 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
 
 	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
 	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
+	option.compress_flag = F2FS_I(inode)->i_compress_flag;
 
 	inode_unlock_shared(inode);
 
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 352a822d4370..2b9c4c99ceee 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -93,6 +93,7 @@ struct f2fs_sectrim_range {
 struct f2fs_comp_option {
 	__u8 algorithm;
 	__u8 log_cluster_size;
+	__u16 compress_flag;
 };
 
 #endif /* _UAPI_LINUX_F2FS_H */
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
