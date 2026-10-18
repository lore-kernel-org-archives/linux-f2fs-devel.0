Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B9ECCF2C9
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:To:Date:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S8xzOyhxmSJuslsAhLkcogB7J0wX8/7Nai70hT/N9wY=; b=NDnrqQEqXNPoNdz2Qdc8eJbQkl
	l2WvCJbtCn4vaPnouGcm8Za6Kuh72N/bHf1Cem9mKxUtRO8Q48/jsxK2WzCgcfEO7b+grs9cVzalP
	Am6oSKSpBM6xn0ZI7jhbDPh4zSWBh1hYr63RddcMcDPxfgePwk1oMU2XNFWRskISkvaA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xISTm-00034a-Sl;
	Sun, 18 Oct 2026 15:07:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <geldot@protonmail.com>) id 1xISTl-00034U-QD
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Subject:From:To:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/cJA3RKeqv0jFyGu2hsEX9aFji5apbKtg7bIPWM3ksc=; b=lgonMA7kl4kzaaqoV7+MBZWa1o
 UEHn+EibGwCFJoJya2TGGH6X2EOMnO/b38z2F8VcWv4h0g2XqK+zaUiH150Bwe93ekJufcaJUBli9
 keIjEm9UlA6tp8wCevxaGLxpdvsStWxbqSznVT8lEKOdcwElvw/KecqwfoV62yOg0Z4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:
 From:To:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/cJA3RKeqv0jFyGu2hsEX9aFji5apbKtg7bIPWM3ksc=; b=B
 LDZvWhD5dzD46Nldh9jMbaK+eYiRinUSO23aE3sxkez9QiDv2InhdB3EId4q1xjXdZv2CIfNT09vC
 cfygLQqd8hmgkchlibEcasRD0JPXxvjygJjkCt0tJ+K9qEuVX54hGzRB6YXi1F2mtN/KUYh84Htx7
 0P9WIS2DehK4ybnE=;
Received: from mail-24424.protonmail.ch ([109.224.244.24])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xISTl-00010p-Ql for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792336030; x=1792595230;
 bh=/cJA3RKeqv0jFyGu2hsEX9aFji5apbKtg7bIPWM3ksc=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=oPsNMMR6tOXCsdXo1aFL1n4c0l31V2uYSuASQouhC++rGHUXNLCzkCvo63VAxRYCW
 qVek36BpxMnM43ZDVCx9NyxmCSTIuXjIGeKiFd+K3ygeHXwN3Pu5aLxtVc7QiS7tl9
 RH/p7xa0j+AXcDlN/sReWvSs6pb1AhkzvnZtUrIJWhqBsOy34/pZoqZuXPWuZsM9q6
 oMVFsh/dyFPOxP7rjdNCk9jr7RXKABkbfcFQOnEchoLtp7OeJHypCB7gL9QGXbV4w/
 5UZidJwBvExpS5RfAQj/cVVHunrWesLZVMhLlMOSYp4wJmi8Zdn4f8DeOjGJjYKJxc
 a/kHE+m+7GdZw==
Date: Sun, 18 Oct 2026 15:07:08 +0000
To: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Message-ID: <ebaZk7tbA9RElsM8ZlLlcgO-4okvuAioo-uh-w5S3rhYxqkBNRPyhTwd9U2vudXRC1RbRB0jG2Elk8sLinp-5IRsy9b1A14go_Ejo0o5Qeg=@protonmail.com>
Feedback-ID: 219410145:user:proton
X-Pm-Message-ID: a145499102decd397514dc99c688c85283ec6121
MIME-Version: 1.0
X-Headers-End: 1xISTl-00010p-Ql
Subject: [f2fs-dev] [PATCH] f2fs_io: add missing include
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
From: Gary Dotzler via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Gary Dotzler <geldot@protonmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This fixes the build with musl as used by OpenWrt, where falloc.h is not
included implicitly by other system headers headers.

Signed-off-by: Gary Dotzler <geldot@protonmail.com>
---
 tools/f2fs_io/f2fs_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 8b18c3a..8f96d55 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -21,6 +21,7 @@
 #include <getopt.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <linux/falloc.h>
 #include <linux/fs.h>
 #include <signal.h>
 #include <stdarg.h>
-- 
2.56.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
