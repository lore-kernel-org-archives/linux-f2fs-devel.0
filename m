Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74592C87FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Jul 2025 02:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hPLlmzz8GOD9YQyTIRKWwyahc6VL/MYC6I6uM0x0k/k=; b=fm9koPCZXFfYOjW2zEM+clEwiC
	4XbGDulLhxDkmqXvYzEoflt/9t0+E/L80z8au+MEnw0b+8akTXduADczcjXEQqJIYeMYlMCg7jDdh
	b0v2qhojg55809m0Ldeopc5IkkSam7mRyXgmXssQUvYjLPKoZDaEwEzT+PcRaPBrQhFw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uhJAn-0002O9-3F;
	Thu, 31 Jul 2025 02:37:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uhJAm-0002O3-4W
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Jul 2025 02:37:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mRT5SmRRdkIjgGopmBCvZCSWFqiyydkIHMsBgCpLBEk=; b=iUE6B9/qB0nq1uv8262Lhaxdj8
 3h3Y9dSC45y10DoByLHHt7xVOCJe7FD1XqcBmjF0u7RL7pZYlycizYfJGdwzRqVfvTv+c3wpoS2bu
 DRh0YVTd5Y+6ZeuZRLfEJp5uFyB+tUvMvvcqqgw3RLvCV6Uezy+W2e37fv2xQEXKouJY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mRT5SmRRdkIjgGopmBCvZCSWFqiyydkIHMsBgCpLBEk=; b=FTCSBL4ZL6RGQHpe4m4pWs7kpi
 ytxAl4zRJVYjh5IqKLmIz0bnSD6xKiOMaCSV6uL12kIqqUB+hCuwJVJtSpRywNZGJRLHqQCYkZNLV
 6Ddh6l9TztwOzDmGwGo9hq6LdYayL1fyd+u4V7ZU0e7+2rz3NNswv2OdAFKoquR+ank0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uhJAl-0006gn-Nj for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Jul 2025 02:37:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0371B60051;
 Thu, 31 Jul 2025 02:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34767C4CEE7;
 Thu, 31 Jul 2025 02:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753929444;
 bh=95Q2MQJpejoNqVfRLbKKN1BDQdWqt3GGKYHfRa8niks=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=ALoEcrxD4fHEKfPUeLT+tI52XqhS2dGCVPl5Oq3VQweLKIhuOKMLI0w0e0l7l7HiD
 4L1Bg+ou/Xd6N86Ny+MZGuCKJdwu8cUE3qYeHraQXOFd4Qe88wqVhSzwHfMkkKyf/z
 +9SPnPqFeyxG8In/cVn1ZrnjqhZD4Jw30awjVxcJujCNE3cjvpjdZ6J7AElj1Oh7Yl
 Su86DA2oKWpy5RyFraVaRwbzD3a9vN/SbAxvDkDYGni+PMi8vL2SGn3oEHNZtt+Rgb
 oRIPvkcNRII4lgFFGhMHbiLr41xTI4X3ip+1XSCoRI/kq6EA8kbuxZ1gmJBYlG+efF
 lbHOEd2Fclg1w==
Message-ID: <80904609-92b2-4e91-846d-d0c1c1afb513@kernel.org>
Date: Thu, 31 Jul 2025 10:37:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "mason.zhang" <masonzhang.linuxer@gmail.com>
References: <20250730100633.26292-1-masonzhang.linuxer@gmail.com>
Content-Language: en-US
In-Reply-To: <20250730100633.26292-1-masonzhang.linuxer@gmail.com>
X-Headers-End: 1uhJAl-0006gn-Nj
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add error checking in
 do_write_page()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/30/25 18:06, mason.zhang wrote:
> Otherwise, the filesystem may unaware of potential file corruption.
> 
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
> ---
>  fs/f2fs/segment.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ae1223ef648f..10aaa32defca 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3936,12 +3936,17 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>  	int seg_type = log_type_to_seg_type(type);
>  	bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
>  				seg_type == CURSEG_COLD_DATA);
> +	int err;
>  
>  	if (keep_order)
>  		f2fs_down_read(&fio->sbi->io_order_lock);
>  
> -	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> -			&fio->new_blkaddr, sum, type, fio)) {
> +	err = f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> +			&fio->new_blkaddr, sum, type, fio);
> +	if (unlikely(err)) {
> +		f2fs_err_ratelimited(fio->sbi,
> +			"%s Failed to allocate data block, ino:%u, type:%d, err:%d",
> +			__func__, fio->ino, type, err);

Can we print page->index, old_blkaddr, new_blkaddr as well?

Thanks,

>  		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
>  			fscrypt_finalize_bounce_page(&fio->encrypted_page);
>  		folio_end_writeback(folio);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
