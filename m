Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB11C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Apr 2022 22:19:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhf9H-0005YD-T5; Thu, 21 Apr 2022 22:19:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bart.vanassche@gmail.com>) id 1nhf9G-0005Wu-3A
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oa5IQm6l/sMEGzxjZtwXaCo3ggykKuEaf+bTKAZ1S1E=; b=fTEDOOM34i6YPZt0hUfrjjeCKq
 ha9X4J7omu2ybQsPeav4kG969wpLxO3PzOjyYotN7CAkTorm/M2xwKNzGPHPJhut7++XCtorTDObe
 2MR4Fq2ZnSV9dRv+3dibcrvi7uZt2fqlPzVz0/o6rICXTqBX9nXVhXAkpE46rGt6c3ZA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oa5IQm6l/sMEGzxjZtwXaCo3ggykKuEaf+bTKAZ1S1E=; b=lYm8sR/XM+d2B/wkkZ6sdx8xbI
 YAnfsgzO+DjZTKpex4wAWZxscDoDbRh9thvT3yqR3HdtkqwKE0wL0qd6/2JabGqE8Iah+ty+vP7A7
 wMIzuNmOAtuzMbsHJZ5+wnmMXMH3k3+FNQXA7tw1bPe6JKu17eeo8XlZp5T0DSf+IgjI=;
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nhf9G-005sTK-Ef
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:38 +0000
Received: by mail-pl1-f175.google.com with SMTP id u15so3384502ple.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Apr 2022 15:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oa5IQm6l/sMEGzxjZtwXaCo3ggykKuEaf+bTKAZ1S1E=;
 b=65AfoEgThRb1X3PqpHoG7dQJuQn8t8Kv13xjeEvbY1o/GqFbOQKDTXGfE6ICosj5q5
 2OHEWDLUxm7+BXntV2KkyN8d5KpO8HlEKhkibCH2CjAUEhn1QqH+CMVRIFoYkGib8Bes
 Pg7xtEQpDI4BrnQbRXyP4ckHfQjJC343cNCFhllxQZRRffJWuA3Ge+LJXD7+z7UUCsHK
 2jjqZ0/dkhZbTrutA3QDeTnvmYCEuAo6OsWzMmf6IjCoG0t9wz4k58wIQm4LSA7ZgLwH
 saH8z1dsJ/nSIScezs+Sahfa1sFOr8TcC6lh/R7rc7b/V8v1kKQPPPTn3NPkHTKpL2Ko
 He4g==
X-Gm-Message-State: AOAM533U9zCd6LLk0y1hoCWyg7vca+nt/prROU8+64ZVyPy7/NJRgAjb
 5eH3tJR2pI1+ba110DPCkzk=
X-Google-Smtp-Source: ABdhPJzBaX44ZsMUCbFWhCBfN+mKYB9l067upNKI+s8vSm4s282RoUxSW7RbH5DPQugag1T/4LZbPQ==
X-Received: by 2002:a17:902:7009:b0:158:3bcf:b774 with SMTP id
 y9-20020a170902700900b001583bcfb774mr1522171plk.103.1650579572889; 
 Thu, 21 Apr 2022 15:19:32 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:a034:31d8:ca4e:1f35])
 by smtp.gmail.com with ESMTPSA id
 hi21-20020a17090b30d500b001cd4989ff4csm3794876pjb.19.2022.04.21.15.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 15:19:31 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 21 Apr 2022 15:18:34 -0700
Message-Id: <20220421221836.3935616-30-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220421221836.3935616-1-bvanassche@acm.org>
References: <20220421221836.3935616-1-bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1nhf9G-005sTK-Ef
Subject: [f2fs-dev] [PATCH 29/31] Support cross-compiliation for PowerPC
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

Some PowerPC cross-compilers have the uuid.h header file but not the
uuid library. Hence this patch that causes f2fs-tools only to use the
uuid functions if both the uuid header file and library are available.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 mkfs/f2fs_format.c | 2 +-
 tools/f2fscrypt.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index ce7d1c9e40bd..60a6b15af8ec 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -22,7 +22,7 @@
 #include <time.h>
 
 #include "config.h"
-#ifdef HAVE_UUID_UUID_H
+#if defined(HAVE_UUID_UUID_H) && defined(HAVE_LIBUUID)
 #include <uuid/uuid.h>
 #else
 #define uuid_parse(a, b) -1
diff --git a/tools/f2fscrypt.c b/tools/f2fscrypt.c
index f2fbf0bf3878..37c791e52e7f 100644
--- a/tools/f2fscrypt.c
+++ b/tools/f2fscrypt.c
@@ -356,7 +356,7 @@ static void parse_salt(char *salt_str, int flags)
 			perror("F2FS_IOC_GET_ENCRYPTION_PWSALT");
 			exit(1);
 		}
-#ifdef HAVE_UUID_UUID_H
+#if defined(HAVE_UUID_UUID_H) && defined(HAVE_LIBUUID)
 		if (options & OPT_VERBOSE) {
 			char tmp[80];
 			uuid_unparse(buf, tmp);
@@ -384,7 +384,7 @@ static void parse_salt(char *salt_str, int flags)
 				(((unsigned char)(h - hexchars) << 4) +
 				 (unsigned char)(l - hexchars));
 		}
-#ifdef HAVE_UUID_UUID_H
+#if defined(HAVE_UUID_UUID_H) && defined(HAVE_LIBUUID)
 	} else if (uuid_parse(cp, buf) == 0) {
 		salt_len = 16;
 #endif


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
