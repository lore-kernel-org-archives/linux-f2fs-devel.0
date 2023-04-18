Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86564C77B75
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Apr 2023 15:51:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ponbv-0003cv-1H;
	Tue, 18 Apr 2023 15:51:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ponbt-0003cp-6k
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Apr 2023 15:51:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SWIIHK88UX74y/rLDAQZ/bqtN388K70bDoKvMBQpPFM=; b=UO7Uv/0Us+0UvT3/uLnrv+5vUf
 +yWMzwhO+3TVaMLjutEeGd7UrDXmnskRdAATR6zdHpWX0Zy/ZJIAj8lyWcZ7IL5KcXPNv0Q3rwiUx
 cznfB7RhPvoNrA1LKjwOG59RiJcSshebeVfPrhSIAzJ96CLZNOVnMV8B+JliC8vI2D6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SWIIHK88UX74y/rLDAQZ/bqtN388K70bDoKvMBQpPFM=; b=MDqmWE4uosIn9ZjDnYQM+RfbOU
 jIyT36sFAiiHX4MVqjI5+DQtS5872mgFOstCQYsZKH4KU+1k3QKwdnGbMllitakDDdIUNUPI6J0Ze
 Ei5UL6pMkxmZvy9iRD8uzM2v6eOEkoZXzZrOwr07FyL4l0UunCBqDC9QJ6LG4rBJl/8Q=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ponbs-00BXa9-Rz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Apr 2023 15:51:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 024FB635C8;
 Tue, 18 Apr 2023 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838DAC433EF;
 Tue, 18 Apr 2023 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681833066;
 bh=Ra9LOOWN9eSP/4y8aM9TfE/7Ag8xiVkMl5Q5mzBrecQ=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=P/izFCk/AKRvCxZjg8Shl0wwFYA0f007+xbf2DYwzCo9+kWejl6kYM0QB29UTfu06
 csRkkw0kQOtEjjtFkSPMlX6J8JzFfVSdlm+jXKoprEpRG9dSQ4Xlk6ltnS99i/DEPH
 NeiaJspeorMmvCD0CTThN0AM6atv0Fq5GS5daWOgE9Lt6RRJRwf/qIxvLM8Bc6uXBp
 pSgGsLsAf1aKAVXV0s5C0v3ARJyXmbAojXt6zgi7fzJVfP3UOVq0gO1gkXW10favaP
 mqfhPPS3+EHh87jQZ+eppKEasxaaxaFEJSbb6ZyLBttf1w3T8TNDQXMmdvIT4GWPTl
 rMr94pU2wEXbg==
Message-ID: <e2ec7e19-634c-a065-fe7a-b052d02d4752@kernel.org>
Date: Tue, 18 Apr 2023 23:51:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230414104308.6591-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230414104308.6591-1-bo.wu@vivo.com>
X-Headers-End: 1ponbs-00BXa9-Rz
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: allocate trace path buffer from
 names_cache
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
Cc: wubo.oduw@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/14 18:43, Wu Bo wrote:
> It would be better to use the dedicated slab to store path.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fs/f2fs/file.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 15dabeac4690..27137873958f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4361,7 +4361,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
>   	struct inode *inode = file_inode(iocb->ki_filp);
>   	char *buf, *path;
>   
> -	buf = f2fs_kmalloc(F2FS_I_SB(inode), PATH_MAX, GFP_KERNEL);
> +	buf = __getname();

How about:

buf = f2fs_kmem_cache_alloc(names_cachep, GFP_KERNEL, NULL, F2FS_I_SB(inode));

>   	if (!buf)
>   		return;
>   	path = dentry_path_raw(file_dentry(iocb->ki_filp), buf, PATH_MAX);
> @@ -4374,7 +4374,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
>   		trace_f2fs_dataread_start(inode, iocb->ki_pos, count,
>   				current->pid, path, current->comm);
>   free_buf:
> -	kfree(buf);
> +	__putname(buf);

kmem_cache_free(names_cachep, buf);

Thanks,

>   }
>   
>   static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
