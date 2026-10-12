Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A11CA9ED1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 03:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LIl2Arx2ihuqxAeouGsBsxwP+Eha6+1GScccpUhxNoQ=; b=hYYF5qr2EDeysR1+/LxFIyEIgx
	mbysRLHLBpZWK2IN8FsqsJPOFy76OBESleMnPt6CkH8WT0mV/Q8gdgxlnmsw/wgXyVPTfyy9Dkyqj
	bwiAysiH7pfnM8VuCn6XPDfT+cR+3BbeuKeE/E08PB0CDuxTuZh+RyYPawLlyQOch0nM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xG6Hy-0005Va-2q;
	Mon, 12 Oct 2026 03:01:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xG6Hw-0005VU-2G
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 03:01:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Akzdmk8ispYdrVaiRaEkBsWQAezgYlwqc2eqIbTZKn8=; b=ScLSa52C63/KIK8xCQLt/fsMtj
 suAZJ5TkwVpFC1fKzaO5WXDou0JS8Ol1HTI+R9wiyMGqPIfb1wUSe3Yj3vg00UiE5Z8Nx9nqDILWb
 N7ZPhuHWG7Qr3Be8rp/N7k59MDZb5R5fQM+qZ5uWP0bQjUjvHY/OZ2hZYu7WekTdiBck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Akzdmk8ispYdrVaiRaEkBsWQAezgYlwqc2eqIbTZKn8=; b=mVk0Egv1kLMNay30mACQloyPw8
 DsVjCbCSv7IqeI/ByEIIIcD0ZMSGK6G6+8Z7QAasNF6XH5Gz04SDplzBVK/fXUl+dEEU68dxNtqHO
 uGpkBW8HLvdDIhU+uR9lVEAjK2jGXt+XY12UjrgBk96G7I3fSTnWzfbzefFNMkClMGas=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xG6Hu-0003hA-5n for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 03:01:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F9DD414BC;
 Mon, 12 Oct 2026 03:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB9E1F0089B;
 Mon, 12 Oct 2026 03:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791774072;
 bh=Akzdmk8ispYdrVaiRaEkBsWQAezgYlwqc2eqIbTZKn8=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=PdqQlJ+l9LfLboA8j4ZOLMM3RuB928UbWAXehTxA5jvHobjodbdPu2HYq2fEHOYT/
 /OP4JJt02XnLgq1PcyFxkM60CXZQHJ36QriUhKah1OxtO1H2Z8hdJR0jLYljP+7wQA
 pVqG/dH/XlKpugb+BdI58SJa7y/vhBLJt+N82tvyEcWf5P9qdNi/RwWAd3rYTb460H
 xX8tuWjZ55S9LkEQC4btfetStiJM5Cm8nPPzA0Q174EscH1GgjyeY9U985wm9qpKHs
 8RUhxhqq2IO+0Zotqxh+xhMLGunH5hfG3rNeSGWVSGMby+73YSI3dYckvDS/SurNXl
 z3mO2KLfkhhyA==
Message-ID: <efb9eda2-371b-437c-8652-ed25c842f11a@kernel.org>
Date: Mon, 12 Oct 2026 11:01:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
 <20261009161224.4163796-4-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261009161224.4163796-4-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xG6Hu-0003hA-5n
Subject: Re: [f2fs-dev] [PATCH v3 03/17] f2fs: support regular file buffered
 writes on large folios
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
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/10/26 00:12, Nanzhe Zhao wrote:
> +/*
> + * Drop the folio lock when a node was changed, then balance the
> + * filesystem and reacquire the lock.
> + *
> + * Return: true if the folio became unusable while unlocked (being
> + * truncated), false if the folio is still usable.
> + */
> +static bool f2fs_folio_may_unlock_balance_fs(struct folio *folio,

f2fs_balance_fs_folio_locked() ?

> @@ -4198,11 +4501,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>   
>   	*foliop = folio;
>   
> +	/* Clamp the write length to the folio size. */
> +	blen = min_t(unsigned int, len,
> +		     folio_size(folio) - offset_in_folio(folio, pos));
> +
>   	if (f2fs_is_atomic_file(inode))
>   		err = prepare_atomic_write_begin(sbi, folio, pos, len,
>   					&blkaddr, &need_balance);
> -	else
> -		err = prepare_write_begin(sbi, folio, pos, len,
> +	else if (!folio_test_large(folio))
> +		err = prepare_write_begin(sbi, folio, pos, blen,
>   					&blkaddr, &need_balance);
>   	if (err)
>   		goto put_folio;
> @@ -4222,7 +4529,19 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>   
>   	f2fs_folio_wait_writeback(folio, false, true);
>   
> -	if (len == folio_size(folio) || folio_test_uptodate(folio))
> +	if (folio_test_large(folio)) {
> +		err = prepare_large_folio_write_begin(inode,
> +					folio, pos, blen);

Is it possible that we can relocate prepare_large_folio_write_begin() after

else if (!folio_test_large(folio))
	err = prepare_write_begin(sbi, folio, pos, blen,
					&blkaddr, &need_balance);
else
	err = prepare_large_folio_write_begin(...);

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
