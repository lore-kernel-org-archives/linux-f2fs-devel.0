Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E40C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7KdKykqVmrBvyiILq/NJE0gASzDOrKhYrEYwc6YTGxo=; b=hqnq0GrjeldF1M5UlNqrWVpY88
	l+J4mLXteMyBFWGr8Z5LF05r02CNatV1nvrrWl3fhjzs7sXDuC3hGMMf0Wd8yPNetxGyyck3HQZsI
	u0WXg2IPEkLbEJwr620XSGg6FVSXAzQEDiWZeYvI52W/uMZCLrUrpD+xfMtKIU8Puqm0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0xfW-00066S-2n;
	Mon, 31 Aug 2026 08:47:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0xfV-00066L-3X
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VQnyeozED9KENp5fLCfASXjgZw48Aez7/KG7ZHlPB6o=; b=TZVTlnfiI6fkfF6kZvvW6xdp2Z
 Ska+n1xswgrqiPdP/h0qV+XYXYIYEFHRXfOcczpJV4ErC8ZuF2ktDktQ/BqzmSfhscazZPDN1j0g4
 LwpGcNvSE/UYLgL09lsxYL1xdmCbSeaqqVY7LU4V2UHU5bnb+ZaJMxEPsTReXMaVaq+E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VQnyeozED9KENp5fLCfASXjgZw48Aez7/KG7ZHlPB6o=; b=CgkaAUFEqJUoZJou3k6gJs8dFt
 w8r+mGR0SDeNxV42yDqD7khwEuG1UDh2+y8NecuVjAJ74tOORMRbvf7cRYo0m14MSNGnks9SVTd90
 JnihP4iPvaQckleGw4yg5OYdyidp7XjWAbYax66XGoieiwzG4IAQ0rMy3NjH8F1HekA8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0xfV-0005cU-9I for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:47:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FA7060120;
 Mon, 31 Aug 2026 08:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E401F000E9;
 Mon, 31 Aug 2026 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788166019;
 bh=VQnyeozED9KENp5fLCfASXjgZw48Aez7/KG7ZHlPB6o=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VarKxufOjF6BHqCh8Z40QAsdJqNubO50wawp61Z3JBQ3BhuO/DENJ4jsFiEzOJVvQ
 ldLi5gMiXYx0vR7ofVe6PNpVHoSva48bt/tHrRSoOg4ZKaR2mt0tM7eXNg9BCaEaMf
 1ySy9kqreXd4mWNkRqe0tHmjqiX+UKEkIJ2lF7BP/vR6DVirLU65l+nqfcR7VAdVYi
 VPyjzM0J8x3HPNeZYmOZ+6+y2AYOx3EdvsfTPzDt1N9MBcD5jex5JxNClTyq87VxMo
 NusHTTXOYJ8OA84ILSET03FrZ5KILZBBTi2H03GYTrSDvgWIOBxS6gCuw5OeKxJhJc
 GT9090PLkflAw==
Message-ID: <bd032f33-01ec-48e0-a214-cd1e04cb466e@kernel.org>
Date: Mon, 31 Aug 2026 16:46:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826130916.2231342-4-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260826130916.2231342-4-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x0xfV-0005cU-9I
Subject: Re: [f2fs-dev] [PATCH 14/14] f2fs: make compressed files compatible
 with large folio
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/26/26 21:09, Nanzhe Zhao wrote:
> The compression flag is the hint indicates that the inode can be
> compressed, when the inode is using large folio, we expected it keeps
> using the large folio read/write paths and its data stays uncompressed
> on disk until the inode is evicted and re-read
> 
> Let f2fs_write_begin() skip the compression overwrite preparation for
> such inodes and remove the compressed-file gate in
> f2fs_read_data_large_folio() so the data is simply read/written as
> regular blocks.

Can you please elaborate more about compress policy in doc as well?

Otherwise, user may be confuse about compressed inode behavior, e.g.
for the case we enable compress inode via ioctl, but due to large
folio flag is set, content of inode will be kept as raw before evict
and reload.

Thanks,

> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2e20833c6417..befcdc3742f6 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2955,12 +2955,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	int ret = 0;
>   	bool folio_in_bio = false;
>   
> -	if (f2fs_compressed_file(inode)) {
> -		if (folio)
> -			folio_unlock(folio);
> -		return -EOPNOTSUPP;
> -	}
> -
>   	map.m_seg_type = NO_CHECK_TYPE;
>   
>   	if (rac)
> @@ -4935,7 +4929,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>   	}
>   
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
> -	if (f2fs_compressed_file(inode)) {
> +	if (f2fs_compressed_file(inode) &&
> +	    !mapping_large_folio_support(inode->i_mapping)) {
>   		int ret;
>   		struct page *page;
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
