Return-Path: <SRS0=pHl4=GP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF8C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Jan 2021 17:31:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F303022AED;
	Tue, 12 Jan 2021 17:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F303022AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kzNWA-0002DE-GY; Tue, 12 Jan 2021 17:31:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <djwong@kernel.org>) id 1kzNW9-0002D1-13
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 17:31:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=94j1NQqEfWmJG8kLI2EYm1aaeKvzyQGgr0k7/UAV73Y=; b=LxhGVOKXfS3HvbZXAUD/YuNnkE
 J2E0buXtTWqKZW3h0YYuKRzzlW5G+ewm2wgj3TObEI3edanBpAKjYifqk3RkXnfW+zeiB8OEo9J1C
 V/vmwG8MC38lwBdXSlksP54ktrw4/BUIZsORy/eHTI005vYYYmcjk34lwFIAd6J9o2uY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=94j1NQqEfWmJG8kLI2EYm1aaeKvzyQGgr0k7/UAV73Y=; b=FDdXGbqzyj2GQ3sRDSGbp27sKz
 vfpWwzstqbPUh7whcOai4xZbrpcQ4X1LzjHbF9OoIQaH+2scyovQREUP7tHNckZ/GzcDaJncRnztt
 7qRs+Nk+OnPkVChtzsNHDrjvo099qU3nJ4VhiOipi0XU8fk3CivxGJph26CEfbrCk2wk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kzNW2-004oT6-Dl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 17:31:40 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C0662311F;
 Tue, 12 Jan 2021 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610472681;
 bh=hx3kcnBTK+3EJoLgdpAJwhITPHZ0HHh1DKuSieNfJfg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z9gjqutsZnsUP356ckbPegqUDZKsQXXxP9eJGdZyOU8bBk8u4FYIkX3C7Wx3NeqMk
 v+aEGfiH5lnMkDGIggxZUuRuwpwUD8mpUPHEGc5T0OvUqiMZDNG0b7VMf4cFd2qcjz
 1HUwMirf62JvcEXIn0EP6SGiYqXY168L+JodLgoWfsyM84qy1ePCxcQXZhFeTp5f+J
 IVNPVJewaAWGGqZt3iZtqq6T4aeMnwMVIacz3qiZgsHIbx6N+rcSfbb8cUdU2TjOQS
 d8TcjcUJWf4dgqNPZF22czS9lFJYH20ifNFJJd5kriPwY2GYNOiqJS6j++Rx/6DXd6
 q4YFbbdwHGkwQ==
Date: Tue, 12 Jan 2021 09:31:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20210112173120.GQ1164246@magnolia>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-13-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-13-ebiggers@kernel.org>
X-Headers-End: 1kzNW2-004oT6-Dl
Subject: Re: [f2fs-dev] [PATCH v2 12/12] xfs: remove a stale comment from
 xfs_file_aio_write_checks()
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 08, 2021 at 11:59:03PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The comment in xfs_file_aio_write_checks() about calling file_modified()
> after dropping the ilock doesn't make sense, because the code that
> unconditionally acquires and drops the ilock was removed by
> commit 467f78992a07 ("xfs: reduce ilock hold times in
> xfs_file_aio_write_checks").
> 
> Remove this outdated comment.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Yep, thanks for the update. :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_file.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5b0f93f738372..4927c6653f15d 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -389,12 +389,6 @@ xfs_file_aio_write_checks(
>  	} else
>  		spin_unlock(&ip->i_flags_lock);
>  
> -	/*
> -	 * Updating the timestamps will grab the ilock again from
> -	 * xfs_fs_dirty_inode, so we have to call it after dropping the
> -	 * lock above.  Eventually we should look into a way to avoid
> -	 * the pointless lock roundtrip.
> -	 */
>  	return file_modified(file);
>  }
>  
> -- 
> 2.30.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
