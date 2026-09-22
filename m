Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643D3C98305
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qW3ObBf2L913Fsl4cCZ/VHKWKCYI18YYorKAoo0h5Ps=; b=Hc3uK14UX/er1KsEGzBPmQCsKv
	EKgm3mJ1wDgBv2MtagOy1WPThsQBme3P8llsugxwnerJ6pnfKENUMAh/OBG582kL7ceEEC4O3m+MH
	WjdWRgbdZqfrGvnQ0109O4ZaoeyG7uMAE2gyXVhkpOEBE8t/71C/WC29X6aFia3Q3IwY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8rvk-0000wC-Ct;
	Tue, 22 Sep 2026 04:16:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x8rvh-0000vs-OW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 04:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JDLbvCKUB+a+IDR0laoJE09QGbcCCmet6VJT4AONztI=; b=kCmlX7NzGF/QflN84UFGAjOxTH
 kn0HNQE3dS77D8pyxCiEASu/ukTMNulRm02+lTBrD1R1fAq92z+gL5r9Dti1J6PM7KwIGVt5L8qbQ
 EY3+GdS8r0d6kK4jiQJsNKUONvU5A53UMoYhbdnQ23L5vgM3XfWzMJHH0ZXumt+ThDA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JDLbvCKUB+a+IDR0laoJE09QGbcCCmet6VJT4AONztI=; b=Vxvqg+gzYJQfNmQ0ohxz5RiJ4Q
 Yj5a8FRngmT1q/uffkcPAVGl7ABW5r16mLlWm7kvFGgUClSJl+hPbNdVZBp3lxngOSrJxmKBFid8r
 UWFrryd4HrJdZTY2rf7fkvgQfK1f+0i151lrJyz7GlNtp/GtQhN6AEjD5HNEZMzI7S5A=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8rvh-0004nl-4W for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 04:16:30 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-39e59dca659so2252847a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 21:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790050583; x=1790655383; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JDLbvCKUB+a+IDR0laoJE09QGbcCCmet6VJT4AONztI=;
 b=ChfDuVo+rudXyOmQdiSblqg366sLsOndzThCLTkYq2WMSofUtrhVhgfXWE5FcmoB+j
 R77yX02P0cKT6YGhkjYMbe9jZ8xD0zGtUZsK64MvQiEdTRSRD8vwWwJ5/kZXcgXc8skH
 NiivUeyOdb76UDLsfp8XvJ0MjZfz6K43k6/1VE38MTKZ9QN01EsafxZ9ggwg6mWwUy1u
 HcD7Us66BjGDcdqsXBk4sQNhuw4kWffq4/6wQbTQNUumHP76J1LNVHsQG/R+akNM3+cq
 NcTDNm0mPshMbzwSRZMkDL6ALofnpHfyeyhFdUlSVwHAN0qZxre1BveAekewZAUlhsYZ
 pX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790050583; x=1790655383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JDLbvCKUB+a+IDR0laoJE09QGbcCCmet6VJT4AONztI=;
 b=gdu6UW80ShWgBwN9Ry7wR9YSLl2qaFCOxo84Ej6Nhxf9SoB7aoC0TZ+pChQbn6m4lj
 PaqGSOGjrsgBk+90p3x2toHM8t0s1hLrAPk0vlhA1pq4tXskqBhAQnZ5oWE5dWWmVxjh
 q6zhjMept1oU5gIsWNKksNtz2iiwK/XXU+K4Nc7bJLbet0tgwmoXRSa97X2afM8o9a2Y
 H2J2C6n210H5Rw/g5Gun8AxLMcWUnLbi5CpSgp+urI9unXKGB2bpIDVLgB0c+0+reVma
 9PSJIUVT2dAp3kC7eQ5cfbjxLmTxGtBYJMm317LxzbAG4utQh2yq4EbEgZkp0S9Dm6M6
 aSLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt1JuruW9YdniytPwOOIRbM/dJmAgxUHleLZ9RGCbsl/Nsz4G/i5EUrkL2+R6n2634eCJJc5lPCcrigf/5lK/i@lists.sourceforge.net
X-Gm-Message-State: AFuF++kGr8Og/k9KpoTRy4g+1JiJwhVOrCv12I3IX9pJhQzHs+ob7D5d
 Ks3vYygx5IA/yn5YZ2h7Jd3cWtpIsyCbpvMoG4PkAniJHU7ucLlt3XbQ
