Return-Path: <SRS0=iK4e=E4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEE9C56201
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Nov 2020 05:01:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39432078D
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Nov 2020 05:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="F/oSErUG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ksSquFCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39432078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kghVa-0002P5-KX; Sun, 22 Nov 2020 05:01:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <krisman@collabora.com>) id 1kghVY-0002Ox-Qv
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Nov 2020 05:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wFsi3ix9hTLUgdW/yNyQEjY9QMbtg6sdmsm/0sRxjqk=; b=F/oSErUGI5rdTBbiO4CgZbUHaH
 u6WCB+xurHY82OdeCW7/80pkFSUo6dc/Urmf40gM0j5CGc8JNiniJtaT2ASdy1lpIJ/BWZITKCr/O
 n3rIP8thjyWEREu5JZD52Ggwef9ggXzvLjbwRsFWBy7189gqeYWDA9v3UoAjCfXx1KoE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wFsi3ix9hTLUgdW/yNyQEjY9QMbtg6sdmsm/0sRxjqk=; b=ksSquFCN2IVzdsoZX5Kx25CGuc
 drrkbIIrMPdhsMwxUaurTLLOCzpg5qUnB/rtho0N9DOpL/qG5u8oRCLU9Q/1fU5VkmooDxRLQcS/K
 quT3oSM94Or+kOi+xspe+/M81pYuz5PqM5E2whTYw9uOYLPmAc5BUwnrjoNacnyyUZQI=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kghVO-007T5R-Ts
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Nov 2020 05:01:52 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 8363F1F45BFE
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Daniel Rosenberg <drosen@google.com>
Organization: Collabora
References: <20201119060904.463807-1-drosen@google.com>
 <20201119060904.463807-2-drosen@google.com>
Date: Sat, 21 Nov 2020 23:55:37 -0500
In-Reply-To: <20201119060904.463807-2-drosen@google.com> (Daniel Rosenberg's
 message of "Thu, 19 Nov 2020 06:09:02 +0000")
Message-ID: <87tutij8hi.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1kghVO-007T5R-Ts
Subject: Re: [f2fs-dev] [PATCH v4 1/3] libfs: Add generic function for
 setting dentry_ops
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Daniel Rosenberg <drosen@google.com> writes:

> This adds a function to set dentry operations at lookup time that will
> work for both encrypted filenames and casefolded filenames.
>
> A filesystem that supports both features simultaneously can use this
> function during lookup preparations to set up its dentry operations once
> fscrypt no longer does that itself.
>
> Currently the casefolding dentry operation are always set if the
> filesystem defines an encoding because the features is toggleable on
> empty directories. Unlike in the encryption case, the dentry operations
> used come from the parent. Since we don't know what set of functions
> we'll eventually need, and cannot change them later, we enable the
> casefolding operations if the filesystem supports them at all.
>
> By splitting out the various cases, we support as few dentry operations
> as we can get away with, maximizing compatibility with overlayfs, which
> will not function if a filesystem supports certain dentry_operations.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
