From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: Use crypto crc32 functions
Date: Mon, 7 Mar 2016 15:35:51 -0800
Message-ID: <20160307233551.GA44902@jaegeuk.gateway>
References: <1456787577-59946-1-git-send-email-kmok@cyngn.com>
	<20160302182136.GB9395@jaegeuk.gateway>
	<CAHjoi4evE_eAq1OgrUo8AC3=vnZ-zH6xKDeLpgendeYN6Ak37w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ad4gy-0005JH-40
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Mar 2016 23:36:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ad4gw-0001WI-SO
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Mar 2016 23:36:00 +0000
Content-Disposition: inline
In-Reply-To: <CAHjoi4evE_eAq1OgrUo8AC3=vnZ-zH6xKDeLpgendeYN6Ak37w@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Keith Mok <ek9852@gmail.com>
Cc: Keith Mok <kmok@cyngn.com>, linux-f2fs-devel@lists.sourceforge.net

On Wed, Mar 02, 2016 at 12:01:02PM -0800, Keith Mok wrote:
> Will update the first BUG_ON by using SHASH_DESC_ON_STACK.

I meant, for *every* BUG_ONs, doing like:

	if (err)
		return original f2fs_crc32();

Thanks,

> 
> 
> 2016-03-02 10:21 GMT-08:00 Jaegeuk Kim <jaegeuk@kernel.org>:
> > Hi Keith,
> >
> >> +static inline __u32 f2fs_crc32(struct f2fs_sb_info *sbi, const void *address,
> >> +                        unsigned int length)
> >> +{
> >> +     struct {
> >> +             struct shash_desc shash;
> >> +             char ctx[4];
> >> +     } desc;
> >> +     int err;
> >> +
> >> +     BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver) != sizeof(desc.ctx));
> >
> > I can't accept this and the below BUG_ON, since this hits during the checkpoint
> > procedure which is very critical for entire filesystem.
> > How about calling back the original method for the error cases?
> >
> > Thanks,
> >
> >> +
> >> +     desc.shash.tfm = sbi->s_chksum_driver;
> >> +     desc.shash.flags = 0;
> >> +     *(u32 *)desc.ctx = F2FS_SUPER_MAGIC;
> >> +
> >> +     err = crypto_shash_update(&desc.shash, address, length);
> >> +     BUG_ON(err);
> >> +
> >> +     return *(__u32 *)desc.ctx;
> >> +}
> >> +
> >> +static inline bool f2fs_crc_valid(struct f2fs_sb_info *sbi, __u32 blk_crc,
> >> +                               void *buf, size_t buf_size)
> >> +{
> >> +     return f2fs_crc32(sbi, buf, buf_size) == blk_crc;
> >> +}
> >> +
> >>  static inline struct f2fs_inode_info *F2FS_I(struct inode *inode)
> >>  {
> >>       return container_of(inode, struct f2fs_inode_info, vfs_inode);
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index 6134832..9630865 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -574,6 +574,8 @@ static void f2fs_put_super(struct super_block *sb)
> >>       wait_for_completion(&sbi->s_kobj_unregister);
> >>
> >>       sb->s_fs_info = NULL;
> >> +     if (sbi->s_chksum_driver)
> >> +             crypto_free_shash(sbi->s_chksum_driver);
> >>       kfree(sbi->raw_super);
> >>       kfree(sbi);
> >>  }
> >> @@ -1254,6 +1256,15 @@ try_onemore:
> >>       if (!sbi)
> >>               return -ENOMEM;
> >>
> >> +     /* Load the checksum driver */
> >> +     sbi->s_chksum_driver = crypto_alloc_shash("crc32", 0, 0);
> >> +     if (IS_ERR(sbi->s_chksum_driver)) {
> >> +             f2fs_msg(sb, KERN_ERR, "Cannot load crc32 driver.");
> >> +             err = PTR_ERR(sbi->s_chksum_driver);
> >> +             sbi->s_chksum_driver = NULL;
> >> +             goto free_sbi;
> >> +     }
> >> +
> >>       /* set a block size */
> >>       if (unlikely(!sb_set_blocksize(sb, F2FS_BLKSIZE))) {
> >>               f2fs_msg(sb, KERN_ERR, "unable to set blocksize");
> >> @@ -1506,6 +1517,8 @@ free_options:
> >>  free_sb_buf:
> >>       kfree(raw_super);
> >>  free_sbi:
> >> +     if (sbi->s_chksum_driver)
> >> +             crypto_free_shash(sbi->s_chksum_driver);
> >>       kfree(sbi);
> >>
> >>       /* give only one another chance */
> >> --
> >> 2.5.1

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://makebettercode.com/inteldaal-eval
