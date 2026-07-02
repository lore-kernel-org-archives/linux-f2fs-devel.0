Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1F8C43602
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4hSa9TLAU1xaPv4yPoKaELWRt2L+BI7Wc6W5bUkjihQ=; b=hWC2JQndLlmsv0fWU2vLSWqcKl
	lP2GqMt1cHMtYLZpYld+NK3EOaGSMFSl3QIk1nGcQMW5hgjGEj29CRa7o/DC38XHIOeJJT6cVYAl+
	s8eheg1XtcSTewmRZSbIZcDHMzr7PlOnv+gKc+kID7r2UvyB8RO9SEVzqe9sNBCzbwvs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wfBLS-0004Mq-8Z;
	Thu, 02 Jul 2026 06:56:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wfBLR-0004Mk-45
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 06:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bWjYLobU7DmPTU+ID3ps9WdzFfRD5rzyDp7xm8e48hU=; b=Cp9YJSLE2SMsYlwch1gdCDmTwI
 SbrdWfkaltqIw60LvZAn8umxjUz/5kt9EgQrCadTfFNZ9/aceffHx24O8QGECOFIaqvvken7X2C0N
 p9WJcsYp/eGSRN/Bt4d4GDRiQuzoHKl8WXPUyingDzNPFAwoAoqYXQHrDyZ1PKR1g9k0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bWjYLobU7DmPTU+ID3ps9WdzFfRD5rzyDp7xm8e48hU=; b=Jo1Q0lrRfkp0fNPnC8x/Lff3XX
 l4k6+HkADpoJ56g2Df/Ylpz4g6V3RV/uASwfoN7vld6sPOy/z7I+2hiqmh8KHfhjZYGTVVDvwALAU
 FRd22NbxGlTpc2fAKNbpnjj7GYqcaYqEdKHAvRCFzUMlP5upB0/5UNGPQTN/3eKk0GPg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfBLM-0002Xc-Hk for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 06:56:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6957960103;
 Thu,  2 Jul 2026 06:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC11F000E9;
 Thu,  2 Jul 2026 06:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782975366;
 bh=bWjYLobU7DmPTU+ID3ps9WdzFfRD5rzyDp7xm8e48hU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=D1s+vpTtCUky1VvDNmU7YQT8Wnb8ZLr3UtGrXjqoxSEFKITwYZz/jlFR8MUomyifB
 9hvk4vqNHVMVKshhPv5oINYTGJEL+8zKW27kV8kEEm2McKkCFc3tlc9fsnWLayRqmx
 RTKPcRRYLMs5e2jd0dYOt7x4rkABAidGRtyfZBMdr8kMvF8nac+aI6kvgn5Rj9QEYq
 mMzIfgNiGeNAKgHlg6q4KArGOclMi2UeQ23TbciDeCkDb1CiYq1bK6k9zVg7RILtIR
 oJOYNEJVsn8GL47pO2EjAK0KZT+rrmuiHpHZY6gzrDeYdTdMtDeJLCMAVbHFns6J8O
 Luiz2iGe685VQ==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 06:56:01 +0000
Message-ID: <20260702065602.4120914-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260702065602.4120914-1-jaegeuk@kernel.org>
References: <20260702065602.4120914-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wfBLM-0002Xc-Hk
Subject: [f2fs-dev] [PATCH 2/3] f2fs_io: add include dir
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Jaegeuk Kim <jaegeuk@google.com>

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 tools/f2fs_io/Android.bp | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/f2fs_io/Android.bp b/tools/f2fs_io/Android.bp
index 52cdb73f41d6..d507c63c4fd6 100644
--- a/tools/f2fs_io/Android.bp
+++ b/tools/f2fs_io/Android.bp
@@ -4,6 +4,9 @@ cc_defaults {
         "-D_FILE_OFFSET_BITS=64",
         "-Wno-unused-function",
     ],
+    include_dirs: [
+       "external/f2fs-tools/include/",
+    ],
 }
 
 cc_binary {
-- 
2.55.0.rc0.799.gd6f94ed593-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
