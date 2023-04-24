Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A879DC77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Apr 2023 06:18:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pqpX0-0008FG-SN;
	Mon, 24 Apr 2023 06:18:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1pqpX0-0008F6-F9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Apr 2023 06:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m8/vbs/KZ4kG3rGa6EPpInm5hn+HmPY26T8rCn74t/Q=; b=T1kE3Iak9CAARmfK8EcN73ZIZU
 aNE0eG9rbJ//A/RbexLFIpz3NTxFD7c+bHJ004s08QwdFIATTUQt/jDe13H2B8Thy1r8WYd+eP1Ac
 9jCaTbXmi2Mpp9Wxqdp2+wXhpXSRmfvxRguwYEeCk+aOYFP+qAky3oTDo1oNxBWRWWWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m8/vbs/KZ4kG3rGa6EPpInm5hn+HmPY26T8rCn74t/Q=; b=VAVWrB7aaJTmQwf0ZgtpvkIcyd
 BbhjZ0AVGDlk1X6wgVaCgPm3YyQaM7twcX3U9K43SuTKkHVPJovpiN4Wr/3gJrXAnk3U1TvF91h4y
 HenBghP0XCKVciE7lLVuCSiyUZot/fBTBGpa+t+h3E7IicjL0hVXv0eAFweN4gztQHck=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pqpWy-0004Ea-U2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Apr 2023 06:18:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B3E21617E4;
 Mon, 24 Apr 2023 06:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E9EC433D2;
 Mon, 24 Apr 2023 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682317106;
 bh=yrOHoQW3uvuLL/IhB326kZ2OBDh3o24byU0KV1vIAfs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UT/Dbssa7FMu87YCTTzaTmgLkwn75ydoQ5e1ln1O+ABDNIqGOzM3jqE84LcFRLXtQ
 8PuuiokVVXrvBeYIF8iLRJehcsneFbeO541NlPuyK4WYdzoxYQNo4Ct81C2GCviI+E
 79/CFqU6DUXRwrF75TfpgUzUqpnzqkrSmaHscnDlFYff2Q092otoUICLTqHPcjNycW
 C7ARkCXD0SS6fhBsNHyLWVZjmfBZdVWOaqI2B3r1Z1l+wSYSI5vYVpmU08euCPzUsC
 TVc0sjLEGEsQXHIvBCt48O7duOfV2QNgFrxe001cpPfOwYHak5QZkXJngosDVkNNLc
 yFrTv1XJj1gDg==
Date: Sun, 23 Apr 2023 23:18:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230424061825.GO360889@frogsfrogsfrogs>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-12-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230424054926.26927-12-hch@lst.de>
X-Headers-End: 1pqpWy-0004Ea-U2
Subject: Re: [f2fs-dev] [PATCH 11/17] iomap: assign
 current->backing_dev_info in iomap_file_buffered_write
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nfs@vger.kernel.org, cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Apr 24, 2023 at 07:49:20AM +0200, Christoph Hellwig wrote:
> Move the assignment to current->backing_dev_info from the callers into
> iomap_file_buffered_write.  Note that zonefs was missing this assignment
> before.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/gfs2/file.c         | 3 ---
>  fs/iomap/buffered-io.c | 4 ++++
>  fs/xfs/xfs_file.c      | 5 -----
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 8c4fad359ff538..4d88c6080b3e30 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -25,7 +25,6 @@
>  #include <linux/dlm.h>
>  #include <linux/dlm_plock.h>
>  #include <linux/delay.h>
> -#include <linux/backing-dev.h>
>  #include <linux/fileattr.h>
>  
>  #include "gfs2.h"
> @@ -1041,11 +1040,9 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
>  			goto out_unlock;
>  	}
>  
> -	current->backing_dev_info = inode_to_bdi(inode);
>  	pagefault_disable();
>  	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
>  	pagefault_enable();
> -	current->backing_dev_info = NULL;
>  	if (ret > 0) {
>  		iocb->ki_pos += ret;
>  		written += ret;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2986be63d2bea6..3d5042efda202a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2010 Red Hat, Inc.
>   * Copyright (C) 2016-2019 Christoph Hellwig.
>   */
> +#include <linux/backing-dev.h>
>  #include <linux/module.h>
>  #include <linux/compiler.h>
>  #include <linux/fs.h>
> @@ -876,8 +877,11 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iter.flags |= IOMAP_NOWAIT;
>  
> +	current->backing_dev_info = inode_to_bdi(iter.inode);

Dumb question from me late on a Sunday night, but does the iomap_unshare
code need to set this too?  Since it works by dirtying pagecache folios
without actually changing the contents?

--D

>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.processed = iomap_write_iter(&iter, i);
> +	current->backing_dev_info = NULL;
> +
>  	if (iter.pos == iocb->ki_pos)
>  		return ret;
>  	return iter.pos - iocb->ki_pos;
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 705250f9f90a1b..f5442e689baf15 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -27,7 +27,6 @@
>  
>  #include <linux/dax.h>
>  #include <linux/falloc.h>
> -#include <linux/backing-dev.h>
>  #include <linux/mman.h>
>  #include <linux/fadvise.h>
>  #include <linux/mount.h>
> @@ -717,9 +716,6 @@ xfs_file_buffered_write(
>  	if (ret)
>  		goto out;
>  
> -	/* We can write back this queue in page reclaim */
> -	current->backing_dev_info = inode_to_bdi(inode);
> -
>  	trace_xfs_file_buffered_write(iocb, from);
>  	ret = iomap_file_buffered_write(iocb, from,
>  			&xfs_buffered_write_iomap_ops);
> @@ -753,7 +749,6 @@ xfs_file_buffered_write(
>  		goto write_retry;
>  	}
>  
> -	current->backing_dev_info = NULL;
>  out:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> -- 
> 2.39.2
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