X-Gm-Gg: AYBFou0qiqtMh8xyXaj44k+YZbNJWKv9UZseVA+S1zYH3ede7YeT+hrl924Q+NpvGZu
 yzUMtv+Jasp8PWAndxO+kha/bcEKGYDawEnvQnaySqXOvLWx/DDGDJkAlfSajpIoxJya44TS8aV
 mgZF3e3G4XGoZ1kj3AfjSsekEdNQSP5Az8bu7/39H8U8e+eM8uluALEXOGqsfYYVaeRDrZYCIuz
 Dgtg0882+wTnC88U+hY3/1IToXbjN5Z/huRAXRFozuE4DW7uD9gPwRGhSOkvzBQLxyXvt1yD690
 OOF37js3DeNzp008UWyc8RIZ16AoEdmABATj008fkjDKk1UX6BYinU/8kY6n/G1I6vf3Fhi9Qrt
 S3xs2rJMWUtgg0hcgZNKwREVX/zEFmEA2as8+yJy7cHmnESoTutzCXUv3wovY30Tn+jmIklkcnW
 W31ur0X9OMelWTD0Hfo+UdoeK8FwA4HFKpr6a1Dkicm6K3cax9DktrAikYhUGDV3F6puOrUGh86
 pzYEKABJsmypOB4bZP0rofJjeRRYa2ifNCE
X-Received: by 2002:a17:90b:56c5:b0:39d:f95d:bd08 with SMTP id
 98e67ed59e1d1-39e55008a3amr25857593a91.14.1790050583196; 
 Mon, 21 Sep 2026 21:16:23 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674d65d4sm2204031a91.15.2026.09.21.21.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 21:16:22 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Zi Yan <ziy@nvidia.com>
Date: Tue, 22 Sep 2026 12:16:00 +0800
Message-ID: <20260922041600.1240429-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
MIME-Version: 1.0
X-Headers-End: 1x8rvh-0004nl-4W
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
Cc: Qi Zheng <qi.zheng@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 Alistair Popple <apopple@nvidia.com>, ceph-devel@vger.kernel.org,
 Eric Biggers <ebiggers@kernel.org>, xen-devel@lists.xenproject.org,
 Gregory Price <gourry@gourry.net>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-fscrypt@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 linux-kernel@vger.kernel.org, Nico Pache <nico.pache@linux.dev>,
 linux-perf-users@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-doc@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Hongbo Li <hongbohbli@tencent.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Byungchul Park <byungchul@sk.com>, linux-trace-kernel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Barry Song <baohua@kernel.org>,
 Kairui Song <kasong@tencent.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Muchun Song <muchun.song@linux.dev>, linux-f2fs-devel@lists.sourceforge.net,
 Minchan Kim <minchan@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Thomas Gleixner <tglx@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Pratyush Yadav <pratyush@kernel.org>, Alex Markuze <amarkuze@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-mtd@lists.infradead.org, Chunhai Guo <guochunhai@vivo.com>,
 Jonathan Corbet <corbet@lwn.net>, Dev Jain <dev.jain@arm.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Gao Xiang <xiang@kernel.org>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 James Clark <james.clark@linaro.org>, Steven Rostedt <rostedt@goodmis.org>,
 Borislav Petkov <bp@alien8.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Tal Zussman <tz2294@columbia.edu>,
 Ilya Dryomov <idryomov@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>, Ian Rogers <irogers@google.com>,
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 Peter Zijlstra <peterz@infradead.org>, Dave Young <ruirui.yang@linux.dev>,
 Yuanchu Xie <yuanchu@google.com>, "Liam R. Howlett" <liam@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Yue Hu <zbestahu@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Richard Weinberger <richard@nod.at>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Usama Arif <usama.arif@linux.dev>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Namhyung Kim <namhyung@kernel.org>,
 Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org,
 Adrian Hunter <adrian.hunter@intel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Zi Yan,

Thanks for the series. The cleanup is a nice help for the f2fs
large-folio work -- it removes the page-based private-flag plumbing that
my series would otherwise have to carry itself.

My large-folio series v2 [1] can be rebased on top of this series. The
only overlap is the PAGE_PRIVATE_* flag helpers, which I can re-express
on top of the F2FS_FOLIO_PRIVATE_* names while keeping the
f2fs_folio_state indirection.

Jaegeuk, do you have a preference on the ordering here? My personal
suggestion would be to review and merge this series first, and I'll
rebase on top of it.

[1] https://lore.kernel.org/linux-f2fs-devel/20260915041909.2903887-1-zhaonanzhe@xiaomi.com/

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
