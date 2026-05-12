Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DCFCD4F24
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bjx2GaZF5naRV3FxmBHCStiUp172svqm6vQj18nQw3o=; b=HW8DdgPmaY9bm21KC0hApmbOQV
	FfllIS62LvjE2o1BExOq9UOXn0sUvpbIT40h+yfUGegY2R+edXnaF1k/QCFKsk7v5YUYj/u0CO5om
	i/wjPWfRReu7H725E1GY/PlY2S+bA+j7ITRhRVMde/T0B14mEstTyoMkXljM6sOGEPNo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMqBd-0006HQ-By;
	Tue, 12 May 2026 16:42:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wMqBc-0006HK-2H
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 16:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kub5HTDrwBJzNbI3PNEkBe/s6Sf2C6g3RIxDvnlWSBU=; b=S9aDiWoU7iE6Lk4fXQvZNudFkO
 j/8bKBUs3HgYA65FTgxajJPhS3UQpQGT0wA0Dx7LqCYdKUx+AAaqVyi/KHC9XThXrkglaqu/maD6M
 Ak0ubFHuqaT58EKqRcyUAKQ+vo152qGjbKsA4AdXMW950T4YPMcpCgZSZLrv7ldWToZg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kub5HTDrwBJzNbI3PNEkBe/s6Sf2C6g3RIxDvnlWSBU=; b=aJ9yQAyJJ+Eo+rP9xq+XZvnspL
 iSo9v4THwfjW1yPdF/v5pqPZGAN4BUWFncf25xVK/dVFEzKIJ7a8/anP3dvD+g0jBR/SEmKuYAorW
 5Pmp5JSX91K5Cf79pfC9tiqDNn91AcYscGVnanXeh2nA1v6G5OeVfsJ2nZw34NfOCqC4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMqBZ-00075e-Uy for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 16:42:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C266418D9;
 Tue, 12 May 2026 16:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A35C2BCC7;
 Tue, 12 May 2026 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778604132;
 bh=HoLO8a+vZpAtLOTBMM5s56bZzE6B2/xXip3V7gv1An8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TTTeSIYr0mdy8HmJYqjqcLWEHq0y8Zlb5+Bkj0i0AArnuJ7wbNWQRMMg/+jBX4e7l
 DMqWrdAzfmyEdet2+8O3vETYUEeeqn+HB1x8V5oWp3B/dV8OYzwc7AiQ+4kpybNjeu
 oXlammqPj2J4WUGQdZx5gTME6ga/ClckN0NU0hI7bwp362zNjXaD8zqd7sk5PtrP0Q
 I6saHT3UM/tU5CEmUlfhbS35iXJrbw0AAOWn+6LoGkEM+4Ezqd4MYb6Z2cOe1iuf5v
 X0x+S5CcTFnIhFy4dpdSpOQ5IspuYVG0Zf0k0TaC3AV6LVdFF6C+DXDWZy4rOp+aAH
 FMfkMFkcQb+cg==
Date: Tue, 12 May 2026 09:42:11 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260512164211.GE9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-5-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-5-hch@lst.de>
X-Headers-End: 1wMqBZ-00075e-Uy
Subject: Re: [f2fs-dev] [PATCH 04/12] swap: restrict to regular files or
 block devices
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

On Tue, May 12, 2026 at 07:35:20AM +0200, Christoph Hellwig wrote:
> Various swap code assumes it runs either on a block device or on a
> regular file.  Make this restriction explicit using checks right
> after opening the file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense to me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  mm/swapfile.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index a183c9c95695..651c1b59ff9f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3515,6 +3515,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		error = -ENOENT;
>  		goto bad_swap_unlock_inode;
>  	}
> +	if (!S_ISBLK(inode->i_mode) && !S_ISREG(inode->i_mode)) {
> +		error = -EINVAL;
> +		goto bad_swap_unlock_inode;
> +	}
>  	if (IS_SWAPFILE(inode)) {
>  		error = -EBUSY;
>  		goto bad_swap_unlock_inode;
> -- 
> 2.53.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
