Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B47C88E64
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rf+syBlVHio3FKFPyf+/wdlZHdQCeyhjQ5Di82NdtEY=; b=IIKDFkGuHBFXlG7MtnVV0Wwk0L
	weruDRQ4pfzoi7Du5UC0cnAEsUlfeef3rJgbzzJN4VMhhQz+UJrhLh02TaDbvrGKYRbCE5YleaOlX
	FCdAbBesFD6GtURwCiM9Dk3xrQ4mjbC/VeM/WsC1pBJkB2lZOpccwj74MJ/nABi7AD08=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5yZp-0003Vg-Kt;
	Mon, 14 Sep 2026 04:45:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1x5yZm-0003VV-AS
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 04:45:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XIa/QTT2Vtv8NiYChAuw57Ae+l0UAwkEY31SNMwQavs=; b=feKhHg+D0iDLMsG4cHyMA7umZW
 p4twWdY6H5m695Kqni7kOo6EJbUIK3fzs635OjQo0OnzK60+7BmEekz2z+pdvhyHG2Qtv96wM0Et1
 K2nZqxKidwBpLowhPk902ZOOiwHMrpUBzwBOWwaV0yyUd3VoSZYi77a9vyvzPdJCjPBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XIa/QTT2Vtv8NiYChAuw57Ae+l0UAwkEY31SNMwQavs=; b=G0L8QNojK54p7WdeRDO4krAAjk
 99XNL1JgkfGLZPIEhRrB4OvqPhbPwiyrBBwdxL93393BdGRcIpVRoZDXDJh2didhZKVOD0svqsHeu
 wE3mQKzvi8wdaJKE49POndnbG0BOkWdbaoQfQjV2X5s6WGDo/3qIfUJS+5Z0h6zw2RVc=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5yZk-0002Bj-Jg for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 04:45:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XIa/QTT2Vtv8NiYChAuw57Ae+l0UAwkEY31SNMwQavs=; b=VHq/c8Pp7UCdPy63XwI1Y7/evy
 Zs6wNzMUH3y9lsWgsWNb5RSGYeSQu3+dwRZdgXhGjQadm2skLDAn/gsZQSr0RPAMMeECDGpa+etFJ
 GZ9W0qUhgJ+QpqD56J7NZ5uRTrraPD2HDAatD107Dp3uDh0n+iOUAQepIYxNbT07CT1OivKUu4rqR
 9T7pMp18HVSaFbknP5sOsW0VTb6JH/cNVnoDNqHZ/wAn8VlL9cIRO8bUeAaRAYVhxkupw1SgasBjf
 4D0IoMEvGnWlzdIMpEsme0E/QLtp6CUPuirl9Z1VPsWGxuq6MgoCtKLvy6o4mAhIx6zXHL2D24MjY
 lZwDMIbg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1x5yBr-00000008huW-1WeH;
 Mon, 14 Sep 2026 04:21:11 +0000
Date: Mon, 14 Sep 2026 05:21:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Message-ID: <aqd2N1J3ui1llWWG@casper.infradead.org>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
X-Headers-End: 1x5yZk-0002Bj-Jg
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
Cc: Tal Zussman <tz2294@columbia.edu>, Matthew Brost <matthew.brost@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 xen-devel@lists.xenproject.org, Gregory Price <gourry@gourry.net>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-fscrypt@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, David Hildenbrand <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
 Nico Pache <nico.pache@linux.dev>, linux-perf-users@vger.kernel.org,
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

On Sun, Sep 13, 2026 at 10:23:58PM -0400, Zi Yan wrote:
>       md/md-bitmap: replace PagePrivate() with page_private()
>       buffer: replace page_buffer() with page_private() and delete it

Sorry, looks like I screwed up git send-email usage.  I'm proposing
replacing these two patches wth the three I sent.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
