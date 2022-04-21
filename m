Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A775C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Apr 2022 22:19:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhf95-0005Q0-R1; Thu, 21 Apr 2022 22:19:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bart.vanassche@gmail.com>) id 1nhf94-0005PE-F2
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tlk6n+GqQqUb6SiQRdz3cYZMtWCLAcaChDFTtbTyU6U=; b=cojg2wGOmhpA32xgstPbpmZxNb
 Xdou1uhNvEwXzJbjc+45QS/xsBL5UlbfJjk9ySJQxQXJajicwY/E+gvJnCpIUb8VIn+pRdDpST8y7
 N0w7UXJxTyQ0uLwEcp5GCW5maF8HPmBrBhwpbT3DdSe9SR/NVSp+03XARtqysSSknK/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tlk6n+GqQqUb6SiQRdz3cYZMtWCLAcaChDFTtbTyU6U=; b=JxL0H4hTz+/zdTX5uZGlKsD8hj
 UCPkhY2Hph5P+fAFD00kM1plnhgCd3NX74Gc9if1KmD/rbwZAIioeoQBxX/3rvc1Xc2NJjs+OcWSL
 C5nVIANcxsRS0rbXlN92gt2iV9x770xYEh7ouX0wI2VaMYoCQkx8GsTw8l4KH/gzjSbE=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nhf94-0002xJ-K9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:27 +0000
Received: by mail-pl1-f170.google.com with SMTP id h12so3100051plf.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Apr 2022 15:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tlk6n+GqQqUb6SiQRdz3cYZMtWCLAcaChDFTtbTyU6U=;
 b=bKRWj/TbK0DAxg0lAF1TTJaSgVE9sgwX5tUk7DiLN4Od3DJRl60/Xsobxjq22/CcZN
 oBs62Z9OJsA5dLPfNFlRiOy0cfKE0gjwXXpAnX4clx5bnvML2XRmPo79f95bBTDQtCMo
 By6PVUAZl+eEtlHqFOkswBi3zdStIFtoXBK67KilqYVtxQ8Z3sH7bAVNclv2uKe6AjH/
 QvwMEqteKFVaGFhEsc6K2dMb7IkY3e43Iz+jQXTa/jVw6Oev9ak6KK3JFH/FX+x1QWPj
 BRC8tqyOvCP72NVQ0EGDXjzcbBWL4bkS8rQFieBLUyYSGwIfvtTB844RBVJG12OFhvZG
 phbw==
X-Gm-Message-State: AOAM533lk6nbMYEdFbNizC3qE/p2x/OxNBXVgfbGUCq6Li8Y3We8WAwT
 CJXzl17jyzGZgnGA9bCwYB5a6+7ix+dwow==
X-Google-Smtp-Source: ABdhPJzP/AEtGyLq4zAOwvFYqVtZGdtBemhf/JuQLrHRUOpYbgROXS9Se0qAGz0aSqfLJokZH/PRPw==
X-Received: by 2002:a17:90b:4f92:b0:1cd:3a73:3a46 with SMTP id
 qe18-20020a17090b4f9200b001cd3a733a46mr1949285pjb.66.1650579561051; 
 Thu, 21 Apr 2022 15:19:21 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:a034:31d8:ca4e:1f35])
 by smtp.gmail.com with ESMTPSA id
 hi21-20020a17090b30d500b001cd4989ff4csm3794876pjb.19.2022.04.21.15.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 15:19:20 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 21 Apr 2022 15:18:26 -0700
Message-Id: <20220421221836.3935616-22-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220421221836.3935616-1-bvanassche@acm.org>
References: <20220421221836.3935616-1-bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1nhf94-0002xJ-K9
Subject: [f2fs-dev] [PATCH 21/31] fsck: Remove a superfluous include
 directive
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fsck/main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index b555ff4dbee7..fc776eb0af1f 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -32,11 +32,6 @@
 
 struct f2fs_fsck gfsck;
 
-#ifdef WITH_ANDROID
-#include <sparse/sparse.h>
-extern struct sparse_file *f2fs_sparse_file;
-#endif
-
 INIT_FEATURE_TABLE;
 
 static char *absolute_path(const char *file)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
