Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C5AC27C79
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jun 2024 21:24:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sKPGL-00045o-Kq;
	Thu, 20 Jun 2024 21:24:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1sKPGK-00045a-Hy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Jun 2024 21:24:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NwvUyN8h/MN79bhRw4WZ2w6W1GyaV7Re0UTnoarnXHU=; b=RHxxqwI5KBwC5DHeS0K342O6By
 n1eSrMfpWkbZVvtFD9ZUwYAIVLeF+zjh3Mh/U8L1eO8W5XOSwSN9rwmpsFWGXyNAVh/zUKwtXLkEB
 u0/80KrCUHWNYQieS2Ka7Vtxf6MkA//efZ/gOTKeMVjiC2AY4tTjDIL5vYOynEMlwfwo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NwvUyN8h/MN79bhRw4WZ2w6W1GyaV7Re0UTnoarnXHU=; b=SzdtbSywhBlzBjlukAWhLgXl8X
 vlCD/SpVSZ/POlr+rqgcIy/lG+tJ/eNfwZFvesgL6RBp79oexricRcwG3IE8RzCpdDqO/yAyIUyE4
 BHzwhLtcFshpMUmgRJJG/3D6Un7IzdQvdnJX7Ay5mhTBNUpD1z3Q84L3UUHpK0PN5G9I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sKPGK-0005Fm-SD for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Jun 2024 21:24:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AF130620DD;
 Thu, 20 Jun 2024 21:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578C8C2BD10;
 Thu, 20 Jun 2024 21:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718918642;
 bh=J2GqEQCdBgJeMDsHOUD3ggS0L8MaxCNWl/BVWnLRCW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FlQZkEWXuYjG3lBPD+CbeqHswxAsU7y4iss7QjmrwwSkTw2iU3E6o6btinmhwPHrD
 lSF/mb5wOLfVwxtjYYm93dMIUn1hfwPO7/uvnuUvaMGfIVTVH8Kn/kMXsydRkfKkKk
 +q9uKCYgckPzfqcC2uHLzy4ZEe1BFH/G9Q8G00qfYW4ZlnjgKp1D8f5mbTBTzHet3f
 KJRe02ZO01MDudREL9gtQdj64PgKYAVNDPPdkW0hXvesX4jdchaliSxKMN5OssSrSq
 Ecnj4xZ09k4NozRYTQARzo3zXOkrOETiUmVHdKRiMwF75ak/8AVeIkVdoL0kbhtqfE
 xzqtOujZzBqdw==
Date: Thu, 20 Jun 2024 14:24:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Message-ID: <20240620212401.GA3058325@frogsfrogsfrogs>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-2-john.g.garry@oracle.com>
 <20240612211040.GJ2764752@frogsfrogsfrogs>
 <a123946e-1df2-48da-b120-67b50c3aa9f5@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a123946e-1df2-48da-b120-67b50c3aa9f5@oracle.com>
X-Headers-End: 1sKPGK-0005Fm-SD
Subject: Re: [f2fs-dev] [PATCH v4 01/22] fs: Add
 generic_atomic_write_valid_size()
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
Cc: ritesh.list@gmail.com, gfs2@lists.linux.dev,
 mikulas@artax.karlin.mff.cuni.cz, hch@lst.de, agruenba@redhat.com,
 miklos@szeredi.hu, linux-ext4@vger.kernel.org, catherine.hoang@oracle.com,
 linux-block@vger.kernel.org, viro@zeniv.linux.org.uk, dchinner@redhat.com,
 axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, mcgrof@kernel.org, jack@suse.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org, chandan.babu@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 13, 2024 at 08:35:53AM +0100, John Garry wrote:
> On 12/06/2024 22:10, Darrick J. Wong wrote:
> > On Fri, Jun 07, 2024 at 02:38:58PM +0000, John Garry wrote:
> > > Add a generic helper for FSes to validate that an atomic write is
> > > appropriately sized (along with the other checks).
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   include/linux/fs.h | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 069cbab62700..e13d34f8c24e 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -3645,4 +3645,16 @@ bool generic_atomic_write_valid(loff_t pos, struct iov_iter *iter)
> > >   	return true;
> > >   }
> > > +static inline
> > > +bool generic_atomic_write_valid_size(loff_t pos, struct iov_iter *iter,
> > > +				unsigned int unit_min, unsigned int unit_max)
> > > +{
> > > +	size_t len = iov_iter_count(iter);
> > > +
> > > +	if (len < unit_min || len > unit_max)
> > > +		return false;
> > > +
> > > +	return generic_atomic_write_valid(pos, iter);
> > > +}
> > 
> > Now that I look back at "fs: Initial atomic write support" I wonder why
> > not pass the iocb and the iov_iter instead of pos and the iov_iter?
> 
> The original user of generic_atomic_write_valid() [blkdev_dio_unaligned() or
> blkdev_dio_invalid() with the rename] used these same args, so I just went
> with that.

Don't let the parameter types of static blockdev helpers determine the
VFS API that filesystems need to implement untorn writes.

In the block layer enablement patch, this could easily be:

bool generic_atomic_write_valid(const struct kiocb *iocb,
				const struct iov_iter *iter)
{
	size_t len = iov_iter_count(iter);

	if (!iter_is_ubuf(iter))
		return false;

	if (!is_power_of_2(len))
		return false;

	if (!IS_ALIGNED(iocb->ki_pos, len))
		return false;

	return true;
}

Then this becomes:

bool generic_atomic_write_valid_size(const struct kiocb *iocb,
				     const struct iov_iter *iter,
				     unsigned int unit_min,
				     unsigned int unit_max)
{
	size_t len = iov_iter_count(iter);

	if (len < unit_min || len > unit_max)
		return false;

	return generic_atomic_write_valid(iocb, iter);
}

Yes, that means you have to rearrange the calling conventions of
blkdev_dio_invalid a little bit, but the first two arguments match
->read_iter and ->write_iter.  Filesystem writers can see that the first
two arguments are the first two parameters to foofs_write_iter() and
focus on the hard part, which is figuring out unit_{min,max}.

static ssize_t
xfs_file_dio_write(
	struct kiocb		*iocb,
	struct iov_iter		*from)
{
...
	if ((iocb->ki_flags & IOCB_ATOMIC) &&
	    !generic_atomic_write_valid_size(iocb, from,
			i_blocksize(inode),
			XFS_FSB_TO_B(mp, ip->i_extsize)))
		return -EINVAL;
	}


> > And can these be collapsed into a single generic_atomic_write_checks()
> > function?
> 
> bdev file operations would then need to use
> generic_atomic_write_valid_size(), and there is no unit_min and unit_max
> size there, apart from bdev awu min and max. And if I checked them, we would
> be duplicating checks (of awu min and max) in the block layer.

Fair enough, I concede this point.

--D

> 
> Cheers,
> John
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
