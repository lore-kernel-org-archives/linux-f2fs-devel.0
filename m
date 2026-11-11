Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33910606A32E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CysWu8KK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AfYtc3D7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TEQd+HIK;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEXLROa6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AmzBQcIRibtjwuX+sxcbvb0dmK7OYyFhdofFJbDGLy8=; b=CysWu8KKKWaZGr
	emJ8y5lyG+lLmNArzzoJD5LAXSr6E6teUDmYSxa9tc/S0eyeTIE5hyT35oofHqWvGqw3F3qklKqh3
	d9QjFdR7wnMUYQhch9z5NX35gt4QcBGiOEAjYsfeluB+aer70IFJr27FT05X4xyxg3D1DSvVpzuPM
	k4Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR3Yo-000000001iS-1Noi;
	Wed, 11 Nov 2026 08:20:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xR3Ym-000000001hc-32PM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:20:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+oxjStHEHoefxFsm+KwtZhtmkkwQmSjmnWwb2W4j1Jw=; b=AfYtc3D7F4ArKeX4mCIR2Nw0fq
 2GTLSbY1x3Ya7wZMhse+EbgZK4jP/aDymdCptHjRqrCNyuqdSEEfAifzKgv/KoQRdmqSw1jIgAFTh
 IioVH1swsBt7DS2ENHWRx7Mxg+zd3o3a87bm+1WE83OiBQGSNwKaaCdH5fCLK/fGhUtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+oxjStHEHoefxFsm+KwtZhtmkkwQmSjmnWwb2W4j1Jw=; b=TEQd+HIKGbQiYzNpD9iuzyhzBy
 l8Vv4S7Ftnq0Pq3aAsK/HYXe1pnopmO3kLieS9fUSwi5oVDPNGTQPYjjKSGFMiqQa4zaUTyOlV7uO
 7qWYXUnmonIjt4K/8HmBuHhXL8Oj0h2FcJlUo92iKumIUB20OPF8PwTS5ppSxFCUuHZs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR3Yl-000000006sk-19m4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:20:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5CAF43611;
 Wed, 11 Nov 2026 08:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05E01F00A05;
 Wed, 11 Nov 2026 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794385193;
 bh=+oxjStHEHoefxFsm+KwtZhtmkkwQmSjmnWwb2W4j1Jw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VEXLROa6kvDRDxSIQt7NekFU+4rly7RsSMI/io8cmB/6VfRX39IvQacxb64yIiwQS
 3DFuH6dQQSO9njzgnwHL+14rzTJHFmwDK5NzYSXdXXkuhWVkTWng3kNiBIFYzp5NdI
 mDmXISG0aABpTpSfX4NOA0LVBgLn+R049kFCTiRBEZQOz19P1oTEGZcUK4+NNQTNVu
 eN8oyHwzNjI1RDWgqVgCdXK0KmEcS0P25La5Pcpyyx8FvlDg77bbVHX3MTYTJBRJVb
 Nz6kl9aX4BABcf2pNtllaWcdSQhXhRz9n18QPCr0hMVu2BJEafzinrg2/TYTVClzr0
 Se3MePmg5oTnw==
Message-ID: <b2253246-48ba-4c48-899c-9f568fa2df71@kernel.org>
Date: Wed, 11 Nov 2026 16:19:50 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: huang zheng <huangzheng9869@gmail.com>, jaegeuk@kernel.org
References: <20261103091215.180531-1-huangzheng9869@gmail.com>
Content-Language: en-US
In-Reply-To: <20261103091215.180531-1-huangzheng9869@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR3Yl-000000006sk-19m4
Subject: Re: [f2fs-dev] [PATCH] f2fs: add checkpoint step timing statistics
 to debugfs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: huangzheng1@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 17:12, huang zheng wrote:
> From: Huang Zheng <huangzheng9869@gmail.com>
> 
> This patch adds detailed timing statistics for each checkpoint step
> to the debugfs stat_show interface. It displays the time taken by
> each phase of the checkpoint process, including:
> 
> - lock acquisition
> - block operations
> - flushing data/node/meta pages
> - flushing NAT/SIT
> - syncing metadata
> - waiting for dirty meta/checkpoint data
> - device flushing
> - waiting for last checkpoint

Well, all spot times should be consistent only after checkpoint(), if stat_show()
captures times during checkpoint, the times could be inconsistent.

> 
> This information is valuable for debugging checkpoint performance
> issues and identifying which steps are taking the most time during
> the checkpoint process.
> 
> The statistics show the longest recorded time for each step, helping

It didn't, it record the time every time, but only printing the stats in
kmsg if the total time exceeds the threshold (5sec).

Thanks,

> developers and users understand where checkpoint bottlenecks occur.
> 
> Signed-off-by: Huang Zheng <huangzheng1@xiaomi.com>
> ---
>  fs/f2fs/debug.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 6fe606e2c70d..8fd76a69dcad 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -445,6 +445,22 @@ static const char *ipu_mode_names[F2FS_IPU_MAX] = {
>  	[F2FS_IPU_HONOR_OPU_WRITE]	= "HONOR_OPU_WRITE",
>  };
>  
> +static const char *cp_time_names[CP_TIME_MAX] = {
> +	[CP_TIME_START]		= "begin",
> +	[CP_TIME_LOCK]		= "lock",
> +	[CP_TIME_OP_LOCK]	= "block_operation",
> +	[CP_TIME_MERGE_WRITE]	= "flush_data_node_meta",
> +	[CP_TIME_FLUSH_NAT]	= "flush_nat",
> +	[CP_TIME_FLUSH_SIT]	= "flush_sit",
> +	[CP_TIME_SYNC_META]	= "sync_meta",
> +	[CP_TIME_SYNC_CP_META]	= "sync_cp_meta",
> +	[CP_TIME_WAIT_DIRTY_META] = "wait_dirty_meta",
> +	[CP_TIME_WAIT_CP_DATA]	= "wait_cp_data",
> +	[CP_TIME_FLUSH_DEVICE]	= "flush_device",
> +	[CP_TIME_WAIT_LAST_CP]	= "wait_last_cp",
> +	[CP_TIME_END]		= "unblock_operation",
> +};
> +
>  static int stat_show(struct seq_file *s, void *v)
>  {
>  	struct f2fs_stat_info *si;
> @@ -631,6 +647,14 @@ static int stat_show(struct seq_file *s, void *v)
>  		seq_printf(s, "  - Total : %4d\n", si->nr_total_ckpt);
>  		seq_printf(s, "  - Cur time : %4d(ms)\n", si->cur_ckpt_time);
>  		seq_printf(s, "  - Peak time : %4d(ms)\n", si->peak_ckpt_time);
> +		seq_puts(s, "CP steps (longest):\n");
> +		seq_printf(s, "  - Total : %llu(ms)\n",
> +			   (u64)ktime_ms_delta(sbi->cp_stats.times[CP_TIME_END],
> +					sbi->cp_stats.times[CP_TIME_START]));
> +		for (j = 0; j < CP_TIME_MAX - 1; j++)
> +			seq_printf(s, "  - %s : %llu(ms)\n", cp_time_names[j + 1],
> +				   (u64)ktime_ms_delta(sbi->cp_stats.times[j + 1],
> +					sbi->cp_stats.times[j]));
>  		seq_printf(s, "GC calls: %d (gc_thread: %d)\n",
>  			   si->gc_call_count[BACKGROUND] +
>  			   si->gc_call_count[FOREGROUND],



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
