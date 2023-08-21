Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D676EEE49AA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Aug 2023 15:52:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qY7D3-0001P6-Q6;
	Mon, 21 Aug 2023 15:52:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1qY7D2-0001Oz-Bu
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Aug 2023 15:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ExMvI1n03K7iB6O1mojan5p3xAAEG44/FkLAoAvAIP4=; b=Y1vdCSMJz7fy5fsHqL/GnWlddg
 Hl73nbVIPvLMXxQNdwUgj6dzuhoo7LYO7A+hcuBSuAiy5gleaShkbbbbyLx0xUSCae3qOWinFfIU6
 Hjvnnw+OfiKLvy5PLkygoQ+cNFqVnxASpf4klTXcE80WqRcX2WFFU8HseOFxV0rQzFoM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ExMvI1n03K7iB6O1mojan5p3xAAEG44/FkLAoAvAIP4=; b=WVbA6UDPTpDyj5jiozTnRdxO+Y
 in8z1yq0JBU0InJIV2agZqrA/n8a1GfEUFVkMM7ymwThPLJKvn9kdnvoQiYM0ZzA2JZtKEsXnvlp/
 xCvt+uP4DLz/gPWOyS2Jj+AiNlThUatv7dmYx8m60iBinAbt/nGjCWbuhecs0ZvTA2gA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qY7Cy-0005ns-38 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Aug 2023 15:52:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 813CA63BF5;
 Mon, 21 Aug 2023 15:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F0BC433C7;
 Mon, 21 Aug 2023 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692633161;
 bh=/vUBGyYP6VPO4JH3SmEIBCefV7FnpLZ3SJcwW8GIf5c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H6V0CaqMpxTdaO+LJv26M2zy4Tz566Z18dEQrMZ6FPcYyqiNZmvzPfasyNf0FID6B
 FoKWyGF8R+5ykhtbAaGhCfbioayjQht+ErRCbM7gBDDpuKpIMWpTfLkgQGgEh2+Wva
 nOt4CDfmxJf3VK3ZpfnNIHeXYhxDDdm6B3brvPQ18zyHrbAfOgOrlze7YBQLqA2eka
 u71Ryd9q6SHFQnUDkfSkrIOxrPnvrHBlarNfjNKuu/Jj3t/B3F7lw3nivGEDoy1sC6
 /Mkq9jxm+qwono3i/ffFQfhUnJgl0DODxSzeRk1xw2lIbKJ4BsVPB9HZyaLyZ6Whmr
 MvSmZ3ylZBGEw==
Date: Mon, 21 Aug 2023 17:52:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20230821-derart-serienweise-3506611e576d@brauner>
References: <20230816050803.15660-1-krisman@suse.de>
 <20230817170658.GD1483@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230817170658.GD1483@sol.localdomain>
X-Headers-End: 1qY7Cy-0005ns-38
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
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
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Aug 17, 2023 at 10:06:58AM -0700, Eric Biggers wrote:
> On Wed, Aug 16, 2023 at 01:07:54AM -0400, Gabriel Krisman Bertazi wrote:
> > Hi,
> > 
> > This is v6 of the negative dentry on case-insensitive directories.
> > Thanks Eric for the review of the last iteration.  This version
> > drops the patch to expose the helper to check casefolding directories,
> > since it is not necessary in ecryptfs and it might be going away.  It
> > also addresses some documentation details, fix a build bot error and
> > simplifies the commit messages.  See the changelog in each patch for
> > more details.
> > 
> > Thanks,
> > 
> > ---
> > 
> > Gabriel Krisman Bertazi (9):
> >   ecryptfs: Reject casefold directory inodes
> >   9p: Split ->weak_revalidate from ->revalidate
> >   fs: Expose name under lookup to d_revalidate hooks
> >   fs: Add DCACHE_CASEFOLDED_NAME flag
> >   libfs: Validate negative dentries in case-insensitive directories
> >   libfs: Chain encryption checks after case-insensitive revalidation
> >   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
> >   ext4: Enable negative dentries on case-insensitive lookup
> >   f2fs: Enable negative dentries on case-insensitive lookup
> > 
> 
> Looks good,
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Thanks! We're a bit too late for v6.6 with this given that this hasn't
even been in -next. So this will be up for v6.7.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
