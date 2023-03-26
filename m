Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666A9C6FD1C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Mar 2023 13:47:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgQia-0003ZY-G4;
	Sun, 26 Mar 2023 13:47:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pgQiU-0003ZR-Ru
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 13:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L/LZWqqG7X5vjnhpi75VHPT0CJh4H1QcujZQr0+wDss=; b=buwcke8x0MDitq+Myfqj8lNIDV
 Ov2K5rKIvPB4wHnGOIlrUSUanCMyAygq1tmYPaALYRduY0/X/7J9QQ9W0mgnU1PdJ7hTijF2lV1RA
 OPou2fjWVdoJRNNQw14MrPL/cy4TiaTwVqsun4CUtgDUcY2xOV5zloTwcbbV70MNupF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L/LZWqqG7X5vjnhpi75VHPT0CJh4H1QcujZQr0+wDss=; b=dv9Tom9i0kMqVTr4dPNcyaUGtU
 oxBl8ga5ZcWOFZe+qJYIbeuR1u7E4GMm/okVzmr1hOL6/RlFoEq8dm6bCehoBIntf20/Ha98zhn2o
 ebJB3Zxs8eEq3bD/M1XtYjZp2eUMzIu/lOrs2MkfCGtHECScE+5iCk5W6KJ45D5vKF6I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgQiU-004Mqi-IN for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 13:47:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EF3D660EE2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Mar 2023 13:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C6DC433D2;
 Sun, 26 Mar 2023 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679838437;
 bh=s2QYAdjbUYQBkX1WyFcFHz0Vhba1CYaExhV8K6Xm6iE=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=WlczRvY58+j7UqiQ0n27gc7fKfvprvdjanglAmNZrCG/VjSo5ZpvNgsN9mKbFRbGu
 M3cvoO1b6F7UzA0QCXq0SylaVtJKLGzBXeSa04nYzRWSyQdGVUwnxj553nXE2dL3Rb
 An34Z7ymKIhJi1n2WhwLZ6NkNb/tGxIPotAx+ngpi/NzuwIHblXvZ4bMH9ARUeM3dE
 qQ6WZ4y08cRTVb7xVoK2oyl/DHDQ2WsnuXMysrZFqB4Wm9r8vA+qzj4HFkrxU2KlPS
 xtmkYzV2gtbY9dFGHUC2Yn1/HjgdnjjA67jOlhm7D40Jb1Y5djR5zVuiEOfPNQvcWn
 SmEaSnCWmiM3Q==
Message-ID: <8aea02b0-86f9-539a-02e9-27b381e68b66@kernel.org>
Date: Sun, 26 Mar 2023 21:47:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230323213919.1876157-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230323213919.1876157-1-jaegeuk@kernel.org>
X-Headers-End: 1pgQiU-004Mqi-IN
Subject: Re: [f2fs-dev] [PATCH] f2fs: get out of a repeat loop when getting
 a locked data page
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
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/24 5:39, Jaegeuk Kim wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216050
> 
> Somehow we're getting a page which has a different mapping.
> Let's avoid the infinite loop.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/data.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index bf51e6e4eb64..80702c93e885 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1329,18 +1329,14 @@ struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
>   {
>   	struct address_space *mapping = inode->i_mapping;
>   	struct page *page;
> -repeat:
> +
>   	page = f2fs_get_read_data_page(inode, index, 0, for_write, NULL);
>   	if (IS_ERR(page))
>   		return page;
>   
>   	/* wait for read completion */
>   	lock_page(page);
> -	if (unlikely(page->mapping != mapping)) {

How about using such logic only for move_data_page() to limit affect for
other paths?

Jaegeuk, any thoughts about why mapping is mismatch in between page's one and
inode->i_mapping?

After several times code review, I didn't get any clue about why f2fs always
get the different mapping in a loop.

Maybe we can loop MM guys to check whether below folio_file_page() may return
page which has different mapping?

struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
		int fgp_flags, gfp_t gfp)
{
	struct folio *folio;

	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
	if (IS_ERR(folio))
		return NULL;
	return folio_file_page(folio, index);
}

Thanks,

> -		f2fs_put_page(page, 1);
> -		goto repeat;
> -	}
> -	if (unlikely(!PageUptodate(page))) {
> +	if (unlikely(page->mapping != mapping || !PageUptodate(page))) {
>   		f2fs_put_page(page, 1);
>   		return ERR_PTR(-EIO);
>   	}


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
