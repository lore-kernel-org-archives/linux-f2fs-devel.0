Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C8DC072A2
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Nov 2023 02:34:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r4B9w-0001mJ-9c;
	Sat, 18 Nov 2023 02:34:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3aRtYZQYKADIRfcgSbUccUZS.Qca@flex--drosen.bounces.google.com>)
 id 1r4B9u-0001mD-SY for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Nov 2023 02:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8DMjQxPHsXDl1utN53ZdyGpdJ7ktMDSn08B+JQ2WLUU=; b=SykHY2pJzGo08J37tQKZK5qsZL
 /BAESkx1vQ6VrjK5N6REdcKjOlG4fwx3H7wNfmcdXeEMJuJcSBTkh/LklxvqUE8slCueDlK0QU1xe
 px1tcLHUrtg+LwdvVb82t3rixOCAwLPJmqG6c/PyXhnV//AJ/qVFAM7q57a4MRicIBhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8DMjQxPHsXDl1utN53ZdyGpdJ7ktMDSn08B+JQ2WLUU=; b=PvvGu7fvO+4HATVSSXFcPkfXPv
 k1CZUU94jo2UlIt2UokSfNXqpTbWAB7F5lX5htAKKopFARUF+WnTuf1kc6AkWCMqawykF5lTsMNy5
 9dEa4HPKVRowp1mLdMG9LqL4m0HZtoO+7zLNxIohAm3BRwgGJKw5dynMrTZaPie8o01Q=;
Received: from mail-qk1-f202.google.com ([209.85.222.202])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1r4B9q-0007pB-E4 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Nov 2023 02:34:10 +0000
Received: by mail-qk1-f202.google.com with SMTP id
 af79cd13be357-778b3526240so302077985a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 17 Nov 2023 18:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700274840; x=1700879640;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8DMjQxPHsXDl1utN53ZdyGpdJ7ktMDSn08B+JQ2WLUU=;
 b=ANQUbnmi+q10Ii6FXt8PDk4sfrqtOsz+CNMyYdpim0YFatkvHtNDGucAzYrHKg3VUX
 4BtNBCL6Gfpt9RGH7HhSdGU1iJKwFzxbofFlhK6M7B2hzIFrkB6ng1k7bgjmRr3lQb//
 gEH0CXlWgI4K5PiGmU0r6MDYZ/7Ub9X2K53BhXwVjI6WPn+Iy1F4hIE0orzY7rrVaCPA
 0yU0nRagrKhRpc9P+pRbXqgxjmgXnf7d8gL4FshTIF+SfcCDF262PHkGH2Zor2Shkm+G
 iTmrtqkqjFG37KbGhgd2cM7pdLMLjnOwAxgAsPXVwFx5ZGxc3X/ak6Q4qyz2GyoNgbfP
 j7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700274840; x=1700879640;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8DMjQxPHsXDl1utN53ZdyGpdJ7ktMDSn08B+JQ2WLUU=;
 b=o6TFrVzswBeq4radrTqnYrcd3URtDnYRBy27nu1QuwS5nXVBjwBey6aLftAblQ09wX
 F4OUbKnRNMPAlK63tTXBKGGybjAwtigJkx3byu0RSNjf/VfxwiWx/rpuPL1G3kb4AMQ1
 WVSJdOWoXHbLNI+9F8JXedph0s9p8BMxKSyjQ+wnVkPRAW5m0Ov99EZ1dtJwt8opTVAt
 YBq1k3TrAvHm+ZYEgHtj2np+qWFpjAlTdZONt9XY9MJaoxAtRyHsGRWwehLSY9Mi9Gzl
 WHAGevYD5fqn1scKNJ75kYZYZGHeW0RESkOmGrfORWWZefDH2c+0OM12liyfS6kcgxP4
 gExQ==
X-Gm-Message-State: AOJu0YwuefNSpX3n+fVW4cM3mHWp+Tbu319YbtA7ciyjrJxzDZXlhGWv
 1EPFCO9k++WlyoybbSBAv9DAa86kgfOAPeWWlpAQGjvHMKXwTRlqIU5IUgNOj84g6xS6ulkLpg1
 85xXKzbkdwQZJB3Qnf/dPw4ysE25AQh7s2oK4/ia7IlACXWvUgQZZJOs6z6HGZIl+3rOzWa8N9+
 JqJOYCwDU=
X-Google-Smtp-Source: AGHT+IH01QzCwzxOFZY8LgvM0Atm+9JJTfj3QptRXy62USP5KTIzx7jsWUsHznI8auj1W8ripK5iTejYps0=
X-Received: from drosen.mtv.corp.google.com
 ([2620:15c:211:201:5334:1f35:bdef:529b])
 (user=drosen job=sendgmr) by 2002:a81:4984:0:b0:59b:e81f:62ab with SMTP id
 w126-20020a814984000000b0059be81f62abmr31882ywa.7.1700273001441; Fri, 17 Nov
 2023 18:03:21 -0800 (PST)
Date: Fri, 17 Nov 2023 18:03:07 -0800
In-Reply-To: <20231118020309.1894531-1-drosen@google.com>
Mime-Version: 1.0
References: <20231118020309.1894531-1-drosen@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231118020309.1894531-2-drosen@google.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1r4B9q-0007pB-E4
Subject: [f2fs-dev] [PATCH 1/3] f2fs-tools: Fix debug size print
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
 Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The conversion from block size to MB in this debug statement assumes a
block size of 4K. This switches it to properly use the filesystem's
block size.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fsck/fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 55eddca..509b485 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -3494,7 +3494,8 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	max_blks = SM_I(sbi)->main_blkaddr + (data_secs + node_secs) *
 							BLKS_PER_SEC(sbi);
 	printf("[FSCK] Max image size: %"PRIu64" MB, Free space: %"PRIu64" MB\n",
-						max_blks >> 8, free_blks >> 8);
+						max_blks >> (20 - F2FS_BLKSIZE_BITS),
+						free_blks >> (20 - F2FS_BLKSIZE_BITS));
 	printf("[FSCK] Unreachable nat entries                       ");
 	if (nr_unref_nid == 0x0) {
 		printf(" [Ok..] [0x%x]\n", nr_unref_nid);
-- 
2.43.0.rc0.421.g78406f8d94-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
