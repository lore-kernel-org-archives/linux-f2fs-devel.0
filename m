Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7BCC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Apr 2022 22:19:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhf8j-0001d6-Rc; Thu, 21 Apr 2022 22:19:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bart.vanassche@gmail.com>) id 1nhf8i-0001cx-CV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uSxNKbyqMf7hHVLx/ixngFPHFOFArYvNg9c8fV+82TA=; b=PZj926ueaStfKspnksKF3hjiAJ
 dl2O4aq7sjpANQpKIckr0ZWngy+r1KYI2sZlIJIFO7tSawfunQL4gdVlZxfQaPN76K9rPVfWUWlld
 witykKHhq9x7ZsXQQcP1TZitedudftAb0RL6MlgFrF/vDXfoP0S1cXwuitL82GnYJxX4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uSxNKbyqMf7hHVLx/ixngFPHFOFArYvNg9c8fV+82TA=; b=JcsRI6XpY16XPTk86qbMAgtUjb
 UtJvHO4/LTrGd1tC9ob5B5gEkulFalEWsbinJvGCt/+MbL434jdaLKZrM/QqCkUrGEpmXz+pvXRol
 NBYWpvNO3gOCw6www0taW8mwR5TSK/aPUyCHIM0O54ZE//SjJV0Z3vyJEuiA/MZjEWns=;
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nhf8c-005sOg-J7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:02 +0000
Received: by mail-pg1-f180.google.com with SMTP id q12so5765862pgj.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Apr 2022 15:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uSxNKbyqMf7hHVLx/ixngFPHFOFArYvNg9c8fV+82TA=;
 b=XG3IzQ1AzLsARXzGv6NL/0pQ5wYm2e6sPfew7XdxkexZQYPbMqTrODcnglIk2s2+eF
 gexDJXeIBvyoLzFpc3xKAe2c3o8gV81LeSbe0nbkSpLS6F15If3KHknKyPBhRaROdZf3
 V2pdzCXpWXktu7GiHb1DXXrraukkG71hap/2p+ifkb5+Yj0u/TgccHG/toyTDPsmU0AQ
 4WLT6h/s3t4QzlyGsFjzVNXq161H4osb90iKQdUsEf1gnhpxe4t6e76tHCwPkGMTs89l
 VgprN30H1PeWkrwaykD1xL7CA7Qr799p+NnoTMti9eiiN8GtBqtLMoTJPFdLyMLc4x5r
 6lfA==
X-Gm-Message-State: AOAM531wAoXVP61sR4k5m0EuL/86cYCS1YeSMjSpSTtmcWdzRpPMYsRz
 utcnPHAeB6NNiS1eITch+/7YWenc+fhVaQ==
X-Google-Smtp-Source: ABdhPJxc4ArC/H7ab+4Fca7MTHwI0aGf6q12sSsSN8qUYpJRKExouNwIY+PhV7vvhYbAZ2LH58BEsQ==
X-Received: by 2002:a63:2b0b:0:b0:39d:890a:ab68 with SMTP id
 r11-20020a632b0b000000b0039d890aab68mr1281885pgr.247.1650579533006; 
 Thu, 21 Apr 2022 15:18:53 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:a034:31d8:ca4e:1f35])
 by smtp.gmail.com with ESMTPSA id
 hi21-20020a17090b30d500b001cd4989ff4csm3794876pjb.19.2022.04.21.15.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 15:18:52 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 21 Apr 2022 15:18:08 -0700
Message-Id: <20220421221836.3935616-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220421221836.3935616-1-bvanassche@acm.org>
References: <20220421221836.3935616-1-bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1nhf8c-005sOg-J7
Subject: [f2fs-dev] [PATCH 03/31] configure.ac: Enable the automake -Wall
 option
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

This patch fixes the following automake warnings:

/usr/share/automake-1.16/am/ltlibrary.am: warning: 'libf2fs.la': linking libtool libraries using a non-POSIX
/usr/share/automake-1.16/am/ltlibrary.am: archiver requires 'AM_PROG_AR' in 'configure.ac'
lib/Makefile.am:3:   while processing Libtool library 'libf2fs.la'
/usr/share/automake-1.16/am/ltlibrary.am: warning: 'libf2fs_format.la': linking libtool libraries using a non-POSIX
/usr/share/automake-1.16/am/ltlibrary.am: archiver requires 'AM_PROG_AR' in 'configure.ac'
mkfs/Makefile.am:11:   while processing Libtool library 'libf2fs_format.la'

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index c908c9394613..b40012bd8745 100644
--- a/configure.ac
+++ b/configure.ac
@@ -33,7 +33,7 @@ AC_CONFIG_SRCDIR([config.h.in])
 AC_CONFIG_HEADERS([config.h])
 AC_CONFIG_MACRO_DIR([m4])
 AC_CONFIG_AUX_DIR([build-aux])
-AM_INIT_AUTOMAKE([foreign tar-pax dist-xz])
+AM_INIT_AUTOMAKE([-Wall -Werror foreign tar-pax dist-xz])
 
 # Test configure options.
 AC_ARG_WITH([selinux],
@@ -46,6 +46,7 @@ AC_ARG_WITH([blkid],
 
 # Checks for programs.
 AC_PROG_CC
+AM_PROG_AR
 LT_INIT
 AC_PATH_PROG([LDCONFIG], [ldconfig],
        [AC_MSG_ERROR([ldconfig not found])],


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
