Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA86C83F12
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Aug 2023 12:58:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qaboo-0003dT-M9;
	Mon, 28 Aug 2023 12:58:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qabon-0003dL-Sl
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 12:58:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cy+PqoW9MaccJe5BuETy5o4C6Ly7RbgS/10PS9PQyTc=; b=RE1w6ph4++HQthLjDkaDHzL2sT
 6xEgAJfwWb787EM0X6VfbAfwY8xANtESUFzlQa09sKSwGN6yH3o8V3UtvVcjw8sNzLonkfkjzDRxa
 zNBx0sS1E/mCi0ks3526HqS/6AzsXdI8SJRAlG9Nocp0di6XEmfAcZ1bdB1u+15ATd1g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cy+PqoW9MaccJe5BuETy5o4C6Ly7RbgS/10PS9PQyTc=; b=Z/mblPtEFK9kgGMkKbAENG9Z9w
 2XREC83kuWlzUC1Mh7HZdwUGDHDoftu1JtFfpuBv5b1DwU+mn1umet0xybk8p1Glm+6wq3ciun7Op
 AEqcEs/H/nwCgSl/OCWTb/ehcuhrzSG55FCC7FHL6N3Jz3MMBJYhbHINPut/AxiVvo1Y=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qaboj-000l0X-7S for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 12:58:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B779C6101C;
 Mon, 28 Aug 2023 12:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDAFC433C7;
 Mon, 28 Aug 2023 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693227478;
 bh=8cU2djbQzQGZfvO5mEqYGDCcsbdwpnMr9ZdtXrnK8iI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Di9gvKRP6tzRgQDhTqATp2XbwNQeb8dy99esv13fW63/rgXjXWQG+5WS7+1/aKl3v
 Sw+bHJcHRz9BWLryOOctWfXsxJWVKRilMe5Mtx4rtvVccjhWiGHMb4ySFf9RMhDglT
 l9tfIQxANtO0A7kP+GDhdOGxRxgpTxZfUdfo/b11OU/Hv/pMKB+/CScPmkceGkKKzw
 U9bUCNbudcaU4h/VMVmdxRM+/dretupx+ZkwfPbLIZbU4xWvAZzjkqBj/DACK02hY+
 iGTQ7c7OLJ6jl1HmblzKELTBE0qBNE9o2eMHNwEsKTi1lOU/9QK4WRhjupU/nClEW9
 k2EQSuAekMJ/w==
Message-ID: <1388dd5e-8d66-6f88-25d1-f563d7c366d6@kernel.org>
Date: Mon, 28 Aug 2023 20:57:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-23-jack@suse.cz>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230823104857.11437-23-jack@suse.cz>
X-Headers-End: 1qaboj-000l0X-7S
Subject: Re: [f2fs-dev] [PATCH 23/29] f2fs: Convert to
 bdev_open_by_dev/path()
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
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/8/23 18:48, Jan Kara wrote:
> Convert f2fs to use bdev_open_by_dev/path() and pass the handle around.

Hi Jan,

Seems it will confilct w/ below commit, could you please take a look?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=51bf8d3c81992ae57beeaf22df78ed7c2782af9d

Thanks,

> 
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/f2fs/f2fs.h  |  1 +
>   fs/f2fs/super.c | 17 +++++++++--------
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e18272ae3119..2ec6c10df636 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1234,6 +1234,7 @@ struct f2fs_bio_info {
>   #define FDEV(i)				(sbi->devs[i])
>   #define RDEV(i)				(raw_super->devs[i])
>   struct f2fs_dev_info {
> +	struct bdev_handle *bdev_handle;
>   	struct block_device *bdev;
>   	char path[MAX_PATH_LEN];
>   	unsigned int total_segments;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index aa1f9a3a8037..885dcbd81859 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1561,7 +1561,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>   	int i;
>   
>   	for (i = 0; i < sbi->s_ndevs; i++) {
> -		blkdev_put(FDEV(i).bdev, sbi->sb);
> +		bdev_release(FDEV(i).bdev_handle);
>   #ifdef CONFIG_BLK_DEV_ZONED
>   		kvfree(FDEV(i).blkz_seq);
>   #endif
> @@ -4196,9 +4196,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>   
>   		if (max_devices == 1) {
>   			/* Single zoned block device mount */
> -			FDEV(0).bdev =
> -				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
> -						  sbi->sb, NULL);
> +			FDEV(0).bdev_handle = bdev_open_by_dev(
> +					sbi->sb->s_bdev->bd_dev, mode, sbi->sb,
> +					NULL);
>   		} else {
>   			/* Multi-device mount */
>   			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
> @@ -4216,12 +4216,13 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>   					(FDEV(i).total_segments <<
>   					sbi->log_blocks_per_seg) - 1;
>   			}
> -			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
> -							  sbi->sb, NULL);
> +			FDEV(i).bdev_handle = bdev_open_by_path(FDEV(i).path,
> +					mode, sbi->sb, NULL);
>   		}
> -		if (IS_ERR(FDEV(i).bdev))
> -			return PTR_ERR(FDEV(i).bdev);
> +		if (IS_ERR(FDEV(i).bdev_handle))
> +			return PTR_ERR(FDEV(i).bdev_handle);
>   
> +		FDEV(i).bdev = FDEV(i).bdev_handle->bdev;
>   		/* to release errored devices */
>   		sbi->s_ndevs = i + 1;
>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
