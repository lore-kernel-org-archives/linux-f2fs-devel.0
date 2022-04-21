Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1D9C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Apr 2022 22:19:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhf8g-0005G3-3c; Thu, 21 Apr 2022 22:19:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bart.vanassche@gmail.com>) id 1nhf8e-0005Fx-Q8
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9BE9zcjyFUUXWMWK2sDDh38a85L/Y7g8rUAumUEL56w=; b=RAOfY2UiCbK0BpIzwKNbGFKcIF
 hdGAVblLhmNVTb1vCkGdxXHvoHCwCkxXve0Ji4Wb8YkZgvnNXd7bQaVd4q9cLcCEmVNnlusuiSXKi
 wduTbjS45qaH2JFi1GVqABwDvOa8R21QVgDyWCJJkXyaeUsBUZxY0V29/iojybR1Cu9A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9BE9zcjyFUUXWMWK2sDDh38a85L/Y7g8rUAumUEL56w=; b=Yn85MQDgy7046/fs/wHG2lqogc
 6g2gju839tAe0ylAAryAij0zwaYMtnRY0KSZEhVqp4mco4Z1Zal8STVZcCz0kFMsBggW2pafCXSsC
 T0hlJsOVPDMdffJQQ/hkkRQ1ykG5K6Unlr+wBpSFTlxYwzXXZ7Vvmbx4+fzk6bmciXZg=;
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nhf8b-005sOf-23
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:01 +0000
Received: by mail-pf1-f180.google.com with SMTP id h1so6228197pfv.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Apr 2022 15:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9BE9zcjyFUUXWMWK2sDDh38a85L/Y7g8rUAumUEL56w=;
 b=fD1MgZ0iEcnJIVGP5ZDPZ5zrdVm2Ba45WOmXlg78S869DrE5uZ49nv5yORnc/aT7bI
 3uIqzllNrARZdOxbQyB+rwYqfKO7gruHsYMW4GfL+WYUyhn+5tMvkReCu2KrW9CLs5AS
 a4iUnERkYZJmgGNauxDxrMDYfnqPYnFqWRV4XVfRZmJj8I5FMQ7JQ++eptrcfiHP2qml
 Eiwij76+n4tisFKdfVxVFZygBPCSWwyCGUp+BBb2ElxBLVz3qqE9g8oe4I0kf1egwPJI
 HZj89xcl8Hyd2koWsIo03DXh2lYgeHqe/2n3MJQ3I2drCNbw/hdQXXy6+uV0nNEAe9Ai
 1mNg==
X-Gm-Message-State: AOAM5336bnSswaA/XZFUmuaJtSpIvVS3xTpAYBYofpJQFz7I+0RnHal0
 4EXlj5N0S3ViFaPKj9fg7NqTDPSA72xaeA==
X-Google-Smtp-Source: ABdhPJwuuxt9NzsGXNh3nYUK6iYFydzfAwQ1sz3LKsgvwGgwUCs21OB06xtT+mN39O0TqWrk0SAm7w==
X-Received: by 2002:a63:ad4d:0:b0:378:4b82:b881 with SMTP id
 y13-20020a63ad4d000000b003784b82b881mr1368257pgo.282.1650579531493; 
 Thu, 21 Apr 2022 15:18:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:a034:31d8:ca4e:1f35])
 by smtp.gmail.com with ESMTPSA id
 hi21-20020a17090b30d500b001cd4989ff4csm3794876pjb.19.2022.04.21.15.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 15:18:50 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 21 Apr 2022 15:18:07 -0700
Message-Id: <20220421221836.3935616-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220421221836.3935616-1-bvanassche@acm.org>
References: <20220421221836.3935616-1-bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1nhf8b-005sOf-23
Subject: [f2fs-dev] [PATCH 02/31] configure.ac: Remove two prototype tests
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

Since no code uses the HAVE_.*_PROTOTYPE macros, remove the code that
sets these macros.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 configure.ac | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/configure.ac b/configure.ac
index f906be780eb2..c908c9394613 100644
--- a/configure.ac
+++ b/configure.ac
@@ -146,31 +146,6 @@ AC_CHECK_FUNCS_ONCE([
 AS_IF([test "$ac_cv_header_byteswap_h" = "yes"],
       [AC_CHECK_DECLS([bswap_64],,,[#include <byteswap.h>])])
 
-dnl
-dnl Check to see if llseek() is declared in unistd.h.  On some libc's
-dnl it is, and on others it isn't..... Thank you glibc developers....
-dnl
-AC_CHECK_DECL(llseek,[AC_DEFINE(HAVE_LLSEEK_PROTOTYPE, 1,
-			[Define to 1 if llseek declared in unistd.h])],,
-			[#include <unistd.h>])
-dnl
-dnl Check to see if lseek64() is declared in unistd.h.  Glibc's header files
-dnl are so convoluted that I can't tell whether it will always be defined,
-dnl and if it isn't defined while lseek64 is defined in the library,
-dnl disaster will strike.
-dnl
-dnl Warning!  Use of --enable-gcc-wall may throw off this test.
-dnl
-dnl
-AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
-		[Define to 1 if lseek64 declared in unistd.h])],,
-		[#define _LARGEFILE_SOURCE
-		#define _LARGEFILE64_SOURCE
-		#include <unistd.h>])
-dnl
-dnl Word sizes...
-dnl
-
 # AC_CANONICAL_HOST is needed to access the 'host_os' variable
 AC_CANONICAL_HOST
 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
