Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECC2CA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PL6/gXxQFWJYGhY+2mnprpeWWarQP9od+DJwi8yYL+A=; b=hoRuRD0bMzVduZBSqq5C9NABlV
	GgJ9xrylPa5FVTzEGTdrJsLq83usmayoGnjBqIVfGtaBdSr/CYu+yjbtq7JDhH5FQ15r5vDhs7lbZ
	cUnGLjhbojdH3C/qTi30v7X3V8p63VoDBHP7YD8J3CnPlENjf6c+vk7KDRt2u4vYw8Ag=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yS-00028f-O1;
	Tue, 06 Oct 2026 08:56:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yQ-00028U-SZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4OcYaGBMyjAjdPcmFvhN7quzF1FNmh3RAdwyqZwKqq8=; b=NxI8V8ZT7royPey4Tg+tcHRpQF
 QD/0b8TMq2PfPkMTl4fZRjZjt4ZQI3p6riVJMEb/PwCo/a5Z0IdEcqsadUjZcXh897PvaSXNcR/iH
 Ngwd1Bov/PB6ZrSyBsJctmfxhqk4myvXElS2ejTetJI8mHxZzb8a1lJ50lHqVywSD5v0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4OcYaGBMyjAjdPcmFvhN7quzF1FNmh3RAdwyqZwKqq8=; b=cjYOcLdh0NPeTDJITouyeW/Pzt
 ZzTEJMNfaPFhGPHIQd+C0Y+EbI5rJ7qKKVEGHbvDqqcZWlnkuJaWCqUk+TYmJp0xR4IP8CVSZGpDF
 SeYnrqCsUFHs1zSsTPMrB9H+WT4Gu4b4BHn/Y7nn+czCF8t4/MrwIIqEXyyc8iNq9UFA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yQ-00024w-3x for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C01D6022A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1BC1F00898;
 Tue,  6 Oct 2026 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276988;
 bh=4OcYaGBMyjAjdPcmFvhN7quzF1FNmh3RAdwyqZwKqq8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ku9gfmgXxV5wFVuy6XVE8I9Te/8vEjg4gN6EEIVwdMNyUYM9PCrDhmAND0F/w/om+
 0DKAiLBgUgxESSdABiUossJlgQY3vSIDaRYk5mAniprtU4dy0ASGzZtmnazxUTARy/
 jJUWNUUsYrqeNunP3CfLtkJGY5b+qob8nH95AYNQA5vMoonETrM7RQqirn44kcuo9G
 +aS4vysprmqub3W3qNZO9L+4IT9O0yLf2EL6VSKKp0nbe1HfwPxUYi2Y9W5Sn4zHTf
 vNTE5VP/PGFw94KhHBdvqvV8FUJguejfDY5pC3O4CkCWbo3sM8MkhhwQj7O6M3MUUz
 YUNhomFMKDlTg==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:33 +0800
Message-ID: <8900633faf8103fe992514d07d69efc9d38e8241.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yQ-00024w-3x
Subject: [f2fs-dev] [PATCH 07/21] fstests: add SEMANAGE_PROG
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, zlang@kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Define `SEMANAGE_PROG` for an upcoming test case that uses `semanage(8)`.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 76b43b8c6ad9..e8fecc168e5a 100644
--- a/common/config
+++ b/common/config
@@ -243,6 +243,7 @@ export PARTED_PROG="$(type -P parted)"
 export XFS_PROPERTY_PROG="$(type -P xfs_property)"
 export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
 export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"
+export SEMANAGE_PROG="$(type -P semanage)"
 
 # udev wait functions.
 #
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
