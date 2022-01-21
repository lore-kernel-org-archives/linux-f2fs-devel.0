Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9385BC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Jan 2022 01:30:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nAilA-0005pt-9e; Fri, 21 Jan 2022 01:30:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nAil9-0005pd-3Z
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Jan 2022 01:30:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5q7WlQD6Vh2kbqt2X4lfyI8Lp08JDSbIfYVgFkgvU5o=; b=Rg0KdPVLC2aMRlCQ+izZ9HLqGX
 UO6Ns5MFcqXIWc1OWw5WWEVsz8k0mP2eLtsl/ao5wd7EJCBR4eMoiu588hs79eUjpNA45shm89/tO
 P2tzV5IDTC7ixAmp6hNelmatUWXJ7lCJZ85jXBizSldkAg4gSARpxXxHOx8qENRv4osc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5q7WlQD6Vh2kbqt2X4lfyI8Lp08JDSbIfYVgFkgvU5o=; b=jlJ1HSbEthe80af3QEaGOuXbKz
 gAK6hp/7+Bf0TshTDDIkgSN3K5PEOPgzFF8ixksmA/EUpI3qO6HrVHKLc/Q/ukwmxHTnw6ka0Bryk
 VNfsHD/PrFCgvIaBKabijEtrn+0pu9NaAv67b3YEyNiG/gCCU73kPGjqNWh1hM9wIJUQ=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1nAikv-005lPu-M3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Jan 2022 01:30:22 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 3ED411F45843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1642727451;
 bh=jHIs3XKzhPz//rxsayW/LeWaylwWk5P+YYlJwHwjTNc=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=d/45kpz7h1Gh3Fee/A+jedC+TvoXnUVF7l8ZKMR6NoSTrSg5ujani40PMzMSnbnwN
 WP6wYw9iU883Yw18oiZSo5NNTEzFpxK8Zm8XhrtpDRO9siR//g1CzQCHVm1HNidhjt
 EjAkMzEMH6i/H6SVFxfhKlkW73E7C5F13zKxKs0Zlb/mztZUt/Ea3+HiOkgeTVrdsP
 +CMe27c4rvBR/8P80dE/AJqC/ZZFrgy33rxC0hc7RagSfMQbDZRiW3DQ4PAztXYwLF
 LaYWkxlKNb+z8mhY2LG2/uY15OKOGIHfYhy/aryR3L+9+XpqJYac/JjmemufolP/tI
 8ykwdwKmLHupA==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Christoph Hellwig <hch@lst.de>
Organization: Collabora
References: <20220118065614.1241470-1-hch@lst.de>
Date: Thu, 20 Jan 2022 20:10:47 -0500
In-Reply-To: <20220118065614.1241470-1-hch@lst.de> (Christoph Hellwig's
 message of "Tue, 18 Jan 2022 07:56:14 +0100")
Message-ID: <87zgnp51wo.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1nAikv-005lPu-M3
Subject: Re: [f2fs-dev] [PATCH] unicode: clean up the Kconfig symbol
 confusion
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


Christoph Hellwig <hch@lst.de> writes:

> Turn the CONFIG_UNICODE symbol into a tristate that generates some always
> built in code and remove the confusing CONFIG_UNICODE_UTF8_DATA symbol.
>
> Note that a lot of the IS_ENALBED() checks could be turned from cpp
> statements into normal ifs, but this change is intended to be fairly
> mechanic, so that should be cleaned up later.

Hi,

Just a typo s/ENALBED/ENABLED/.

> Fixes: 2b3d04787012 ("unicode: Add utf8-data module")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I fixed the typo and pushed the patch to a linux-next visible branch

https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/commit/?h=for-next&id=5298d4bfe80f6ae6ae2777bcd1357b0022d98573

I'm also sending a patch series shortly turning IS_ENABLED into part of
the code flow where possible.

Thank you,

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
