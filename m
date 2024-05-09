Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A9AC04FFE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 May 2024 00:46:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s4rvp-0000te-Gg;
	Thu, 09 May 2024 00:46:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1s4rvo-0000tU-LG
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 May 2024 00:46:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gNPmiJb/3TX00gU3ojtAgUg3W+hYTAhCOOACKIqA6qE=; b=RYXs4Fd8FZJlsLXirDlmRlHbId
 PJlNe5qdFTlCOLmPGXi5n1k/rnQMPxPNeYwD19s7nNjWYMKDHe+aSyUtrSKwG1T2SP9jgSwkDtcSM
 MXBPAp1Tkew7z+jy8t8l0tukQg+zL3srOWsf9BDvKPkmYeuNNxyU4dhXrYtOnrCI0eXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gNPmiJb/3TX00gU3ojtAgUg3W+hYTAhCOOACKIqA6qE=; b=kZp2CCukbQrdv5JLLNLm4Cg93a
 BknjODhaT6x0h6ITOBjmPS0BYA8DHMK0ZQpavrRXk0IwogFsfUJ1bmddbkKxOfYzuiPGMBFPbaE6a
 fZcD8KpVz2bo1u9kMsxEm7HhTkTAJRJ1NwzfbEVGNVYHmUA0CRP6DINM3I0iIyN8VyHk=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s4rvp-0006kM-2i for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 May 2024 00:46:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 752D4CE179B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  9 May 2024 00:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F004C113CC;
 Thu,  9 May 2024 00:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715215591;
 bh=zYzZ47aIbLYgJWhf+ax5I/IicovIZS8EJW8+BM1aTIU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=brH3UiF5pKt7B9d3J3arotQt31ROL88isqOCQma1jlku4vDpHehmVMl/brEbHudaa
 A1g4FN7fUUsLQRN/SCvIq6U8dz2dpos4PASMDL8QSvbx5QM2LmwrAhYBhuM6ErOdA5
 xtyY8RTWCcBNXphNN3Y0GvkfXGUktkFiPNx3Q3zq2AZn2e33fzKHXszB5/0o0dwAcO
 /mzW/luTIEkkDec/fmsCMkgs5EcWk39ppyBflIgLl58/WOUBIlwDi/RiswYgiy/eow
 SOUS0HDDnCxcA4LNIoJ9UgFjR5zp2EVmMyLooe8/mvmft18UJ5/Q2FadNk5+UxB2Vx
 3dQSeb4lbplIg==
Date: Thu, 9 May 2024 00:46:29 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Zjwc5QGJfm6XXzOX@google.com>
References: <20240506103313.773503-1-chao@kernel.org>
 <20240506103313.773503-2-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240506103313.773503-2-chao@kernel.org>
X-Headers-End: 1s4rvp-0006kM-2i
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: fix to add missing iput() in
 gc_data_segment()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/06, Chao Yu wrote:
> During gc_data_segment(), if inode state is abnormal, it missed to call
> iput(), fix it.
> 
> Fixes: 132e3209789c ("f2fs: remove false alarm on iget failure during GC")
> Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/gc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 8852814dab7f..e86c7f01539a 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  			int err;
>  
>  			inode = f2fs_iget(sb, dni.ino);
> -			if (IS_ERR(inode) || is_bad_inode(inode) ||
> -					special_file(inode->i_mode))
> +			if (IS_ERR(inode))
>  				continue;
>  
> +			if (is_bad_inode(inode) ||
> +					special_file(inode->i_mode)) {
> +				iput(inode);

iget_failed() called iput()?


> +				continue;
> +			}
> +
>  			err = f2fs_gc_pinned_control(inode, gc_type, segno);
>  			if (err == -EAGAIN) {
>  				iput(inode);
> -- 
> 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
