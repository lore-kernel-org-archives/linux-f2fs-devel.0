Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DA8C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Nov 2022 19:52:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oxCqF-0002Kq-Ip;
	Mon, 21 Nov 2022 19:52:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1oxCqD-0002Kk-Vq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Nov 2022 19:52:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iaPVkf5sYf3j1N/ewWUR48878n+szf9W4DAsM3uKlmE=; b=I5xqQCRSdhC7YM1ArNWY6XFYAT
 6mriXpSioZUBYZ31xdEBt1smtpsi86pdXKHO1PiM7TJw6rHyIPJEOao0PUWha3CJyiQi1VhuA5sY9
 MTjVun1oOtkuJegQN9B/ePtbJdIQVNTuxpvGtjwlTTjdBmFNhJdZGwLClpay0AKp0KLY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iaPVkf5sYf3j1N/ewWUR48878n+szf9W4DAsM3uKlmE=; b=YCgYxl/TwnxYPegLBnhVVUloKY
 YyxxbHicE3zRMQd3MLOmjkLsOT8xyLy1nRppuZpIYYIZ6KQ/7zeBF5BB8SsJuktUg5As6sF7bcEYw
 A22HgizawH7zTmWuCTL1gKMrmNBftawFi5tkl/+qfkcb7/S6ZAN90381kKjqBECdvKT4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oxCqD-0007eh-CO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Nov 2022 19:52:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F407A61456;
 Mon, 21 Nov 2022 19:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3593CC433C1;
 Mon, 21 Nov 2022 19:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669060343;
 bh=e3ckNQ3AIoADAgf/ebPYYoIm7JZ0SGqlrtn9J2k3xWQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WVT4pmRQyclkI9wj3E0sS0TMkksmSbkkQqj66ikyHbwPoFKShZspYh3gjOUXrIVkZ
 2T5hY3fRA2FrEdkg5Ba9oeUbylKKPFeBQ1mEnh/tk+MakYyUC0d0Sjq3QFOxKqWkQh
 doaNEiGEUMTR6OB0HxAMCDlO5kUfhujQQm4S1iPL2uCP+7bQYd+u0LrEvpwjEczRce
 dIKCxAmWSSxBdveRpnjHXK3wETuCajOfXlb4dOnLstiCoubTitlxPk9l8ua8cSGc7W
 Jt+Tef4yqhp/ZdE19AYHBXoUsqKX7RhRiZTmrHrDSahzG7jiS3ElENnng4xtP3Lop7
 Bzd4v4Db3luag==
Date: Mon, 21 Nov 2022 19:52:21 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Alexander Potapenko <glider@google.com>
Message-ID: <Y3vW9Q8HVQth2Sz4@gmail.com>
References: <20221121112134.407362-1-glider@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221121112134.407362-1-glider@google.com>
X-Headers-End: 1oxCqD-0007eh-CO
Subject: Re: [f2fs-dev] [PATCH 1/5] fs: ext4: initialize fsdata in
 pagecache_write()
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
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org,
 syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Nov 21, 2022 at 12:21:30PM +0100, Alexander Potapenko wrote:
> When aops->write_begin() does not initialize fsdata, KMSAN reports
> an error passing the latter to aops->write_end().
> 
> Fix this by unconditionally initializing fsdata.
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Fixes: c93d8f885809 ("ext4: add basic fs-verity support")
> Reported-by: syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  fs/ext4/verity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index 3c640bd7ecaeb..30e3b65798b50 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -79,7 +79,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
>  		size_t n = min_t(size_t, count,
>  				 PAGE_SIZE - offset_in_page(pos));
>  		struct page *page;
> -		void *fsdata;
> +		void *fsdata = NULL;
>  		int res;
>  
>  		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
