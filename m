Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C70C04A94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Aug 2023 11:12:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qSy9a-0001sE-Ef;
	Mon, 07 Aug 2023 11:12:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qSy9Y-0001ro-D6
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Aug 2023 11:12:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ubpyp4SIhGXjO6/VTKiZvWjlRzyN8ANvKHVN5xSGnIw=; b=Ykk0BrHAFY0Az7/pEbxIvs4qRS
 GzgAL/MeZfnpm0+6l+GCjKkVFeG/cqTqsuXshMHjz5nNQwZZAFdi+F7BLhgdLyVmkHDQd5Q7X56D9
 UX89qP2phHxrwAK+yUv6c2JQUgtzMjL0nvtH74w0q/tvwLb6nViyFs5RvVaceaRCj+jo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ubpyp4SIhGXjO6/VTKiZvWjlRzyN8ANvKHVN5xSGnIw=; b=jo4JLmn5XuIHD0tbHFkMluz4aJ
 Bil2eFNHydfCe4HZeHmdQfkil6WeRbEkGg+v4tVQl0To9bHDOv9rni3/ZT3r5VHx3dzCNj69Pxrsf
 OJSol30u5mrDqlJRSFPkVWSJmCRK4nnN5w9S98ozEhBaS71JL2eKAKlqcYTAwuZtxfOQ=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qSy9V-00FrYh-Pu for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Aug 2023 11:12:01 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1bb91c20602so9342305ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Aug 2023 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1691406712; x=1692011512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubpyp4SIhGXjO6/VTKiZvWjlRzyN8ANvKHVN5xSGnIw=;
 b=G6tJn+16QVti2qtu2hqYljseIE/XGpe1Yhsul4LFU6R/aCDAM7lceOlES83Z0B/Pue
 2irlih/PCzGRhADqlmxdT4ZmTPg/rDw2XT4QeZKx/Tui9xhVWAtyJogqiocaYi2mPJVJ
 JfsH0RSoKbpVavaYBWWtyo/mJh8W+H0WFTE4SVefHn6UoqHLIS8l90Z//i2iVib88cLh
 SO8x9HJ9eijOF2Obr6A8OaZNG3N0xetNtsejNB5r0CVLeObeV8ZzJa8r4m2G8/H610tO
 JRFiieD8eIQL4G+uzuFBv5AMDY6TbkMqFwB+fegzuV4xQGReerwz1d1NP8JNZHZ17Zsd
 g+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691406712; x=1692011512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubpyp4SIhGXjO6/VTKiZvWjlRzyN8ANvKHVN5xSGnIw=;
 b=RL0oHkb6OOTaX3a7Xx5UtwKXy0TeoWz6gWZ4w5W51+PPdEO0btCIOKWwbL4GGUgQe/
 wAyUpvhb4VFWDTrosjd3kr9GGN/Sghao7X9yoS3VqgaROMtq1o1GSw6g0kjjJh+3s30D
 NUp+rQSOf9j5GK7dGhOU/8ehjKncSznD6kBsMigUVlNZAqYrCPBD6nSUmuir9XN6nI8v
 fSlQISUmOnc24YKdQKfKmVyN3nTW2FSUxSQrsHVkzQPY2ybbTUUyQKsPj3MJSj+vdIxW
 yB8rvt7PL0e9JkK2WSzVNl8xsISsOSfHPcdzed6xgcgRO8Bo9NlhnQ/4jAa/RvDb0qPT
 3z0Q==
X-Gm-Message-State: ABy/qLZ2JtC/L7zo89k5l0sqU95mQ8CTLtYmis8pqMi9ozHa+mB2je/e
 JbBGGy9Qh5WSNi7LH/tB6uUXWQ==
X-Google-Smtp-Source: APBJJlGAdl0ewhYUg6UhJdRJKXIwq0U3XoR/AJshcbF16xE0A4mgQC4Umc8PgwnpC/Hq6tl8ikCZEw==
X-Received: by 2002:a17:902:ea04:b0:1b8:17e8:547e with SMTP id
 s4-20020a170902ea0400b001b817e8547emr32460173plg.1.1691406712196; 
 Mon, 07 Aug 2023 04:11:52 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 04:11:51 -0700 (PDT)
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev,
 simon.horman@corigine.com, dlemoal@kernel.org
Date: Mon,  7 Aug 2023 19:08:57 +0800
Message-Id: <20230807110936.21819-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
X-Headers-End: 1qSy9V-00FrYh-Pu
Subject: [f2fs-dev] [PATCH v4 09/48] erofs: dynamically allocate the
 erofs-shrinker
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

Use new APIs to dynamically allocate the erofs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/erofs/utils.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..6e1a828e6ca3 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -270,19 +270,25 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
-static struct shrinker erofs_shrinker_info = {
-	.scan_objects = erofs_shrink_scan,
-	.count_objects = erofs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *erofs_shrinker_info;
 
 int __init erofs_init_shrinker(void)
 {
-	return register_shrinker(&erofs_shrinker_info, "erofs-shrinker");
+	erofs_shrinker_info = shrinker_alloc(0, "erofs-shrinker");
+	if (!erofs_shrinker_info)
+		return -ENOMEM;
+
+	erofs_shrinker_info->count_objects = erofs_shrink_count;
+	erofs_shrinker_info->scan_objects = erofs_shrink_scan;
+	erofs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(erofs_shrinker_info);
+
+	return 0;
 }
 
 void erofs_exit_shrinker(void)
 {
-	unregister_shrinker(&erofs_shrinker_info);
+	shrinker_free(erofs_shrinker_info);
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
