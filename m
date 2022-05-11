Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526C6C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 May 2022 17:38:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1noqHp-0003J1-K6; Wed, 11 May 2022 17:38:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1noqHm-0003Iv-Qh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 May 2022 17:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m4foIi3aByc7JwjOuuAOSh2ICfkBktH8Ue+wYxGRwY8=; b=bTqtiOXTSkQXisjQLeSXNVRfgF
 hPJzuE9oRqNrjZHXWn+tZLzQdbz3iQCxOR/jKVubt3uJnlj3ptvHPhMzL3pxbOwvfMes6bssoFdTb
 jJFogFqkc4+wod91rd3ngnCM8BVFRj2yQHXKExkk3AsSHY89h0s3NqvoY1iZ8ooXQwho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m4foIi3aByc7JwjOuuAOSh2ICfkBktH8Ue+wYxGRwY8=; b=LUX3j7xOIfM6mmXOscbtejWJuR
 PtknmNnhjY1mXa5J9Uzw5a3Hof26nqYIF/+P26wooJwFlmtv0XFk2+h6u7M6yeFj/9xYmH5U8KUzT
 pyHtiG7657738PNOXzyTcgMxOQELnaKHfeX9O84dNr/0qUnGlOFq1sp6YmTU4J2CNGrc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1noqHl-008zrR-7j
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 May 2022 17:38:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D0D7561D2E;
 Wed, 11 May 2022 17:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBBAC340EE;
 Wed, 11 May 2022 17:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652290679;
 bh=aCdJZ9j/PdDH2n+Soo73CJM408N6OH2MVsuqlRgTyUY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CcCUfm40CzRZ1Y6C96F/ZLkrgWClKU80ytqM1L6OU/pKGGDj5qyDlaRd06MG1OQA1
 DnwUFFuzFcmuCOT/Ot3+GJ6cqqrHLIt/bWZVRkK4EyJDr8xlt9S2ReMHPRZk51EJ+e
 3KLD9r1fQHa3k3XR9VQZehsHwT8LHOIFHNQCrT/sMfLmdr4mVvGv8aeiqIYeVykz6+
 WEC0CvZd3Xd0br0at88Vf7aLP3dppquz5X9U7T+vsqUsXg04r6vT3Utm8fXuMZQP4F
 KvNN6vSYjo7BE/pTN4MwqVsmCXLxH2hV/BtBOzsg4WCf1AAP+muEcRoiK9zTWgLkkW
 fd2Cpf93nk+VQ==
Date: Wed, 11 May 2022 10:37:57 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <Ynv0ddBz91EoyWwl@google.com>
References: <Ynu4CGiqiU4l2vdf@kili>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ynu4CGiqiU4l2vdf@kili>
X-Headers-End: 1noqHl-008zrR-7j
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error code in
 f2fs_ioc_start_atomic_write()
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
Cc: kernel-janitors@vger.kernel.org, Daeho Jeong <daehojeong@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Dan,

Thank you for the fix. If you don't mind, can I integrate this fix into
the original patch which is in -next?

Thanks,

On 05/11, Dan Carpenter wrote:
> Return an error code if f2fs_iget() fails.  Currently it returns
> success.
> 
> Fixes: 3d7ad9c30607 ("f2fs: change the current atomic write way")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/f2fs/file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 79d1a20fbda9..cd768fadfd67 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2047,6 +2047,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  	pinode = f2fs_iget(inode->i_sb, fi->i_pino);
>  	if (IS_ERR(pinode)) {
>  		f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +		ret = PTR_ERR(pinode);
>  		goto out;
>  	}
>  
> -- 
> 2.35.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
