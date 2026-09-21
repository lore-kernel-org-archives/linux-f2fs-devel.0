Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83990C982E1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qWHzonbenjfr5T+KUX2qVlIHLR/MtibklSnMl/9Jvgk=; b=PI7McjJEk2RpGHCC78PyGXdfMH
	a6hWv6KOljPxmO9hfH7a/QrFftNUqpBsuBCnwnE3DLCi3jDpO1bNJ3zA2yWBaSceSmAZ+eDm3Lr10
	ASAvhY/zvvasftCxJVrGM4htH8eLC8OcYZgK5vXRX2Bm0QxHqrUYrShMqALH730w/KvM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8YcZ-0007SJ-Eo;
	Mon, 21 Sep 2026 07:39:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lance.yang@linux.dev>) id 1x8YcX-0007SD-Q1
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 07:39:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5w3ycCGa4RFXPrE/mVtI/6EI9P8fpVebaaYmqzh6+Ws=; b=OiJhqkfJtOI2phkH6Pq5Umngro
 RmKmQ0fsO8jdOuBZID4OMcqt4mHeHd8HZe8q8bHfkKnQ+SjDOtf/O+lHL13x9nP7biQa64mtAy7bd
 rh0ZHutkpcBJYlLh1RdPJIQD9VbwqY9KRUDXmKHamJGa5uX/E1gtK9DogolWShPKYc94=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5w3ycCGa4RFXPrE/mVtI/6EI9P8fpVebaaYmqzh6+Ws=; b=kJRrfnlfxrWHneACPpKqjJIa8k
 zc86lsWfYtkYiIPzzexRecUAGp/fxyR1taGAG0TasWywIb9hEMJLmn2hdsoT0wV5nZ0cl1dqdAmtz
 IbzOxSlL5tPgJW/n9SND3EDwEBRY6TUBcDvbL+4oi/4PUraNOa4gn1aBXtqsP5c1jgQc=;
Received: from out-149.mta0.migadu.com ([91.218.175.149] helo=mta0.migadu.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8YcW-0006hw-Q9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 07:39:26 +0000
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
DKIM-Signature: a=rsa-sha256; bh=QASj6Z6chGBEQBYT8Fc20eY9OhWz9aaUtq7xvhcRKKw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789976357; v=1; x=1790581157;
 b=MOHCbkyBVQm4tJ9DsrkkobQByRHrE03xCq8KQR+8P5TLGQdvpA2xiw0OsToI6SmT3OzfUNhX
 YUV98ukDxnv+7lT/oLUAhR6Isgqc6ZcLsMsVdHz/vkDAC+jwA5IyymPGOPbhwE797N4owb37Dky
 9z0gJsjcNnH0jPxfd2YE9QHs=
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
Received: by smtp.migadu.com with ESMTPS id 57f2f9324be8538a;
 Mon, 21 Sep 2026 07:39:17 +0000
X-Mizu-Trace-ID: 57f2f9324be8538a
X-Migadu-Flow: FLOW_OUT
Message-ID: <b71094a8-d5b3-4d24-8423-18882fbe0cb8@linux.dev>
Date: Mon, 21 Sep 2026 15:39:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-7-bb68b6a21869@nvidia.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260920-remove-pg_private-v5-7-bb68b6a21869@nvidia.com>
X-Headers-End: 1x8YcW-0006hw-Q9
Subject: Re: [f2fs-dev] [PATCH v5 07/17] f2fs: convert the ->private flag
 helpers to folio-only
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
Cc: Michal Hocko <mhocko@suse.com>, "Liam R. Howlett" <liam@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Nico Pache <nico.pache@linux.dev>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Ying Huang <ying.huang@linux.alibaba.com>, Vlastimil Babka <vbabka@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Dev Jain <dev.jain@arm.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Gregory Price <gourry@gourry.net>, Ryan Roberts <ryan.roberts@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Tal Zussman <tz2294@columbia.edu>,
 Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 2026/9/21 10:28, Zi Yan wrote:
> page-based ->private flag helpers are used in the compression path, where
> large folios are not enabled. They can use folio versions with
> page_folio(). The two remaining users in data.c and segment.c can use
> fio->folio instead of fio->page (two are in a union).
> 
> Drop page-based helpers after the conversion and rename
> PAGE_PRIVATE_{GET,SET,CLEAR}_FUNC() and the PAGE_PRIVATE_* flags to
> F2FS_FOLIO_PRIVATE_* to match. Convert the folio/page union from
> f2fs_io_info union to folio only, since no page user is left.
> 
> The folio helpers do a plain read-modify-write where the page ones used
> set_bit()/clear_bit(). It is fine because the converted code either holds
> folio lock or, in f2fs_compress_write_end_io(), matches what the
> non-compressed code does in f2fs_write_end_bio().
> 
> Assisted-by: LLM
> Suggested-by: Tal Zussman <tz2294@columbia.edu>
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Nice work! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
