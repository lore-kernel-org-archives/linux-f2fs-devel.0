Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16AFFCE078
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vM1WerpBI0DmNSq9B3Y9MuvSZXsg4Kn0E8pusk6iq/I=; b=X0peD0M/zT9ItrcWjmEQbIEzsE
	kG87ZXlsHk3R7rk0fD3tANfJ7K64vQHZiZnunbe5BOHFKRwEDg80C5FRSz7OEvCTqt1lULGhF3bPk
	lQoDSvec0ALK8U4haKDl3fC2ufZMRnNR5vJJA6OhpI9tPMAQ0FcGLz7rB9OvHEje0ohY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvbCE-0006em-JN;
	Thu, 26 Feb 2026 13:14:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1vvbCD-0006eg-36
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 13:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n1GVrJkaq5WHGx+GWTcqrATUrcyExqNgPTLvNqarQAI=; b=gZgQt+S6h+9sH83FjouZdrlNgy
 exdBLoaPuUQKwowFZ5ZdqKZS23sbpGj7VCa7xCmtEmHrD4oVNbEftkaAbnv+Q4PchDVKuu7+WoM05
 LEr1N4oOUYva0CUBb0lbHgbtHhHHBSs/JblCPiaS9ZrZ/rAyfh7RiIf/a9xHimU5IbYo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n1GVrJkaq5WHGx+GWTcqrATUrcyExqNgPTLvNqarQAI=; b=b2dm5wP96Bf7bX990JRo2qynJ5
 V6FRUI1J1yldJMrjCzrtWyxoSSmnfYSGL37rCHEx0miFy+CaOSloTARFzVAv7MOXQDsziCYD0uMDe
 Tzggz+cTaKyCKeFUvLn8odE/o2Z3GfNABdTwYUHSYtdyxl3Luotb8HKLiksh25esv3RY=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vvbCC-0001L1-5e for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 13:14:25 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8CE71FA9C;
 Thu, 26 Feb 2026 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772111652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1GVrJkaq5WHGx+GWTcqrATUrcyExqNgPTLvNqarQAI=;
 b=RkX1tfVZOKSFeTpXbKMSQrkjS8DiWF9dl6iG0MTuiEWPjIfb7l+c9Vxhe07l9C5XMYN+gq
 D6fFh6GAOsTvBGyrY/2NpAOu2pS+8IGxhGKqDfTKmEuBb//COrtz1HtBtOzt2lTFL1PkJf
 QFtiVqtzIrIdFKM9Z8uJ33qtde+B86A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772111652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1GVrJkaq5WHGx+GWTcqrATUrcyExqNgPTLvNqarQAI=;
 b=ZzDwtMmLuCzQkg6CPTLYsjjNmtRbjAn3ogJRQxgqjMgB86XX3cbyMVsTJCOONSEsgoVml5
 0daFFWnfXwuUsnCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772111652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1GVrJkaq5WHGx+GWTcqrATUrcyExqNgPTLvNqarQAI=;
 b=RkX1tfVZOKSFeTpXbKMSQrkjS8DiWF9dl6iG0MTuiEWPjIfb7l+c9Vxhe07l9C5XMYN+gq
 D6fFh6GAOsTvBGyrY/2NpAOu2pS+8IGxhGKqDfTKmEuBb//COrtz1HtBtOzt2lTFL1PkJf
 QFtiVqtzIrIdFKM9Z8uJ33qtde+B86A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772111652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1GVrJkaq5WHGx+GWTcqrATUrcyExqNgPTLvNqarQAI=;
 b=ZzDwtMmLuCzQkg6CPTLYsjjNmtRbjAn3ogJRQxgqjMgB86XX3cbyMVsTJCOONSEsgoVml5
 0daFFWnfXwuUsnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 969ED3EA62;
 Thu, 26 Feb 2026 13:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XEjAJCRHoGkgSQAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 13:14:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 5EDF1A0A27; Thu, 26 Feb 2026 14:14:12 +0100 (CET)
