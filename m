Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5087C38145
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Sep 2022 02:28:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oW7H8-0002KD-K9;
	Thu, 08 Sep 2022 02:28:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1oW7H6-0002K7-Ne
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Sep 2022 02:28:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sE+O3cGML886RlEDtMupT9UA2Wb82anhhvWc9NHk6G8=; b=CU3uW7B4qFndfFf4zl1BkLfJGe
 Rmjjc/1yi+6sfoTeMS4Lns8qAbclu52JzAtGEEZBmHZXzS7G9qWQBnHIpphPYWc5V3O8t6m/hd7yg
 7504ERCD9pX4cmuqeZmD7k4LXJsz/h3wF7MRw+KjmelhDsPp0F/7j+EhfoXw9xxydTfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sE+O3cGML886RlEDtMupT9UA2Wb82anhhvWc9NHk6G8=; b=MZZg9I/aNj7UNFBCSJ/kW4PAKo
 HWfGZY0Dp1hgLlzgNKjzsmESbGYP6N1aNZ7m+fw+dnR88ApDdufBmdxh5LCLOia8XG6kQh4OTrgPP
 zoqUykliU+33gxn7hSZ8MlAbRg+y6VW82TfpzzO79U4BYLHb7VoiDNBVuPMVol4JPThg=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oW7HI-0007cm-KD for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Sep 2022 02:28:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5FB95B81F9D;
 Thu,  8 Sep 2022 02:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA497C433C1;
 Thu,  8 Sep 2022 02:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662604101;
 bh=4Y6H0Ev36nz1d+Iize2cdKlFN9p0DOZjwOlZK63qVY8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BKJ7vo5jasROosUAZiWZ8Kia76q0+4jfGm8NheAz7za2lc5hlQLJ4PFKJNxtssIAB
 xFMCMVL7jRylX+GGItaSSQPvr6gY87NqO3coXwGDzIs0oRPbj5SsReejRMleclIhY7
 HhOWPVuNr4TcOfXRcKmqqq2UlQ6f/rHBgj/DGfkMBlVJ1SZOtNdhV05srxrkdcVt4y
 m3ao/nKVkkh92Af+xI3Jfg9F+JImBZlHuez2ttMrwkeKiAP4opdFZFvsI35jy6D9fJ
 p70KmJXcwx1YSKI+pKDXI0dq8Bf8isc6b9A+z7IwpisKH9KXD32NHxPsUmF8Hgguos
 IJQWLI2TzJBRQ==
Date: Wed, 7 Sep 2022 19:28:19 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Weichao Guo <guoweichao@oppo.com>
Message-ID: <YxlTQ3H+PPKcvpyc@google.com>
References: <1662518328-4925-1-git-send-email-guoweichao@oppo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1662518328-4925-1-git-send-email-guoweichao@oppo.com>
X-Headers-End: 1oW7HI-0007cm-KD
Subject: Re: [f2fs-dev] [PATCH] f2fs: let FI_OPU_WRITE override
 FADVISE_COLD_BIT
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
Cc: zhangshiming@oppo.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 09/07, Weichao Guo wrote:
> Cold files may be fragmented due to SSR, defragment is needed as
> sequential reads are dominant scenarios of these files. FI_OPU_WRITE
> should override FADVISE_COLD_BIT to avoid defragment fails.
> 
> Signed-off-by: Weichao Guo <guoweichao@oppo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index aa3ccdd..97b75f0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2543,7 +2543,7 @@ bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
>  		return true;
>  
>  	/* if this is cold file, we should overwrite to avoid fragmentation */
> -	if (file_is_cold(inode))
> +	if (file_is_cold(inode) && !is_inode_flag_set(FI_OPU_WRITE))

				   Fixed build error by adding inode above.

>  		return true;
>  
>  	return check_inplace_update_policy(inode, fio);
> -- 
> 2.7.4


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
