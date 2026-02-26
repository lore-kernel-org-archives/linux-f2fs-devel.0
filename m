Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D42FCE068
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/BCEPG+FOKOMit4Pg4RaOoiShDkLsYY2TfVfd42luvM=; b=K9o40+syZU0kTitpsns0HTXwV0
	ycPmsWX+I9JtFo7FSwvJS2S7c0JPZxBR1u8erLqBUMJtwzIXshBz4WpZ3lqlo+RYTogRaf3Jl3Qkg
	nNAHGxY4XL2bEubdbt4+9JUBEuI8ulNXwppEAJX6U7jj9Puwl4x3LMRnxVHjFMe3Djso=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvbB0-0006Gq-1Q;
	Thu, 26 Feb 2026 13:13:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1vvbAy-0006Gj-Fd
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 13:13:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=; b=g6lgAHPZRQ4zgV84f9XpfnxFG4
 ar7Hq5f34LxiN/59pX0Lz74qe/oCkl2roK1Q0mZo7IlhH2e7pHRv2qx71BYDGxtzE1Gs1sjNn2vr8
 45IRoXmJV6n/eUmzu66/UI01QGdTl+vBeLIJZxZCmyNfqiXly4Op31r+8N8BMEi3MO3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=; b=VmBQNaOEXxeQxU7ikeDM49/HeE
 /8s6Va5Uzx6T5u28PePF2tj4Mo1l78MbnPs+QO0MIr3TrC99IWggHcE2RRl7T3Q5c8yPJzPtwk4Vt
 ++IAsmfuqFn1IAv3MQIw/JFnvTF5zNtUjet9VFoUhEC2UKZ/8GW1LH2Pf+HLcEA+fxhg=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vvbAx-0001GI-D3 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 13:13:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA9EC1FA54;
 Thu, 26 Feb 2026 13:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772111576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=;
 b=VGr+5vEttV5KSq8KiEHuA26h/lUE7LlTpKXuEPlZT6DHY8M0THqc8Wu4WiiN1rMKTDa6OR
 5Zwq7W2zP5J9H2ZZtsgp7HFYiY7A5pTLtjNy0TniXfJ1K1ZfjtmltW1AfqY66XIH5dEDdF
 VeWG6x2cAMoVE/5vHhJrUfeSClIjrGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772111576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=;
 b=69XqZjby1BkpPQKJs37ti4jhyJiLv1OPj8pDlz96Ez+SqXyH4PTF7HJvtJR1jjG+ILIaff
 xw7ztXeG0NlBlDCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772111575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=;
 b=F9/qrZcgGN/hgxgLb3qI//qiHnxBKsB5Ntd3IGQuMTlxZWdr2ZN0mP/0xmZRIkCuKafDWW
 +xk6zJK7T/iYLhGjEM5isA7Eem1B8k1QXrKcyY15lvatrlOTH99iXwpZ6R10io+b8DM7zy
 RLtfnL1PTllGjvJOTHiKeaQnegihWz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772111575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=;
 b=uMdyIKIfyG5+TXpjkra12NBuPmWqX7KgZp3+we3ktt8NePQQXrpbFT4ToI2DhSA7MGpiSM
 FOl4NQaT3QPKQJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA6F53EA62;
 Thu, 26 Feb 2026 13:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1O9nMddGoGkmSAAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 13:12:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 8CCF6A0A27; Thu, 26 Feb 2026 14:12:51 +0100 (CET)
Date: Thu, 26 Feb 2026 14:12:51 +0100
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Message-ID: <hulhfdnrv4bbm6nvy3x4xbuxmc5ypmhpwdpt3jurfkibq5t2pu@6dcvs2uzzr46>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
 <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
