Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40491C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Jul 2022 03:31:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oDHU3-0005E5-8i; Mon, 18 Jul 2022 03:31:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <qxy65535@gmail.com>) id 1oDHU1-0005Dy-ON
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jul 2022 03:31:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gxsRO0ngre/s5qV9cZCyz4/oIa9KN/kzIjt87eVjDT8=; b=VuHcr80P93cUAhQd3RP8Fwx+iT
 XjKmVbGEGk0zPx8eLn3rJfJwb+aFxe64l3GK6zMDdBY3D2RAxJti32IOoCdg6dftktwFg5ZMCMSeY
 6/ZiUB8rqpoRFwr/OvdRfvKYQwGqJgkpRolFO0fafztqceMSnmb+5+ekIgVeYWqAjWAI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gxsRO0ngre/s5qV9cZCyz4/oIa9KN/kzIjt87eVjDT8=; b=l
 QcgtdRcgxcnTeqf5ke1fJ1ATnOgRZ3Ia6+JbEg+3c9a9GQRoljnl7CEt9RbapC+EBmc8YcKUMEWqB
 YBSazm1YZsSYX+G70YbLhVPsW1qXRHWK4NvYE5tgH0fSfVLZHVkTUXl5lZlyUCo2YQydaLxOKbe0c
 tzLXr2hemkxhB3x8=;
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1oDHTx-002JsX-AA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jul 2022 03:31:45 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 cp18-20020a17090afb9200b001ef79e8484aso11624287pjb.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 17 Jul 2022 20:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gxsRO0ngre/s5qV9cZCyz4/oIa9KN/kzIjt87eVjDT8=;
 b=ZW2DJH6LJWwLfU3otFDA+R2+hJcTXzjEzanWBQi3SNf9OtgclKQ9Lcskr3TimMn40y
 ZyG5waqlQGyEgk+rL4vsc/Hf2pJIUY/ArpHusipj0RsrJKiMFgqzGtcVBgQ0dA628jKU
 4gwIIEuemwc49jIIwkL8iviDR1aVcDgJVJo+X8/OP2mXSf8FB4M1OvzctcrbZunWKnsx
 hDy1TQtXjFkpQbpiSM1teTveXC+LPjMlSgBw5dxrLSusFUhR5D1DBmskWBAmugUhYXln
 BUYBMey9FpPhE4bVxosD7yR1oxrPHJRnmqx/+84pEsXpFHO1leG2eH18Mw2jzHTV5656
 2eOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gxsRO0ngre/s5qV9cZCyz4/oIa9KN/kzIjt87eVjDT8=;
 b=BIMoO53ejikCKRGrUHWWDhVLBWwfawb5KZC/cYJbD+FUnWatbmeGncXEe36xYuZiHF
 xmiAPGLCX0l+z8lVlKRMOw03c6edciVPgaPo/2722AM/cr+IG7fDAd+DTAIOyNOBpa3F
 b7yGo6qOCdjtjp+CtYzPjhRG/i3u+w+GJ7kIGdx8hVYjTXbuoz8LW4tvAMJDSVi9jAE5
 Di1k+9gmqROAOtrAWaRXL5utsXFeE0NUFnLoeqDMjya+F4MaRehELjX7jFELSeQ3Ljp+
 v+LNYcG6c3ufbKzZE1ofrGqUqlt9CkQ2WvVkbnMgF5Z7Ro9rDd0m6d6EePce2KtRD2QV
 0WuA==
X-Gm-Message-State: AJIora88iyriKyQm/F6Y/wTOVgfB+dtNcFPlgbsVLvlwcTAfsP+f9D/q
 S2JSBifSQTq4Fg+DgRhUG55ySGx76LVz9g==
X-Google-Smtp-Source: AGRyM1ue50DGSdWhrau5aIcTUlkVONKZFxG4AkbLeM4hjyBkYC79TiJBBzqEqDDzUxS1arlNZd7n6Q==
X-Received: by 2002:a17:903:4094:b0:16b:df0e:6312 with SMTP id
 z20-20020a170903409400b0016bdf0e6312mr27548746plc.61.1658115095731; 
 Sun, 17 Jul 2022 20:31:35 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a170902d1d300b0016c57657977sm7999221plb.41.2022.07.17.20.31.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Jul 2022 20:31:35 -0700 (PDT)
From: qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Date: Mon, 18 Jul 2022 11:28:40 +0800
Message-Id: <20220718032840.9653-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1oDHTx-002JsX-AA
Subject: [f2fs-dev] [PATCH] f2fs: don't bother wait_ms by foreground gc
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
Cc: qixiaoyu1 <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_gc returns -EINVAL via f2fs_balance_fs when there is enough free
secs after write checkpoint, but with gc_merge enabled, it will cause
the sleep time of gc thread to be set to no_gc_sleep_time even if there
are many dirty segments can be selected.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 fs/f2fs/gc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d5fb426e0747..cb8ca992d986 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -150,8 +150,12 @@ static int gc_thread_func(void *data)
 		gc_control.nr_free_secs = foreground ? 1 : 0;
 
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi, &gc_control))
-			wait_ms = gc_th->no_gc_sleep_time;
+		if (f2fs_gc(sbi, &gc_control)) {
+			/* don't bother wait_ms by foreground gc */
+			if (!foreground) {
+				wait_ms = gc_th->no_gc_sleep_time;
+			}
+		}
 
 		if (foreground)
 			wake_up_all(&gc_th->fggc_wq);
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
