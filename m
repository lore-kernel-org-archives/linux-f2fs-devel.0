Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C9606A685
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eXDBsMuh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mI17rgmL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZPDYqstV;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IgwwjnMf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L6pkI/IqpIS1K7+YCA6SfNhVqcHpBNQdi4ndi1dVmEg=; b=eXDBsMuhwc195NOYTLLyrQ8RvX
	bD4dmTzOAGblYspLdUUQabrC/oANGDWQBjXOh4vXfgdV1hphOh9dNV0Ew43P1Ku5kEhj1Rl2nPbZz
	nvHOC+5rw5H25n6Tze35mQaBRQ1kLnZN9JruabuE2LVD1vpSXuT/o8d/2hu4hBHjB6Qc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUX14-000000004gX-2Qjr;
	Fri, 20 Nov 2026 22:23:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xUX0h-000000004gA-08SY
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 22:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uS1+xQe3B8rmtkclorvpldO1X/AeJScyduZArKaUSx0=; b=mI17rgmLm1u71tpA3Hg/n7693S
 VLyMINJ56XfbrQyI2hofynjkIY32HMUrrWNYkcx1iEOsoZ/dfZXECdXswxNQPziLt2WGxUH//cyYw
 tHj2zLrVc2wO5Kkt+uHMZPp6TFqCFSIMHf6X56YvbGamgrS8d2kavC0ZUTsnT5yGIOlo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uS1+xQe3B8rmtkclorvpldO1X/AeJScyduZArKaUSx0=; b=ZPDYqstVRnIlRZCHcJBioM9Qmx
 8fUsns+P4azKaPYimh283r3qiC3h3jpBwTBaRj934eh7YdHjt9tF5kJ/49gIt31tWb95cvbBJu/Ul
 MBbYaa8xgFIxHnWyB5e2cZCT0f3Vix1myrJJvGNcvkcBiZ2KJnhjOdxeonPnjA+houBA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUX0g-000000005TT-2JD7
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 22:23:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 264AD44E95;
 Fri, 20 Nov 2026 22:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0420D1F000CA;
 Fri, 20 Nov 2026 22:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795213384;
 bh=uS1+xQe3B8rmtkclorvpldO1X/AeJScyduZArKaUSx0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IgwwjnMfHaRkmfJn07kpFLgVXS2VICq79tfV3PI2EtqmL3PtLYlopaeJb5eXojEn8
 S61bVEzAJNeJLAoZYfFkWhdUjTGyKG+vJRZvm64NWiOMbYRAAYMtasuSUQ8bSIh123
 CDa9hkfys7F1E1BCzwBWnXNyA3VrYcdKOsPO38KaW9Lk3TiJiK0T9aEqHx7MD+ptoy
 GstBPsfrpHJ9lHQ8Px0Ip8gaP2nbW6IrjYDxJejQRug2MkrZgNMbNkDAAc2xvlIbJC
 R9IyjlocCKAjHIKagXuvaVEhJYU6D9AsyBv3dFlYYPrG/OrfdBh0C04CFxmNKCMq5X
 uQLVrPdOf+TmQ==
Date: Fri, 20 Nov 2026 22:23:02 +0000
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261120222302.GD3048696@google.com>
References: <20261120155032.187246-1-aalbersh@kernel.org>
 <20261120155032.187246-5-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261120155032.187246-5-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUX0g-000000005TT-2JD7
Subject: Re: [f2fs-dev] [PATCH v3 4/7] iomap: use fsverity_is_building() to
 check for fsverity IO
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity <fsverity@lists.linux.dev>, Christian Brauner <brauner@kernel.org>,
 tytso@mit.edu, linux-f2fs <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 viro@zeniv.linux.org.uk, fsdevel <linux-fsdevel@vger.kernel.org>,
 jaegeuk@kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 04:50:26PM +0100, Andrey Albershteyn wrote:
> As fsverity inodes are read-only, the only write IO happening
> during I_VERITY_BUILDING is fsverity metadata.

I think this is not accurate?  The inode is not a "fsverity inode" yet,
and it can still have dirty data in it that is undergoing writeback.

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6d843b168d5f..0a176741e7b0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1930,7 +1930,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio,
>  	struct inode *inode = wpc->inode;
>  	u64 isize = i_size_read(inode);
>  
> -	if (wpc->iomap.flags & IOMAP_F_FSVERITY) {
> +	if (fsverity_is_building(inode)) {
>  		WARN_ON_ONCE(folio_pos(folio) < isize);
>  		return true;
>  	}

This function no longer needs the 'wpc' parameter: it can be passed
'inode' directly instead.

Sashiko also found an issue with this change.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
