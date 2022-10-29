Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1723BC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Oct 2022 04:47:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oodl6-0003qA-ES;
	Sat, 29 Oct 2022 04:47:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oodl4-0003q4-IW
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Oct 2022 04:47:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KUOB99+eNFVZwcGV53fgw8ytEoA1O6w5bQdwqcMTdN8=; b=lUc740BICPHGdiirnCxnd5kkdK
 5jvLfCIEt/5YQaMl+Guq0EJNwfUTl4dxKK96hYtn7RcpeP0cb9QeHGsXhURj0WHDz5rUeZsiDZ4VR
 qkgFmbvX/uyWu4S6qLEdkXRJeAZ4dTUffN50JhiQwZaYIRK0C7KEFbeg3VfYFa7UbbAc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KUOB99+eNFVZwcGV53fgw8ytEoA1O6w5bQdwqcMTdN8=; b=gAzzDVhJX1H8Yfc/nvSc/4b6yX
 EN7G3z/ep6DvGpxfVW4RbmXShUszegTZq0ATDyqkESsaf6jyddVV6W1fsk7ZBrsupBe37haLyh6pE
 3IhVAKEL+cWo+UsUff+Tb6HcEdiB+8Wb4VB8aWLLSRs8zJLf8ceaNOFGo78rh22//lko=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oodl2-0006KW-DI for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Oct 2022 04:47:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 64967CE2FCF;
 Sat, 29 Oct 2022 04:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA46BC433C1;
 Sat, 29 Oct 2022 04:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667018852;
 bh=mAACII8QLXPb+2oghNArcGBgEFrS6aOgUSNOHVDZKPc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CYsWQpVBnAqxfH9QjR9cAu5rm4qWCaoDoHDMrXu8qeGJPjfInBlhlb4hosNwuCb5y
 2/JzqwR6JP/mLfD9pMpYktbhYQ40F+5gyKrX5+LhkAeZVCGACQWLfAJN1MO+F+rPcr
 pF8cd+2VZwfLQNvSAvq7XUTQh6KwHuX3FKB2+f+TAi2/+GyiiYYojDCj8PoUYR+ZFY
 DOI0yXq6r/4zM8H+euAL9EjltJmkjxHL7PzH4n9I24I4nBVjmUa8zpgWtf5jD8qY3B
 fNuxhK1UeMdSTzH7u3Edo7OiEPYEp8TUmTzUuPUUxaMVZZr+PpvXV+EUQRERLh+cl5
 knBFlU8Gx7F1w==
Message-ID: <80fe1f37-586b-4fc6-f007-1d3e8ec3fdb9@kernel.org>
Date: Sat, 29 Oct 2022 12:47:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 linux-fsdevel@vger.kernel.org
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-14-vishal.moola@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221017202451.4951-14-vishal.moola@gmail.com>
X-Headers-End: 1oodl2-0006KW-DI
Subject: Re: [f2fs-dev] [PATCH v3 13/23] f2fs: Convert
 f2fs_sync_node_pages() to use filemap_get_folios_tag()
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
Cc: linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ceph-devel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/18 4:24, Vishal Moola (Oracle) wrote:
> Convert function to use a folio_batch instead of pagevec. This is in
> preparation for the removal of find_get_pages_range_tag().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/node.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index a2f477cc48c7..38f32b4d61dc 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1935,23 +1935,24 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>   				bool do_balance, enum iostat_type io_type)
>   {
>   	pgoff_t index;
> -	struct pagevec pvec;
> +	struct folio_batch fbatch;
>   	int step = 0;
>   	int nwritten = 0;
>   	int ret = 0;
> -	int nr_pages, done = 0;
> +	int nr_folios, done = 0;
>   
> -	pagevec_init(&pvec);
> +	folio_batch_init(&fbatch);
>   
>   next_step:
>   	index = 0;
>   
> -	while (!done && (nr_pages = pagevec_lookup_tag(&pvec,
> -			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
> +	while (!done && (nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi),
> +				&index, (pgoff_t)-1, PAGECACHE_TAG_DIRTY,
> +				&fbatch))) {
>   		int i;
>   
> -		for (i = 0; i < nr_pages; i++) {
> -			struct page *page = pvec.pages[i];
> +		for (i = 0; i < nr_folios; i++) {
> +			struct page *page = &fbatch.folios[i]->page;
>   			bool submitted = false;
>   
>   			/* give a priority to WB_SYNC threads */
> @@ -2026,7 +2027,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>   			if (--wbc->nr_to_write == 0)
>   				break;
>   		}
> -		pagevec_release(&pvec);
> +		folio_batch_release(&fbatch);
>   		cond_resched();
>   
>   		if (wbc->nr_to_write == 0) {


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
