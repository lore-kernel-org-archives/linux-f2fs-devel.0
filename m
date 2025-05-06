Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFB6C3ABBE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 May 2025 23:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GvEMr1CfPtpNSKZNH09iCFwlMb+r7VclRWfnTMeYqQA=; b=nDiDWy9EHHkQjXh9YEcl5F324G
	/D2qUdnDNZ/ctM0jHy6AR8s386Xu8Z6Yf8U5myh1Jatr61EmjPfYMDznWi0eoWK9ECCAQuQm0SEi6
	ZrHnZ/TLA5n5HIylBAZQqrbRXXsLIkjiIVaiEq3W1ttaiIg7QcdIqNBwUndigRM3VOa8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCRkE-0000iP-90;
	Tue, 06 May 2025 23:30:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1uCRkC-0000iJ-Oo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 May 2025 23:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oO8U/OILyZsq/gh8a1e1jcc5CX64w+9/MkpnnjcoQ64=; b=DOofQ6MFvHJDmHHlBuHCYTTtCp
 Zpg5Jv+O9t4X6+9g7iLPQZ3JTML+sEiCIBYTeR7zzwefI1neyZ51TVeUc8zk0AhZgjongV+5A9j+e
 lwEMfcdeUCVQFftTOnz4rNvSKT9MNX/WgJ52qDJ93gTAPYMEDgZzaru0U2bw0W+nrjIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oO8U/OILyZsq/gh8a1e1jcc5CX64w+9/MkpnnjcoQ64=; b=mawKrytGWIpjQpOI1uEZz9fWbl
 pcKwtwbKW5cFD6bWcPySQKKQsnxZ8ly0Hx0nq2IaEkPSeQbdrTqxepM3BANEwZOdLl2M75n2Tchs8
 h3S3zPxLtJ5YBUJKuoOxLJsoUnyXLwKw/L9yRgb4ZvwccIagevawkBBNxV/+w3D87Sj8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCRjw-0008Hn-WC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 May 2025 23:30:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 662F744904;
 Tue,  6 May 2025 23:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FD4C4CEE4;
 Tue,  6 May 2025 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746574210;
 bh=KXMcgPhKNRt4MH+6WvvoyGgQ1wkfJ1IkK0hCDyefnAU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uUzb6/CgUdZ2JrU8tbqoUODwjTgGSDjF2ASJjSWqGg8k1tDo104k410fSHSUPc8TL
 t++Us9GaWc3QfipZQDamkzXaAEOmdC8dNjU7BkLKa8WyChtr5sK78xMtI39zgjIlcP
 izW0P6HGOcGs7vL4DQoXK69vkkwzJKZ3/uDwwRfXc0JupXUUy6z92CMiLY0B7o/pFv
 cE2UI79MMFA7QF87KVdi0CTyx4MqXk2jC7zNqMbbEKOehNZWoxtVPPtTOemDyZvpUd
 PEGWYXAcRgrL5wC7cRrqqDTNFBggfSh5Pn/19bW/OPVkHC0LGKb0cigRpmXxaWu8Kq
 ojcOYTFGY/ZhQ==
Date: Tue, 6 May 2025 23:30:08 +0000
To: Eric Sandeen <sandeen@redhat.com>
Message-ID: <aBqbgLjM_dfFsCN3@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-6-sandeen@redhat.com>
 <aBqGw8lUbNtvdziC@google.com>
 <5eda52cb-995f-4bb7-a896-927bacdd17a2@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5eda52cb-995f-4bb7-a896-927bacdd17a2@redhat.com>
X-Headers-End: 1uCRjw-0008Hn-WC
Subject: Re: [f2fs-dev] [PATCH V3 5/7] f2fs: separate the options parsing
 and options checking
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
Cc: linux-fsdevel@vger.kernel.org, lihongbo22@huawei.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/06, Eric Sandeen wrote:
> On 5/6/25 5:01 PM, Jaegeuk Kim wrote:
> 
> <snip>
> 
> >> +static int f2fs_check_opt_consistency(struct fs_context *fc,
> >> +				      struct super_block *sb)
> >> +{
> >> +	struct f2fs_fs_context *ctx = fc->fs_private;
> >> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >> +	int err;
> >> +
> >> +	if (ctx_test_opt(ctx, F2FS_MOUNT_NORECOVERY) && !f2fs_readonly(sb))
> >> +		return -EINVAL;
> >> +
> >> +	if (f2fs_hw_should_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
> >> +				&& !ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> > Applied.
> > 
> >        if (f2fs_hw_should_discard(sbi) &&
> >                        (ctx->opt_mask & F2FS_MOUNT_DISCARD) &&
> >                        !ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> > 
> 
> yes that's nicer
> 
> >> +		f2fs_warn(sbi, "discard is required for zoned block devices");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (f2fs_sb_has_device_alias(sbi)) {
> > Shouldn't this be?
> > 
> > 	if (f2fs_sb_has_device_alias(sbi) &&
> > 			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
> > 
> 
> Whoops, I don't know how I missed that, or how my testing missed it, sorry.
> And maybe it should be later in the function so it doesn't interrupt the=
> discard cases.

No worries. I applied the check after doing the discard cases.

Thanks,

>  
> >> +		f2fs_err(sbi, "device aliasing requires extent cache");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (!f2fs_hw_support_discard(sbi) && (ctx->opt_mask & F2FS_MOUNT_DISCARD)
> >> +				&& ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> >        if (!f2fs_hw_support_discard(sbi) &&
> >                        (ctx->opt_mask & F2FS_MOUNT_DISCARD) &&
> >                        ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