Date: Thu, 26 Feb 2026 14:14:12 +0100
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Message-ID: <xcmjnkxgv5qzhqouj7dk3hqrd452crzosc74lyo53iqzeicepe@d6aoxuglacqo>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
 <20260225-pagevec_cleanup-v2-4-716868cc2d11@columbia.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260225-pagevec_cleanup-v2-4-716868cc2d11@columbia.edu>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Headers-End: 1vvbCC-0001L1-5e
Subject: Re: [f2fs-dev] [PATCH v2 4/4] folio_batch: Rename PAGEVEC_SIZE to
 FOLIO_BATCH_SIZE
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

On Wed 25-02-26 18:44:28, Tal Zussman wrote:
> struct pagevec no longer exists. Rename the macro appropriately.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/extent_io.c        | 4 ++--
>  include/linux/folio_batch.h | 6 +++---
>  include/linux/folio_queue.h | 6 +++---
>  mm/shmem.c                  | 4 ++--
>  mm/swap.c                   | 2 +-
>  mm/swap_state.c             | 2 +-
>  mm/truncate.c               | 6 +++---
>  7 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c373d113f1e7..d82ca509503f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2095,13 +2095,13 @@ static void buffer_tree_tag_for_writeback(struct btrfs_fs_info *fs_info,
>  struct eb_batch {
>  	unsigned int nr;
>  	unsigned int cur;
> -	struct extent_buffer *ebs[PAGEVEC_SIZE];
> +	struct extent_buffer *ebs[FOLIO_BATCH_SIZE];
>  };
>  
>  static inline bool eb_batch_add(struct eb_batch *batch, struct extent_buffer *eb)
>  {
>  	batch->ebs[batch->nr++] = eb;
> -	return (batch->nr < PAGEVEC_SIZE);
> +	return (batch->nr < FOLIO_BATCH_SIZE);
>  }
>  
>  static inline void eb_batch_init(struct eb_batch *batch)
> diff --git a/include/linux/folio_batch.h b/include/linux/folio_batch.h
> index a2f3d3043f7e..b45946adc50b 100644
> --- a/include/linux/folio_batch.h
> +++ b/include/linux/folio_batch.h
> @@ -12,7 +12,7 @@
>  #include <linux/types.h>
>  
>  /* 31 pointers + header align the folio_batch structure to a power of two */
> -#define PAGEVEC_SIZE	31
> +#define FOLIO_BATCH_SIZE	31
>  
>  struct folio;
>  
> @@ -29,7 +29,7 @@ struct folio_batch {
>  	unsigned char nr;
>  	unsigned char i;
>  	bool percpu_pvec_drained;
> -	struct folio *folios[PAGEVEC_SIZE];
> +	struct folio *folios[FOLIO_BATCH_SIZE];
>  };
>  
>  /**
> @@ -58,7 +58,7 @@ static inline unsigned int folio_batch_count(const struct folio_batch *fbatch)
>  
>  static inline unsigned int folio_batch_space(const struct folio_batch *fbatch)
>  {
> -	return PAGEVEC_SIZE - fbatch->nr;
> +	return FOLIO_BATCH_SIZE - fbatch->nr;
>  }
>  
>  /**
> diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
> index 0d3765fa9d1d..f6d5f1f127c9 100644
> --- a/include/linux/folio_queue.h
> +++ b/include/linux/folio_queue.h
> @@ -29,12 +29,12 @@
>   */
>  struct folio_queue {
>  	struct folio_batch	vec;		/* Folios in the queue segment */
> -	u8			orders[PAGEVEC_SIZE]; /* Order of each folio */
> +	u8			orders[FOLIO_BATCH_SIZE]; /* Order of each folio */
>  	struct folio_queue	*next;		/* Next queue segment or NULL */
>  	struct folio_queue	*prev;		/* Previous queue segment of NULL */
>  	unsigned long		marks;		/* 1-bit mark per folio */
>  	unsigned long		marks2;		/* Second 1-bit mark per folio */
> -#if PAGEVEC_SIZE > BITS_PER_LONG
> +#if FOLIO_BATCH_SIZE > BITS_PER_LONG
>  #error marks is not big enough
>  #endif
>  	unsigned int		rreq_id;
> @@ -70,7 +70,7 @@ static inline void folioq_init(struct folio_queue *folioq, unsigned int rreq_id)
>   */
>  static inline unsigned int folioq_nr_slots(const struct folio_queue *folioq)
>  {
> -	return PAGEVEC_SIZE;
> +	return FOLIO_BATCH_SIZE;
>  }
>  
>  /**
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 149fdb051170..5e7dcf5bc5d3 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1113,7 +1113,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>  	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
>  	struct folio_batch fbatch;
> -	pgoff_t indices[PAGEVEC_SIZE];
> +	pgoff_t indices[FOLIO_BATCH_SIZE];
>  	struct folio *folio;
>  	bool same_folio;
>  	long nr_swaps_freed = 0;
> @@ -1510,7 +1510,7 @@ static int shmem_unuse_inode(struct inode *inode, unsigned int type)
>  	struct address_space *mapping = inode->i_mapping;
>  	pgoff_t start = 0;
>  	struct folio_batch fbatch;
> -	pgoff_t indices[PAGEVEC_SIZE];
> +	pgoff_t indices[FOLIO_BATCH_SIZE];
>  	int ret = 0;
>  
>  	do {
> diff --git a/mm/swap.c b/mm/swap.c
> index 2e517ede6561..78b4aa811fc6 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1018,7 +1018,7 @@ EXPORT_SYMBOL(folios_put_refs);
>  void release_pages(release_pages_arg arg, int nr)
>  {
>  	struct folio_batch fbatch;
> -	int refs[PAGEVEC_SIZE];
> +	int refs[FOLIO_BATCH_SIZE];
>  	struct encoded_page **encoded = arg.encoded_pages;
>  	int i;
>  
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index a0c64db2b275..6313b59d7eab 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -385,7 +385,7 @@ void free_folio_and_swap_cache(struct folio *folio)
>  void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
>  {
>  	struct folio_batch folios;
> -	unsigned int refs[PAGEVEC_SIZE];
> +	unsigned int refs[FOLIO_BATCH_SIZE];
>  
>  	folio_batch_init(&folios);
>  	for (int i = 0; i < nr; i++) {
> diff --git a/mm/truncate.c b/mm/truncate.c
> index df0b7a7e6aff..2931d66c16d0 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -369,7 +369,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  	pgoff_t		start;		/* inclusive */
>  	pgoff_t		end;		/* exclusive */
>  	struct folio_batch fbatch;
> -	pgoff_t		indices[PAGEVEC_SIZE];
> +	pgoff_t		indices[FOLIO_BATCH_SIZE];
>  	pgoff_t		index;
>  	int		i;
>  	struct folio	*folio;
> @@ -534,7 +534,7 @@ EXPORT_SYMBOL(truncate_inode_pages_final);
>  unsigned long mapping_try_invalidate(struct address_space *mapping,
>  		pgoff_t start, pgoff_t end, unsigned long *nr_failed)
>  {
> -	pgoff_t indices[PAGEVEC_SIZE];
> +	pgoff_t indices[FOLIO_BATCH_SIZE];
>  	struct folio_batch fbatch;
>  	pgoff_t index = start;
>  	unsigned long ret;
> @@ -672,7 +672,7 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  int invalidate_inode_pages2_range(struct address_space *mapping,
>  				  pgoff_t start, pgoff_t end)
>  {
> -	pgoff_t indices[PAGEVEC_SIZE];
> +	pgoff_t indices[FOLIO_BATCH_SIZE];
>  	struct folio_batch fbatch;
>  	pgoff_t index;
>  	int i;
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
