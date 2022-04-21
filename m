Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1981EC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Apr 2022 22:19:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhf9E-0005Vu-MN; Thu, 21 Apr 2022 22:19:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bart.vanassche@gmail.com>) id 1nhf9D-0005VD-GW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cgoqWW5CSr6T4mRzkGb4HkqpLklagpEa7LFpXWS5/tI=; b=fSaTEntncAisXJTdS06obFy1aq
 u3oD/5fWfxj0u/9OetbnVL9uSvZmDY2gwBTaFH9iDE/uqSgJaukv5s3FezEN0ijnW7oUOKsyDLbmY
 WqcfaYYdin4XQqmjRbH9GFKgYqpXTfMNAQeA0+gN/s6/14/3rJ3fVjlz3ek+JI+RGaK8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cgoqWW5CSr6T4mRzkGb4HkqpLklagpEa7LFpXWS5/tI=; b=AI56hwOeu241Kz3nq6HtP0/Ijx
 kGdOSTaQek76+EvC+O6KEx03NdftAR31DZsGLdgJu1zXBca9GxcmBSHFpjZKkGUxsmUh8VQLWD5Tj
 rowgfHO6+DDsf8krQ1fFubeolfTxeyAQn82KeKvvaWWbCDo+lrP7RGvXaaqX6wgI7k5c=;
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nhf9D-0002yB-KK
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:36 +0000
Received: by mail-pf1-f172.google.com with SMTP id j6so3917831pfe.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Apr 2022 15:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cgoqWW5CSr6T4mRzkGb4HkqpLklagpEa7LFpXWS5/tI=;
 b=QUAGmLF3ylCaGzWndnADIuVVnetNV+zhuo54gSM2ONU7kuluRgaFE9DtrNqd0DCXnj
 8WSYjcHbVihA38jHa8oK5nSGzcmG2OXiRWu0vRqz0nGK2/b6Ke747LftN/g8l8MZ7Psw
 KfW6C4hlImC2tSYI3skph2co5IHJ+Kc9P6AAF4Yr1T0Huu/FRbDr2WeYduksSGzFCVvk
 RfkZEhx90d8/A+w+5C1wXcK8BGCJvsutddGsqSqfxqXnxv/uBEJ7Y35fL7IzePvvuCpd
 gxfydSsJXi1nX3+MbvthW7FotpSGvUOGxbld+ChUEWZUxRT1eZHnRFVMoU71MIyJswR4
 ti6Q==
X-Gm-Message-State: AOAM532vl0kuLHY2rXm9nfK0shtzPhouimKSs8smevkjyJuFpZkVl4xh
 c4PgKVlWyILv10edQqBB4/s=
X-Google-Smtp-Source: ABdhPJxo9JolAC7OKToFN0UA0UktCpNgrjmqNMKK03BAo5nimuPRSR2T2giu/72gENG9WZCtjSkdqQ==
X-Received: by 2002:a62:a504:0:b0:50a:ceee:5f4 with SMTP id
 v4-20020a62a504000000b0050aceee05f4mr1839815pfm.13.1650579570003; 
 Thu, 21 Apr 2022 15:19:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:a034:31d8:ca4e:1f35])
 by smtp.gmail.com with ESMTPSA id
 hi21-20020a17090b30d500b001cd4989ff4csm3794876pjb.19.2022.04.21.15.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 15:19:29 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 21 Apr 2022 15:18:32 -0700
Message-Id: <20220421221836.3935616-28-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220421221836.3935616-1-bvanassche@acm.org>
References: <20220421221836.3935616-1-bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1nhf9D-0002yB-KK
Subject: [f2fs-dev] [PATCH 27/31] Annotate switch/case fallthrough
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

Just like in the Linux kernel source code, annotate switch/case
fallthrough.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fsck/fsck.c       | 1 +
 fsck/main.c       | 1 +
 include/f2fs_fs.h | 6 ++++++
 tools/f2fscrypt.c | 1 +
 4 files changed, 9 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 798779cfaf8a..19a28b0eedad 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1669,6 +1669,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, int casefolded,
 				switch (ret) {
 				case 1:
 					fixed = 1;
+					fallthrough;
 				case 0:
 					child->dots++;
 					break;
diff --git a/fsck/main.c b/fsck/main.c
index 8676f17555c5..aef797e98405 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -370,6 +370,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				exit(0);
 			case '?':
 				option = optopt;
+				fallthrough;
 			default:
 				err = EUNKNOWN_OPT;
 				break;
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index dd62bc89a926..73dc48e25ec0 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -73,6 +73,12 @@
 #define static_assert _Static_assert
 #endif
 
+#ifdef __clang__
+#define fallthrough do {} while (0) /* fall through */
+#else
+#define fallthrough __attribute__((__fallthrough__))
+#endif
+
 #ifdef ANDROID_WINDOWS_HOST
 #undef HAVE_LINUX_TYPES_H
 #endif
diff --git a/tools/f2fscrypt.c b/tools/f2fscrypt.c
index 293173fcb5b4..f2fbf0bf3878 100644
--- a/tools/f2fscrypt.c
+++ b/tools/f2fscrypt.c
@@ -726,6 +726,7 @@ static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
 			break;
 		default:
 			fprintf(stderr, "Unrecognized option: %c\n", opt);
+			fallthrough;
 		case '?':
 			fputs("USAGE:\n  ", stderr);
 			fputs(cmd->cmd_help, stderr);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
