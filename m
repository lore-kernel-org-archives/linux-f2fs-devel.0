Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ED9C001B0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Aug 2023 14:23:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qTk5j-0004iS-M5;
	Wed, 09 Aug 2023 14:23:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jlayton@kernel.org>) id 1qTk5h-0004iM-Ej
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Aug 2023 14:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l99z4t7iYAcjcpd8pe3GA9+BxylS//t6BR8LMSus4Kw=; b=SzY5eH4h187lAdJHbTejOR/0MO
 jKVXowWkdBzXuK3iJT9v6y2vCuGITSpS+P3Nm1K7qaqozF3P2ERGS7uTM2ZROhiPSmY70ao7YSWwn
 YUrENWPkvlHu+CZdse1YMSSdYGxN0UIaUje3DNA4x/B1Q264UhiVroIMeEMVp2LitX10=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l99z4t7iYAcjcpd8pe3GA9+BxylS//t6BR8LMSus4Kw=; b=Xa+W8JT2po8R4OCQ3tqtAYZkoX
 3y75uZ+xluT3B6DemC9T5/CYKT3KM2+FkZq28vsIrf6Yq0nfFnOfjrAMqqTacofes9L+YdWysx990
 F++KqcrBYF7XkBcy4Q2z4qVnDGIotADikZA+wD1nFjH7vpRTkWAsb1O2EtotpjTWmgmI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qTk5d-0005bW-4j for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Aug 2023 14:23:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 85ABA6250A;
 Wed,  9 Aug 2023 14:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2D2C433C7;
 Wed,  9 Aug 2023 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691590982;
 bh=LgXOvH2tCTHIjBx4H7FiUs60LQPWskUEsq2zDenCRXk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=d3tvC2K0q9zmSKovb3MCz70OZ0zDUfwQjvtmqpayy/+0zTCRnvBnhoitfla9mzpYS
 6/IQTcAliZ/qw+jQL6ikoz6PNYzqJ5V/AqPdhloBtpJ7o+04K1HJBA1CLTORrD2v+D
 7LM1T9XMRPVFf25JkonEGd6tPIqFqFkNRPbUkBuWrkC1zyTV3QcmWREwMXrZwRBWOf
 qlZSX+5xrbt2rURYBov8h1oSuPFEc5pUfvutsD/+H96L3ykp7YO0AtG9js4MbdLlC5
 xVqrAhV0e5CphxqERFiIWxatm9vmAPUWZveD51138XqFFJM1+SpLi461h67PgiJAZz
 6pxgp2dPf4+Bg==
Message-ID: <7edc9239f73022b9c2a1d3f4f946153f85f94739.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 09 Aug 2023 10:22:54 -0400
In-Reply-To: <878rak8hia.fsf@mail.parknet.co.jp>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
 <87msz08vc7.fsf@mail.parknet.co.jp>
 <52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
 <878rak8hia.fsf@mail.parknet.co.jp>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Headers-End: 1qTk5d-0005bW-4j
Subject: Re: [f2fs-dev] [PATCH v7 05/13] fat: make fat_update_time get its
 own timestamp
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
Cc: Latchesar Ionkov <lucho@ionkov.net>,
 Martin Brandenburg <martin@omnibond.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, "Darrick
 J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org,
 Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>,
 David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, linux-xfs@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org,
 Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>,
 linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 linux-unionfs@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>,
 cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org,
 Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>,
 Namjae Jeon <linkinjeon@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 codalist@telemann.coda.cs.cmu.edu, Shyam Prasad N <sprasad@microsoft.com>,
 Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>,
 ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
 Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>, Gao Xiang <xiang@kernel.org>,
 Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>,
 linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>,
 Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org,
 linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, 2023-08-09 at 22:36 +0900, OGAWA Hirofumi wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > On Wed, 2023-08-09 at 17:37 +0900, OGAWA Hirofumi wrote:
> > > Jeff Layton <jlayton@kernel.org> writes:
> > > 
> > > > Also, it may be that things have changed by the time we get to calling
> > > > fat_update_time after checking inode_needs_update_time. Ensure that we
> > > > attempt the i_version bump if any of the S_* flags besides S_ATIME are
> > > > set.
> > > 
> > > I'm not sure what it meaning though, this is from
> > > generic_update_time(). Are you going to change generic_update_time()
> > > too? If so, it doesn't break lazytime feature?
> > > 
> > 
> > Yes. generic_update_time is also being changed in a similar fashion.
> > This shouldn't break the lazytime feature: lazytime is all about how and
> > when timestamps get written to disk. This work is all about which
> > clocksource the timestamps originally come from.
> 
> I can only find the following update in this series, another series
> updates generic_update_time()? The patch updates only if S_VERSION is
> set.
> 
> Your fat patch sets I_DIRTY_SYNC always instead of I_DIRTY_TIME. When I
> last time checked lazytime, and it was depending on I_DIRTY_TIME.
> 
> Are you sure it doesn't break lazytime? I'm totally confusing, and
> really similar with generic_update_time()?
> 

I'm a little confused too. Why do you believe this will break
-o relatime handling? This patch changes two things:

1/ it has fat_update_time fetch its own timestamp (and ignore the "now"
parameter). This is in line with the changes in patch #3 of this series,
which explains the rationale for this in more detail.

2/ it changes fat_update_time to also update the i_version if any of
S_CTIME|S_MTIME|S_VERSION are set. relatime is all about the S_ATIME,
and it is specifically excluded from that set.

The rationale for the second change is is also in patch #3, but
basically, we can't guarantee that current_time hasn't changed since we
last checked for inode_needs_update_time, so if any of
S_CTIME/S_MTIME/S_VERSION have changed, then we need to assume that any
of them may need to be changed and attempt to update all 3.

That said, I think the logic in fat_update_time isn't quite right. I
think want something like this on top of this patch to ensure that the
S_CTIME and S_MTIME get updated, even if the flags only have S_VERSION
set.

Thoughts?

---------------------8<-----------------------

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 080a5035483f..313eef02f45c 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -346,15 +346,21 @@ int fat_update_time(struct inode *inode, int flags)
        if (inode->i_ino == MSDOS_ROOT_INO)
                return 0;
 
-       if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
-               fat_truncate_time(inode, NULL, flags);
-               if (inode->i_sb->s_flags & SB_LAZYTIME)
-                       dirty_flags |= I_DIRTY_TIME;
-               else
-                       dirty_flags |= I_DIRTY_SYNC;
-       }
+       /*
+        * If any of the flags indicate an expicit change to the file, then we
+        * need to ensure that we attempt to update all of 3. We do not do
+        * this in the case of an S_ATIME-only update.
+        */
+       if (flags & (S_CTIME | S_MTIME | S_VERSION))
+               flags |= S_CTIME | S_MTIME | S_VERSION;
+
+       fat_truncate_time(inode, NULL, flags);
+       if (inode->i_sb->s_flags & SB_LAZYTIME)
+               dirty_flags |= I_DIRTY_TIME;
+       else
+               dirty_flags |= I_DIRTY_SYNC;
 
-       if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && inode_maybe_inc_iversion(inode, false))
+       if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
                dirty_flags |= I_DIRTY_SYNC;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
