Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CFEC88E70
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L5rtRyABdVR8uBSeXyO08pPM6EsDoxKnlWJShvukNig=; b=OLSqCyp4F7fo3PaWw4oJol1+L1
	DgTCVhkdAUNPgIf3VP/B7Phf0CbzVc18OzdJdEt6A8TvP1ZH9Yw1OVWkner9fzsqIe6bsPBP4fao4
	0KUSVHWZ0QRjMCitutDikeHNIdKNvFOOJt66qa7PugKhCdsZaGo3kA3vbwSuVWi+9iTc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x66TA-0004MO-0s;
	Mon, 14 Sep 2026 13:11:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <david@kernel.org>) id 1x66T8-0004MG-Hz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 13:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HMEr8VxikyVfU6qvEUZWpmfPP3XV/5sFL4uxF81JxCA=; b=KkAy529klR4SIiB0wIjqC+ic79
 RtwsiYsNxH3Rm27uA0rCREcG62mZgWEYuJREBTuXxGlLzyo3wgd499cW9iL+LHZ1WJ6Ie99vLVIyH
 gHqOqJVzjR165J14+n8iI6z86s8CjCa7CYg915YO3KNinqUeIPT2ZBFoLa+96InJ1vcE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HMEr8VxikyVfU6qvEUZWpmfPP3XV/5sFL4uxF81JxCA=; b=kWAAZml0AaIYaDyNKIel7zTOLM
 E39XZTvYXq5BULBKMbP1o9wtyqUAr47LYjpwEPHDhk21WT4ZWQ0pI3PdxAdpH9f732uxNo669jUj4
 4Y012Ywdnn8kXj/A+dOGrNPZvCPbdAPDeKYCWeV+YqibG5e+9lyex82U0AUSISBiuY7Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x66T4-000829-EG for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 13:11:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A94E40332;
 Mon, 14 Sep 2026 13:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F6B1F000FF;
 Mon, 14 Sep 2026 13:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789391484;
 bh=HMEr8VxikyVfU6qvEUZWpmfPP3XV/5sFL4uxF81JxCA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CJKJt+kIe+hjf+CMIokL8p95jJbZP9ztsmmxzZVo1NFVjWTN+jeWfJ8gkpM0krJT8
 Utjnt2XRl1o23z+XgGILQt1K7qKpVap9QKwfAQ3Pbw7Nb1qdciasZLG+bCxX6W8crk
 mB6ySTVDkFOyHlizGE9wPiKXzd5ZoeQzUUHq4GK3Az9uzbVLKJs+jLvaWj//Z7s9yJ
 26BLl4l4JsAZDlTiLo0F5mBC0VkJP+XRzFeBS+pwUeA7vgq+fA4Y2VALNJVCMnpA9v
 1Oa2VfL25A9Rb97s1Afe8qFm5GadjQrDawLd5iUENfXkRUR76/6j5S6iZTu65TIRWr
 3oGpW4Ax822zA==
Message-ID: <066c3b3b-e5a7-4cbb-b077-26c78cfc07ac@kernel.org>
Date: Mon, 14 Sep 2026 15:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
 <aqd2N1J3ui1llWWG@casper.infradead.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <aqd2N1J3ui1llWWG@casper.infradead.org>
X-Headers-End: 1x66T4-000829-EG
Subject: Re: [f2fs-dev] [PATCH v4 00/16] Remove PG_private by using
 page/folio->private checks instead
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
From: "David Hildenbrand \(Arm\) via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "David Hildenbrand \(Arm\)" <david@kernel.org>
Cc: Tal Zussman <tz2294@columbia.edu>, Matthew Brost <matthew.brost@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 xen-devel@lists.xenproject.org, Gregory Price <gourry@gourry.net>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-fscrypt@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>,
 linux-kernel@vger.kernel.org, Nico Pache <nico.pache@linux.dev>,
 linux-perf-users@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Song Liu <song@kernel.org>,
 Hongbo Li <hongbohbli@tencent.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Qi Zheng <qi.zheng@linux.dev>,
 Byungchul Park <byungchul@sk.com>, linux-trace-kernel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Barry Song <baohua@kernel.org>,
 Kairui Song <kasong@tencent.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Li Nan <magiclinan@didiglobal.com>, Muchun Song <muchun.song@linux.dev>,
 linux-f2fs-devel@lists.sourceforge.net, Minchan Kim <minchan@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Alex Markuze <amarkuze@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-mtd@lists.infradead.org, Chunhai Guo <guochunhai@vivo.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Dev Jain <dev.jain@arm.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
 Gao Xiang <xiang@kernel.org>, Juergen Gross <jgross@suse.com>,
 Baoquan He <baoquan.he@linux.dev>, James Clark <james.clark@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, ceph-devel@vger.kernel.org,
 Ilya Dryomov <idryomov@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>, Ian Rogers <irogers@google.com>,
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 Peter Zijlstra <peterz@infradead.org>, Dave Young <ruirui.yang@linux.dev>,
 Yuanchu Xie <yuanchu@google.com>, "Liam R. Howlett" <liam@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Yue Hu <zbestahu@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Richard Weinberger <richard@nod.at>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Yu Kuai <yukuai@fygo.io>,
 Axel Rasmussen <axelrasmussen@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Usama Arif <usama.arif@linux.dev>,
 Xiao Ni <xiao@kernel.org>, linux-raid@vger.kernel.org,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Namhyung Kim <namhyung@kernel.org>,
 Wei Xu <weixugc@google.com>, kexec@lists.infradead.org,
 Adrian Hunter <adrian.hunter@intel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/14/26 06:21, Matthew Wilcox wrote:
> On Sun, Sep 13, 2026 at 10:23:58PM -0400, Zi Yan wrote:
>>       md/md-bitmap: replace PagePrivate() with page_private()
>>       buffer: replace page_buffer() with page_private() and delete it
> 
> Sorry, looks like I screwed up git send-email usage.  I'm proposing
> replacing these two patches wth the three I sent.

For everybody CCed wondering "which patches":

https://lore.kernel.org/r/20260914041830.2072626-1-willy@infradead.org
https://lore.kernel.org/r/20260914041830.2072626-2-willy@infradead.org
https://lore.kernel.org/r/20260914041830.2072626-3-willy@infradead.org

-- 
Cheers,

David


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
