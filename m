Return-Path: <SRS0=K3S8=XS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FABBC04EBF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Sep 2019 10:10:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBC820820;
	Mon, 23 Sep 2019 10:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="RpWaqhiU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cDuiH2js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBC820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iCLIk-0004sm-9Y; Mon, 23 Sep 2019 10:10:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack@suse.cz>) id 1iCLIi-0004sf-Ma
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Sep 2019 10:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y/leVQOesvX/XM3KBnx/PYz9Cg0b/e+gYJOVe+q4Tjk=; b=RpWaqhiUlejS3J/Mss/WqNQzmK
 p8WpSGdDVWNVG1iv3jhlq6BCJgvWzMK5vjkX2eWoPW+mB5NOQdzCGdchJMamyxQXKXTsf+34w3Bcy
 3fYUmOAEBwTmYN7yhJ4X+RsC2nSfOKru2fRxRrpe972KBdw416+JV8S8twSpXvi3BquA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y/leVQOesvX/XM3KBnx/PYz9Cg0b/e+gYJOVe+q4Tjk=; b=cDuiH2jsYJ9+AFm1DWje00eAku
 8FjlcPvncyQLbhzHVJqXtzGdeJdQncK7DGUIKx7wj1/UogxDkswplrUNL+ecqjS92/CWzZyq2Wip+
 BD+u6NppiCK2RZ4V/rkabKkFdxFHxh8DxTRKehLtui+0LSBVGuMzzuls0UiE8Sif5BAw=;
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iCLIg-003uDg-OF
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Sep 2019 10:10:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A0A9FAF65;
 Mon, 23 Sep 2019 10:10:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 516001E4669; Mon, 23 Sep 2019 12:10:42 +0200 (CEST)
Date: Mon, 23 Sep 2019 12:10:42 +0200
From: Jan Kara <jack@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <20190923101042.GA25332@quack2.suse.cz>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
 <20190911164517.16130-1-rgoldwyn@suse.de>
 <20190911164517.16130-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190911164517.16130-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1iCLIg-003uDg-OF
Subject: Re: [f2fs-dev] [PATCH 2/3] ext4: fix inode rwsem regression
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
Cc: Ted Tso <tytso@mit.edu>, david@fromorbit.com,
 linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org,
 Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, andres@anarazel.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed 11-09-19 11:45:16, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
> Apparently our current rwsem code doesn't like doing the trylock, then
> lock for real scheme.  So change our read/write methods to just do the
> trylock for the RWF_NOWAIT case.
> 
> Fixes: 728fbc0e10b7 ("ext4: nowait aio support")
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Thanks for fixing this! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, I've also added Ted as ext4 maintainer to CC.

								Honza

> ---
>  fs/ext4/file.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 70b0438dbc94..d5b2d0cc325d 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -40,11 +40,13 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	ssize_t ret;
>  
> -	if (!inode_trylock_shared(inode)) {
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock_shared(inode))
>  			return -EAGAIN;
> +	} else {
>  		inode_lock_shared(inode);
>  	}
> +
>  	/*
>  	 * Recheck under inode lock - at this point we are sure it cannot
>  	 * change anymore
> @@ -190,11 +192,13 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	ssize_t ret;
>  
> -	if (!inode_trylock(inode)) {
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
>  			return -EAGAIN;
> +	} else {
>  		inode_lock(inode);
>  	}
> +
>  	ret = ext4_write_checks(iocb, from);
>  	if (ret <= 0)
>  		goto out;
> @@ -233,9 +237,10 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
>  		return -EOPNOTSUPP;
>  
> -	if (!inode_trylock(inode)) {
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
>  			return -EAGAIN;
> +	} else {
>  		inode_lock(inode);
>  	}
>  
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
