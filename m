Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4683FCE077
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CohVa61SDA6jzfWXgm1LZuVReyrlyUgWzEGX0qzZQlM=; b=SosWlMYNu2nmX36jSnR8GG9AqL
	kA4fsJuaQha7Ruxf+2nOYr5N9o1CynDqe6QeKUm8aEGQq0JgydffYRX+7caH57BfxVja/3gg9Ijtv
	RtA0MyEN1BFaoo9I5eshLWaXpE5qr/4FDP6KbkyRON5YKWhx3ZF6m8s0dXrL2BhcQoJM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvbH7-0006lx-HX;
	Thu, 26 Feb 2026 13:19:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <david@kernel.org>) id 1vvbH6-0006lr-Ca
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 13:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WD6XTRarfy5RNjSLuokAzaZext5Dun04xofWaYrk1rs=; b=Kcv8G6wkQo1tUnQsiYow7Xq0Fe
 84H7cM7vRtxWb+a8C8FXhP5Pm9o5aTFTD6TlURD7FoMmTrqSS+n/t5W1gu0uDxJGjYSv8eSMaqHBu
 O9nCNqybYmuF058vwzfhMZaC66dl6pdCkQw9eAA9T/3Et4DdcUY44pTcwIlDc7KXT9WA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WD6XTRarfy5RNjSLuokAzaZext5Dun04xofWaYrk1rs=; b=moRA1SlRDErPN4i4lYgua40RxU
 7xjBnttrsKGGgRXOcfnGTuxlcZTYI4we9w4A2yDbBgjVVUPbgxkCfxBwXERbVVjyzI/fNU4032bts
 iLteXly0iZHCP8nexfzNbGnKlXwCxWBqtiluZXgEI13GZI+bBS5+g2ptLZY1ACFXfYQg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vvbH5-0001kA-Uf for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 13:19:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E4CE74439F;
 Thu, 26 Feb 2026 13:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC336C116C6;
 Thu, 26 Feb 2026 13:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772111961;
 bh=Pf04Z7iE3GM1u8EKRphHFGn52yUYGcn6vqYD0z/gPbY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jMmZos5dus2Vdwkn4H474ZgHVP2copjj/B3Awars5H3ImcL7EgOM+GnMA5CvpMRm3
 uZjje4pqYf4U/nYL+xRxiEDH//aWM0rBwtjD95CAOoRC2yuXMGbL5XtrrMmgfnS2rW
 SKRnp4xNZwZG4CbEKAWHfIsR255vlBA65beKvnqEE9eQWoG97Ra/KUkEcxKju0Wfvo
 sjYcPaRs41hJ/9ffBGb+rQMm97rSXg5Yl5sDLfCmjj7fxTZulWhSZ1k9V9zsma5KQh
 vO/EnlqBQWN2nRtvXne5k66C0o9AUqoILyum0ho9cOZ5L+B4QwkKlPj3fsUzF/4C8F
 ObzEmPlSut8+g==
Message-ID: <e2b9ef35-48af-4580-86b4-8640d353028c@kernel.org>
Date: Thu, 26 Feb 2026 14:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tal Zussman <tz2294@columbia.edu>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams
 <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
 <20260225-pagevec_cleanup-v2-3-716868cc2d11@columbia.edu>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260225-pagevec_cleanup-v2-3-716868cc2d11@columbia.edu>
X-Headers-End: 1vvbH5-0001kA-Uf
Subject: Re: [f2fs-dev] [PATCH v2 3/4] folio_batch: Rename pagevec.h to
 folio_batch.h
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
Cc: nvdimm@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>,
 Alex Markuze <amarkuze@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Peter Xu <peterx@redhat.com>, Yuanchu Xie <yuanchu@google.com>,
 linux-mm@kvack.org, Chris Mason <clm@fb.com>, Hugh Dickins <hughd@google.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Pedro Falcato <pfalcato@suse.de>,
 samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
 David Airlie <airlied@gmail.com>, linux-afs@lists.infradead.org,
 Simona Vetter <simona@ffwll.ch>, linux-cifs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
 Mark Fasheh <mark@fasheh.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Zi Yan <ziy@nvidia.com>,
 NeilBrown <neil@brown.name>, Axel Rasmussen <axelrasmussen@google.com>,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 Wei Xu <weixugc@google.com>, Shyam Prasad N <sprasad@microsoft.com>,
 Olga Kornievskaia <okorniev@redhat.com>, Anna Schumaker <anna@kernel.org>,
 Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, cgroups@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Tom Talpey <tom@talpey.com>,
 ocfs2-devel@lists.linux.dev, Bharath SM <bharathsm@microsoft.com>,
 Joel Becker <jlbec@evilplan.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Sterba <dsterba@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, ceph-devel@vger.kernel.org,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Jani Nikula <jani.nikula@linux.intel.com>,
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, dri-devel@lists.freedesktop.org,
 Muchun Song <muchun.song@linux.dev>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-btrfs@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org,
 netfs@lists.linux.dev, Brendan Jackman <jackmanb@google.com>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/26/26 00:44, Tal Zussman wrote:
> struct pagevec was removed in commit 1e0877d58b1e ("mm: remove struct
> pagevec"). Rename include/linux/pagevec.h to reflect reality and update
> includes tree-wide. Add the new filename to MAINTAINERS explicitly, as
> it no longer matches the "include/linux/page[-_]*" pattern in MEMORY
> MANAGEMENT - CORE.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
