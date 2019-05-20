From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: improve xattr value printing
Date: Mon, 20 May 2019 16:56:14 -0700
Message-ID: <20190520235614.GB61195@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190424175730.70979-1-ebiggers@kernel.org>
 <242d8b26-592b-57da-bd1f-3466bf714803@huawei.com>
 <20190515154846.GA21903@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hSs8l-0001fv-5I
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 May 2019 23:56:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hSs8j-00CpDi-7x
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 May 2019 23:56:23 +0000
Content-Disposition: inline
In-Reply-To: <20190515154846.GA21903@sol.localdomain>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 05/15, Eric Biggers wrote:
> On Sun, Apr 28, 2019 at 02:25:10PM +0800, Chao Yu wrote:
> > On 2019/4/25 1:57, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > - Print the values of xattrs that have an unknown ->e_name_index, rather
> > >   than ignoring them.
> > > 
> > > - Replace char with u8.  Otherwise xattr values containing bytes >= 0x80
> > >   are printed incorrectly on platforms where char is signed.
> > > 
> > > - Only parse the encryption xattr if it has a known format number and
> > >   size.  Otherwise print it as hex.
> > > 
> > > - Remove incorrect le16_to_cpu() on ->e_name_len which has type u8.
> > > 
> > > - Consolidate the code that prints the xattr value as hex.
> > > 
> > > - Constify pointers to the xattr entry.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > 
> > Thanks,
> > 
> 
> Hi Jaegeuk, are you planning to apply this patch?

Yup, it's in dev branch. Just too busy to add them into master.
Thank you for the heads up. Will do soon.

> 
> Thanks,
> 
> - Eric
