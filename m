Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0049AC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 May 2022 17:53:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1npZTU-0003xs-DG; Fri, 13 May 2022 17:53:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1npZTR-0003xl-3l
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 May 2022 17:53:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4JJmcNVs8K3zCtZFx7b/T6GviXKVCpbPhp6FKDyoJKI=; b=VKgexwaT1vGlM046JXKhxPwRec
 KsRQHAI0RaZnAFHVGlT3Mww/BO9XsRiWpyFBkruhF+I2u4nK7iBf1aN98qqC+7rIqe9tcbsi/fJd1
 8/GgYsYRxNKCq1TqZvJxgko9hhVdYnC6JE8UgtYW1zdt7hr/rPcMXdgGA+Q8x4ADsV/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4JJmcNVs8K3zCtZFx7b/T6GviXKVCpbPhp6FKDyoJKI=; b=A
 ZZ4T0wUBpRvqcln/HV8vSMK5VXa0XqG+gU7DiLG3TOQiL4XETKMRVROV9hsEM+hmLZzK+54yD2437
 SQVQ7ijY4jTrd395UYz/NEgHTnj6ebK8qjsbUxeE5zTY5KmOudTmG6ixpB5yim1wRxwXMAvVIuI+J
 dYIP2yR3xC6DOKas=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1npZTM-00B8X0-Vy
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 May 2022 17:53:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B4B7FB8311C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 May 2022 17:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DE2C34100;
 Fri, 13 May 2022 17:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652464372;
 bh=WnpFCIBW+5Di+eAXnkdLhSoqrr3dp6aWAhPTP+Ieyco=;
 h=From:To:Cc:Subject:Date:From;
 b=nLoBmKY978kMghIEceEXIaLMdec0DguDZOgnFCaRUDCqij3MdsHoEEnwGiE0rhC5g
 +iwf/YCddGX45vqLW5+uPGlpanRgoUgKmwD1Ht9G1NtESUuiZ1+gwp+jBnRtoQ2Fny
 WTgn2mV/SBntjAaFh3+tmQM3vfYVINWL7MlI3dXdN4sa8/a6VNcAtrU4ud27mIFEml
 u+nqQJOgURh3BZPAa9q6MJHVb8q2O8zT+gYFQhIEEWTrRyfu1NbeuTb/hlwcDbHhzv
 rwJi7lWjs5CcogBSP5Na22JiTzFLtvcucf1m0IyspyoAGcCmBa8R9NClZxClLf0/hI
 m6WnEGrJGBr+w==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 13 May 2022 10:52:49 -0700
Message-Id: <20220513175250.184032-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
X-Headers-End: 1npZTM-00B8X0-Vy
Subject: [f2fs-dev] [PATCH 1/2] f2fs-tools: build silently
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
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index e8ce0057c4ff..cfcc405b5f21 100644
--- a/configure.ac
+++ b/configure.ac
@@ -12,6 +12,8 @@ m4_define([f2fs_tools_gitdate],
 AC_INIT([F2FS tools], [f2fs_tools_version],
 			[linux-f2fs-devel@lists.sourceforge.net])
 
+AM_SILENT_RULES([yes])
+
 AC_DEFINE([F2FS_TOOLS_VERSION], "f2fs_tools_version", [f2fs-tools version])
 AC_DEFINE([F2FS_MAJOR_VERSION], m4_bpatsubst(f2fs_tools_version,
 				[\([0-9]*\)\(\w\|\W\)*], [\1]),
-- 
2.36.0.550.gb090851708-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
