Return-Path: <SRS0=/iKT=UJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632FBC468BC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jun 2019 04:38:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313FA2085A;
	Mon, 10 Jun 2019 04:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Ggp8KyTc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GjFL9X9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313FA2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1haC51-0002r4-Ob; Mon, 10 Jun 2019 04:38:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1haC50-0002qw-9i
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jun 2019 04:38:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RVIer1zvGaaIfvyn5F36rSmi43Paz1XgnfXypjm5MJs=; b=Ggp8KyTcCXrM4HHhnBTdQqPeMB
 DxT4sXzxJpZn8jQJmjviQkiN10h2Or/0Izb/j1an75R1GWQdAUR9f4gLALZpqfy44e89SpW3bDyse
 NUiGPgNJ2ryuVbQKpvHvqgY7fVqIbQuckP4Xn1OyVAYHEf3h6UzByjqZClvNG0EiPUX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RVIer1zvGaaIfvyn5F36rSmi43Paz1XgnfXypjm5MJs=; b=GjFL9X9Y6fFmjpgKEL9Fcp0F9P
 kkcPBSlEDpGaSfgNKL50Hq3sy3/ijqR7YFFDZY/+FDYekyGMWd8T1kejjkh9YRsimVbl3dcAg6lz6
 SrpaKvoUlrJtP0WkKSdlhwK5Zd5R3E4QZCTV4zxUl5N/kaD0go4jnd0+Xc7WTf2ZT4e4=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1haC4y-005VhL-Pp
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jun 2019 04:38:46 +0000
Received: from callcc.thunk.org ([66.31.38.53]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5A4cS90014550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jun 2019 00:38:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 83D27420481; Mon, 10 Jun 2019 00:38:28 -0400 (EDT)
Date: Mon, 10 Jun 2019 00:38:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20190610043828.GC15963@mit.edu>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <20190606224525.GB84833@gmail.com>
 <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
 <20190607181452.GC648@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190607181452.GC648@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1haC4y-005VhL-Pp
Subject: Re: [f2fs-dev] =?utf-8?b?5Zue5aSNOiAgW1BBVENIIDEvMl0gZXh0NDogb25s?=
 =?utf-8?q?y_set_project_inherit_bit_for_directory?=
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
Cc: Andreas Dilger <adilger@dilger.ca>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 Wang Shilong <wangshilong1991@gmail.com>, Wang Shilong <wshilong@ddn.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190610043828.5G7ozKZ45OOggrXqzTf_46O37NwmdUIvDKNZzcL20l8@z>

On Fri, Jun 07, 2019 at 11:14:52AM -0700, Eric Biggers wrote:
> 
> Existing versions of chattr can't be changed, and people don't necessarily
> upgrade the kernel and e2fsprogs at the same time.  So (1) wouldn't really work.
> 
> A better solution might be to make FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR never
> return the project inherit flag on regular files.

I've amended this patch by adding the following to fix it for
FS_IOC_GETFLAGS (which is chattr uses):

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7af835ac8d23..74648d42c69b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -779,6 +779,8 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ext4_ioc_getfsmap(sb, (void __user *)arg);
 	case EXT4_IOC_GETFLAGS:
 		flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
+		if (S_ISREG(inode->i_mode))
+			flags &= ~EXT4_PROJINHERIT_FL;
 		return put_user(flags, (int __user *) arg);
 	case EXT4_IOC_SETFLAGS: {
 		int err;

						- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
