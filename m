Return-Path: <SRS0=oydM=A7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3AC43465
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2020 23:38:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020D2207FC;
	Mon, 20 Jul 2020 23:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="SfdU7R/c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GBaZu8P+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HOPSEkOJ";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="dpz3hRRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020D2207FC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s0VWZINu1b1pcKyZ4HFcTwRz86U3fEdupRCXuxsF4ng=; b=SfdU7R/c8ujdwrmr11mwZ6yRH
	DbTfAPde7zAV9kk7WNgJkZXVS9hZHFFdpLRa7lBW7JeW9xGCtgY3x0rl3JgM8a2ESPl/N1gZqlWGk
	ACWEnIs5TpH3lgADfd8sQ7mY9MwRWKsbOCzYlbVTgfXNaD6E4bblIiOh1bO5Eaeluadl8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jxfMA-0006nQ-La; Mon, 20 Jul 2020 23:38:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <30ioWXwYKAH8vdw1dwjrrjoh.frp@flex--satyat.bounces.google.com>)
 id 1jxfM9-0006mo-CQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Jul 2020 23:38:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H043ZGT0tUkHasuQEIGWrSIMw4QdS1VbmKoEccjtzM0=; b=GBaZu8P+0IQ5uucAbfuo6+lPo
 STdHTPu+k/yq1pin/7x7/qjc4nD2SEbaAb9C7Pcmtt1nD58r9PG7xQ5QnKCtPdeP/vpCvQfw1vvUz
 AxmW1oPoO/BeMx12p4d8xrCeObI/ZaXMlQfzSjCoRjthZEvLWLe8Rmn8IIfn8bUr+mV2k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H043ZGT0tUkHasuQEIGWrSIMw4QdS1VbmKoEccjtzM0=; b=HOPSEkOJo2VT5qoO7V2JVIeQim
 7w+s+SGhkRop5DdBkd8R3RFAhuf3FNWHuoK4AZnu1jghoh5MLg7RjU+xxLf9Hre9rEfh7x6Gc9C58
 PTBsXy2RiRR5+piTdhYRxzSq9/iikOPXJz5B+UM1mS3SQBC5zgR470yZ448Ka9/0jkJA=;
Received: from mail-pg1-f201.google.com ([209.85.215.201])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jxfM8-00EOUx-7K
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Jul 2020 23:38:01 +0000
Received: by mail-pg1-f201.google.com with SMTP id x184so14853452pgb.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2020 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=H043ZGT0tUkHasuQEIGWrSIMw4QdS1VbmKoEccjtzM0=;
 b=dpz3hRRXJhzFYY0/pCX+Y/eePZpWFCADC/kjj4qZk3jOrPT6G6tdSjuyh9Qw+Wrue9
 9f6dhzx0VvfFcrv4a6Firxihch6LbPRbw8QtUFYbwd4f1tEtLpf5bbkhowqe2WfQ2faw
 kB23eVk86fVuNkCwvfPS/vFUeGyQ4ajGNPlCM2T5YJCzs0iVMV+giOYth8pP1IoNiIus
 FwA5zN/b6t+kqlz18awv5ni7cMS7s5ikKECiJK6Jzuibq8sR3hYMa51fZAjxbYwbSer4
 WjNWu50cQeiODtlqpxegUVzn2ulDcCCSBkWeQKnwEj276YUVPDg3kVr0Rfiy1ajwok15
 JZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=H043ZGT0tUkHasuQEIGWrSIMw4QdS1VbmKoEccjtzM0=;
 b=sk5I1QToRQpKdJlyc8CH5bcsRO3OPv4ub9z2WvrXSw0JantOzLedjbtMz95Vb3m/gB
 UAoTNDO30oalGDdgOZklgke3yLm+gkiJgcqh7crJPT8hpbT7KevzJlxukW00RyJ4c0z2
 gdQ8kHF3Wz8EqgBkAUlAozSpJQ/FBWt/eSczPqiVT5FWAwem3QNjWKJAAjCu1SR8Oes8
 jB4Go4zvV8TeFZwQJ0puHRrT3IuOwqzAT8loTV5cmrarZck5uJCgI3pXAdtfNc0PSAZT
 2xIxfz1v0eVZuSLGfS4xg3jjbXg/aqOUUtO8QrjcGaZTe2dmBnJ6TU2+vlwmktEtJGJH
 RWqA==
X-Gm-Message-State: AOAM5321wrBCF4dYAKvNbguTVHxP+Lx05bYB311bY8lAWZKgLVPq4LhZ
 Yt9yxYcImyRZKhCFobd0SaPNegyDmgo=
X-Google-Smtp-Source: ABdhPJzD4zyxL6NAWP8CBEO3nWgs3IY5xzymZloYi6QDkienrJ3ha/vZk0REiujEDejgnVubHrJvYSOYoFY=
X-Received: by 2002:a17:90a:bd8b:: with SMTP id z11mr82498pjr.0.1595288274362; 
 Mon, 20 Jul 2020 16:37:54 -0700 (PDT)
Date: Mon, 20 Jul 2020 23:37:39 +0000
In-Reply-To: <20200720233739.824943-1-satyat@google.com>
Message-Id: <20200720233739.824943-8-satyat@google.com>
Mime-Version: 1.0
References: <20200720233739.824943-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jxfM8-00EOUx-7K
Subject: [f2fs-dev] [PATCH v4 7/7] fscrypt: update documentation for direct
 I/O support
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
From: Satya Tangirala via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Satya Tangirala <satyat@google.com>
Cc: linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Update fscrypt documentation to reflect the addition of direct I/O support
and document the necessary conditions for direct I/O on encrypted files.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/filesystems/fscrypt.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index ec81598477fc..5367c03b17bb 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1049,8 +1049,10 @@ astute users may notice some differences in behavior:
   may be used to overwrite the source files but isn't guaranteed to be
   effective on all filesystems and storage devices.
 
-- Direct I/O is not supported on encrypted files.  Attempts to use
-  direct I/O on such files will fall back to buffered I/O.
+- Direct I/O is supported on encrypted files only under some
+  circumstances (see `Direct I/O support`_ for details). When these
+  circumstances are not met, attempts to use direct I/O on encrypted
+  files will fall back to buffered I/O.
 
 - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
   FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
@@ -1123,6 +1125,20 @@ It is not currently possible to backup and restore encrypted files
 without the encryption key.  This would require special APIs which
 have not yet been implemented.
 
+Direct I/O support
+==================
+
+Direct I/O on encrypted files is supported through blk-crypto. In
+particular, this means the kernel must have CONFIG_BLK_INLINE_ENCRYPTION
+enabled, the filesystem must have had the 'inlinecrypt' mount option
+specified, and either hardware inline encryption must be present, or
+CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK must have been enabled. Further,
+any I/O must be aligned to the filesystem block size (*not* necessarily
+the same as the block device's block size) - in particular, any userspace
+buffer into which data is read/written from must also be aligned to the
+filesystem block size. If any of these conditions isn't met, attempts to do
+direct I/O on an encrypted file will fall back to buffered I/O.
+
 Encryption policy enforcement
 =============================
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
