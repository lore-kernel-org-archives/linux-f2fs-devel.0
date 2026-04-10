Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2109CF44857
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t4xvdsTmGzQIj9uAtrrgGt91XP0Tv4KFcQm9e2yeBYQ=; b=SI+uq5UhZCat4UVfNQdmqLCrKl
	tyI3CftBiK0DYw95ZQjRNo4b3F/asdhLweCND7lfll1T2VVwHToVkNKZgvxM4Mbzf2ahJ6dxnSMVQ
	ROP4NjPLl5pmKfwXSxJDc4U9/5FAKzaJ2ynmHBcDj1m+RXnjIJBD0JEa6luGHuNd1pBs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wBBH8-0004vt-QA;
	Fri, 10 Apr 2026 12:47:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lgs201920130244@gmail.com>) id 1wBBH7-0004vm-3h
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 12:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KoX3WbY7wSPwBwc2j2U0W0uZOmyQY8MWh9rOIhaU/PY=; b=FCSDgPEDc/WY/zhHfv7HPFB36o
 f2y6I1HwDCLtYL1uDYThBbuljwTJxBJJxIS5UXNw4/vNLJLzty/WXy0vOpz5gICjAXwfHkHRLLHtB
 WYxwr5X6ikHC9SX42Hu2bfrDuOp0MbhyNxydgTZlv2TPNQ2k2QYdxcYpjg1ikFoM7YMY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KoX3WbY7wSPwBwc2j2U0W0uZOmyQY8MWh9rOIhaU/PY=; b=l
 +GOffxvoB3feFz0v/BGpOc2qZ4wjsNZq86xK5p+laduK24ALRL3hhWZdaDouu7aGwAiQ76c01oraB
 7Yt7ErIPqvinQYdIdhhknEWvgVSOIa3SqBbuDqznyX9a1Ixz38bc84EOD3p+bU9u9c2mk0QjpELa2
 s9aAyIYmHFrptS5I=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wBBH6-0004oT-Om for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 12:47:53 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so11348125ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Apr 2026 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775825262; x=1776430062; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KoX3WbY7wSPwBwc2j2U0W0uZOmyQY8MWh9rOIhaU/PY=;
 b=DAwgxiABm0ypO1KVimcTMIex7ZO3tBgyxNZUsFVFp4eIMaOHQNtuAxr+9P0pdc5/l3
 NCrDPOWsImIap9Alf+/5w2o4LbUmJVE6v+8a/kMoc3Nj9koQk8UNTTd01HTQA2sPez8Z
 SNKjT/2ainZhmALBWtgW36uSq2z63QUzsfzbKNabTPG69llVTLKpswxMis/gl/t7Qqm2
 awYlr3tm6elm2QOI+sRRTSdhtbpr77joeerMskonmiLnJAjA2hVdhf8V1ryghDdny8le
 lOyfFDzCryCXgtzQGUvu/Z3SM71zjs/ECmJKWV4u5Argc6+3VPjOBcU3Kx//ehfw52m0
 0ooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775825262; x=1776430062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KoX3WbY7wSPwBwc2j2U0W0uZOmyQY8MWh9rOIhaU/PY=;
 b=KmQTMkeYBqyON0M2mfR0B+vO61pMawhvaXndg/TLbrP7Fw5nlGTGsfdSaUQKG+jmXG
 nEOJHoeNuWKbwMAkeWHIgkZSSNvqFv/jaa8pEQpO9aHCPdesWLscPdiORWVFzOqFFuF6
 MwtGHAmAUuTzaJYaVRyUXc7scgBFOuXS47zQA1RkIKQGxQr41Jivac5/SzpezmhmOQPI
 MLbJuUlmuUG8LVOgp66W3Z9kjzVZpqSm1LJQnubB53xg3kEEa72IglbhB96UHYblMGnM
 Jj32+vru3Xyp6TFOX6LUkvzMGDi2RvflWV7p0Fdb6qXkZWBbT9F2UDjKBpNo88nZ8pt1
 q/uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQVoBj+XUzJYHW8eslJEq8HyqCjvMwysttKTIEw+3Y8DPsvu4EvLxDDiXrhVFWD3JSAvZms5kjg3Xdj2B96+7t@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyfcfTSrfO/S4eqJCrbuMLHOQwyaYvOph3/R9oEv2K5ttRGgiXR
 ViT+QYGTpv3f7OymcTYV7FTgHR1W7qUuB23h1cdf5+tBJo6jx52CAmsc
X-Gm-Gg: AeBDievm5X4KQseyDTKRXACocgBSjKJjtn5GT5gsS4+q1rdlpJDXxUGOSMM4Ko2dpnA
 yfx2gy3gvML92hKHLvHiupxTWHVSVmmOp775qA/LCUZV3STKUfjRUSEaubpDkifD3DbpDFG7vK0
 DCf9DC3tmSSVuxdTyMabNAa2dOTPv57H4Z3uHeymYAd1PYtKYrYv5SEMoLr96JFY704Gsd5bHZ6
 gBE4iHCL2neAwjrTEiLToJZHugsICH9cKklYVk4eZgNszVBPpkbBK+XglfNC9aHzd8aoGObSilI
 6smwiLHB5GkDcfqKV2BHLG6JXhBYiOIBx7nCbhrc0bzWoXUyF9T57wQnlpAVJ2ccvB+NRSX5S04
 50VtaSEeI/JFEk4fnG0uTEvfnvgM8MY7trSboGDjDkAAdQ938HaS3o/Uyh4tSHYLoPSv6cwPhw7
 QfDyQOAFmpBXnwKH1WP3RjDg==
X-Received: by 2002:a17:902:c152:b0:2aa:e47d:e3b with SMTP id
 d9443c01a7336-2b2c711e5efmr51316945ad.0.1775825261969; 
 Fri, 10 Apr 2026 05:47:41 -0700 (PDT)
Received: from lgs.. ([112.224.67.108]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4c9dd5fsm27554365ad.0.2026.04.10.05.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 05:47:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Fri, 10 Apr 2026 20:47:26 +0800
Message-ID: <20260410124726.2035729-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wBBH6-0004oT-Om
Subject: [f2fs-dev] [PATCH] f2fs: fix uninitialized kobject put in
 f2fs_init_sysfs()
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
Cc: Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_init_sysfs(), all failure paths after kset_register() jump to
put_kobject, which unconditionally releases both f2fs_tune and
f2fs_feat.

If kobject_init_and_add(&f2fs_feat, ...) fails, f2fs_tune has not been
initialized yet, so calling kobject_put(&f2fs_tune) is invalid.

Fix this by splitting the unwind path so each error path only releases
objects that were successfully initialized.

Fixes: a907f3a68ee26ba4 ("f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 fs/f2fs/sysfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index c42f4f979d13..4df0de9ccb00 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1893,24 +1893,26 @@ int __init f2fs_init_sysfs(void)
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
 	if (ret)
-		goto put_kobject;
+		goto unregister_kset;
 
 	ret = kobject_init_and_add(&f2fs_tune, &f2fs_tune_ktype,
 				   NULL, "tuning");
 	if (ret)
-		goto put_kobject;
+		goto put_feat;
 
 	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	if (!f2fs_proc_root) {
 		ret = -ENOMEM;
-		goto put_kobject;
+		goto put_tune;
 	}
 
 	return 0;
 
-put_kobject:
+put_tune:
 	kobject_put(&f2fs_tune);
+put_feat:
 	kobject_put(&f2fs_feat);
+unregister_kset:
 	kset_unregister(&f2fs_kset);
 	return ret;
 }
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
