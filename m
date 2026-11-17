Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F18606A330
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E+de6VTy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KuQsntgs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mkxaN09u;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVtUkHUj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xjokWfUZTEcFMAlnL2ytYL+qONbKVVBey9PawyqTUpg=; b=E+de6VTy/Zfmy3
	zNoTNiuxD13FnpC7q3LNlHMWIlM9fp+nMLuy4qEJTS9Y+2m4aF1q7dYb7TTf5GSBz7ex44EW1OP7K
	63aNyDgEEWa/HNgItxTLRnAZvUMrpDZ22TP+dHsw2HM07yPouOgP54MTnSlQrpfd8vCzk2jV0uvIJ
	7lc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTExK-000000007On-3KDc;
	Tue, 17 Nov 2026 08:54:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTExJ-000000007Of-2Ts4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xoqdIKT6S9pjGgEJNeSle+HgG7N60MAqw5HxEVi8hEA=; b=KuQsntgsQjrluOxtUfDVArjVKn
 8YEigSQst5wY/jUP2kjIwvtdI3qMVt4htk14Gwabm6ibpu0lTjjqUiiBelrzQ8dKb4QlNOk515kos
 2j68fOpieEl3ui9wJ9OHjiyDmciB5wlZWBANewXyq5egU613OPWh2+b8r0gZgqeHlshU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xoqdIKT6S9pjGgEJNeSle+HgG7N60MAqw5HxEVi8hEA=; b=mkxaN09u33cTegvVSklp5TwIU/
 EQZCO+Wij6OwouduZhGwYvVmGZL7Mmo4GJuleSPjtC2tO9GtIKPWDk5P/IE8UGcry28jOCnivzBsM
 LeShRsozLsuJHvWFtoTBWuTI2Uewdpyoryr1ICvzk+Yqr/FeTscb+oq6cZoqsM+Ivc2c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTExH-000000002iw-06IO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:54:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84D5343CFD;
 Tue, 17 Nov 2026 08:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7347A1F000C4;
 Tue, 17 Nov 2026 08:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794905653;
 bh=xoqdIKT6S9pjGgEJNeSle+HgG7N60MAqw5HxEVi8hEA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=WVtUkHUjJATZ+7jGAR2WLUzlSvPn73Wjuqi5Q6tbS9Iyd6Ve9rvve4QQMQjakEFck
 ynGzRrLdPZ8Iuc/JqksHd1iwn7dsBedV1MBsGTRTCd4TwIi5s4lRYYi7Y0Hs/3IP+r
 JWgoMV4qzphwA0LU4xgC3qML+XFAlF6Bpzz49PgiHxkvydghLj5YSTmxIM1UGubNHm
 NDYtiQ6wvZ7kk2xKbbiU92mIuRyx5DqAFOZIM4Ye+HxOY9Z1BHjHL55oXL8zN/06Iw
 RpFf0z5T/E2MhZzs0dufrE4W731t0V2/aUX3Eqle7wXCYnw58TeiY2AbeCiZY9NMTZ
 25qzKVModbDcg==
Message-ID: <6300b592-1e44-406c-9696-af748d49b235@kernel.org>
Date: Tue, 17 Nov 2026 16:54:10 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-4-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-4-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTExH-000000002iw-06IO
Subject: Re: [f2fs-dev] [PATCH v2 03/20] f2fs: extend f2fs_folio_state for
 subpage blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With subpage blocks, even an order-0 folio holds several blocks, so
> track uptodate and dirty state per block for any folio that holds more
> than one block, not only for large folios.
> 
> - Identify the folio state by a magic number. An order-0 folio can carry
>   one now, so folio_test_large() no longer tells it apart from the
>   context of a compressed page, which folio->private can also point to.
>   Carry the page private flags over when the state is attached.
> - Make the uptodate and dirty helpers take block indices, and attach the
>   state on demand in them. Some of their callers cannot return an error,
>   e.g. f2fs_set_link() and f2fs_delete_entry() once a directory folio
>   holds several blocks, so allocate the state with __GFP_NOFAIL, as
>   ifs_alloc() does in iomap, and drop the allocation failure handling
>   of the callers. The write paths attach the state before a folio is
>   dirtied, so writeback does not normally have to allocate it.
> - Handle per-block state in invalidation, dirtying and writeback.
> - Clear PAGECACHE_TAG_TOWRITE as well as PAGECACHE_TAG_DIRTY in
>   f2fs_clear_page_cache_dirty_tag().
> 
> Some of these changes also apply to large folios when the block size
> equals PAGE_SIZE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
