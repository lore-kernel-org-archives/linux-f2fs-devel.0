Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7154C44501
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Jan 2026 09:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o4jymooE4Qv+E2bDDj6DusoYyplkiP21elo/bmESUG8=; b=NI9EZjP9HSpybdBSwqSc6BR3XE
	k36dXWx49NHuIr7qpeVTayCT8PLIq0ZMC8EABWCEOg/K2nqEyOA1TqlXjkfW1M6fNqp0kOZtC73ML
	ADAalyqPRYLxJub7R99WoAhIqDem8XcMbCH5jtFdal3z6TOC1Sil9R6tD+KrjJgx/rfA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viUpu-0000dw-UC;
	Wed, 21 Jan 2026 09:49:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+bcc91a9d4ebb8e7eb2a7+8186+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1viUps-0000dY-7i; Wed, 21 Jan 2026 09:49:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RwuG4Zh8xzi3XsfiX+hfl4eOhPi+sTrKAwirdvzvU78=; b=Np5043BwmHFImedRMHllwpA83H
 DeI+8uSRoogCwac4Vr9yOusMUwHcpUModPNRXz05QSizzOA5iE2cyaoRoTLXzrbtVy4kE7H36rZ5u
 RNW72ZFQOR6c+HJeyBSRNM9co80YkkhI0HIQe3eGamL5Yg9d+Gze+XUZ8CIija78QI14=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RwuG4Zh8xzi3XsfiX+hfl4eOhPi+sTrKAwirdvzvU78=; b=UdTvAmivfwHBKXybq2l0AV35eL
 O58pCGH1if+VN/jN28ZJx5XdrUYLC8qKz1ZQGrEtsHrEX0yuQZqGKrfxqZtHHIqGmKT7MwHmcqo2S
 K7t82QoydPY8D4UoWHo9EC3LZw0/M89B6On1w5O1mqkEQDYiV7lIbYR0hlxQI/8WYj3s=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viUpr-0000tn-Jc; Wed, 21 Jan 2026 09:49:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RwuG4Zh8xzi3XsfiX+hfl4eOhPi+sTrKAwirdvzvU78=; b=nZgTFNzu14yUnMagBymm1SVNaE
 0iI2+v0tg8mrJftjxuiLasZhfk9iatzt6SV3zcWbej4U221rInInSi+IHEz/gS/qBm9sRHcJyamaY
 2iVgOPW0H3w/vq4ErMxFUpMgqMdpr99bvrrbEx1zBJxf6Oqd1tds0vHyOzdQuLPKc5V+mIOIAqEl1
 w6H+15/ZlqHoAqJ9oz6poJ5+1SXpK3oiRj9woVMFWFqnIBi9cp3UcnQlhY2ZC1n18yBMINnNb27r3
 TUQ/4lNxikcW3bhV7aDAFg1yrx2W+1KDhA9xNOfeEs+KGiyy3rKt15Wi5bHrUF/HESTAyVVaZu416
 HhHRjLFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1viUpM-00000005D5S-1Xs6;
 Wed, 21 Jan 2026 09:48:40 +0000
Date: Wed, 21 Jan 2026 01:48:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Message-ID: <aXCg-MqXH0E6IuwS@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org>
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>
 <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <aW8w2SRyFnmA2uqk@infradead.org>
 <176890126683.16766.5241619788613840985@noble.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <176890126683.16766.5241619788613840985@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1viUpr-0000tn-Jc
