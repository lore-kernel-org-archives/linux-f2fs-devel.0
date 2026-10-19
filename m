Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83BDCCF2E3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YpR1zNfbXX+iz/GXGDwaAobc3/LbGKh+A3eLb85T8jw=; b=l+pfEgjfIlH2SNDvGO9oXad86Y
	72bclW0yiwYi/fHl4hy3lmk0IHroSq1oJ00qBVu3wpuRqD94Sj+EYjzovD2HDRDKzaY8Vc2inBt1a
	BQCMKTv6Uw46u39y6JKq3L/2gleO67uVb7vE38olfKKb4nOSESgYejWRq7QfMCo0OpgU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xImHA-0001B2-Pm;
	Mon, 19 Oct 2026 12:15:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xImH9-0001Aw-TU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:15:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6TTtJoKfHd6+Axw1JqNgldMsT9Eop/fBn3fLsjLmaDM=; b=b+6hY96r0bn03VSbq2n3oJAJK7
 6lYCrNrD8+ssTOF5DTKDflrCzrCE1U2EfszMo/8+rp44uwmiibJhSOlnLVLsRQ8/+aDSx/YGi2K53
 R+jI5xlPMMqAmRmrIboLLs6BjXUn18c8AMLql7iQh22OMTV+Iqpx4yQEW7Yjt+o8VY7o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6TTtJoKfHd6+Axw1JqNgldMsT9Eop/fBn3fLsjLmaDM=; b=k2f5a70siQVqjLL7KgYcVoPDDL
 /QZ32Yi74KweIX1NB79siKLQwbIbstUcQWvuHKpyXfS03GRuPR8YziFMyUJxVGbdB5MDC7YcjuTI+
 0S7sQRgfWhDkhr7UsPg+DSW5qO+ngQW7PtbfYbQ4A5jFJJK6OWmkMcjQ2CZbBcB+v46I=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xImH7-000110-8n for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:15:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0A9B60136;
 Mon, 19 Oct 2026 12:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4924C1F000C4;
 Mon, 19 Oct 2026 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792412127;
 bh=6TTtJoKfHd6+Axw1JqNgldMsT9Eop/fBn3fLsjLmaDM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VWMzLl5uTYn4Nr2CO5I68kA6L5fuaaWtjx+wOU2n1sQ5caKEvscc7GS0fIIPEN74Z
 v5CbDbEy/X+Xi4hlln3kI7zEjVy2OCzPbp3MDTgygzZC8pVe4E5PvIpxVlmkBO96Ma
 bKG5iEuIzS5AZSPqlfXh9Tq7e3P921yXEdlaIHGQB0vnIAi1416nJSZE8BAkir3r8D
 6SSH/XhrVbEi0F/jaifTp+HGqFBKK9aUirK4/hqoI5iUPNByBc3aZr/KkTVBDbKQKs
 Nnig6smW16YQFecpujsjcvvjtMvwr6OXc/t7G/JXrGk+51kKNc5QnGheOj27GWojJp
 0/5xAT2sXGbmw==
Message-ID: <5c409e48-a6ff-4572-83ea-8e63d8e3552a@kernel.org>
Date: Mon, 19 Oct 2026 20:15:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <20261014064445.2835813-10-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261014064445.2835813-10-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xImH7-000110-8n
Subject: Re: [f2fs-dev] [PATCH v5 09/16] f2fs: optimize small block size
 large folio read
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
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>, linux-kernel@vger.kernel.org,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/14/26 14:44, Nanzhe Zhao wrote:
> @@ -3214,17 +3227,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		 * If the page is under writeback, we need to wait for
>  		 * its completion to see the correct decrypted data.
>  		 */
> -		f2fs_wait_on_block_writeback(inode, block_nr);
> +		f2fs_wait_on_block_writeback_range(inode, block_nr, len_blks);

Oops, sorry, I didn't notice there is unnecessary f2fs_truncate_meta_caches()
in f2fs_wait_on_block_writeback_range(), so still we'd better just use
f2fs_wait_on_block_writeback here?

    void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
                                    block_t len)
    {
        struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
        block_t i;

        if (!f2fs_meta_inode_gc_required(inode))
            return;

        for (i = 0; i < len; i++)
            f2fs_wait_on_block_writeback(inode, blkaddr + i);

        f2fs_truncate_meta_caches(sbi, blkaddr, len);  <------------
    }

Thanks,




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
