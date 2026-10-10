Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAACCA9EBE
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 07:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nXqXnlCXMcWJvyjnudHg8WX7oyOgJGflXHYJD4EiVDM=; b=CBoU3Y/9W6SEwICWholaYAnpIv
	JG8zkZz0h+5hO9P+Q/Vvpr2732ZyZ3OMxp36/LZbgDbFm/pp6d0TN61TBqauUjBj1wcg3MH8V+h1h
	W0SzNSUS1n5u7g5czJ7JI6dtfV2rU28UP0p1jsdbZ88W0lMvqHVwKfv6OUM25+GjJPqw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFR3q-00032U-Vf;
	Sat, 10 Oct 2026 07:00:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFR3q-00032K-4m
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 07:00:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fDPUvN/ZiQi3Vp5qShmOzcpuRv0wYB/MjMNxCby/yDI=; b=HLToPBU5t2QhGBHQMEl2ooKL0b
 BwB4C1Hk+Z5FcFbOrOnQa/QkUN3373BgFQ3QhGi9UBtFNKG12Wv4rX5aY78yVHQ07yUIu9VIs11kh
 L3+lLoG/sElVIvuE3cUhuWhTwgaJ/Pzag1t27Pcr/gnF6yYRLV5trbxV8tnETGiHxn9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fDPUvN/ZiQi3Vp5qShmOzcpuRv0wYB/MjMNxCby/yDI=; b=k
 hL1o1HxK2bnDm7mQ7N2Pcldi10JgIJ/FRhoiMdnsLdhulS8KbDJ38NuczsBqylIZ8eiy4hgsoRccV
 UKEVb38zBaF2nNclCIcvu2oMAsvv7WLVvbOZsco4iymAFZ6kDvnZBA5smjk8wDsaZl4sQl3yb8VHr
 gcqaF1igdpdaA4qw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFR3o-0001on-AP for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 07:00:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEBF3601F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Oct 2026 06:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64D61F000FF;
 Sat, 10 Oct 2026 06:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791615594;
 bh=fDPUvN/ZiQi3Vp5qShmOzcpuRv0wYB/MjMNxCby/yDI=;
 h=From:To:Cc:Subject:Date;
 b=cQuiAvptIOpVfYBAZoOVsDS1wF/r96u5WKBq3qjCPfxHZIlbwMXfJaeJqS9iEuFBF
 5hAR2J7myZmBiqquFmmtSyVNq+IRr0LTfZSHfy0fhYjrHV/P5iQXfYoUJFXN5Kzj7H
 JysKrsY+oDgv9Dsk6XUyrSVNWn5T9sucW3exX/t6GRAy00mmOpZTKj01xO6HClwoum
 +mkzh0f5gp/P+tl8pPHn6W0HxJt+P8/usyPG1p4c/GrJBQXVm4wNM3oVt6y7VKIEuT
 ibnLTynJz9PZprrEnFO6TxggwqWHg6Ybj7o711AM32AiKZUQQNA2cJhsv1N1ukU+/a
 TjaSfZgEdUPkg==
To: jaegeuk@kernel.org
Date: Sat, 10 Oct 2026 14:59:46 +0800
Message-ID: <20261010065946.1763794-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xFR3o-0001on-AP
Subject: [f2fs-dev] [PATCH] MAINTAINERS: f2fs: add dev branch to git tree
 entry
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

The F2FS entry lists the git tree without a branch, so tools that
derive a baseline from MAINTAINERS, e.g. sashiko, fall back to the
remote HEAD, which points to master. master only moves at -rc1, so
series developed against the dev branch fail to apply there.

Name the dev branch explicitly, where f2fs patches are queued.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..068beaa035ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9947,7 +9947,7 @@ S:	Maintained
 W:	https://f2fs.wiki.kernel.org/
 Q:	https://patchwork.kernel.org/project/f2fs/list/
 B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=f2fs
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev
 F:	Documentation/ABI/testing/sysfs-fs-f2fs
 F:	Documentation/filesystems/f2fs.rst
 F:	fs/f2fs/
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
