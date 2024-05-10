Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA3DC25B74
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 May 2024 01:26:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5F1L-0003dh-Nv;
	Fri, 10 May 2024 01:26:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1s5F1A-0003dN-VW
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zs7b0lEaSzJiP/RpZxAIBV1QwgR1BnMi/jL2DLDLlU0=; b=NnQ6iSYmB08qAA10N5iwZmhgS5
 qtvFsVpeJivV6smFRm1v3R/0YE1gJ9i2Af2oxKPi/DWE6eNmnCMaCGRQd4rGYIr/vpz5tNE1wjfaI
 iVAloXSVk/SRIkxsDSLocTUBCGdnLaOvwEn++Y3Gf2eYJYXGWB+Ti68ay3EA7Vs4Yhyg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zs7b0lEaSzJiP/RpZxAIBV1QwgR1BnMi/jL2DLDLlU0=; b=BkyBs0A8zaUwNg4vYNQRZz6xk4
 fAYTe+VUz4g/3IEFbbgWFw+Cd3VTHdDZxJMHiHy5G06wSqALvPr9QkIw3J2uq11/++YVv8ECe5Spx
 ZYJCIYrMmIiDAXBcyO7ItSGeMFd0PUfKNj2ryH3jMiLmIvDP0paYv30Z80b4r//T6WxY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5F1B-0007bQ-BA for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:25:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C81AFCE1C14;
 Fri, 10 May 2024 01:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48E6C116B1;
 Fri, 10 May 2024 01:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715304341;
 bh=AcFmfnE2SjS9n37wQ7KWN0OORIobOYPwAzFfJDvf0d0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NsgwgbYBQqgOLYZTyt2LSVvl3VOMIZc2ON7mdOseE1h+gq4YbC/GeE0ME8wFWBU0e
 Snm7cJatEr62rHkiAXBemkZz/f/3MUfBdApBnBIzYHQYtq6ytrajNPc7hmijIQDM8E
 7Snvyo1CwyW6+Mg808mRm0KCtK1F0UPJYddyjY/Vd6rfU2TTGdQHFQ/XfuI3CmOFrb
 MJkjynpB3Uyr7pLve/0GoKrcxzxTsy86bM/QI7/slSebH+8EAwbggMxFkPo58gJq+g
 qblgZwXPnHfN970fUaAEQ5unqFYrFLfS1ufHuidziOXN7U2PRzWmru96EqBTE2TUUu
 czkl/is1dHVCw==
Date: Fri, 10 May 2024 01:25:39 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Message-ID: <20240510012539.GG1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-9-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-9-eugen.hristev@collabora.com>
X-Headers-End: 1s5F1B-0007bQ-BA
Subject: Re: [f2fs-dev] [PATCH v16 8/9] ext4: Move CONFIG_UNICODE defguards
 into the code flow
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
Cc: krisman@suse.de, brauner@kernel.org, kernel@collabora.com, tytso@mit.edu,
 jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 05, 2024 at 03:13:31PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: port to 6.8-rc3]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/ext4/crypto.c | 10 ++--------
>  fs/ext4/ext4.h   | 33 +++++++++++++++++++++------------
>  fs/ext4/namei.c  | 14 +++++---------
>  fs/ext4/super.c  |  4 +---
>  4 files changed, 29 insertions(+), 32 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
