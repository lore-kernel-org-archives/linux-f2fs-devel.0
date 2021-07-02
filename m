Return-Path: <SRS0=Mutv=L2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27683C11F68
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Jul 2021 14:03:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DF861427;
	Fri,  2 Jul 2021 14:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DF861427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lzJl0-00066l-8a; Fri, 02 Jul 2021 14:03:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <wangshilong1991@gmail.com>) id 1lzJky-00066V-La
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Jul 2021 14:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qpNCCXMrKGyrqYi31MT+GevEnuDdqsiRqNjPGny1C78=; b=O9xuMbvNLQ+M/EWNcKzTPyAnbH
 FKtE6ZoYhgTUN1FSGfAtjnolOhVeg/9ntHv6RBFL9BwM+NzXCy8Ms+xa11DHHw6TBmEpNG2ToJtnr
 oFSSMFuWA7TNnuvtIMfXhoXBJfFfe/3UehNXoM2R/OnpUjvh2gw7lmdUK9ia5ZfyL8qU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qpNCCXMrKGyrqYi31MT+GevEnuDdqsiRqNjPGny1C78=; b=m
 dvStz8MJYHz4GxVm7G/CdxO8h6nnxOvy5hzfmos0vgjEve4s966bJKZCRi5k3AkB6pkGm7k71zfT7
 ZopTqqKN1P6KtFxv8UXKfHUawxzt7H6yP9CcO/VR6m2B1ne+uHoAyLErX+xyxEd5//gt4jXOPawR9
 pj5ViFJO+Bhob4rI=;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lzJku-00034V-7Q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Jul 2021 14:03:00 +0000
Received: by mail-pf1-f171.google.com with SMTP id x16so8981015pfa.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 02 Jul 2021 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qpNCCXMrKGyrqYi31MT+GevEnuDdqsiRqNjPGny1C78=;
 b=pfjQMUJqoWM4kGrC6B/jmlpPPFpiCl59qw3Zdobsq+Ysg8679Tjas1UIR1IxYx6SpO
 hx9HxH3s7Jp/kTqTwTRop5PkWg+ER3+ayMi5uKXHytCNQ8rZfoQVqLY1vTuIyROLQFEl
 NR8pcxuTvBgRbx++JdZx/VB9AjmLgwind36k49RT42bzYAxKJZpYqe29enKRgK4tkyRr
 mnH1XNod4sX6YRCb2n0VSZFVgqHlkl2EHuzLR3uC8wJ4wrbO5KrQGOHYvjaCkYQDdG9x
 ZPQQ2gPo+/SoRKYQ3RNzqqMDej83ajJCr5erpfSHX4dN18k7bupUpWFJAZWiMkhXXAqP
 3dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qpNCCXMrKGyrqYi31MT+GevEnuDdqsiRqNjPGny1C78=;
 b=iJyz5y4RI/oYDrJh/0B3iNF9mnJeqL2hflqA0mOq1O/3nb7mi9wrtOMv3U7SfqD+kP
 dhb/4CgHyJHT/bHbRjQkItPsyCQAMcIqDTH+dpqqekNiDDMGNuNEGi8z8DrvpXQG55/r
 kGiQgILHUR7TfM0aje/wZQ4RKY9peYHJQZtOGknrkT0+2C/JfxPPy1tIrYGrr2G7SYx/
 OI/m0t+hEyWn9s6dx50INZ5JyyaethgovnOpW5EWaCQmJlw6RXnuFax85mDYyESoCABq
 cMpHnGwPGQMtfk4MJm9533Rjh7Z65q+7K01ivgoHRBq5JLBGA9NNtKWGrHL/1xlN+Rp8
 aq+A==
X-Gm-Message-State: AOAM530sMg8/7Q10eoLnZ7q2OiuxFIzvTlEmbpKVSRqfB0QryFUk3yif
 x4hfDSwyL3kJT5IsAVHaVwI=
X-Google-Smtp-Source: ABdhPJyKUCADoXCbqFx3cl7qRl/BxbhntTWF1mY+I9dkZf8hzu6/r8r54P+dFV/roUXYEviVXlW/SQ==
X-Received: by 2002:a63:4e4c:: with SMTP id o12mr174831pgl.95.1625234569568;
 Fri, 02 Jul 2021 07:02:49 -0700 (PDT)
Received: from localhost.localdomain ([183.165.208.218])
 by smtp.gmail.com with ESMTPSA id u21sm3563898pfh.163.2021.07.02.07.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jul 2021 07:02:49 -0700 (PDT)
From: Wang Shilong <wangshilong1991@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Fri,  2 Jul 2021 10:02:43 -0400
Message-Id: <20210702140243.3615-1-wangshilong1991@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Headers-End: 1lzJku-00034V-7Q
Subject: [f2fs-dev] [PATCH v3] fs: forbid invalid project ID
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

fileattr_set_prepare() should check if project ID
is valid, otherwise dqget() will return NULL for
such project ID quota.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
v2->v3: move check before @fsx_projid is accessed
and use make_kprojid() helper.

v1->v2: try to fix in the VFS
---
 fs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1e2204fa9963..d7edc92df473 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -806,6 +806,8 @@ static int fileattr_set_prepare(struct inode *inode,
 	if (err)
 		return err;
 
+	if (!projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
+		return -EINVAL;
 	/*
 	 * Project Quota ID state is only allowed to change from within the init
 	 * namespace. Enforce that restriction only if we are trying to change
-- 
2.27.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
