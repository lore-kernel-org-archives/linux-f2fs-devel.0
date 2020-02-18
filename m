Return-Path: <SRS0=tJjq=4G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DACC34031
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:33:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943FE2173E;
	Tue, 18 Feb 2020 21:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="FaSpWOdp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EQ5+Gvke";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="f5Iuo6bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943FE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j4AUl-0007MT-0G; Tue, 18 Feb 2020 21:33:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jhubbard@nvidia.com>) id 1j4AUk-0007MM-4s
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Feb 2020 21:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RXve5/fUA3oBILhUm8o+y+17c7pBmRijpBQPJAnmP80=; b=FaSpWOdpNYLXvdTwfJx5BRdcqw
 4xF65w82lJ+vVWxK19E5KMGkxF9pZpfeYKleRFSf8sUUIfyHXL5fr8oNyTIXHJy9nuDoKJyyBOnCL
 yJUGqk29/Qg9MJEA9vmah3/iQSlp4ZH05lCowV8paJLFb7UKuIZloLtBo1jLcE/IRGS0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RXve5/fUA3oBILhUm8o+y+17c7pBmRijpBQPJAnmP80=; b=EQ5+GvkejYGaR+orkwA5DHvjP0
 BmDmXRcnKXUtpVPsShyg9BYOLTiRrVQ9cJP+75fJJJS+MPBGB9dWmPUH2O5vG8YefX/MwrwAkGdVm
 B0S14U0rR37KIn3+2h9aSuCcMxplIqyFwqkxb1gtTiY4VMZBAE9qUEv3f0kAOWZTVvW4=;
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j4AUi-007iM1-WF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Feb 2020 21:33:30 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4c57d90000>; Tue, 18 Feb 2020 13:32:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Feb 2020 13:33:20 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 13:33:20 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 21:33:19 +0000
To: Matthew Wilcox <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-3-willy@infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ed5b3635-be1b-c290-0e19-b516e7af2aca@nvidia.com>
Date: Tue, 18 Feb 2020 13:33:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-3-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582061529; bh=RXve5/fUA3oBILhUm8o+y+17c7pBmRijpBQPJAnmP80=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=f5Iuo6blIXbcDZrM05UIgCY8ANT5xW9HB6FXMMGQCfaHMfBnR1DfaWLTMAYIE7XBP
 B9QOW8wSO4ij5j+4bCfhLlUR2LpeSTGJV0y8tnLGhP+d4at2LBMPXmcd1007q6GV+V
 F6nXmc1d8pgAlmrCaaR8bklkj+n7DiCZH8Mj9XZsOl6SUYvt06XEAlqdCtbjrJAqsO
 JEKRbCwBCkx6iNbCJyyfXN8/DDeOTx/qKgkY7yedkT+Pn0V+QFJNvk6ybzosDhS50D
 pgn5lvAGlEV280+lBsRM1YfSDahNeoARNWUSdQ6PSTGWm5OdOjiCPRr9K7h5I26KXq
 jvW6k1ji+T2MA==
X-Headers-End: 1j4AUi-007iM1-WF
Subject: Re: [f2fs-dev] [PATCH v6 02/19] mm: Ignore return value of
 ->readpages
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We used to assign the return value to a variable, which we then ignored.
> Remove the pretence of caring.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/readahead.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Looks good,

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 8ce46d69e6ae..12d13b7792da 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,17 +113,16 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
>  
>  EXPORT_SYMBOL(read_cache_pages);
>  
> -static int read_pages(struct address_space *mapping, struct file *filp,
> +static void read_pages(struct address_space *mapping, struct file *filp,
>  		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
>  {
>  	struct blk_plug plug;
>  	unsigned page_idx;
> -	int ret;
>  
>  	blk_start_plug(&plug);
>  
>  	if (mapping->a_ops->readpages) {
> -		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
> +		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
>  		/* Clean up the remaining pages */
>  		put_pages_list(pages);
>  		goto out;
> @@ -136,12 +135,9 @@ static int read_pages(struct address_space *mapping, struct file *filp,
>  			mapping->a_ops->readpage(filp, page);
>  		put_page(page);
>  	}
> -	ret = 0;
>  
>  out:
>  	blk_finish_plug(&plug);
> -
> -	return ret;
>  }
>  
>  /*
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
