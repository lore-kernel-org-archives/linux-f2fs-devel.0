Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEA5C41513
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jul 2023 08:09:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qOw3Q-0007h6-52;
	Thu, 27 Jul 2023 08:09:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qOw3O-0007gy-Od
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 08:08:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9TzzNXWnGUC4v0Im6lZC1fetjV0NX81rj7dQA53Eb1w=; b=RitnvXFstqhnJl3LEIre4baxbF
 1EFFo7OtYacFDH0AtYgFmdUs6RvSS4oVAnMcBRM5o1mK5PdPsx1fbYmB+Dki2/M96rgMPMzKYBrJm
 efDgiH8gKC1OupRKgf7G4VurNLnewDXtWNhMnYdvNO8z9XnnJFWh1vxYnPdEMUB1WkAI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9TzzNXWnGUC4v0Im6lZC1fetjV0NX81rj7dQA53Eb1w=; b=gbVrALFoV/UJ2TyTGaOx+X2FV3
 l3Xac0+aLCqd1MvnfykIlHOCMtG+7JTXFxlUFJ2ooR2J+LVYYd0ZgStHr3cc9CP4VQ1XW2XMkjGtA
 QhBjAi+w9eazYMAiBfNkXP1IetT61POotYXrKndrhhE82YbHowJTp3qqTvzcEIidQhRo=;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qOw3O-0004ZU-84 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 08:08:58 +0000
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-66d6a9851f3so167833b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Jul 2023 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690445332; x=1691050132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TzzNXWnGUC4v0Im6lZC1fetjV0NX81rj7dQA53Eb1w=;
 b=fVbo4B1Sn0AGX1nNJK0Eo1gukSsful8PC6Tpi9R2ay4P+tk9frdioPsIm2s6rPxi46
 ++BpYvSQrpfhaqWc0rmuBFjQPz0zzH5N+AGXb67rsChsvEkjfu687Mjmoln0lCJnbS1t
 S6gxfZ/pYInNuKorknrCkgDtrsNJQ+5b+KQpVkQdCPQpNRB6D3agySMM3uM99/xhPotu
 rAoYyPnK20sDnc7vY5XomSSW5p6ngHpl0qbTjtgeFdhf5V6H8EL0+GE/5QBEhSY2aRe8
 CqIfoMbQ3ZACqieIYGVBf+Lq9zLueZGm5ISvf4EF/2FFF37Zi67sB1q+1Y4ZesHEzWZS
 zb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690445332; x=1691050132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TzzNXWnGUC4v0Im6lZC1fetjV0NX81rj7dQA53Eb1w=;
 b=Fh8F5/NMsoA8krz4c/dzyLAKd/h0tIkp2FRctG6cl3RNGNFXwD5U4huaPv5z/wOoNh
 egJF3pCH6Jz9lrDFHgoKfTZXOY5xITdeFzw5b9K0bWe5+wrqufQAjkaJO3nxzkDpUmrb
 zU8B3uTzAsZRiVdix+eZhe0dABA6fUkYqHisPT/MmxJDLW9HFsGzrHLWI5mhJo/lTCjN
 kR3n3rfxxWhdrReaqDIhELMs7BWYzO7GHPhrG1QL5oDzPuNsU24BU2fx9wvZkGvsgbT/
 pK6Q5hQ4Zcy7TDfxUgkKgnpI4lTurBFdxcgCrsfQD1tY3JHqlSP2LC+S4PlzN4eLFo53
 Qedg==
X-Gm-Message-State: ABy/qLYPeEjmxZwJHv3q1ZSx8naexgZYz7ErUErpfgOI6kqDbKGXJtvN
 n/FNOVUyC7liMJSPxMhUVXRMbA==
X-Google-Smtp-Source: APBJJlFfoYzSpk6JWYRi+8IvWqqU5f15Mb/GG4zvV09auI3h1+KA8DLVYcizqJGa8aoS7uGFfDYCtA==
X-Received: by 2002:a05:6a00:488e:b0:677:bb4c:c321 with SMTP id
 dk14-20020a056a00488e00b00677bb4cc321mr4639246pfb.0.1690445332713; 
 Thu, 27 Jul 2023 01:08:52 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 01:08:52 -0700 (PDT)
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev
Date: Thu, 27 Jul 2023 16:04:28 +0800
Message-Id: <20230727080502.77895-16-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
X-Headers-End: 1qOw3O-0004ZU-84
Subject: [f2fs-dev] [PATCH v3 15/49] nfs: dynamically allocate the nfs-acl
 shrinker
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
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org,
 cluster-devel@redhat.com, xen-devel@lists.xenproject.org,
 linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org,
 linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use new APIs to dynamically allocate the nfs-acl shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/nfs/super.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 2284f749d892..072d82e1be06 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -129,11 +129,7 @@ static void nfs_ssc_unregister_ops(void)
 }
 #endif /* CONFIG_NFS_V4_2 */
 
-static struct shrinker acl_shrinker = {
-	.count_objects	= nfs_access_cache_count,
-	.scan_objects	= nfs_access_cache_scan,
-	.seeks		= DEFAULT_SEEKS,
-};
+static struct shrinker *acl_shrinker;
 
 /*
  * Register the NFS filesystems
@@ -153,9 +149,17 @@ int __init register_nfs_fs(void)
 	ret = nfs_register_sysctl();
 	if (ret < 0)
 		goto error_2;
-	ret = register_shrinker(&acl_shrinker, "nfs-acl");
-	if (ret < 0)
+
+	acl_shrinker = shrinker_alloc(0, "nfs-acl");
+	if (!acl_shrinker)
 		goto error_3;
+
+	acl_shrinker->count_objects = nfs_access_cache_count;
+	acl_shrinker->scan_objects = nfs_access_cache_scan;
+	acl_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(acl_shrinker);
+
 #ifdef CONFIG_NFS_V4_2
 	nfs_ssc_register_ops();
 #endif
@@ -175,7 +179,7 @@ int __init register_nfs_fs(void)
  */
 void __exit unregister_nfs_fs(void)
 {
-	unregister_shrinker(&acl_shrinker);
+	shrinker_free(acl_shrinker);
 	nfs_unregister_sysctl();
 	unregister_nfs4_fs();
 #ifdef CONFIG_NFS_V4_2
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
