Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D58CDE00B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jun 2026 03:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fs4dnyWK7FKEht7FkSIC/Ze7j8hdCDU+MEYRGUrck0s=; b=huEAJvDkIHEen+fErTT9woRn+n
	VfMpWBefYGYV5fV87ggkwb4bcsjKj/4pP40CnhXtDt47TygziCkUhaIMgKpS4v076PNCuu+ZKqAoD
	oSUTBjzGQ7H9Q9NjZ707OzZcBEj+xQuYSt+XZxS/xlP3JICF0VM6w8S07/up3Ih6qM8I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcwvA-0002JS-Ay;
	Fri, 26 Jun 2026 03:08:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1wcwuw-0002JA-JB
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 03:07:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z4o/+uzc41vKgJ19Dqul3fyR5EOnKFEN3eoQx2mbEsg=; b=gopMNHBcpawnGWi7uoIGEDHbHv
 iRuN7k8LZXEjAOnqCqW3znw/jabxLhjvUjxdpv+v1Omyb37CShvPuC/w+BkRM7KEy8wHzaaLDf6QZ
 5Y1NC2IhPr2dHxRs8jV9z0F0RvSP1BnWJvL9RX5lcK1jGdX7ABIRXBQ5gzog/2WC5Xd8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z4o/+uzc41vKgJ19Dqul3fyR5EOnKFEN3eoQx2mbEsg=; b=T
 pHy/w0ESIL666VT6dIjqPms2UuZ+9zDnuHtj2e7ka/Z0I92olqkjZ5ClUDfbvCArO9c0fQ8LV0haA
 4Ml570dv3xiPasd9SdP3JzGm8+TxQBlH59VdU2Usv6/FCLI/1etfuG+c24WtUmE3uI7DrIjie8MbW
 6Jz+lUuhgIoTcUDw=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcwuv-0000e3-Dj for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 03:07:47 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2c7f1db3ad4so4971075ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 20:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782443255; x=1783048055; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z4o/+uzc41vKgJ19Dqul3fyR5EOnKFEN3eoQx2mbEsg=;
 b=R9GGuogKS654g3WNTNBUvW7f80XAS1OSE4LxYZFQalytaGCWA56cb9dNRI6LO3UimV
 1qTlWxJt+gpjVL92Mx4Z/+jrGLdPSUTXOg/8OtZ+Ua9hTj0buh+G3TgX/hJzNWiohbwp
 NcPChZnErD5535QLXvleq07/qWXsZGkgH84T8M1NBos+uDxIXqfyrXRGxLPhLb1C3yXc
 d0nuLrzK/sDBbncrHqrOnvK896a14nEbZ9sPqcjlJ4oM8ZRY9s2pm/IO0PLFlpNVOGjr
 FJsG9/dt0klEo4TPiYO0KJ9hWw8r+/WwgURlNI3LsQbJW6EgGm+rVpMfqE0G4aFsgwzo
 2Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782443255; x=1783048055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4o/+uzc41vKgJ19Dqul3fyR5EOnKFEN3eoQx2mbEsg=;
 b=GyJHFuK5HGztZg/8blUPQ/2ISH+DFYM/XrVHUTncWABz/TtQPEMhFnZx8fwGu66PPc
 KGYY7IV646GuXTL4/dbN7NpNLpo40Qo3iab5ZehK9RlUdgX8s/aT8+CaAp41/xg/qnmJ
 dq5jVn2AOVFf4aoBm8UYkJYqf9V4Mx9Da89XTTh9QC8VgBVYuX7u2xsyrjHMMEdBDYqH
 5xV4FvRiKxto0cM9/pWYbhY7sdox4vEEZqFMiX2tylwgD+N11/aFxrWuGJ7q4xhyfZN0
 4gr4876mxGjpOSIyjHfXvaX+F8S4rXowrgDAdyzjIEiI4rZUCfdFj0phs6+q17Ua40mZ
 /rCg==
X-Gm-Message-State: AOJu0Yy6lriC0N/wCj//fOVQWay/HaIDazWHA0TefUZKvSCzX0V8XQrS
 fogwO5XHySknK6ckZqAfRVzIfO0aK9h6+pTlTWk3KELqSCsC043H0Ep8WWCQaw==
X-Gm-Gg: AfdE7ckQ3Vzh3S5BRRU5NdNto3lLV9K0+x9Vs1JQo5gRe9lTYaUoXmweOSrnFiYCFB+
 +nBlISA2wAogaLq2rUBCXWVNt6QK8h/i2iXcPyJR+1G6ruAYqOo53Q/E0A6HgCZ9/9Rwh0zW0ml
 yD4vWegnk5Z5cP+t+iC/4kFcsx59+IWe5eKYCbKUdA0uLqAKE2zF968SViKy6pgYQfvmPKq2KeH
 d8EIUfyoY5bOqokjdAK1vFvHAOvvpshSSPm/epG6RWlErYLZRLbewtM8su2VEvccd0UIhUlNsMk
 ozOJWaFe9cAauZqZCuj9ZYbAXm4DVx11ade7P/GowtsPv1WNNxrvLsLuvR6nfnI95VGkyP9KJvw
 U6DSan1YB2PmneR7+lXXDykJXtK0FPZKUBAWgYr7aN1EnxpqIlyaNIYxYxszmw+/Orb/LC2UcMb
 L/fIcfMiovbDChBtuTGjXzeTk=
X-Received: by 2002:a17:902:f693:b0:2bf:114b:924 with SMTP id
 d9443c01a7336-2c7fccdef3amr53480065ad.34.1782443255137; 
 Thu, 25 Jun 2026 20:07:35 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f65127a5sm30246155ad.83.2026.06.25.20.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:07:34 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri, 26 Jun 2026 11:07:28 +0800
Message-ID: <20260626030728.1364795-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wcwuv-0000e3-Dj
Subject: [f2fs-dev] [PATCH] f2fs: Remove unused curseg_segno() and
 curseg_alloc_type()
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
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The only callers of curseg_segno() and curseg_alloc_type() were removed by
commit 5a4fed7cd97a ("f2fs: simplify do_checkpoint"); both helpers have
been unused since then.

Being static inline functions they do not trigger -Wunused-function, so
the dead code has gone unnoticed.  Remove them.  No functional change.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/f2fs/segment.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b0c06b3580b4..33a2257da1e6 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -796,20 +796,6 @@ F2FS_IPU_POLICY(F2FS_IPU_ASYNC);
 F2FS_IPU_POLICY(F2FS_IPU_NOCACHE);
 F2FS_IPU_POLICY(F2FS_IPU_HONOR_OPU_WRITE);
 
-static inline unsigned int curseg_segno(struct f2fs_sb_info *sbi,
-		int type)
-{
-	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	return curseg->segno;
-}
-
-static inline unsigned char curseg_alloc_type(struct f2fs_sb_info *sbi,
-		int type)
-{
-	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	return curseg->alloc_type;
-}
-
 static inline bool valid_main_segno(struct f2fs_sb_info *sbi,
 		unsigned int segno)
 {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
