Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9CDECE589
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:20:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1snmjz-0000NA-B6;
	Mon, 09 Sep 2024 22:20:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1snmjx-0000Mg-2c
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Sep 2024 22:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7ju9SGTU3qrpQt9b2K14pzpemAOmcwhjJLKLVpOR2qY=; b=Nw5qVRmiuc8By+G50MaozRqKCv
 Z+3VEXH7lBdMJPWKd23zjRhCtpAQABuab9dF6LWSXs9XMKTTPqps2r6iYJDj130DFzVES8o0b+jQm
 T31quaD7ZGhqqliZD4PMdRTj3H/WJFiZgFr29VScNBXZqlUKqH8Z8lXYYKA/kQmxitmI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7ju9SGTU3qrpQt9b2K14pzpemAOmcwhjJLKLVpOR2qY=; b=YsM+e9t2k+fEBDhB3QDOc/E+OL
 DjpKk5Af/26LEohWEIcD9OwflThUzhHUyNvsL0AON7uJn9MrkxYNLr7I/mnZ3l6RqTWzsGgtamoI7
 5cf4BgLhxRG5ozWWwVG7JnzefVvUtEhn5+bsrYAZLp+xteCpdKjcLNNG9Yi0g93h//Ag=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1snmjs-0006gS-Dj for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Sep 2024 22:20:05 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2d8a54f1250so3193545a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Sep 2024 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725920394; x=1726525194; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ju9SGTU3qrpQt9b2K14pzpemAOmcwhjJLKLVpOR2qY=;
 b=RpflnFyX8gt5udYK4xdopWonMBCB3m/0OwrMCdcNMcXouzeyU92DAnIpQtc1juvNoY
 KyE4LOMSgGkjPvhQ9Att4Y+cj+4rmctajIj63IEmfKgxzmvXZ2kLrJRUnqKX6ox5p/4a
 wvNRAFWO5wZty7CW5wR/gy7NIk+2xrs/bR9HCN9ojS/2vfqA9+lrg3gMtHlqe4sUWvSw
 cWDgd7wmg3OMY3w2lfDZNnVhxLSSJuUTZ8B+1WQ4GibJfZPm3B6rftvHyFBz/M4GeSeI
 ON360nLv1sM92b3Z1RspEZHhoytpt5k8X+fUb1p9nTjlynwx26sKuVlmHv0Zs73xTyvv
 qZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920394; x=1726525194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ju9SGTU3qrpQt9b2K14pzpemAOmcwhjJLKLVpOR2qY=;
 b=C0i7NmWvsIMm5Fu0hsUh473AmPM3xfSrmstPyF9ergDSuEotmmPFxef43RnpuBE1I/
 3KLokP/3r7fl4JryMoS2bTwLsTtd636bi/0WDy83rzQeOpRhZ2mdpthH7OkxCsaePlXm
 b0mJ8tFcescLdZEHbV8i8Gei5qsEaSOK7NrD5hTlNA/KC5v2I2xHq1NM+8N9tafClmX5
 iBRK3V0V3/tJV2REhguiaG+tsWQlKdyNMSlCwcinbnJHNS9Y+FNSiM2HFbpJqKvzM/eK
 D92eySG6+TMG/V515vcXHIBgGjQBEk8rYTw2fG5Y2YIu4dC/0EoanTSyjaXPKJTn/UQr
 OmKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO/ZdlFCyGi+ilsbv9H4Ml8ruk4+1YKEdyoiAESBeXRfGzoO1KxNDMtI/zwFJp9f8GZuRNr4v1w749mrM72g8v@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxKWKFpWu9R1SEKaChnZCO/itt+3cGoCI3t3Ee7ZnfUfrXQbuqN
 D2IXQjZo0CGz9oDPV/YFSPIvyqTdYV+VLrGiZ4lH2E5XYRyD+mee
X-Google-Smtp-Source: AGHT+IEiweGW9x3af6N5AmUP+sYWfEa5idVX2NKd9Gi5tR4l5i+m0dhJU50vaHHcEmOfeF3QpFpMLg==
X-Received: by 2002:a17:90a:f16:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2dad4ef808cmr14005403a91.15.1725920393685; 
 Mon, 09 Sep 2024 15:19:53 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:ed56:14c3:db02:6c66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04988470sm5016840a91.54.2024.09.09.15.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 15:19:53 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  9 Sep 2024 15:19:42 -0700
Message-ID: <20240909221946.2004046-3-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240909221946.2004046-1-daeho43@gmail.com>
References: <20240909221946.2004046-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1snmjs-0006gS-Dj
Subject: [f2fs-dev] [PATCH v2 3/7] f2fs: add reserved_segments sysfs node
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

For the fine tuning of GC behavior, add reserved_segments sysfs node.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/sysfs.c                         | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9165f617d216..deff703035e1 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -771,3 +771,9 @@ Description:	Controls migration window granularity of garbage collection on larg
 		section. it can control the scanning window granularity for GC migration
 		in a unit of segment, while migration_granularity controls the number
 		of segments which can be migrated at the same turn.
+
+What:		/sys/fs/f2fs/<disk>/reserved_segments
+Date:		September 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	In order to fine tune GC behavior, we can control the number of
+		reserved segments.
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 66d15609d5ad..761d1abd46a8 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -974,6 +974,7 @@ SM_INFO_GENERAL_RW_ATTR(min_fsync_blocks);
 SM_INFO_GENERAL_RW_ATTR(min_seq_blocks);
 SM_INFO_GENERAL_RW_ATTR(min_hot_blocks);
 SM_INFO_GENERAL_RW_ATTR(min_ssr_sections);
+SM_INFO_GENERAL_RW_ATTR(reserved_segments);
 
 /* DCC_INFO ATTR */
 DCC_INFO_RW_ATTR(max_small_discards, max_discards);
@@ -1144,6 +1145,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(min_seq_blocks),
 	ATTR_LIST(min_hot_blocks),
 	ATTR_LIST(min_ssr_sections),
+	ATTR_LIST(reserved_segments),
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(migration_granularity),
 	ATTR_LIST(migration_window_granularity),
-- 
2.46.0.598.g6f2099f65c-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
