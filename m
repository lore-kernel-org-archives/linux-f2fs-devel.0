Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E30E8FDB7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Oct 2023 21:08:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qnmcm-0006r3-VN;
	Tue, 03 Oct 2023 21:08:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1qnmcl-0006qw-BA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Oct 2023 21:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eP5y3XrI52G/EWwodsmSHUCB5YkZESEmXXN8PSy41u4=; b=YJwwviFGa2X1wL2Udzlsq4ajMO
 05eG65Y4ZyMV+B3LU6NJ0JTRtICc3BdwFCSm21dlcwetiiTyBDieDLnGfqYTjvbSpLTczakZ3Tv8u
 2krNeBCoThE7vSKiU/8nNwATEpN5Knb7D4cpxdJjC5eIvQFd/CsJt4OwWMHx8T1uk/6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eP5y3XrI52G/EWwodsmSHUCB5YkZESEmXXN8PSy41u4=; b=f
 X9RwC9ZBNuxObb6mKgBYo8eFvdcDVkl6teJAL9579gOotkCje/qttIUOqSSYSqVsAgJe1JsUrPgKP
 ybngZNLZZTkFpMjJQxqLXpz0wUzgTWXWeKNE2oJXJHH9bo+ilQ2Qx1rdd3va+qLrqYiB4SmCsNeJY
 7GoCy8S1DFST90/Y=;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qnmce-000Gbs-Ug for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Oct 2023 21:08:10 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2792d70ae25so969961a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 03 Oct 2023 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696367279; x=1696972079; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eP5y3XrI52G/EWwodsmSHUCB5YkZESEmXXN8PSy41u4=;
 b=ZB91JugCVuj/OHvo6s7s9BuJh3G++ZUvoxy6mL0v7GnePEp+ExKpxGBKbQxz+hvIsq
 spASrmWvmALHtadG6G1uyu9QgeG8zyXW8mcrhlG4lvu9Cxb8B/I6PZj19tfwgg7kNeyT
 B9zDb3bW1MMJXGuAI8ntoL8Y1no9bZClJWkcHu/u7l6ZLnIcifhmwEwsaMcTqWa1vGVj
 hdiQVfN9+W2UiZiviKPGthxYwUIw2tZP+cemnaCoxs0h/SuKD6pCghHMmqR6eXWeGlB5
 phzlEH53nhvr1h9QNb1Gv8itLllw6viCWLtbNyiW61yjr0d5xeRcpOCqZfeoGBi5jy/h
 IKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696367279; x=1696972079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eP5y3XrI52G/EWwodsmSHUCB5YkZESEmXXN8PSy41u4=;
 b=PdTY+2zeXOlJT9VbEIxBn3vw+gMoosisboyhXaDTRFsnA01JBSmtM4A5bebGqotZsb
 3rzSaDJHbfDgqCeFxj4FGlAQxW7ug/jUE9AQRIKJ/N17UsO6hQ7uTnRx8l2A3hLrJTZi
 T5J/FB4rhFAQoVE+xR6VzUuIcaPk8hD1ppoWVNrC7VplL1aqOxDYMci7iOurbiY3cl7X
 QJGKnWUR1uxOgGm2pPdZDDmKN+1JSw2IqF+hmPYtNRIZtr2UR+uIqlEE+XzYuTNFhLST
 yNo71WPCGNHRHBSFihjExwaKLqlL0DqxW+OrhBrOGMpfGdjc5XA6xa+vruEs0eaBv+9R
 c4Rg==
X-Gm-Message-State: AOJu0YxvH4CyhueKj9IOn1Kw7yObDY9V5PR0B2VRzY4G+sYyfk7EDiGv
 Q1gaa7R4a+VTqogPXj8HH7U=
X-Google-Smtp-Source: AGHT+IGLbAqS6OCs+muiuq3M+y8rKqOE/s0qEoEGOJldOdpZE22VGPL1c3dW6J2MFAI/bB/fb8Z7xA==
X-Received: by 2002:a17:90a:348d:b0:273:e8c0:f9b with SMTP id
 p13-20020a17090a348d00b00273e8c00f9bmr464500pjb.15.1696367279212; 
 Tue, 03 Oct 2023 14:07:59 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:1d9:902f:6531:9779])
 by smtp.gmail.com with ESMTPSA id
 18-20020a17090a19d200b00278ff752eacsm21887pjj.50.2023.10.03.14.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 14:07:58 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue,  3 Oct 2023 14:07:54 -0700
Message-ID: <20231003210754.275175-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
X-Headers-End: 1qnmce-000Gbs-Ug
Subject: [f2fs-dev] [PATCH] f2fs-tools: make checked node progress correct
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

Let's say we have 100 nodes to be checked. With post-increment of
checked_node_cnt, when we reach the last node, we cannot print out 100%
progress. So, go with pre-increment.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 78ffdb6..23b9433 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -517,7 +517,7 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 		if (!c.show_file_map && sbi->total_valid_node_count > 1000) {
 			unsigned int p10 = sbi->total_valid_node_count / 10;
 
-			if (sbi->fsck->chk.checked_node_cnt++ % p10)
+			if (++sbi->fsck->chk.checked_node_cnt % p10)
 				return 0;
 
 			printf("[FSCK] Check node %"PRIu64" / %u (%.2f%%)\n",
-- 
2.42.0.582.g8ccd20d70d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
