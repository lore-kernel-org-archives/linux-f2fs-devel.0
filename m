Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440A6C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nf7jnGR+qFjPob04EgbWq1sEN59sxGKoO4HENVLO474=; b=FFP5S0WOuLmwd2IyedRHM69tPG
	NY2rjgDqhZuB4DaP3qIioa0vwOmKd1JZabhXtjtVNE9XXiSWOAZFUw5BEqdiDpBnDFFgmzmTn/K2x
	600fokdWEtdQxfEg4rY4vRr65nDk4R72yjhOtVV4bicNTc00ka2JjyDJqpEBtNWMenSM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3TK3-0000iO-1Q;
	Mon, 07 Sep 2026 06:59:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x3TK2-0000iG-Gc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 06:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oilWt90wydTedVxkBRKlV4xDKcIB7LoMgooBU5GgjTs=; b=RcoUvk7YLF3xrsvBd5pZ7KyJFk
 HEd2nXP0D+wnv/S6DTV0qr67d/7FF1oB94gnbV/WFljD7IxOCeQeH1RLFnimh/Dt+A32tn5Nfyg/W
 7GlNlvFs1vrHJ01nJK6EpAKpkW1em1Ej186LXnY4wEEdKtlrqWl1e3Yar4K/HS9NNzl0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oilWt90wydTedVxkBRKlV4xDKcIB7LoMgooBU5GgjTs=; b=mVIYEJKPvpdyXhyPWEZ6VDhQ7R
 FnDuot1MQYs2UmhNprszJVv89BleAvRcg6tdxoaEnqhDZV1cF00UJQ36h/G9tgbHSu232srrJyB8E
 5QA05DC4dqhK/pjZvwym0cK7mrgOw+ym+lGJ4aiC7qERmLPf/YEmUVaWwMHqk/lMHMKE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3TJz-0006mp-JM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 06:59:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51D7240819;
 Mon,  7 Sep 2026 06:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12E11F00A3A;
 Mon,  7 Sep 2026 06:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788764350;
 bh=oilWt90wydTedVxkBRKlV4xDKcIB7LoMgooBU5GgjTs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ObPhtTfytR0Nvy1rYaB37Es5H/ySzmAcs4G46u3RejRUY3b3BgTIRRxv8d3++bgRl
 0NG6S7fkvuYbuioMwEMhrVqiJcrtRwU2KlxDPqNgVGpuocIAKUHM1LD1J1QKHsbDbM
 o10mmWDXIY6p/G+J5ZPD+q5NloRv52UWCOp2xnciOZ9RfFgnkrYKODG1XmgGaNaIPT
 KlG45zHEizEWwt0nYmI8hAomiB8/jj+L/E73Tsr+qMsNRZly9qko+KqSo5+UpfzAtb
 kS/boguWqup7lSPDZxDZQOOr+DqctKCAbKStD3f3jcMR2x5e/0I4/B//eXc1ZDWd8i
 iSuRpVLAjHeAg==
Message-ID: <5d42ad8a-20df-4995-a59d-826caab89d5f@kernel.org>
Date: Mon, 7 Sep 2026 14:59:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
References: <12ab1762-e635-42d6-ab0b-e3358e3b32c2@kernel.org>
 <20260907035120.2183257-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260907035120.2183257-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x3TJz-0006mp-JM
Subject: Re: [f2fs-dev] [PATCH 05/14] f2fs: support large folio writeback
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
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/7/26 11:51, Nanzhe Zhao wrote:
> On Thu, 27 Aug 2026 19:17:33 +0800, Chao Yu wrote:
>> We should not relocate dec_page_count() above f2fs_in_warm_node_list() to
>> avoid racing bugs.
> 
> Thanks for the review, I'll restore the order like this:
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> @@ f2fs_write_end_bio()
> -		if (f2fs_folio_has_ffs(folio)) {
> -			struct f2fs_folio_state *ffs =
> -				(struct f2fs_folio_state *)folio->private;
> -
> -			finished = atomic_sub_and_test(nr_pages,
> -					&ffs->write_pages_pending);
> -		}
> -
> -		while (nr_pages--)
> -			dec_page_count(sbi, type);
> -
>   		if (f2fs_in_warm_node_list(folio))
>   			f2fs_del_fsync_node_entry(sbi, folio);
> 
> +		if (f2fs_folio_has_ffs(folio)) {
> +			struct f2fs_folio_state *ffs =
> +				(struct f2fs_folio_state *)folio->private;
> +
> +			finished = atomic_sub_and_test(nr_pages,
> +					&ffs->write_pages_pending);
> +		}
> +
> +		while (nr_pages--)
> +			dec_page_count(sbi, type);
> +
>   		/*
>   		 * we should access sbi before folio_end_writeback() to
>   		 * avoid racing w/ kill_f2fs_super()
>   		 */
>   		 ...
>   		if (finished) {
>   			folio_clear_f2fs_gcing(folio);
>   			folio_end_writeback(folio);
>   		}
> 
> Does this look good to you?

It's fine to me.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
