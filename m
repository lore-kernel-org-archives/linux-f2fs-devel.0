Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB9FC10F1A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 May 2024 01:25:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5F13-0003xE-3l;
	Fri, 10 May 2024 01:25:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1s5F11-0003x8-W6
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:25:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NloqIc+V0pui5CStRd+DL6w1IgT4O3i32CnVyhJwEes=; b=HBV893t00Qehc45gJ/Q+jpa/gx
 jawadqqO6FYNoMA1mtc2sTOCEtUUMRnLNrUGePG1nGx8WqSOTg/JmyChkOJXrHlb6WS7VszqkVtH+
 Sul4lPmqzYhmUnrm3b1xdV2lCEoLl81S91GI6LgY8SlFFC1RDrSyDdY/+v6wc7rbAaXI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NloqIc+V0pui5CStRd+DL6w1IgT4O3i32CnVyhJwEes=; b=j+fJM737dKUHoC4qJR0OVa2Efo
 U2n/J2euj+bBT8XEuIEqFgT4ryTOOKP65j/ZyolUYS9eHCnQMXKv83DE0TzgsNfCiWuyXzKrmRgWD
 f/7OSladDvu7FQFN7MMgG6ui4qv9TG4AGzwTSy1qf/g+itfeirefz9tut6Obl8G8jFRY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5F13-0007b5-6H for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:25:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 22B2ECE1C14;
 Fri, 10 May 2024 01:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2062FC116B1;
 Fri, 10 May 2024 01:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715304327;
 bh=z6usap/sG4pNmXnz79zMaYcGqNYRG6xfvcprS7cuFkI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N7igZdW8tgYu0o8kPCfFrxugMADMEZ0lCFEu9UoLdURi8eu138yKWg/2ootT5zu5c
 T0G/fZU941SH5WD8Qw18MiyQf9ftFYRJhvQ9C2K2KlOnzroGfZu0/+HyFi9T6OFzZ9
 p1yG48T48Ps161PumuwbBGRRTLoaQwftCeRzdqgO5Dm8ZzWnCBepTI9eO5/4/BiJdt
 JD1Q10H+z7UBJBoyGG5LekBosH0bGwkOQu8gb2bnP0QdtGMJbUKh6Xn+2O/1Emu5q7
 NfBWu5Kw7Rut2ZpIJll8V3BkstRTm7H83eEP4/JxwnV8ZtmhADiqsGocmx25eiDheN
 3GBs0ueg7Ijag==
Date: Fri, 10 May 2024 01:25:25 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Message-ID: <20240510012525.GF1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-8-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-8-eugen.hristev@collabora.com>
X-Headers-End: 1s5F13-0007b5-6H
Subject: Re: [f2fs-dev] [PATCH v16 7/9] f2fs: Log error when lookup of
 encoded dentry fails
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
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 05, 2024 at 03:13:30PM +0300, Eugen Hristev wrote:
> If the volume is in strict mode, generi c_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
> 
> Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/dir.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

But please fix the typo: "generi c_ci_compare" => "generic_ci_d_compare"

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