X-Spamd-Result: default: False [-2.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu,dilger.ca,manguebit.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,ursulin.net,fb.com,dubeyko.com,linux.dev,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org];
 RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL3r69cimucwc5kbfiftdz1c5n)];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCPT_COUNT_GT_50(0.00)[97];
 RCVD_TLS_LAST(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Headers-End: 1vvbAx-0001GI-D3
Subject: Re: [f2fs-dev] [PATCH v2 2/4] fs: Remove unncessary pagevec.h
 includes
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
Cc: nvdimm@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>,
 "Darrick J. Wong" <djwong@kernel.org>, dri-devel@lists.freedesktop.org,
 ceph-devel@vger.kernel.org, linux-xfs@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Brendan Jackman <jackmanb@google.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Zi Yan <ziy@nvidia.com>, Shyam Prasad N <sprasad@microsoft.com>,
 Chris Li <chrisl@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>, samba-technical@lists.samba.org,
 Simona Vetter <simona@ffwll.ch>, linux-cifs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 Hugh Dickins <hughd@google.com>, Olga Kornievskaia <okorniev@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, ocfs2-devel@lists.linux.dev,
 Jani Nikula <jani.nikula@linux.intel.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
 Theodore Ts'o <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>,
 linux-f2fs-devel@lists.sourceforge.net, Anna Schumaker <anna@kernel.org>,
 Alex Markuze <amarkuze@redhat.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Peter Xu <peterx@redhat.com>, Chris Mason <clm@fb.com>,
 Pedro Falcato <pfalcato@suse.de>, Marc Dionne <marc.dionne@auristor.com>,
 linux-afs@lists.infradead.org, Baoquan He <bhe@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Viacheslav Dubeyko <slava@dubeyko.com>,
 NeilBrown <neil@brown.name>, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, cgroups@vger.kernel.org,
 Shakeel Butt <shakeel.butt@linux.dev>, Dan Williams <dan.j.williams@intel.com>,
 Oscar Salvador <osalvador@suse.de>, gfs2@lists.linux.dev,
 linux-nfs@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
 Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
 netfs@lists.linux.dev, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Yuanchu Xie <yuanchu@google.com>,
 David Howells <dhowells@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, David Airlie <airlied@gmail.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, Mark Fasheh <mark@fasheh.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Axel Rasmussen <axelrasmussen@google.com>, Jann Horn <jannh@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, David Sterba <dsterba@suse.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, Wei Xu <weixugc@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed 25-02-26 18:44:26, Tal Zussman wrote:
> Remove unused pagevec.h includes from .c files. These were found with
> the following command:
> 
>   grep -rl '#include.*pagevec\.h' --include='*.c' | while read f; do
>   	grep -qE 'PAGEVEC_SIZE|folio_batch' "$f" || echo "$f"
>   done
> 
> There are probably more removal candidates in .h files, but those are
> more complex to analyze.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

If it compiles than it's nice to get rid of. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/afs/write.c                   | 1 -
>  fs/dax.c                         | 1 -
>  fs/ext4/file.c                   | 1 -
>  fs/ext4/page-io.c                | 1 -
>  fs/ext4/readpage.c               | 1 -
>  fs/f2fs/file.c                   | 1 -
>  fs/mpage.c                       | 1 -
>  fs/netfs/buffered_write.c        | 1 -
>  fs/nfs/blocklayout/blocklayout.c | 1 -
>  fs/nfs/dir.c                     | 1 -
>  fs/ocfs2/refcounttree.c          | 1 -
>  fs/smb/client/connect.c          | 1 -
>  fs/smb/client/file.c             | 1 -
>  13 files changed, 13 deletions(-)
> 
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 93ad86ff3345..fcfed9d24e0a 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -10,7 +10,6 @@
>  #include <linux/fs.h>
>  #include <linux/pagemap.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
>  #include <linux/netfs.h>
>  #include <trace/events/netfs.h>
>  #include "internal.h"
> diff --git a/fs/dax.c b/fs/dax.c
> index b78cff9c91b3..a5237169b467 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -15,7 +15,6 @@
>  #include <linux/memcontrol.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
> -#include <linux/pagevec.h>
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
>  #include <linux/uio.h>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f1dc5ce791a7..5e02f6cf653e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -27,7 +27,6 @@
>  #include <linux/dax.h>
>  #include <linux/filelock.h>
>  #include <linux/quotaops.h>
> -#include <linux/pagevec.h>
>  #include <linux/uio.h>
>  #include <linux/mman.h>
>  #include <linux/backing-dev.h>
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index a8c95eee91b7..98da200d11c8 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -16,7 +16,6 @@
>  #include <linux/string.h>
>  #include <linux/buffer_head.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
>  #include <linux/mpage.h>
>  #include <linux/namei.h>
>  #include <linux/uio.h>
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 830f3b8a321f..3c7aabde719c 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -43,7 +43,6 @@
>  #include <linux/mpage.h>
>  #include <linux/writeback.h>
>  #include <linux/backing-dev.h>
> -#include <linux/pagevec.h>
>  
>  #include "ext4.h"
>  #include <trace/events/ext4.h>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c8a2f17a8f11..c6b6a1465d08 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -17,7 +17,6 @@
>  #include <linux/compat.h>
>  #include <linux/uaccess.h>
>  #include <linux/mount.h>
> -#include <linux/pagevec.h>
>  #include <linux/uio.h>
>  #include <linux/uuid.h>
>  #include <linux/file.h>
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 7dae5afc2b9e..e5285fbfcf09 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -28,7 +28,6 @@
>  #include <linux/mm_inline.h>
>  #include <linux/writeback.h>
>  #include <linux/backing-dev.h>
> -#include <linux/pagevec.h>
>  #include "internal.h"
>  
>  /*
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 22a4d61631c9..05ea5b0cc0e8 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -10,7 +10,6 @@
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
> -#include <linux/pagevec.h>
>  #include "internal.h"
>  
>  static void __netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> index cb0a645aeb50..11f9f69cde61 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -36,7 +36,6 @@
>  #include <linux/namei.h>
>  #include <linux/bio.h>		/* struct bio */
>  #include <linux/prefetch.h>
> -#include <linux/pagevec.h>
>  
>  #include "../pnfs.h"
>  #include "../nfs4session.h"
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 2402f57c8e7d..0d276441206b 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -32,7 +32,6 @@
>  #include <linux/nfs_fs.h>
>  #include <linux/nfs_mount.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
>  #include <linux/namei.h>
>  #include <linux/mount.h>
>  #include <linux/swap.h>
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index c1cdececdfa4..b4acd081bbc4 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -31,7 +31,6 @@
>  #include <linux/blkdev.h>
>  #include <linux/slab.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
>  #include <linux/swap.h>
>  #include <linux/security.h>
>  #include <linux/string.h>
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 33dfe116ca52..9e57812b7b95 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -20,7 +20,6 @@
>  #include <linux/delay.h>
>  #include <linux/completion.h>
>  #include <linux/kthread.h>
> -#include <linux/pagevec.h>
>  #include <linux/freezer.h>
>  #include <linux/namei.h>
>  #include <linux/uuid.h>
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 18f31d4eb98d..853ce1817810 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -15,7 +15,6 @@
>  #include <linux/stat.h>
>  #include <linux/fcntl.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
>  #include <linux/writeback.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/delay.h>
> 
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
