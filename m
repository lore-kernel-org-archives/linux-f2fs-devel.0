Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E964CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pAUOKRuobkWF5VhlaDYOhSUoV0Wz7rf1FMMdUsJCH+g=; b=iyz3ljDSZaSkYU2B/lbO0NEI3H
	B8M6kpJlthXqIUIv/v9swQVYp7zdAnUOjp6w4eDduXayM+41v5oDm2dH+IFXafdztuVz9jV0HEVKs
	BCSAQkQW7VwAs8e6mBVG2nKjsK6avRDo8iYqMIwbSmlZlrVJ8C3oibHND1cle8KqzYt0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMqCV-0007hV-3p;
	Tue, 12 May 2026 16:43:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wMqCT-0007hO-Vi
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 16:43:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nSEdh5qhvKHwGvOyzzdlacB9JE8SCO28PhCZho3aXI4=; b=Kv7hSw0FvTwDMfDbIfWiiiLW5O
 5MpUBqNbRqZWnKfnzSieVWGJ+53061mk9IU/694c92OuUfhVd8hklXHo38S7n8YtBjbz4puWd5Q71
 42ccMbmAqsqAwA//q9HlPF8jAJO7SHSFxrjo9GdgV1FiKCP9cY9eW+EW3KCGf2o5NySo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nSEdh5qhvKHwGvOyzzdlacB9JE8SCO28PhCZho3aXI4=; b=Xllc5gdoBT+hB8hp8N8j/7C/An
 Vz3fKOJTq8/uUZnRaA8RIZ5kgUnLFbLahK2xOIcISY33TDqt9vkKred3cftb67tqMpMReu6dfKeja
 VynLB0/4fqMy8YPCljcbGNq/IIfPjJ8DmfspSHiAXi1dObq3cm/jiORHSGYrJdEU7e28=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMqCP-00078L-Jj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 16:43:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AE31340332;
 Tue, 12 May 2026 16:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B5C2BCF6;
 Tue, 12 May 2026 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778604188;
 bh=PBZrTiN4pAoVDQXCJJ+alWgO2xkZJqjotuEKJ6A2uec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LhDaw5alyksUgGWr7B+0tNRNRMhWix5nRIyBwa98tq/kd6I8j+shUG6aVX4PjpvCV
 T0UPqngSxtLEFupErYJkxP6xFRAzIkRfQwy84MuvBPY0FvI7QEYc94CPrTP2bmwrXX
 d/otVY/0Kkw1xfrrVmsd2Er2k2zyg56OwnHH3xBSjgLwQu0/pnFnSdhe5iyEuqvWiJ
 8Q8dB1D3YHgUfms3a7YcngYBDEhhHjo5vNSt2zuw5VNg0vWPLMGb8+TM2WzzgGb37n
 luePu92paJZ4t8fhc+C51bQBP0YyCtdfc0OkYS94Y5yjSIvG0Ls6lxWYIA4uojhZML
 lBXUfTYggysNQ==
Date: Tue, 12 May 2026 09:43:08 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260512164308.GF9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-6-hch@lst.de>
X-Headers-End: 1wMqCP-00078L-Jj
Subject: Re: [f2fs-dev] [PATCH 05/12] swap: cleanup setup_swap_extents
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 linux-mm@kvack.org, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Chris Li <chrisl@kernel.org>,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Kairui Song <kasong@tencent.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-cifs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-btrfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 12, 2026 at 07:35:21AM +0200, Christoph Hellwig wrote:
> Reflow setup_swap_extents so that the flag checking is not conditional on
> a swap_activate method.  This is currently a no-op because the swapoff
> code still checks the presence of a swap_deactivate method, but it
> simplifies adding a new check, and also makes the SWP_ACTIVATED flag
> more consistent.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/swapfile.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 651c1b59ff9f..1b7fc03612f4 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2783,25 +2783,24 @@ static int setup_swap_extents(struct swap_info_struct *sis,
>  {
>  	struct address_space *mapping = swap_file->f_mapping;
>  	struct inode *inode = mapping->host;
> -	int ret;
> +	int ret, error = 0;

/me wonders why not reuse ret instead of declaring a new variable?

--D

>  
>  	if (S_ISBLK(inode->i_mode))
>  		return add_swap_extent(sis, sis->max, 0);
>  
> -	if (swap_file->f_op->swap_activate) {
> +	if (swap_file->f_op->swap_activate)
>  		ret = swap_file->f_op->swap_activate(swap_file, sis);
> -		if (ret < 0)
> -			return ret;
> -		sis->flags |= SWP_ACTIVATED;
> -		if ((sis->flags & SWP_FS_OPS) &&
> -		    sio_pool_init() != 0) {
> -			destroy_swap_extents(sis, swap_file);
> -			return -ENOMEM;
> -		}
> +	else
> +		ret = generic_swap_activate(swap_file, sis);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	return generic_swap_activate(swap_file, sis);
> +	sis->flags |= SWP_ACTIVATED;
> +	if (sis->flags & SWP_FS_OPS)
> +		error = sio_pool_init();
> +	if (error)
> +		destroy_swap_extents(sis, swap_file);
> +	return error;
>  }
>  
>  static void _enable_swap_info(struct swap_info_struct *si)
> -- 
> 2.53.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
