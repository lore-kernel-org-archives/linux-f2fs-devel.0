Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3AEC44525
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SNpuYk7aNDetsFAWr3j6Er60iDY41aE4liJmMvO7r0M=; b=IE0Eu7SKnuzdpY8mmEmY4m8P61
	WTMKLReRID+6NDma3p0WJpVFcAB0ZaWB1MEF++srf5ZGKR1wH/OgQpZ5GtcJML2lKzsZdK9PiNG+1
	Rn2GblQnVGip56+sFzeXAZoOYMe29Fc8TTErYw8RQx+brYksZhzu8k4nZIE8Q1R87IMg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wljwC-0000Hx-2G;
	Mon, 20 Jul 2026 09:05:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wljw9-0000HP-Gf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fmzb25jhZDNq4cfG2tBZE1WMkvl/GQ14vrzOhert9WY=; b=czoUAfkWBNR8g1uwX72nc0Fcvp
 RexDDlY+TiPQtUxjcMhBfJ/fDl7cGQRSiq2vy7Q/SNVhOpuGoid7a5PfBBEbcm+2qF3GtIL6XLyZQ
 nK9wF0nKJntoj1JFJCDC/WyatVdt2n9pHP0XrN5YKo5qiD3OhJtZeKQ81pIZaZVvDVuY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fmzb25jhZDNq4cfG2tBZE1WMkvl/GQ14vrzOhert9WY=; b=Mup6btCvRTOGZqNeQvp4BF/W3D
 0d6XwOnWAuVA1+RyvsaqPOFRoALYfR3WL8J4wiC5Y/EdPApIA0lbGhZC2EWm+qnH8qRh3xilbgNZo
 qb041HZb/SH9C0Z9rfJEKYsbFxqf0eTPw2S5TGXreYtpEnAs4kU0d1RRz0y9GPq0sAeA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wljw9-00086z-8y for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AFD92601D9;
 Mon, 20 Jul 2026 09:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DDD1F00A3A;
 Mon, 20 Jul 2026 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784538315;
 bh=fmzb25jhZDNq4cfG2tBZE1WMkvl/GQ14vrzOhert9WY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bZ1pRiVXQH7m0lMtKeVjtWUFhiy9gQ+id7Lk9deUWD1HT1fu/16I094RgyNr38bzu
 qGhNLnU590aRYgMIkuO9MJ9Pp2rrRPkUP4ama2ohr9yNN/WAaVZzNx2O1R1+PbagW4
 mtYD9H9/nrDil+NvmJ5wvyN25P1USZB+1mLfoHNw/ayfIxBbUP3Azn4l3P9+xr4ePU
 tLZ+FpxMpcr5YqI53eZIctWTtAZIZ6hkO+Q1vizUEVuEc1mHCui9oglvCXVJS1bM8w
 +Ha+JO2Jd9bSTSEAid/29IyhGGdwRR+m2NkJqGWD01nRJFMGLI+I5DP647ddwra87A
 0Dw82M05aDVqg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Jul 2026 11:03:35 +0200
Message-ID: <20260720090410.3487990-8-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720090410.3487990-1-aalbersh@kernel.org>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wljw9-00086z-8y
Subject: [f2fs-dev] [PATCH v12 07/21] fs,
 fsverity: remove check for fsverity being enabled in
 setattr_prepare()
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The check that fs-verity is available in the kernel is not necessary
here. Filesystems could have fsverity files even without fs-verity
module, then truncate will succeed. Previously, this would return
EOPNOTSUPP if verity is missing, but if it's not EPERM was returned
anyway.

Fixes: e9734653c523 ("fs,fsverity: reject size changes on fsverity files in setattr_prepare")
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/attr.c b/fs/attr.c
index 4f437fabb7f0..71888ac903c2 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -176,7 +176,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * covered by the open-time check because sys_truncate() takes a
 		 * path, not an open file.
 		 */
-		if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+		if (IS_VERITY(inode))
 			return -EPERM;
 
 		error = inode_newsize_ok(inode, attr->ia_size);
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
