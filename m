Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4DCCDB474
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Oct 2023 06:33:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qsHAM-0005eG-Qf;
	Mon, 16 Oct 2023 06:33:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qsHAG-0005eA-Ch
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Oct 2023 06:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wRgmhEGdw1Mbrthh+Ogkeu6KnjcN6P8IAw6SOula850=; b=T6cfcjx559j0Y3QpUjDzKdmT5Z
 6lRWim9qVHwG1rF1x7WmISPibZikUadAXqowCzvUsTqR9YVaIZUEBHN44sqybiRhwjOBE8X3klz4k
 bQwJTDitZYgu3TtuRiErSm3OO4lFhtLFew0k/1dHRKBjdJry+aJq+NYM2ypzwwft82aM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wRgmhEGdw1Mbrthh+Ogkeu6KnjcN6P8IAw6SOula850=; b=evk7bwHMMfaXOvfGDfOG76rzK6
 h7RfRksuYPFeh613fzqUvDOvz3sSnDiHCN+qttD4z8DRS0Ex7z8az02sFRygE23pG1Dfrt8HpoY3I
 0EymV0m61QE7nabxHBes7P3wpQv3OhTNnsRbCxzTgKEBr7qIgErNjZ0t2ZAvNF1mK1M8=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qsHAG-00G7nG-75 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Oct 2023 06:33:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7336ECE0D9B;
 Mon, 16 Oct 2023 06:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FD4C433C7;
 Mon, 16 Oct 2023 06:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697437992;
 bh=+Owi4dHO/M4f1OwrwqDow7OigSWRG5/BMlw4FIabhvQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=muaGOCdbAeE393slNe/CMYYTTkBMGihz7xw+znVrPhlxMRVElmU+aXI6BBXN+/MM9
 GJ+WAD+ya4zUG7HPfjmwwd1fq/l8Z8KVzOcjuBJVlTRcyoym2qeYm/Q6FmsA3gnfsz
 lGaVLbUE0+KU+Xt+J9exl16ErejhDqC+3GKgaD9FdWgv/4orpCs84Rx17svhv6efk+
 RTSgK1e9GH3zGlL84Llm87A5wstZQymkXmePBd56wa52Q11LRCxIfupmSDJRrZcBCd
 8tDDaNzRgvypEO45lJ6e7zNBDTVr1KS8GmUOvubxtqeFIW1qI4tBJ6dkj4dcw9kuEp
 0WSQx+TysgD2Q==
Message-ID: <b16ea8fb-b3f2-4ae9-c543-cd84e0f3fa48@kernel.org>
Date: Mon, 16 Oct 2023 14:33:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20231013222453.240961-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231013222453.240961-1-daeho43@gmail.com>
X-Headers-End: 1qsHAG-00G7nG-75
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: initialize allocated node area
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/10/14 6:24, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Need to initialize allocated node areas after memory allocation.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fsck/node.c       | 1 +
>   include/f2fs_fs.h | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/fsck/node.c b/fsck/node.c
> index 3761470..6508340 100644
> --- a/fsck/node.c
> +++ b/fsck/node.c
> @@ -127,6 +127,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
>   
>   	node_blk = calloc(BLOCK_SZ, 1);

calloc() has already initialized memory w/ zero, it doesn't need to reinitialize
it again?

>   	ASSERT(node_blk);
> +	memset(node_blk, 0, BLOCK_SZ);
>   
>   	F2FS_NODE_FOOTER(node_blk)->nid = cpu_to_le32(dn->nid);
>   	F2FS_NODE_FOOTER(node_blk)->ino = F2FS_NODE_FOOTER(f2fs_inode)->ino;
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 3c7451c..7e22278 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -1826,6 +1826,8 @@ static inline void show_version(const char *prog)
>   static inline void f2fs_init_inode(struct f2fs_super_block *sb,
>   		struct f2fs_node *raw_node, nid_t ino, time_t mtime, mode_t mode)
>   {
> +	memset(raw_node, 0, F2FS_BLKSIZE);

Ditto,

Thanks,

> +
>   	F2FS_NODE_FOOTER(raw_node)->nid = cpu_to_le32(ino);
>   	F2FS_NODE_FOOTER(raw_node)->ino = cpu_to_le32(ino);
>   	F2FS_NODE_FOOTER(raw_node)->cp_ver = cpu_to_le64(1);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
