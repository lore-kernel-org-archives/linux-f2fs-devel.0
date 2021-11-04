Return-Path: <SRS0=DfLr=PX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67FAC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Nov 2021 07:16:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769FE61053;
	Thu,  4 Nov 2021 07:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 769FE61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1miWyv-0006uC-Eq; Thu, 04 Nov 2021 07:16:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1miWyu-0006u6-Jg
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Nov 2021 07:16:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JBvu/+T6CnW4dddTKEjTIbvDRP7lrCGxHPDv6PqtliQ=; b=TTQ1bxFHAPeyXRCjW+Ps2JIqcE
 p3Nxjty3jF0NmiWAJZyvE4HScnJc4hK7Pp/qJnQD0Q3fiKQg9/k2oQrqciOo82slUwKq1ZaUoIVLT
 h3thuKKUt3MhGHc/jpaOwg9rW+Eeuwhf520oOYbT5R+lYveTPXmgTH0Kbyh43i17WH28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JBvu/+T6CnW4dddTKEjTIbvDRP7lrCGxHPDv6PqtliQ=; b=H1rAH4UBBw+LWNwfjxDwduN2Uh
 PCBf+gRshyD6ubvKK/SJd6NAFjH6QFi3zAqGWlqKM8Q2cwFyWzCRwBtqYLalyoSggyHtcv1Tb1VNb
 OleVA/u2yugYqaVcjUqxqb6K72GQsYx7dtlb1a1d3C0wWZcQPfP8+NeBP9Ee67pVusdI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1miWyt-00162R-VH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Nov 2021 07:16:16 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6675961056;
 Thu,  4 Nov 2021 07:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636010170;
 bh=/dVlynt37zb9p9c8G7o66XYxQ/Hn5PBByKWDe/nablk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sHPXjo7NKu63XF4cSFNT+TBoso3STuQipEnf+3hv/5siAjihVxRx2vWLG/TRLuf7U
 JdtQJuq/VySNcJ49MApb5HWDROOgBaw58I/4MNtPVcBEuhP/8SG3pbtWWMCSHhA5Ct
 eP7yN+1gM3XcQbJWrBMz/hcWfGSGyEFW8Ma1kra6P89Bg5A+EntXZ5GJ4wT8iqnQ3p
 D6KXLjluvAvvTkbH+mP7SlUADYD9t4//6/hvAB2YtCqN/wI7OnYRBuzVNrs63fjARS
 cpY3/o2K+CBBpu9u817Ht7mIqK6IOhI0cwNvTVUymc+Uut0+Di1ALCUNhQBTsh2wV1
 +kcEAVbGFkhgA==
Message-ID: <bff77e5c-7e14-32c5-6ffe-78e35271532b@kernel.org>
Date: Thu, 4 Nov 2021 15:16:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To: Dongliang Mu <mudongliangabcd@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20211103142228.1235864-1-mudongliangabcd@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211103142228.1235864-1-mudongliangabcd@gmail.com>
X-Headers-End: 1miWyt-00162R-VH
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix UAF in
 f2fs_available_free_memory
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

On 2021/11/3 22:22, Dongliang Mu wrote:
> f2fs_fill_super
> -> f2fs_build_segment_manager
>     -> create_discard_cmd_control
>        -> f2fs_start_discard_thread
> 
> It invokes kthread_run to create a thread and run issue_discard_thread.
> 
> However, if f2fs_build_node_manager fails, the control flow goes to
> free_nm and calls f2fs_destroy_node_manager. This function will free
> sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
> after the deallocation, but before the f2fs_stop_discard_thread, it will
> cause UAF(Use-after-free).
> 
> -> f2fs_destroy_segment_manager
>     -> destroy_discard_cmd_control
>        -> f2fs_stop_discard_thread
> 
> Fix this by switching the order of f2fs_build_segment_manager
> and f2fs_build_node_manager.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>   fs/f2fs/super.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 78ebc306ee2b..1a23b64cfb74 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4135,18 +4135,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   	}
>   
>   	/* setup f2fs internal modules */
> -	err = f2fs_build_segment_manager(sbi);
> -	if (err) {
> -		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> -			 err);
> -		goto free_sm;
> -	}
>   	err = f2fs_build_node_manager(sbi);
>   	if (err) {
>   		f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)",
>   			 err);
>   		goto free_nm;
>   	}
> +	err = f2fs_build_segment_manager(sbi);
> +	if (err) {
> +		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> +			 err);
> +		goto free_sm;
> +	}
>   
>   	/* For write statistics */
>   	sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
> @@ -4351,10 +4351,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   	sbi->node_inode = NULL;
>   free_stats:
>   	f2fs_destroy_stats(sbi);
> -free_nm:
> -	f2fs_destroy_node_manager(sbi);
>   free_sm:
>   	f2fs_destroy_segment_manager(sbi);
> +free_nm:
> +	f2fs_destroy_node_manager(sbi);

IIRC, above two functions shouldn't not be called reversely due to some
resource dependency, Jaegeuk, please help to confirm this.

So I suggest to call destroy_discard_cmd_control() before
f2fs_destroy_node_manager(), is it fine to you?

Thanks,

>   	f2fs_destroy_post_read_wq(sbi);
>   stop_ckpt_thread:
>   	f2fs_stop_ckpt_thread(sbi);
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
