Return-Path: <SRS0=enZK=K4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C163C47083
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Jun 2021 04:47:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9739661159
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Jun 2021 04:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9739661159
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ajR0wogTv0bBNmxcaGvJoo7rvuIk71/YcXbkbSYBxzs=; b=JdGHtov/7nHV8PmvtCwIYVFFJ
	utZONifLuupOfxumVFo3+lUmeOE4QSeDjMXhPIMkUX2wlJOWr8wZ7L/kp8BNCrNnorSe1Xrth76Kp
	mWR2gVPSZJFuIBED1TDlRqsQKGK7TosLARLZZCMtl/uyonNn5nIljK5vRs4uxAgOwKIOs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1loInG-0004RN-CW; Wed, 02 Jun 2021 04:47:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3_wW3YAYKAPIXlimYhaiiafY.Wig@flex--drosen.bounces.google.com>)
 id 1loInF-0004RH-DI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 02 Jun 2021 04:47:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BKOZH6cxK8H9gN/NAu+gVbuI/VQYZv1qm1QPaLOLjHI=; b=kV+oHVfo1Erl69ahvQro0U1gn
 iPnIl8b073Dv35xFPNpXeluXgYcaf+JrINA7unT927jHNToyTPhXfvPy63sSEdV3k71cxSBzBN7zZ
 xSplVERPjn3xmexj2Z9t40wRfomFTf/YyhsAAV7oO5M/taCSccX1iALUDhQF2i28l8xzA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BKOZH6cxK8H9gN/NAu+gVbuI/VQYZv1qm1QPaLOLjHI=; b=TN89MC+e/tlsKOofNTFDv9ilsb
 WaNP/x1y0imVUF3aAUJjLHp/jh/dGfxT5SK90ujcMK39fgJbA/F3606pDG10kI7WQgOG5kG15umWo
 k8gbBX+Fn/u93U9B7JKHBSWdhvvh/erq5joG/rZPvwWF+UHL6k88985oGuyLYWIrSC9U=;
Received: from mail-ot1-f74.google.com ([209.85.210.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1loIn8-0007ot-4T
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 02 Jun 2021 04:47:51 +0000
Received: by mail-ot1-f74.google.com with SMTP id
 c19-20020a0568303153b0290315c1232768so917154ots.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Jun 2021 21:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=BKOZH6cxK8H9gN/NAu+gVbuI/VQYZv1qm1QPaLOLjHI=;
 b=ilMn61oqRM2Lkr1rRMXwrky4dts/4DoVebjHQHw1fhnH/vuUOm9+LTKdaUCtMY/STw
 DzTLXbdzQGvl9s2K8N0w8cifD9rODA5xbpZq6u0RN/NBGoeAqA04HGELINuvvBQtKnUg
 OIrRZ0ofDcCstAan7FJfuEW3KOk3exzjGNHfKq22f9cv5yooM0VGy6RkEM+dsE5O3SYO
 0RSonkVgvkONNTeSSM/6L7bMkURRhdr0QhQQhLk1PVN3heaECznM11cLY4AWzXmvOxDW
 MRNS5kHYa1r4GsB0YSobdNRAtEhh56hfEopCFOi6Qm9CQ2nz+tGtFk9ZttKn6Mz4w5o8
 8Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=BKOZH6cxK8H9gN/NAu+gVbuI/VQYZv1qm1QPaLOLjHI=;
 b=FpsRoiwAbO8+9OflCkmelDNylJHDKSzcMWsvVVeCMzuvPs5BskSXxkdaZEQwgNPnU+
 5stL5SqNOFGUvih91/knJGxOcPhhQMUUCNXpOOkRlrXOKC6JkrYuQZKCPy2SC48Dbxu0
 VUfEBhpeAPme6nv72hhA2x1atzWPit4h43fzKTB14ULlAB60ZI5CSP9uVg8W3D4t2/BF
 T8p52j6mlyABaVh4KpZ6IMTojAk5K76a7GH3EBWXdwJ2RbAcWrRBjDDDQhTdqBE0LGJ9
 ndSMlC8nf8AdBMOEUJjw4NVpr1r+f16vWwwOuUXsnm7UwzPlGgXU/KWHAY6w5Tgbt7Oe
 i3nQ==
X-Gm-Message-State: AOAM531vIFa63FQgt1y3NAAC8k6tVV2iYLjRhdLhnBgzHvyMiM2BRG9p
 MnGS5Pn5bCVxP96ECVY/0uwXknq3pCM=
X-Google-Smtp-Source: ABdhPJx3EPn11cJAZFQbbLtQn7yZRTKw3SHAIWbgcrOqO941WNYsCpYzO0S8sqLgdG0Ts39zGQH2ZATm4Wg=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a17:90b:3b41:: with SMTP id
 ot1mr283480pjb.1.1622607359362; Tue, 01 Jun 2021 21:15:59 -0700 (PDT)
Date: Wed,  2 Jun 2021 04:15:38 +0000
In-Reply-To: <20210602041539.123097-1-drosen@google.com>
Message-Id: <20210602041539.123097-2-drosen@google.com>
Mime-Version: 1.0
References: <20210602041539.123097-1-drosen@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1loIn8-0007ot-4T
Subject: [f2fs-dev] [PATCH 1/2] f2fs: Show casefolding support only when
 supported
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@android.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>, linux-kernel@vger.kernel.org,
 Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The casefolding feature is only supported when CONFIG_UNICODE is set.
This modifies the feature list f2fs presents under sysfs accordingly.

Fixes: 5aba54302a46 ("f2fs: include charset encoding information in the superblock")
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index dc71bc968c72..09e3f258eb52 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -720,7 +720,9 @@ F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
 F2FS_FEATURE_RO_ATTR(verity, FEAT_VERITY);
 #endif
 F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
+#ifdef CONFIG_UNICODE
 F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
+#endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
@@ -829,7 +831,9 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(verity),
 #endif
 	ATTR_LIST(sb_checksum),
+#ifdef CONFIG_UNICODE
 	ATTR_LIST(casefold),
+#endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compression),
 #endif
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
