From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: avoid overflow when large directory
 feathure is enabled
Date: Tue, 27 May 2014 16:49:49 +0800
Message-ID: <010701cf7988$bc218420$34648c60$@samsung.com>
References: <00f601cf7948$1263a480$372aed80$@samsung.com>
	<20140527062307.GB4886@cm224.lee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WpD5s-0008E8-TB
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 May 2014 08:50:48 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WpD5q-0003cA-So
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 May 2014 08:50:48 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N6800ETG5WFC160@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 May 2014 17:50:39 +0900 (KST)
In-reply-to: <20140527062307.GB4886@cm224.lee>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi changman,

> -----Original Message-----
> From: Changman Lee [mailto:cm224.lee@samsung.com]
> Sent: Tuesday, May 27, 2014 2:23 PM
> To: Chao Yu
> Cc: Jaegeuk Kim; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid overflow when large directory feathure is enabled
> 
> Hi, Chao
> Good catch. Please, modify Documentation/filesytems/f2fs.txt

Thank you for reminding me, I will add modification of f2fs.txt in the patch later.

> 
> On Tue, May 27, 2014 at 09:06:52AM +0800, Chao Yu wrote:
> > When large directory feathure is enable, We have one case which could cause
> > overflow in dir_buckets() as following:
> > special case: level + dir_level >= 32 and level < MAX_DIR_HASH_DEPTH / 2.
> >
> > Here we define MAX_DIR_BUCKETS to limit the return value when the condition
> > could trigger potential overflow.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/dir.c           |    4 ++--
> >  include/linux/f2fs_fs.h |    3 +++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index c3f1485..966acb0 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -23,10 +23,10 @@ static unsigned long dir_blocks(struct inode *inode)
> >
> >  static unsigned int dir_buckets(unsigned int level, int dir_level)
> >  {
> > -	if (level < MAX_DIR_HASH_DEPTH / 2)
> > +	if (level + dir_level < MAX_DIR_HASH_DEPTH / 2)
> >  		return 1 << (level + dir_level);
> >  	else
> > -		return 1 << ((MAX_DIR_HASH_DEPTH / 2 + dir_level) - 1);
> > +		return MAX_DIR_BUCKETS;
> >  }
> >
> >  static unsigned int bucket_blocks(unsigned int level)
> > diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> > index 8c03f71..ba6f312 100644
> > --- a/include/linux/f2fs_fs.h
> > +++ b/include/linux/f2fs_fs.h
> > @@ -394,6 +394,9 @@ typedef __le32	f2fs_hash_t;
> >  /* MAX level for dir lookup */
> >  #define MAX_DIR_HASH_DEPTH	63
> >
> > +/* MAX buckets in one level of dir */
> > +#define MAX_DIR_BUCKETS		(1 << ((MAX_DIR_HASH_DEPTH / 2) - 1))
> > +
> >  #define SIZE_OF_DIR_ENTRY	11	/* by byte */
> >  #define SIZE_OF_DENTRY_BITMAP	((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \
> >  					BITS_PER_BYTE)
> > --
> > 1.7.10.4
> >
> >
> >
> > ------------------------------------------------------------------------------
> > The best possible search technologies are now affordable for all companies.
> > Download your FREE open source Enterprise Search Engine today!
> > Our experts will assist you in its installation for $59/mo, no commitment.
> > Test it for FREE on our Cloud platform anytime!
> > http://pubads.g.doubleclick.net/gampad/clk?id=145328191&iu=/4140/ostg.clktrk
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
The best possible search technologies are now affordable for all companies.
Download your FREE open source Enterprise Search Engine today!
Our experts will assist you in its installation for $59/mo, no commitment.
Test it for FREE on our Cloud platform anytime!
http://pubads.g.doubleclick.net/gampad/clk?id=145328191&iu=/4140/ostg.clktrk
