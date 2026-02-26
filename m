Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDC8FD45FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 01:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Mime-Version:References:In-Reply-To:Message-Id:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9Cnw0JHCUHqqHArn+sXYOrgyoplKK3UUk/MbB5ybbs=; b=YuFMrGhWm9qXAByCmQNJHjxM7m
	bSluynLnWK8G8oL7SKXubi05mNAO/01damFk5CMC9It1bG9lQwm0u2OhweWdjlNZBQqtzndh83+Ph
	pu08MBlyYm742opLDS26Ea1oo82peCHZ8vZi+N5sBxOoh1mxsU5wYtp5T4D9foY+gnXI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvPk8-0008Ox-H4;
	Thu, 26 Feb 2026 01:00:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <akpm@linux-foundation.org>) id 1vvPk6-0008Op-Uy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 01:00:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kzBboXRq2m0Xbzbb5Eqzgnd6HDbE7nrSUbmDE0s8g3A=; b=Ag1GfOh+zcwoHW9gHUB65jAXTx
 EUVV0jqTyGG8tILmx4LUBebVXrR8Av3NQyEos5kMDvpG3+1s2Rs7Sq0dct6JL+S0NBxGW4gz4ZAK6
 6HaGck9KnheuDySI8cY/nP66QfmU9Fu+NG++sLu41MVHJ4yT6U6kRAFwdv14FKh+JqeM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kzBboXRq2m0Xbzbb5Eqzgnd6HDbE7nrSUbmDE0s8g3A=; b=Y2MR5nrtgc0uZP3Eos7TamoWFi
 f78bDZdUEsuu6Heu72fyBYydZ7bFUJ5TO/kZbUeCh4Adp/1J478ffSV36OVt2npi+bLFRbuCroLlO
 cRz3SR1oLHzoMnLeqYRSccXdnLgeGp5CsmJT9R2AZUxaGBNWyE1uPEUnF2vPpyfK6/BA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vvPk6-00009v-1Y for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 01:00:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1381C60053;
 Thu, 26 Feb 2026 00:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CC4C116D0;
 Thu, 26 Feb 2026 00:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1772066507;
 bh=a5b15Ngqo2bOOdUHSjsT/sSuPPfkZQCQF/naFXI2QkI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CcOiuO7NEI5etysy42JpjnremhTiWgG4lUGW8vs+Kti8TdTA3xkAw8m9bRPHQw/jW
 UtviHmXGTs0EojsHSlFb7e+3Lc6f61/dMS61S/znrah0BD8VlKfWckTXVq5rOTTIiN
 OwOPmCyouWxjyK/Ldx7pApiM6o9/4J5sMHRRG9vY=
Date: Wed, 25 Feb 2026 16:41:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tal Zussman <tz2294@columbia.edu>
Message-Id: <20260225164144.76e14a362e0d7cae49f20787@linux-foundation.org>
In-Reply-To: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Headers-End: 1vvPk6-00009v-1Y
Subject: Re: [f2fs-dev] [PATCH v2 0/4] mm: Remove stray references to pagevec
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

On Wed, 25 Feb 2026 18:44:24 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> struct pagevec was removed in commit 1e0877d58b1e ("mm: remove struct
> pagevec"). Remove any stray references to it and rename relevant files
> and macros accordingly.
> 
> While at it, remove unnecessary #includes of pagevec.h (now
> folio_batch.h) in .c files. There are probably more of these that could
> be removed in .h files, but those are more complex to verify.

Dang that's a lot of cc's ;)

Thanks, I'll add this series to mm.git's mm-new branch.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
