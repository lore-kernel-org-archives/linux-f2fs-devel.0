Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA92C3DA6F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Aug 2023 03:45:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qZ1HJ-0001iq-Ko;
	Thu, 24 Aug 2023 03:45:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qZ1HH-0001iZ-Tn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Aug 2023 03:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RH+UWxgsfED4SOG31SRsciPnOVwoHjCv5sMnfhtq6Bc=; b=cr8itaBD24wcVktIYba8aXGnsz
 SUOJ2whjoqItdqsjw7wnf7hSV5UMLruhTAdqRiOOE2yviPC5lpH4qHUTbyw5KNh+HRKeRIz5nF9yw
 2MJbt9KRsoBdbih2x2Jh5WUeTyo8EbKCEEX88lYBL5XcROq8gBoNdEF5mnJh7Ufod6kA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RH+UWxgsfED4SOG31SRsciPnOVwoHjCv5sMnfhtq6Bc=; b=M4OC6sbREVzP1Cu1NM0/oyWi1S
 LPXxcCFpFh0U1fcZOUhi+Tq/xd41lpYQZhowKwNDot8q/FSQCRpTQy6/66V4Fv5yGANjZtiPBXuiJ
 RG3eRZhoyugGduV37EctTh3jp+PghbwSDyEJEfTnhagTO4k3qv2bgaw2RcONl5NNkTug=;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qZ1HD-0004xI-TL for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Aug 2023 03:44:58 +0000
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-68824a0e747so1237888b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 23 Aug 2023 20:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1692848690; x=1693453490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RH+UWxgsfED4SOG31SRsciPnOVwoHjCv5sMnfhtq6Bc=;
 b=L5s18IvPmkO1Yi1aX8xoUBVbVs+NYj2wes5Iop5itsw/50mmjZRe3mo5xjdm+YoYr+
 LilfHyHML7A/wtK+y3tmj6oJnO9F477J4r8ASwXsJMy1GqlaxC/IRlgArGQhd91MGOHK
 3A/nIh3uIHjjesEmVDhRjQQGnpOSt+ZUZIXZCdxBGM+Ld1QW0fUX6EUASA/OZvpRDifX
 PZxVf/aQ+feX6zs1fU4hK4chLezuy6pKGNDjYDnCsIRpGw/8fLGUh1PWhw7uWepXLMd7
 7iamIzVc5Mglw5KEkqKNqjKvoDX13NmQ/PUea91yy3q87XQGMlCFJxJ4OLm3P8rzsoMA
 cazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692848690; x=1693453490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RH+UWxgsfED4SOG31SRsciPnOVwoHjCv5sMnfhtq6Bc=;
 b=b/qtusdBgLQ5IH5I5yZBak7nWWZUuUjvKWcmTYowWGrl2xZnqkNUVOlZdyu8Y9jmld
 4hw9FpKA1xbD2hWUcMZyUj8KYOUfaWFF1m9vQFKibS4GaEMsLbxpK7ZwUPO8ma9ZOPTq
 IHf/WUFd/hV781+KWgAeYmmY3eUjOieb3GLdcxiYlwYpGQQyVbgCW0zmgi7Kf6JEbAty
 IpyS2Wpj0MOYcDN/MtrgZTPfcndHqeqltTSEqwYNcGK1qKMELekvxDP0MjslEqXGQlBT
 h3M2n/Qa/sWJir1UcyjxtgqeXsbNNLSo8Um+BKW5AejD87FCN9vHK5TqJs+/MyQkE19v
 KTZQ==
X-Gm-Message-State: AOJu0Ywv19VsfWWTU1beNoBuPPHLVnkILk/BALWKJtYEcgpb0kpfTo3/
 qtPBpT9GrCh3ENb8w6evbHF0DA==
X-Google-Smtp-Source: AGHT+IGADDIb7FS/BEzlD2NDaSR5lL9y4k3FkTUBZvyAz9qvN4bXZycSD4+PZlpH8/QgOFEsYt18oQ==
X-Received: by 2002:a05:6a00:1d85:b0:68a:6cec:e538 with SMTP id
 z5-20020a056a001d8500b0068a6cece538mr7248281pfw.3.1692848690333; 
 Wed, 23 Aug 2023 20:44:50 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 20:44:49 -0700 (PDT)
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev
Date: Thu, 24 Aug 2023 11:42:26 +0800
Message-Id: <20230824034304.37411-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
X-Headers-End: 1qZ1HD-0004xI-TL
Subject: [f2fs-dev] [PATCH v5 07/45] f2fs: dynamically allocate the
 f2fs-shrinker
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
From: Qi Zheng via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 Muchun Song <songmuchun@bytedance.com>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use new APIs to dynamically allocate the f2fs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/super.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 050f4f8ee8f5..86047da85856 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -83,11 +83,27 @@ void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
 #endif
 
 /* f2fs-wide shrinker description */
-static struct shrinker f2fs_shrinker_info = {
-	.scan_objects = f2fs_shrink_scan,
-	.count_objects = f2fs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *f2fs_shrinker_info;
+
+static int __init f2fs_init_shrinker(void)
+{
+	f2fs_shrinker_info = shrinker_alloc(0, "f2fs-shrinker");
+	if (!f2fs_shrinker_info)
+		return -ENOMEM;
+
+	f2fs_shrinker_info->count_objects = f2fs_shrink_count;
+	f2fs_shrinker_info->scan_objects = f2fs_shrink_scan;
+	f2fs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(f2fs_shrinker_info);
+
+	return 0;
+}
+
+static void f2fs_exit_shrinker(void)
+{
+	shrinker_free(f2fs_shrinker_info);
+}
 
 enum {
 	Opt_gc_background,
@@ -4944,7 +4960,7 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_sysfs();
 	if (err)
 		goto free_garbage_collection_cache;
-	err = register_shrinker(&f2fs_shrinker_info, "f2fs-shrinker");
+	err = f2fs_init_shrinker();
 	if (err)
 		goto free_sysfs;
 	err = register_filesystem(&f2fs_fs_type);
@@ -4989,7 +5005,7 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
-	unregister_shrinker(&f2fs_shrinker_info);
+	f2fs_exit_shrinker();
 free_sysfs:
 	f2fs_exit_sysfs();
 free_garbage_collection_cache:
@@ -5021,7 +5037,7 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_post_read_processing();
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
-	unregister_shrinker(&f2fs_shrinker_info);
+	f2fs_exit_shrinker();
 	f2fs_exit_sysfs();
 	f2fs_destroy_garbage_collection_cache();
 	f2fs_destroy_extent_cache();
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
