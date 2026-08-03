Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1320C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gwW94GlivoUlzThvtNbVkYMK3KHFK//8SCAhnmtnAfY=; b=eR93Sgfxkqz0hBssKgGtv2MB/5
	C7Ot6jy1NMYQnKiz8NqupvM+sszDHGA99gN+TAO7rPyw6MrsPwWX5e+taLQl7a7BceEPUz68+N/mt
	FLEYC+JEX+PMOPdDrhKn5WW5Nc+cszgLEUoDrxwJXS8HYinwdlYXeH/clUd8MOPRYcZ4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqoPz-0006SR-8q;
	Mon, 03 Aug 2026 08:53:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqoPx-0006SK-TP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mKNUy26P5uQrkOfhh2PkOznNV2iZK5OADoT4E7cuioI=; b=mywuxdnFdXZqG5KkrF1g7/EOLO
 cHPfthF+0A0W3AyKTu87iXsIr1/u7gqFA4tdPpLUTpA3O1D3Ql7zKbjiepIdIxVzpgiVAmW97Ee0A
 ylFJjZJlZ7agfgf17F9EcQSqPxuiWnubOJqG6f+n3jvzMfLkaAy99ngvbKT4g1D8uuF0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mKNUy26P5uQrkOfhh2PkOznNV2iZK5OADoT4E7cuioI=; b=A7spmpok9eAH2MqcYnAr5l7Dli
 OCyvPzVUEIxvE2dJq4wZ7HGtNWUxZZBxpDO88oHoR6Mj7ygbHuFn+Yk228/LJ6BDdI1KaytGfNKZ+
 aEEcGllBt02ac8Lv06+7HWMUzPgrsPf6lVnm7FXFDorvHCOzeQ+BmzDLS1t/ILgSoUJM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqoPx-0002Lo-7D for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:53:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8FF6360A59;
 Mon,  3 Aug 2026 08:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2251F000E9;
 Mon,  3 Aug 2026 08:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785747179;
 bh=mKNUy26P5uQrkOfhh2PkOznNV2iZK5OADoT4E7cuioI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Bp8zenbkRrNOYJR4dBI6kPPvzQg8TAe/QF8uccWKOQXquvqJZwhmuX2gzy/m7QvJX
 MSmc9BkgVX+sDi8Bf1x5UZNd6Ti+qWzrfVV5FZDHP7zooUZS7/vsP43kKjWnUquT6r
 SgY8IDZ93iDJIa7B/fW5E5qdSOUoX7q9sdoXaw1nc+QXuR2UO8Z1Qs4ScCj6TBdDaq
 4T8zQg9SLMloC+P7q64QhNtSimfwfBIRJzh5K0R/gZ1i5dDMY+EEJadakuI2Mg3R5z
 znC4/G0g9yMyUIZkPvssJKR43J9JOWpiEQWV/wLwV4ahNmyJbdZRKODMOe9J277YNn
 Lfd+AS5/PlZZQ==
Message-ID: <08a3a204-e151-4d55-8141-2bdd5ef4fea5@kernel.org>
Date: Mon, 3 Aug 2026 16:52:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260729114156.3348582-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260729114156.3348582-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqoPx-0002Lo-7D
Subject: Re: [f2fs-dev] [PATCH] f2fs: reject invalid recovered filename
 lengths
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/29/26 19:41, Wenjie Qi wrote:
> Recovery uses raw_inode->i_namelen directly when rebuilding fsynced
> dentries. A zero-length name uses no dentry slots, so recovery can
> report success without recreating the dentry.
> 
> Treat zero-length and oversized recovered names as corruption, mark
> NEED_FSCK, and stop recovery with -EFSCORRUPTED.

Do you have a reproducer for this? maybe using inject.f2fs? It will be
better to cover those bugs w/ xfsqa testcase, could you please consider
to add it?

> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/recovery.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 89af8407b667..70cf99efcb3c 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -126,8 +126,8 @@ static int init_recovered_filename(const struct inode *dir,
>   	fname->disk_name.len = le32_to_cpu(raw_inode->i_namelen);
>   	fname->disk_name.name = raw_inode->i_name;
>   
> -	if (WARN_ON(fname->disk_name.len > F2FS_NAME_LEN))
> -		return -ENAMETOOLONG;
> +	if (!fname->disk_name.len || fname->disk_name.len > F2FS_NAME_LEN)

unlikely?

relocate error handling here?

Thanks,

> +		return -EFSCORRUPTED;
>   
>   	if (!IS_ENCRYPTED(dir)) {
>   		usr_fname->name = fname->disk_name.name;
> @@ -185,8 +185,16 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
>   
>   	dir = entry->inode;
>   	err = init_recovered_filename(dir, raw_inode, &fname, &usr_fname);
> -	if (err)
> +	if (err) {
> +		if (err == -EFSCORRUPTED) {
> +			f2fs_err(F2FS_I_SB(inode),
> +				 "invalid recovered filename length %u for ino %llu",
> +				 le32_to_cpu(raw_inode->i_namelen), inode->i_ino);
> +			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> +			f2fs_handle_error(F2FS_I_SB(inode), ERROR_CORRUPTED_INODE);
> +		}
>   		goto out;
> +	}
>   retry:
>   	de = __f2fs_find_entry(dir, &fname, &folio);
>   	if (de && inode->i_ino == le32_to_cpu(de->ino))



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
