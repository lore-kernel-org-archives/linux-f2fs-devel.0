Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD7EC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6W2yMAU8cuxln0q3y81UxOKVqG093FYsZB0yED1jLgs=; b=aW/H66ti7+zKkG0B3bnT6RZjQp
	I80A5peU249e+T03Dc1+5GMqt9u036LdQ9rZ/NtLRIpUYdaY37NhCBz8wlKW1CldSlaK2DUBVWQPO
	pW3EZqhhhN+8unXyuy/bfflVnMbK3o5kIjXJjhkhZWsHVWiVUn12yS3rRuf5vUu7SlNM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi1Z1-0000YX-I2;
	Fri, 10 Jul 2026 03:06:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wi1Z1-0000YR-3M
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 03:06:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pSv3vviw1eiycIejXFk1DvJls/TrCOQEjNqVjm41GKE=; b=Q6ya+VZkGHOstyC+jDLQmS1Xde
 RBESd6SzxIg/1jtRZO2WmaV6QbjQg/c0UawQ6t7jjm3rE8ubm6PBwP/+r47hRYtSfKJkeXGmu2uS0
 uoEp6+54E5HOXcJbTvHHlqLZzXyzsrNlHGXnm1m6TTEzK0quekFcV2QuzkwV/UIT0x4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pSv3vviw1eiycIejXFk1DvJls/TrCOQEjNqVjm41GKE=; b=EV1SjgW1dPvVca07xDRayk8EBe
 IlmZTIdJHBWnlcQzhu566mZPmk/I9qaJ1Y0+zyOOhs6l3AUqYQzSbbhvEU3vufgJUBslj1y61PMnY
 kq+MTbuefR1GVeRuR9jyJC4uNZagGfEX082wTajF+zhjUOIOH30cuT+2yBDvWLJD7afg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi1Z0-0001ga-JO for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 03:06:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3436D42AF8;
 Fri, 10 Jul 2026 03:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F151F000E9;
 Fri, 10 Jul 2026 03:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783652761;
 bh=pSv3vviw1eiycIejXFk1DvJls/TrCOQEjNqVjm41GKE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=K1bIFa+TQjJzhlneOM15pQBcR7DuCQSUjwIZC52JZoJmz0/7nKVCKqTGFtB9nbrUA
 esqYWXhN7GCxFWyjYeuzLWHFjWD22VRm1t7JgpUr78m81mLekWLbzNO/sHG2qBDydE
 o2NJ6K++lohmnJgsvmouf7MvDB6SrIB5fTqhbtqW1KUxmSedfD7H2OssZdQn+kYoli
 SF9lYhTyM4zCC4A7Nug3P1p9n5t7iNZVk8qyPsjjgJsWVZDunhC2KVX2gGtudKsc6Y
 8g+sjDuwi0rGMUfDk7ARZ1DqLSqk0LxGXhXluAaKo7y8TYxnKJuFpakuc+IOOPFVQh
 KK2zotYIwzUaw==
Message-ID: <aed78e9a-18f8-46a7-9806-6edd1e0f9932@kernel.org>
Date: Fri, 10 Jul 2026 11:05:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
References: <a9b257fd-68ce-45a6-b4df-be5faf583e2d@kernel.org>
 <20260710011534.2307696-2-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260710011534.2307696-2-zhaonanzhe@xiaomi.com>
X-Headers-End: 1wi1Z0-0001ga-JO
Subject: Re: [f2fs-dev] [RFC PATCH v2 01/10] f2fs: extend folio state for
 large folio write path
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
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Pengfei Li <lipengfei28@xiaomi.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/10/26 09:15, Nanzhe Zhao wrote:
>> Seems there are redundant codes below, let's have a try to wrap them w/ a macro for cleanup?
> 
> Got it, thanks!
> How about the following example implementation?

Good, please go ahead.

Thanks,

> 
> static inline unsigned long f2fs_folio_get_private_flags(const struct folio *folio)
> {
> 	if (f2fs_folio_has_state(folio)) {
> 		struct f2fs_folio_state *ffs = folio->private;
> 
> 		return ffs->private_flags;
> 	}
> 
> 	return (unsigned long)folio->private;
> }
> 
> static inline void f2fs_folio_set_private_flags(struct folio *folio,
> 						unsigned long flags)
> {
> 	if (f2fs_folio_has_state(folio)) {
> 		struct f2fs_folio_state *ffs = folio->private;
> 
> 		ffs->private_flags |= flags;
> 		return;
> 	}
> 
> 	if (!folio_test_private(folio))
> 		folio_attach_private(folio, (void *)flags);
> 	else
> 		folio->private = (void *)((unsigned long)folio->private | flags);
> }
> 
> static inline void f2fs_folio_clear_private_flags(struct folio *folio,
> 						 unsigned long flags)
> {
> 	unsigned long private;
> 
> 	if (f2fs_folio_has_state(folio)) {
> 		struct f2fs_folio_state *ffs = folio->private;
> 
> 		ffs->private_flags &= ~flags;
> 		return;
> 	}
> 
> 	private = (unsigned long)folio->private;
> 	private &= ~flags;
> 	if (private == BIT(PAGE_PRIVATE_NOT_POINTER))
> 		folio_detach_private(folio);
> 	else
> 		folio->private = (void *)private;
> }
> 
> #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
> static inline bool folio_test_f2fs_##name(const struct folio *folio)\
> {\
> 	unsigned long priv = f2fs_folio_get_private_flags(folio);\
> 	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |\
> 			     (1UL << PAGE_PRIVATE_##flagname);\
> 	return (priv & v) == v;\
> }\
> static inline bool page_private_##name(struct page *page)\
> {\
> 	return PagePrivate(page) &&\
> 		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) &&\
> 		test_bit(PAGE_PRIVATE_##flagname, &page_private(page));\
> }
> 
> #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
> static inline void folio_set_f2fs_##name(struct folio *folio)\
> {\
> 	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |\
> 			     (1UL << PAGE_PRIVATE_##flagname);\
> 	f2fs_folio_set_private_flags(folio, v);\
> }\
> static inline void set_page_private_##name(struct page *page)\
> {\
> 	if (!PagePrivate(page))\
> 		attach_page_private(page, (void *)0);\
> 	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));\
> 	set_bit(PAGE_PRIVATE_##flagname, &page_private(page));\
> }
> 
> #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
> static inline void folio_clear_f2fs_##name(struct folio *folio)\
> {\
> 	f2fs_folio_clear_private_flags(folio,\
> 			1UL << PAGE_PRIVATE_##flagname);\
> }\
> static inline void clear_page_private_##name(struct page *page)\
> {\
> 	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page));\
> 	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER))\
> 		detach_page_private(page);\
> }
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