Subject: Re: [f2fs-dev] [PATCH 00/29] fs: require filesystems to explicitly
 opt-in to nfsd export support
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
Cc: Martin Brandenburg <martin@omnibond.com>,
 jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 Paulo Alcantara <pc@manguebit.org>, Alex Markuze <amarkuze@redhat.com>,
 Sandeep Dhavale <dhavale@google.com>, linux-btrfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 linux-unionfs@vger.kernel.org,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Chunhai Guo <guochunhai@vivo.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>,
 linux-xfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 Hugh Dickins <hughd@google.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Viacheslav Dubeyko <slava@dubeyko.com>,
 Gao Xiang <xiang@kernel.org>, linux-ext4@vger.kernel.org,
 Salah Triki <salah.triki@gmail.com>, linux-mm@kvack.org,
 devel@lists.orangefs.org, Shyam Prasad N <sprasad@microsoft.com>,
 Olga Kornievskaia <okorniev@redhat.com>, linux-cifs@vger.kernel.org,
 Dave Kleikamp <shaggy@kernel.org>, linux-nfs@vger.kernel.org,
 Tom Talpey <tom@talpey.com>, ocfs2-devel@lists.linux.dev,
 Bharath SM <bharathsm@microsoft.com>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Luis de Bethencourt <luisbg@kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 Chuck Lever <chuck.lever@oracle.com>, Hongbo Li <lihongbo22@huawei.com>,
 Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>,
 linux-fsdevel@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, ntfs3@lists.linux.dev,
 David Woodhouse <dwmw2@infradead.org>, Trond Myklebust <trondmy@kernel.org>,
 Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jan 20, 2026 at 08:27:46PM +1100, NeilBrown wrote:
> > If you think NFS actually explains the semantics pretty well, please
> > explain that too, especially in forms that can be put into
> > documentation, including for the user ABI.
> 
> There are multiple issues here:
> 
>  - filehandle stability.  As far as I know all filesystems provide
>    stable filehandles when the "subtree_check" export option is not used.

That is news to me, but certainly interesting.  Does this include not
reusing the file handle for a new incarnation of the same thing?

>    Certainly cgroupfs does.  So having an EXPORT_OP_STABLE_HANDLES
>    flag would mean it was set for every filesystem - unless there is
>    something else I'm not aware of.  That is certainly possible and I
>    hope someone will let me know if I'm missing something.

Well, if does not provide stable file handles with the subtree_check
export option, or more importantly with the CONNECTABLE flag passed
to encode_fh, which is the level we're operating on, it can't set the
flag.

>  - filehandle uniqueness.  This is somewhat important and if a
>    filesystem doesn't provide it, that should be considered a bug.  In a
>    different thread Christian has observed that there would be benefit
>    if pidfs and nsfs provided uniqueness across reboots.  It is quite
>    easy for a virtual filesystem to generate a 64 bit random number when
>    the fs is initialised, and include that in file handles.  Having a
>    EXPORT_OP_REUSES_HANDLES flag could mark filesystems that are still
>    buggy if that is thought to be useful.

Yes.

>  - GETATTR always reporting file size of 0.  This is the only concrete
>    symptom that Jeff has reported (that I have seen).  This  makes it
>    impossible to read files over NFS even if they have content.
>    Would EXPORT_OP_INACCURATE_SIZE be useful?

i_size = 0 for a regular file sounds like a genuine bug to me.  I'm
actually surprised anything works with that.

>  - maintainer feature choice.  A maintainer may choose not to support
>    export over NFS because they feel that there is no value and the
>    possible support burden would not be worth it.

The maintainer has no way to disallow exporting through nfs.  They can
at best disallow exporting using the kernel nfs daemon if we provide
that facility.  But as I've argued multiple times, making arbitrary,
selective and very narrow choices about use cases without technical
backing for them (which then would be expressable as a flag like those
listed by you above) is really bad software development practice, and
not something that we usually do in the Linux kernel.

>    There may be locking
>    / lease / etc issues that further complicate things.  So it might be
>    reasonable for a maintainer to choose to forbid NFS export while
>    allowing local fhandle access. EXPORT_OP_NO_NFS_EXPORT.

We already have a EXPORT_OP_NOLOCKS flag to deal with this.

> 
> It took me a while to sift through the code/patches/comments and come to
> this understanding and I apologise if I wasn't as clear earlier.  But
> my intuition was always that file handle stability was never the real
> issue, and maintainer choice was.  Hence my rejection of the
> "STABLE_HANDLES" name.

Why do you keep ignoring the fat that the stable handles are really
important for anyone wanting to actually use them for their original
storage purpose, be that for knfsd, a userland nfs damon, or other
storage applications in userspace despite explaining this countless
times?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
