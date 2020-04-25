Return-Path: <SRS0=bJRN=6J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DBDC54FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Apr 2020 13:19:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E97206D4
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Apr 2020 13:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="J02XVOXi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="h3fPlJSg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho9UpzCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E97206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jSKiM-0003YR-Lh; Sat, 25 Apr 2020 13:19:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <nishadkamdar@gmail.com>) id 1jSKiL-0003YJ-8s
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Apr 2020 13:19:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DNsgVTOEmh9ABmuJgNs+R+ip51/i8Ff9/P8faGUFA8U=; b=J02XVOXi2vYjTXlw8JqGfkIxHi
 a4qHTZ401b6N4Ws8a9yvFfRjbdXPrOqH+MV7cy1I06IdwT1rgoEuJonxJsSpdSw05Fn2xZCVvZ4KF
 XKVQvGGppR70eAD+K8vQvoap/YPH5mHggsa/AP88FguCAhKcQxQLx8Wo4yaSv3+63USY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DNsgVTOEmh9ABmuJgNs+R+ip51/i8Ff9/P8faGUFA8U=; b=h
 3fPlJSgbaM7qYyico3SvwIQeC/Wyb5FYtUFz29HCmPL/8mv8oi5+APQGfimW6TfINlhAOmMrb0Qgw
 asSk2BOSoK/xm1yZJLbjqZ6xwXkj6dNXf13R4zm6P0dmNtOYMmrmSpqXDZKXnb9sOQKPdMaw41e2k
 5eZoyr1c8KgMEg6U=;
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jSKiH-00AWmc-GE
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Apr 2020 13:19:25 +0000
Received: by mail-pj1-f68.google.com with SMTP id a5so5078556pjh.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Apr 2020 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=DNsgVTOEmh9ABmuJgNs+R+ip51/i8Ff9/P8faGUFA8U=;
 b=ho9UpzCBsRmIGDj5K/xKj/NLskahiBGJzr+KD0wxxebucuGS072Y24sCfKth8oHWCK
 UxqehHqZ5kFyRrxQdVogJS6ExcmqqalCDIpFABzXDtLIZk26MiNbU/eC7AHOgGl059e7
 D3xFrBjlqbDJRlbGv9/trSw/6UD+7w1gpIzwE0OmZ1uytjZpU4VqCthHflSeM6741GJV
 KBJqUrDL0Iq5KLnJnVSacumf+thWz1SOlKsGXrs1dpbo54yA/A7m14rphsflGbc3w8lK
 MehDBNZpfmY+8N5/2E9GwAZDtnMdUBhjNXvCliwyowFmbU1gzLjB2dWlS/8kGIdjUfuh
 oY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=DNsgVTOEmh9ABmuJgNs+R+ip51/i8Ff9/P8faGUFA8U=;
 b=q7HMqiXhXqwhS5KvwuSpmBFOGEwZY8vGurJDZj0AeR8UUzJ7yECpTgHBG2oVXhmrDU
 hdPRaVup2pm4EMSgCj/96P149xkHTSKDJbTNN9dhSsCimucbQBSHpTNpxAsMkfudZ0K1
 E4S0Zs+fDbXm+oumLeK8QeGYPF3YTCKe1ThHnBkniUX+poP8ZaXcc0//k6iifoYMgt7Y
 5MAW2fcnrpYFzYpt2xB6qBcIMp8Q1x3wIQ8zEiVyjhHlgAIF2EjcdcM2dLgwJQ/SJ/q3
 igEwSHpxCSC+Z8lMx5IW/nJQ/NvRjqSS33xiBIkr/GeQDomvlt2E36sVI1cu4Dy7v/N7
 a+MA==
X-Gm-Message-State: AGi0PuaXvQnTta+G8XS1lgDOt0OJneckR4ahh6qEeSoDiIzEtQSi5Rop
 Iw4FsADAY+/oof1vhiy54KA=
X-Google-Smtp-Source: APiQypJUrnRM8Ie5Cd30fqcFl5PV4Nsvh4bEOA8rA8JA3YRv7uzzPi2x+gNVN2LSS1vc2Ao7lfEf0w==
X-Received: by 2002:a17:90a:f68d:: with SMTP id
 cl13mr13019959pjb.107.1587820755679; 
 Sat, 25 Apr 2020 06:19:15 -0700 (PDT)
Received: from nishad ([106.51.232.103])
 by smtp.gmail.com with ESMTPSA id a22sm8158562pfg.169.2020.04.25.06.19.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 25 Apr 2020 06:19:15 -0700 (PDT)
Date: Sat, 25 Apr 2020 18:49:08 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Joe Perches <joe@perches.com>
Message-ID: <20200425131904.GA9623@nishad>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Headers-End: 1jSKiH-00AWmc-GE
Subject: [f2fs-dev] [PATCH] f2fs: Use the correct style for SPDX License
 Identifier
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch corrects the SPDX License Identifier style in
header files related to F2FS File System support.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 fs/f2fs/acl.h     | 2 +-
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/gc.h      | 2 +-
 fs/f2fs/node.h    | 2 +-
 fs/f2fs/segment.h | 2 +-
 fs/f2fs/trace.h   | 2 +-
 fs/f2fs/xattr.h   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index b96823c59b15..124868c13f80 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/acl.h
  *
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0f7753173e19..5c7a499a6d36 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/f2fs.h
  *
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index bbac9d3787bd..db3c61046aa4 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/gc.h
  *
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index e05af5df5648..6a2011deea23 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/node.h
  *
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7a83bd530812..cba16cca5189 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/segment.h
  *
diff --git a/fs/f2fs/trace.h b/fs/f2fs/trace.h
index e8075fc5b228..789f6aa727fc 100644
--- a/fs/f2fs/trace.h
+++ b/fs/f2fs/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * f2fs IO tracer
  *
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 938fcd20565d..6a192e6c7a9e 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/xattr.h
  *
-- 
2.17.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
