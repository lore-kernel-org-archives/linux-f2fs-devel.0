Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEADEFD9E1A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 21:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BWA7ZlrqAJQh/SKvvEai6TTJYhvd7JTm7TZVULFjtbE=; b=QbvKZSTSFaHMamFyR2fk3UgTFj
	eaNMxsOa1coUIWR9Rb8AaJzgyfn7x0XJ8Tu4LubaPKgSFNFR7jZbyOgz03MGWD5wswG4u2/vvgB6m
	w/0gFiLfoMHwllzRQp4KFIUvETTh9ejYybLW5rnlF6CVfTCo6ixx7USLtMr0z7KFY7Ig=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvjEY-0002Wz-EG;
	Thu, 26 Feb 2026 21:49:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1vvjEN-0002Wk-Hu
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 21:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8h0E2AoeIQ7Q7IEHkeloRVm1CHFYLJOi16YgreKPWm4=; b=VNUDoVF41QOEiA6Hz72Bdxu4m2
 96SP53kKtDSSD8RTgozTeAbqWfrFFf+UEXp8cQgDaP33k1XEUz+b8f3Mj+3CGUaSHcA0m8ICyqkIo
 6/8hgBTTHoZ+0AEwKc3h0iqpKDXXdHDg5IEMpHRpqCQtwIRjdimNd1Graj+u0AkiNyGw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8h0E2AoeIQ7Q7IEHkeloRVm1CHFYLJOi16YgreKPWm4=; b=iE0H7jq7Ure3KuNdDHqCCIU2Za
 Ht5cBCdgtzbd8SazqGIz4VzvlyZDDVwTzhKhqgGRa768Vfq0HFc+Zta1d50MJReegniSbExtEwvJ/
 GesTK80PtW5/nrb7IqZ3966sxyLpvjgKEJ+d3HklHUSk7OnRr2gjGXdEkVhCByD0shwo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vvjEN-0006tk-1a for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 21:49:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E394B60054
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Feb 2026 21:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB10C2BC86
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Feb 2026 21:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772142539;
 bh=LF4bwcYv1+PfMspbbpqO2VzfLK8CTRaCpOj6mQJxZGw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DE91tYxQGQ4QxBgJOEimt9SuyKuQBPYLUL4UlaF+iiU8JXF6e/XKQpF4pv7fNAnqG
 RG+WIvDGsWn1T76onFAto8os34fIxnAjlFCSwj3zLnDCk7zfeAP4JeVOwK2AN25dJJ
 e3nvShtBiEO6bb2MmDT895QDbqwLrqBEhiiGQAWVATQmcZagwuhXgd5Q5CLCbfX0Wh
 Jp9qYXJXn+/juvAObwzMIeS5v/BiIc1hdPtq7XIC1N6yq4Nv0knl0ZB7lbHXyWoFg1
 FjOLw79+zsYESv8/01fif5e7garERpD/+lJ5hpvk9f2ZtPjo5Katp8jQwEAN9NEHkm
 ACC0Y66E/0I6g==
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-64c9ebd1369so1137602d50.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Feb 2026 13:48:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUl97j9MNmfofUIvY2RV/3WZp56i8Ol/WyFCrBd+KdwlTU4kl6fFmkw7DEBACKLH7fLuPHsRovtKHi4Ksx1+CYS@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw8XhmLBzTVNQJ0tClwbtVtaQwPeNkVVe/nLKyj3fvLzdfT6J6K
 2VnMJhdPu87wI62llk1FVEKVEQraFEvrERCAhvYed0vYb5oaPTO6XT+V+lrzRthUndglDZxRh8J
 4093pCLUxSSCzaN1BRXkbwCPJelMCrPGS6/+VcSNDNA==
X-Received: by 2002:a53:e8c9:0:b0:64c:a81e:f2b2 with SMTP id
 956f58d0204a3-64cc211f150mr699646d50.27.1772142538704; Thu, 26 Feb 2026
 13:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
 <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
In-Reply-To: <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
Date: Thu, 26 Feb 2026 13:48:47 -0800
X-Gmail-Original-Message-ID: <CACePvbX5Qm+kQLtCWynvO-2YtoW0mdR+V6rfq=buR6tfR1A9FQ@mail.gmail.com>
X-Gm-Features: AaiRm50fP40RQkljlPLX-PI1NSM3iQnOuQQEi7r5tKbV7kaWVe_vUmPk2uGLYLk
Message-ID: <CACePvbX5Qm+kQLtCWynvO-2YtoW0mdR+V6rfq=buR6tfR1A9FQ@mail.gmail.com>
To: Tal Zussman <tz2294@columbia.edu>
X-Headers-End: 1vvjEN-0006tk-1a
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
From: Chris Li via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chris Li <chrisl@kernel.org>
Cc: nvdimm@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>,
 "Darrick J. Wong" <djwong@kernel.org>, dri-devel@lists.freedesktop.org,
 ceph-devel@vger.kernel.org, linux-xfs@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Brendan Jackman <jackmanb@google.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Zi Yan <ziy@nvidia.com>, Shyam Prasad N <sprasad@microsoft.com>,
 John Hubbard <jhubbard@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBGZWIgMjUsIDIwMjYgYXQgMzo0NOKAr1BNIFRhbCBadXNzbWFuIDx0ejIyOTRAY29s
dW1iaWEuZWR1PiB3cm90ZToKPgo+IFJlbW92ZSB1bnVzZWQgcGFnZXZlYy5oIGluY2x1ZGVzIGZy
b20gLmMgZmlsZXMuIFRoZXNlIHdlcmUgZm91bmQgd2l0aAo+IHRoZSBmb2xsb3dpbmcgY29tbWFu
ZDoKPgo+ICAgZ3JlcCAtcmwgJyNpbmNsdWRlLipwYWdldmVjXC5oJyAtLWluY2x1ZGU9JyouYycg
fCB3aGlsZSByZWFkIGY7IGRvCj4gICAgICAgICBncmVwIC1xRSAnUEFHRVZFQ19TSVpFfGZvbGlv
X2JhdGNoJyAiJGYiIHx8IGVjaG8gIiRmIgo+ICAgZG9uZQo+Cj4gVGhlcmUgYXJlIHByb2JhYmx5
IG1vcmUgcmVtb3ZhbCBjYW5kaWRhdGVzIGluIC5oIGZpbGVzLCBidXQgdGhvc2UgYXJlCj4gbW9y
ZSBjb21wbGV4IHRvIGFuYWx5emUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBUYWwgWnVzc21hbiA8dHoy
Mjk0QGNvbHVtYmlhLmVkdT4KCkFja2VkLWJ5OiBDaHJpcyBMaSA8Y2hyaXNsQGtlcm5lbC5vcmc+
CgpDaHJpcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWYyZnMtZGV2ZWwK
