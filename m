Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370A4C88E64
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 03:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Mime-Version:References:In-Reply-To:Message-Id:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uyq/CqYXbrC1kygsjicUEHSJh8x2ucejNir3TSPKVRM=; b=gctEgMwQ5MUrCYLTpdMi2kCZeN
	AGNFvlBgGZezXkEBTdiq1q/prWpgyHns2QqVhc3wu4Eqqo3V7VjALxjBDTGt1t++zji5RYF9voO0P
	1HSixmHVKCU3qtedYenx5KFb3U1AW6WsBU7mTSrR4Dw+yweovMPp2qaGT/dGZtkwaIcM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5xms-0002V9-9t;
	Mon, 14 Sep 2026 03:55:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <akpm@linux-foundation.org>) id 1x5xmq-0002V2-P4
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 03:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x5zisV7HoQ8XMweM1XOT4E07P1NlnKsteMfQzVmO4Js=; b=PjMUVcTjuEXnpSzLikLSXoNlW3
 C0HKyJYZCx1t8jzBLX+ghcdFb1swq/EX6hQ4vfSmIpxRg2R0zmsQ9K+rs1ueYLr7IB8mJp6uU/ULJ
 9YkOeQxRsIll7JIRKwQx3Y4PlRFHDuGUBzc2c4UNMwIV1a6c/uDNg/kVkk2cmgvA2QH4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x5zisV7HoQ8XMweM1XOT4E07P1NlnKsteMfQzVmO4Js=; b=J1Y62LyurtkCn3jNcaTewskeZt
 5/R9azZFbS5FbvSVOLu1xQeGbh7qJgxSE/Fyqf8ThiZr7/r06Qm8mDicMnai/2+JuXhwUKqDbM4WM
 k+2WyP22wa+NzfzpFkt8sE28OmOMnZjcyVRHMgsO6bBiNVhQL5aanKqzIpUCsFuXnpL4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5xmo-0006oN-P6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 03:55:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DFC540A5C;
 Mon, 14 Sep 2026 03:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FF91F000FF;
 Mon, 14 Sep 2026 03:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1789357202;
 bh=x5zisV7HoQ8XMweM1XOT4E07P1NlnKsteMfQzVmO4Js=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=pHy6fbeflVTU8QtsqFS5eh8OvOR3ntwRr+lHZYMkoAT3ltm91/zKHpwN5XKZntEOS
 ILIVvwKavB+/VLgc77oFP5R90/PbqE2ALcouMF/TdFK9XZ9ovr5QioyLZB1yLh6r2e
 gdt1bOJXa+0zPlb1i7I7WNxSlmbqXRfHn0UsNCp4=
Date: Sun, 13 Sep 2026 20:39:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Message-Id: <20260913203959.6b46b0b5a052aec818a7f267@linux-foundation.org>
In-Reply-To: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
References: <20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Headers-End: 1x5xmo-0006oN-P6
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
 linux-fsdevel@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Song Liu <song@kernel.org>, Hongbo Li <hongbohbli@tencent.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
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
 Dev Jain <dev.jain@arm.com>, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Gao Xiang <xiang@kernel.org>,
 Juergen Gross <jgross@suse.com>, Baoquan He <baoquan.he@linux.dev>,
 James Clark <james.clark@linaro.org>, Steven Rostedt <rostedt@goodmis.org>,
 Borislav Petkov <bp@alien8.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
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

On Sun, 13 Sep 2026 22:23:58 -0400 Zi Yan <ziy@nvidia.com> wrote:

> This patchset removes PG_private to make space for upcoming PG_folio for
> identifying pages from a folio (more details in Note below). Instead of
> checking PG_private, all code is changed to check page/folio->private !=
> NULL instead.
> 
> MM people are cc'd on all patches and subsystem people are cc'd on the
> cover letter and corresponding patches.
> 
> Patch 6 is picked up separately in f2fs tree, but since mm-new does not
> have it yet, it is sent for MM testing.

AI review claims to have found a pre-existing critical level deadlock
in f2fs:

	https://sashiko.dev/#/patchset/20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com

it also had a few things to say about this patchset and, as always,
hugetlb.c.


Thanks, The MM bits appear adequately reviewed and review of the non-MM
bits are, as usual:

  Great to have but I won't permit lack of other-than-MM review to
  block MM improvements.

So I'll queue it all up and shall push it into -next after a few days.

Acks from non-MM maintainers are appreciated.

If a non-MM patch appears in linux-next I'll autodrop the mm.git copy
of that patch.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
