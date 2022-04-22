Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50D0C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Apr 2022 21:18:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ni0fv-0005lA-R5; Fri, 22 Apr 2022 21:18:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1ni0fu-0005l3-SP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Apr 2022 21:18:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/VsDqv8CUYiQniMmi/Q3mivFf4hGo+5aXLI2+Txtyww=; b=fppuEgr6YEAmtwB7FIIzej2IiQ
 g0PW0VsNR5ot9qD0wwdMUGmzwcq4a+wOt15PHG9zGyTbm6DRhilKSwm33TryOFNeEohyKwRkX5T6d
 ZB2wZeHaOMj1epvZf/sasCjBWtTDaBHri+qIXGrQG3EnVyRcsP0kmzKrjsP9xxwXPvO8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/VsDqv8CUYiQniMmi/Q3mivFf4hGo+5aXLI2+Txtyww=; b=ChSC8QEpTDIBFDKWHQkajwglML
 R+6i8FxSkoDwB7+c5l5ROL1j+49cUIojeYoDcjYMVWweVuqjmvTugCmicQGo4lMs5ZHVniRxAqQ7N
 5dWL8ffAQ0/GinjD5aAkGenkKc39UQBDR9ehTJnLHPVzCvV6zC9cSIZBCIOTG7ynjl8g=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ni0fp-006rCF-8G
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Apr 2022 21:18:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EA8BDB8327F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 22 Apr 2022 21:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC7AC385AB;
 Fri, 22 Apr 2022 21:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650662308;
 bh=8E6zV0akEeu60JdtFqO+55vTYrnhKhiFpo0oCLnfrvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e6pjBYBMScyqGp4U3s7ObcBFKYLX6xlf3ir5CHJg5K1E4Q8/xNYYeiP3vfuyUDX1d
 bRhUD5O28WxIlKbO3palWpltkA+mrddjlCxoIVYB3B7NO9wQVbp3BF3yJX+isySxDX
 YU1d1gKTKEsm3zV+lPp8s2rngvwNQqGzr8c063w7ejQm20pmHALHwPmzNMzoZJBPsz
 pt/GewQYv7RT6oUXP+ZjZHKuo7zP5+gP/kKsucdACSS2suRMGtV0RhoVOIVujrcCFb
 qy3zVslPPS0lhJ0EQaJCvfZvGMbYczV0XJ7AOoeGamZpBhJFpig+rLac1FKU+e63kE
 1ydM+WLyWKbvw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 22 Apr 2022 14:18:18 -0700
Message-Id: <20220422211819.2230879-5-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220422211819.2230879-1-jaegeuk@kernel.org>
References: <20220422211819.2230879-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1ni0fp-006rCF-8G
Subject: [f2fs-dev] [PATCH 5/6] f2fs-tools: use android config only if
 there's no config.h
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index d6374270c188..b821b8279f82 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -26,10 +26,10 @@
 #include <stddef.h>
 #include <string.h>
 #include <time.h>
+
 #ifdef HAVE_CONFIG_H
 #include <config.h>
-#endif
-
+#else
 #ifdef __ANDROID__
 #define WITH_ANDROID
 #endif
@@ -43,6 +43,7 @@
 #define WITH_SLOAD
 #define WITH_LABEL
 #endif
+#endif /* HAVE_CONFIG_H */
 
 #include <inttypes.h>
 #ifdef HAVE_LINUX_TYPES_H
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
