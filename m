Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C3AC982FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SC6m2GmD/eVQYYRcXpMI9UCSag4wTiKxeYH8FmvHkkU=; b=lAqQQKTK9Mxxilsp/KFcwjBzyL
	RgT8bql6hsSDjY9xtfxaFEtgM1w1NAixj3G2SPuLRXhVGM6SAtQI8j4qaxh0rmbJJSzJrYuS3EP3P
	kHVoE2zIV9LJ3HmPv8Ufjs0xkpoUS56upWW3jSJSF1N7jIPE7dDWMvBsUsGJXxJUDtI4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x92TL-0004Sa-JX;
	Tue, 22 Sep 2026 15:31:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1x92T7-0004SC-QO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VFYj6sjedfWGEBuGl++9heS9zoD83sYWZIxoZFH52Mw=; b=aesUFF/cONC+wnM1Dj1FEDOCN7
 FUQ7kKmrHtFUdWQJ6etkj4KGe0Ur/8VxR3SeOJOOqvUY01Q0mvix8YVrKHmb3MA0oKjxDwZP0WGug
 riCFwTfKDBZE/eCThsjn0HJSpOUJ13fZIWBNTNN4RIrKIgOGxEKAOkxnOUxDMt72iro8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VFYj6sjedfWGEBuGl++9heS9zoD83sYWZIxoZFH52Mw=; b=LZRRf5hX6bFlLKuomZS58W0Bqx
 3Vrew7voo6Es1DCOyBeG/aZCC0D/0exFGytx9Si0tGLk5mxE9tg9rn1f0O5F+uXU5NOvk5Bx4CSX9
 045vfVls8w2d0lYM0c2aDc8UjkR9nr9tA4w+SFXfJvAT7564RdTfPVe2+4Ruu9q48FuM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x92T1-00070X-Sp for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81B3D40DC1;
 Tue, 22 Sep 2026 15:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971F71F00893;
 Tue, 22 Sep 2026 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790091090;
 bh=VFYj6sjedfWGEBuGl++9heS9zoD83sYWZIxoZFH52Mw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oxgbajWAx+ewgz3EYGgJPYtZfNNrVy2jiDvlrL0XB6QieOmgNe9oJ8tWYTAmWkd4E
 40O1bShYyuGwabzOZg2yryGvTCOWVoLErNmP15TezU6CcK1+IP50a2puK4iDmaw6R3
 PCwUfPw/jYwdSq8HtaOBJAU/3KQvk7VOfDVSLU+W6MZTQuGVG14os2s8QuaTXuRpZy
 c1E7BQMp5Oh5V6N9yXEOXRU2Ns8Xz5BjaAREZfd68p1jzII0svn4YeEB6D4D+XgUXP
 mn6RKCk0xuOhAtFCkmd48wAcJ6k5w8jrTIJhK2olCjTjtXsHqi1z/Ac++TcJ8CKg7E
 LVSLUkJaZCs2w==
Date: Tue, 22 Sep 2026 15:31:25 +0000
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
Message-ID: <arKfTXizFeTeKYDx@google.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260922041600.1240429-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922041600.1240429-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x92T1-00070X-Sp
Subject: Re: [f2fs-dev] [PATCH v5 00/17] Remove PG_private by using
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 Alistair Popple <apopple@nvidia.com>, ceph-devel@vger.kernel.org,
 Eric Biggers <ebiggers@kernel.org>, Zi Yan <ziy@nvidia.com>,
 xen-devel@lists.xenproject.org, Gregory Price <gourry@gourry.net>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-fscrypt@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, David Hildenbrand <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
 Nico Pache <nico.pache@linux.dev>, linux-perf-users@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-doc@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Hongbo Li <hongbohbli@tencent.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Byungchul Park <byungchul@sk.com>, linux-trace-kernel@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>,
 linux-f2fs-devel@lists.sourceforge.net, Minchan Kim <minchan@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Alex Markuze <amarkuze@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-mtd@lists.infradead.org, Chunhai Guo <guochunhai@vivo.com>,
 Jonathan Corbet <corbet@lwn.net>, Dev Jain <dev.jain@arm.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Gao Xiang <xiang@kernel.org>,
 Juergen Gross <jgross@suse.com>, Baoquan He <baoquan.he@linux.dev>,
 James Clark <james.clark@linaro.org>, Steven Rostedt <rostedt@goodmis.org>,
 Borislav Petkov <bp@alien8.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Tal Zussman <tz2294@columbia.edu>,
 Ilya Dryomov <idryomov@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 linux-nfs@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>,
 linux-erofs@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
 Ian Rogers <irogers@google.com>, Michal Hocko <mhocko@suse.com>,
 Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
 Dave Young <ruirui.yang@linux.dev>, Yuanchu Xie <yuanchu@google.com>,
 linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>,
 Yue Hu <zbestahu@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Usama Arif <usama.arif@linux.dev>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Namhyung Kim <namhyung@kernel.org>,
 Wei Xu <weixugc@google.com>, kexec@lists.infradead.org,
 Adrian Hunter <adrian.hunter@intel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 09/22, Nanzhe Zhao wrote:
> Hi Zi Yan,
> 
> Thanks for the series. The cleanup is a nice help for the f2fs
> large-folio work -- it removes the page-based private-flag plumbing that
> my series would otherwise have to carry itself.
> 
> My large-folio series v2 [1] can be rebased on top of this series. The
> only overlap is the PAGE_PRIVATE_* flag helpers, which I can re-express
> on top of the F2FS_FOLIO_PRIVATE_* names while keeping the
> f2fs_folio_state indirection.
> 
> Jaegeuk, do you have a preference on the ordering here? My personal
> suggestion would be to review and merge this series first, and I'll
> rebase on top of it.

Let's keep working on the f2fs tree, since we should not merge this in my tree.
Later, we'd need to prepare how to address the merge conflict.

> 
> [1] https://lore.kernel.org/linux-f2fs-devel/20260915041909.2903887-1-zhaonanzhe@xiaomi.com/
> 
> Thanks,
> Nanzhe
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
