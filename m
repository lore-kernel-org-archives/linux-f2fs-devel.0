Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9B6C25B10
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 May 2024 15:41:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s6Xo6-0003Mc-HE;
	Mon, 13 May 2024 15:41:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nathan@kernel.org>) id 1s6Xo0-0003MQ-9x
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 May 2024 15:41:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z/JWQ9FfacxNVZh0aVHqIXKv3WHxaTQP5fbX9inwGy8=; b=K2DJ9tIadJnJqFiS5LzStEkD9w
 uMuxG+EOZaJat3jVBhVt09YsI8u6cVk8ng2fOYpuV7YXmED9B77Q9Tn+dQj26SGkGTI1wY2oGV47i
 UF+qPCpsZ+dNqkzIFs0ENiI/8QczU+DaM1Vuo3bgfulAgU17TCLa2TrClAu+gB4THQRA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Z/JWQ9FfacxNVZh0aVHqIXKv3WHxaTQP5fbX9inwGy8=; b=g
 MvRDWe3kDPY62XOKYUUsGRcyN3ngPtlWl7knT99AcClF7wR8TrcEWmwKYLiGF8DLvbh88osGbV3+0
 Yu9JqTzZ3V2OnKgB54CTONp4qcCB9z9dfZ0kcIO1cp/mFYGy3MlNrMcRuUn7TLhq99ULvfFF8iwUM
 53jYIIQaMd9/DCMA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s6Xnz-0002ND-Kc for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 May 2024 15:41:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8137CCE0F80
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 May 2024 15:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CBAC113CC;
 Mon, 13 May 2024 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715614838;
 bh=dRf1wpTYcfdxHsutpWJSXKMZr7IAOjWboVwaF2rz86c=;
 h=From:Date:Subject:To:Cc:From;
 b=Dfzfv0AyKyq8OMQXpwoGft1iuXOqN6CMSaWQd7wjz+sTvG3X97PAzx48lhUr/U4vW
 eUCq6FgmRL4GwWKR9l9NNwdLxpl1TZyS22k2IVn1dn+sjacIEsRxhw1J8/U552XNSU
 eEEMbhzDjBGWp4NCCRp0+c3VgNn/gl4MG7gpFbv9AFRn7ojJep1fhsPFFMoQdeysPq
 cTG1nSuJp7WVgSrXQOUx3Qz+Ev2G1221xwcRHQ/BV94TCZ80GzilNYP5v9k+3rZ5FF
 YVZTGpdSQCBO53FtEM6BaqLEBG/C16fFDLxFT8BK8k+UHHVYTdI7OSPy1g3Cbj7Heh
 rYIssbO9f6vFQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 13 May 2024 08:40:27 -0700
MIME-Version: 1.0
Message-Id: <20240513-f2fs-add-missing-inline-to-f2fs_build_fault_attr-v1-1-c3ce1c995fa2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGo0QmYC/x2N0QqDMAwAf0XyvEDsLLL9yhils6kLdHU0dQzEf
 7f4eBzcbaBchBXu3QaFf6Ky5Ab9pYPp7fPMKKExGDID2f6K0URFHwJ+RFXyjJKTZMa6nMq9Vkn
 BRb+m6nytBQ2N3tJ0G4kstOy3cJT/uXw89/0AO0//ioIAAAA=
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=nathan@kernel.org;
 h=from:subject:message-id; bh=dRf1wpTYcfdxHsutpWJSXKMZr7IAOjWboVwaF2rz86c=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGlOJmXXtls2ay3XvJ+62Xf+9k/Tjxr3WZ5dr3psz3NV2
 RaR98vvd5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJrPrP8D9nVeEzwyUt935e
 Xt5kMEHp0IIXqy0Tuf8+XWdzybuqsLSb4X9k5SOxiOQFN99KvS47Jjcn+MW1iisGptlT7cu+ejo
 X5rAAAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Headers-End: 1s6Xnz-0002ND-Kc
Subject: [f2fs-dev] [PATCH] f2fs: Add inline to f2fs_build_fault_attr() stub
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
Cc: Nathan Chancellor <nathan@kernel.org>, patches@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When building without CONFIG_F2FS_FAULT_INJECTION, there is a warning
from each file that includes f2fs.h because the stub for
f2fs_build_fault_attr() is missing inline:

  In file included from fs/f2fs/segment.c:21:
  fs/f2fs/f2fs.h:4605:12: warning: 'f2fs_build_fault_attr' defined but not used [-Wunused-function]
   4605 | static int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
        |            ^~~~~~~~~~~~~~~~~~~~~

Add the missing inline to resolve all of the warnings for this
configuration.

Fixes: 4ed886b187f4 ("f2fs: check validation of fault attrs in f2fs_build_fault_attr()")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/f2fs/f2fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ef7de97be647..1974b6aff397 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4602,8 +4602,8 @@ static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
 extern int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
 							unsigned long type);
 #else
-static int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
-							unsigned long type)
+static inline int f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
+					unsigned long rate, unsigned long type)
 {
 	return 0;
 }

---
base-commit: 991b6bdf1b009832256f8bc3035d4bcba664657b
change-id: 20240513-f2fs-add-missing-inline-to-f2fs_build_fault_attr-207a50c97005

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
