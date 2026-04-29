Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80217FF8867
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Apr 2026 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UpuA38OUAKguXRoif2gaEY6FfkNUYgdYdzTwUfiNdCs=; b=Mqc/A5fz9tpeBhw2GJ96I1tW37
	Q9ApcT9Z1u10ocsYvMokmAZ4J9dLrjuVc5v8IpNuZd5L5Z2YMKdBZPnvkJM5gyAfnL+LOUnhje+wJ
	Qg2eu2pv0XTXfEm2psBXq/8RMAAyMpoM2g9eJD0XfQ8I05SFAZ1VX4/AIl5Jlz4nK8cU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHzai-0001ss-OT;
	Wed, 29 Apr 2026 07:44:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wHzah-0001sj-4y
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 07:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bSug7nFujoSJuXEU+hhGmYh7zVic09yjfXY4gzfoPO4=; b=NO1BRofPZlp4QEMUP6/Ka7yyG+
 4iZOPmz2DJc5adjiFrXujAGuZlhxMDIdT/edMOUsj7xPaI4nSWpiUeB55VqyiqsJfoN2e/CtMNM48
 aKuaUGUJ75/DqYub45s9DRshD3UG9l5+neTLDtSX4N3OOW8xHRhW3BVUSGUNkMJliV/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bSug7nFujoSJuXEU+hhGmYh7zVic09yjfXY4gzfoPO4=; b=WGA2ycR517d4kpizGuxD/vsHBx
 9pftnin2/+ptOQIoUUtkaY2RHV5+ilhsE5oNU8+8v3gmpDsnXkmVy25etpq/6Havy3LwrHLdBrXej
 Hf8HIiavyc6Or9ofkwkjr/cytaPZ+zdqH7TWRtyiUcsRy/94Q+Lub+PlpeaSMRTV6q5A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHzag-0000y9-1N for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 07:44:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5ED2E60582;
 Wed, 29 Apr 2026 07:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD6BC2BCC4;
 Wed, 29 Apr 2026 07:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777448648;
 bh=FZzV5qN+mY5SumTrbEaHACIvGbUnXVThL40tF7WieTE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=W/yLeLwZb4IQ44MD58DInUL5opudCbvOgYEVMpB3V2BeZ5gqIR0pcPbhP3O24wS9G
 2Y5UMzvrjZVCQiaa+02b1BAeZOMGNhvN8w3UXQbiFi503geHGcexQ/51fnxx4Inqgn
 PFahV1+hS23bc+tAzON3hghZsFWtA+QRmlXZMVV+HlmlFaWyC68DeFFOdwLe0li/GU
 qR/XhoSVvfwObJ748wpqnWhYw0kCISJdMZRDmGBnDbO57HK9ljFSx2t7DXeFH1iqdO
 onhg7jF6JuqnjnDa6/0Mrm8A3PxKyxkkNKK2UzSzu8zDLJacawrr+a4KSs5JgH2WUO
 8gCgFwFd7HSnA==
Message-ID: <76c97aef-7c28-4d50-887b-4624d7b2c1ba@kernel.org>
Date: Wed, 29 Apr 2026 15:44:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260423034223.1369837-1-jinbaoliu365@gmail.com>
Content-Language: en-US
In-Reply-To: <20260423034223.1369837-1-jinbaoliu365@gmail.com>
X-Headers-End: 1wHzag-0000y9-1N
Subject: Re: [f2fs-dev] [PATCH] f2fs: add iostat tracking for direct IO
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: shengyong1 <shengyong1@xiaomi.com>, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/23/26 11:42, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> F2FS did not collect iostat statistics for direct IO reads and writes,
> hook submit_io to bind an iostat context and record the submission
> timestamp, replace bi_end_io to collect IO latency on completion and
> then call back to the original iomap_dio_bio_end_io(), to add iostat
> tracking support for F2FS DIO.

Not sure, do we need to distinguish the latency of DIO from buffered IO?

> 
> Signed-off-by: shengyong1 <shengyong1@xiaomi.com>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
>   fs/f2fs/file.c   | 27 +++++++++++++++++++++++++++
>   fs/f2fs/iostat.c |  2 +-
>   2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 2c4880f24b54..fcf725931fd8 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4774,6 +4774,16 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
>   	return true;
>   }
>   
> +static void f2fs_dio_end_bio(struct bio *bio)
> +{
> +	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
> +	void *orig_bi_private = iostat_ctx->post_read_ctx;
> +
> +	iostat_update_and_unbind_ctx(bio);
> +	bio->bi_private = orig_bi_private;
> +	iomap_dio_bio_end_io(bio);
> +}
> +
>   static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
>   				unsigned int flags)
>   {
> @@ -4786,8 +4796,21 @@ static int f2fs_dio_read_end_io(struct kiocb *iocb, ssize_t size, int error,
>   	return 0;
>   }
>   
> +static void f2fs_dio_read_submit_io(const struct iomap_iter *iter,
> +					struct bio *bio, loff_t file_offset)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(iter->inode);
> +	void *bi_private = bio->bi_private;
> +
> +	iostat_alloc_and_bind_ctx(sbi, bio, bi_private);
> +	iostat_update_submit_ctx(bio, DATA);
> +	bio->bi_end_io = f2fs_dio_end_bio;
> +	blk_crypto_submit_bio(bio);
> +}
> +
>   static const struct iomap_dio_ops f2fs_iomap_dio_read_ops = {
>   	.end_io = f2fs_dio_read_end_io,
> +	.submit_io = f2fs_dio_read_submit_io,
>   };
>   
>   static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> @@ -5064,8 +5087,12 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	enum log_type type = f2fs_rw_hint_to_seg_type(sbi, inode->i_write_hint);
>   	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
> +	void *bi_private = bio->bi_private;
>   
>   	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
> +	iostat_alloc_and_bind_ctx(sbi, bio, bi_private);
> +	iostat_update_submit_ctx(bio, DATA);
> +	bio->bi_end_io = f2fs_dio_end_bio;
>   	blk_crypto_submit_bio(bio);

There are duplicated codes in f2fs_dio_write_submit_io() and f2fs_dio_read_submit_io(),
can we introduce a common function to wrap those codes?

Thanks,

>   }
>   
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index f8703038e1d8..57d2c3e68a1b 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -218,7 +218,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>   	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>   	unsigned long flags;
>   
> -	if (!sbi->iostat_enable)
> +	if (!sbi->iostat_enable || iostat_ctx->submit_ts == 0)
>   		return;
>   
>   	ts_diff = jiffies - iostat_ctx->submit_ts;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
