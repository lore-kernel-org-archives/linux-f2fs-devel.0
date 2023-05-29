Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2458C7EE2E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 May 2023 11:26:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q3b0s-0003m1-EG;
	Mon, 29 May 2023 11:26:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q3b0p-0003lu-O7
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 11:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JFyLqlZaT880TxvmcXkgW4toFzXzlbCiGXjWSrStz/0=; b=aDB6kVcVbNuxdcg0wBmHP9GFiz
 Q8xPkY+VwrCpi/pFGAOamkOwyiDB+Oz3k5Prw7Udce5KlI20SjS65DgKFr8+BEVv4o5M3q3RSYPwB
 9RfMYjKRK8GFTaQIMcMtkopx4EIFMntM55Yc6zq+Oax0CEPFHdwiYb0s3kpkhQFfgwAc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JFyLqlZaT880TxvmcXkgW4toFzXzlbCiGXjWSrStz/0=; b=ZVAwLN+TfXjL8RJh3CF7fNe/0P
 OcAVdtesAF8FCsiCQvw3eRAFGN93Y9DySZ1O4hzQcwBj+u/dubsAWqGqqFUpBH4byPrMKm6P/iEOY
 Gtgl2QMeI4iH/ueqZkD0pLGg2W5TK0pdYGQZVDqcbj4DuyOgJUCJIVPlYzMfx9Dxe3UU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q3b0h-00084M-ID for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 11:26:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5126A61464;
 Mon, 29 May 2023 11:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D921DC433EF;
 Mon, 29 May 2023 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685359548;
 bh=M734HCcZquv2Cz/oEOWWN1K6CRi8dZ3pDUyW7P5kdd4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hqAbUCuYJQZZ5gpKSFeiXCkZ9JwR6wRBgfa83pameEjrvVQuIlEJnQT99mA6xEnsU
 DuL94HAz2b7EkzFY3hCkVhdF0oIMD7CCNgSHd+LPw2e64n6NOJ4xx9tomqyUegjTNz
 jCxXO8WndougxwocLVk/vcmeQrOUXjGr8bnod0eTnqpyMDFNNvYkekOXI1gpHY4bf0
 OwDe+s4gKJVKN6LAVhPqZO8aOV6WSxQ7JNOjk4dmllMXm8vrHrecnCdO+LSXFcl2RB
 VWRkyU5aMjeo0TyjqSxphJDFvVpiTXK51e41+lUrE2KpE7S3JfGqWsKIL0LMwwG61Y
 ZnaHn6Mz2n1kA==
Message-ID: <9aa57363-14ce-d851-1b15-e2f376c28abc@kernel.org>
Date: Mon, 29 May 2023 19:25:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20230524114159.8999-1-hanqi@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230524114159.8999-1-hanqi@vivo.com>
X-Headers-End: 1q3b0h-00084M-ID
Subject: Re: [f2fs-dev] [PATCH] f2fs: allows setting compress option to
 files which marked with FI_MMAP_FILE
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/24 19:41, Qi Han wrote:
> Allow to compress mmap files in commit e3c548323d32 ("f2fs: let's
> allow compression for mmap files"). However, we cannot set the
> compress option to the mmap file. To keep the same concept in both
> compress_modes, f2fs_ioc_set_compress_option should also allow it.
> 
> Let's remove checking mmap files in f2fs_ioc_set_compress_option so
> that we can set compress option to the mmap files.

Could you please check below patch?

https://lore.kernel.org/linux-f2fs-devel/20230529104709.2560779-1-chao@kernel.org

Thanks,

> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>   fs/f2fs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5ac53d2627d2..3a97b753a074 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3957,7 +3957,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>   	file_start_write(filp);
>   	inode_lock(inode);
>   
> -	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
> +	if (get_dirty_pages(inode)) {
>   		ret = -EBUSY;
>   		goto out;
>   	}


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
